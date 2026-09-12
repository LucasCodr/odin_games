package save

import "core:encoding/json"
import "core:fmt"
import "core:os"

SAVE_PATH :: "breakout.json"

Save :: struct {
	highest_score: int,
}

load :: proc(path := SAVE_PATH) -> (s: Save, ok: bool) {
	data, rerr := os.read_entire_file(path, context.allocator)

	if rerr != nil {
		return {}, false
	}

	defer delete(data)

	if uerr := json.unmarshal(data, &s); uerr != nil {
		fmt.eprintfln("unmarshal %s failed: %v", path, uerr)
		return {}, false
	}

	return s, true
}

write :: proc(s: Save, path := SAVE_PATH) -> bool {
	data, merr := json.marshal(s, json.Marshal_Options{pretty = false, use_enum_names = true})
	if merr != nil {
		fmt.eprintfln("marshal failed: %v", merr)
		return false
	}
	defer delete(data)

	if werr := os.write_entire_file(path, data); werr != nil {
		fmt.eprintfln("write %s failed: %v", path, werr)
		return false
	}
	return true
}
