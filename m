Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406ED16B3B7;
	Thu, 19 Sep 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782681; cv=none; b=jtrZfBYKh+uOjLGAqeKuFtScJwC4jz+rvcTVuhBlfwizELWB6Nc9XNNtmkbC5Bby9nh9suBKzTqzffHJ4skt0Q75Hk8x7AcKYHw0YK9dsxVdEjU19veTikUlTY8pGFfezl9P6JK6/Rg7b7xxzLefjgAIj2TaB/6ap5NCkzc0sOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782681; c=relaxed/simple;
	bh=rHCSz90r5D1fX+SeHXTz5R+EPa2N6LsxuyaozkGa/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioIlDGn6SqCUmWCStbc2pyluKY2utrVdM2YOigH5P/cbV6KA43IZPrit888p0/yXVlv5Yk7xcCnOi8HZGSCDF0X1rjQ9rZoZBKh+pLJJAanr0OAgSeDw6bcKs+d1WmybOVSP1zQ+eAF+dV+7nRMwk1ZPAEuSNrmwOOlHnw17Uhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=198.175.65.9
Authentication-Results:smtp.subspace.kernel.org; dkim=permerror (bad message/signature format)
X-CSE-ConnectionGUID: XE1TYbJnThO7ZAlLP9mk2g==
X-CSE-MsgGUID: MWlOLKjATQe0NHL2HBpC6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48305708"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48305708"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:51:19 -0700
X-CSE-ConnectionGUID: 63IdjRF4Rpuv/ZkmBww4tg==
X-CSE-MsgGUID: B/SxFBEoTuSlEV5kl0f6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74866721"
Received: from b04f130c8410.jf.intel.com ([10.165.154.100])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2024 14:51:19 -0700
From: Stefan Ene
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	stefan.ene@intel.com,
	stef_an_ene@outlook.com
Subject: [RFC v1 3/3] C and Rust support for perf script
Date: Thu, 19 Sep 2024 14:51:04 -0700
Message-ID: <20240919215107.2263552-5-stefan.ene@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919215107.2263552-2-stefan.ene@intel.com>
References: <20240919215107.2263552-2-stefan.ene@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Ene <stefan.ene@intel.com>

[PATCH 3/3] added the Rust sample script

---
 tools/perf/new_script_templates/README   |  61 +++++++++++--
 tools/perf/new_script_templates/lib.rs   | 108 +++++++++++++++++++++++
 tools/perf/new_script_templates/script.c |   6 ++
 tools/perf/util/new_script_rs_lib.h      |  35 ++++++++
 4 files changed, 204 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/new_script_templates/lib.rs
 create mode 100644 tools/perf/util/new_script_rs_lib.h

diff --git a/tools/perf/new_script_templates/README b/tools/perf/new_script_templates/README
index c2a55a65d444..f16a9759d37e 100644
--- a/tools/perf/new_script_templates/README
+++ b/tools/perf/new_script_templates/README
@@ -2,15 +2,64 @@ Linux kernel additions for C and Rust script support inside the perf-script tool
 
 Steps to use new feature:
 
-    First, use the provided update_perf_tools.sh script to make sure your perf toolset is up to date with the latest implementation:
-        $ bash update_perf_tools.sh
+    First, use run the following lines to make sure your perf toolset is up to date with the latest implementation:
+        $ cd ./tools/perf/
+        $ make
+        $ sudo cp perf /usr/bin
+        $ perf --version
+    Now, you can make use of our new features!
+
 
     a) For C scripts:
-        1. Use the default C template test.c to write your own custom perf event processing
+        1. Use the default C template in tools/perf/new_script_templates/script.c to write your own custom perf event processing
 
         2. Compile the C script into a dynamic library using the following two commands:
-            $ gcc -c -I ~/include -fpic new_script_templates/script.c
-            $ gcc -shared -o test.so new_script_templates/script.o
+            $ gcc -c -I ~/include -fpic script.c
+            $ gcc -shared -o script.so script.o
 
         3. Call the new perf script option to use the newly created .so file using the command:
-            $ sudo perf script --new_script new_script_templates/script.so
\ No newline at end of file
+            $ sudo perf script --new_script script.so
+
+
+     b) For Rust scripts:
+          1. Create a new Rust project using Cargo:
+               $ cargo new rslib_script --lib
+               $ cd rslib_script
+          
+          2. In the Cargo.toml file, specify the crate type as a dynamic library as follows:
+               [lib]
+               crate-type = ["cdylib"]
+          
+          3. Use the default Rust template in tools/perf/new_script_templates/lib.rs to write your own custom perf event processing, and store it into src/lib.rs inside of the Rust project folder.
+
+          4. Compile the Rust project using Cargo:
+               $ cargo build --release
+          
+          5. Call the new perf script option to use the newly created /target/release/librslib.so within the Rust project using the followig command:
+               $  sudo perf script --new_script rslib/target/release/librslib.so
+
+Enjoy using the new scripting languages for an added bonus of usability and performance over the existent Python and Perl options in the upstream kernel code. 
+
+
+<!-- ============================= -->
+
+This section contains some initial benchmark results on the Intel Lab machine using the perf script tools on a 4026869-byte perf.data file.
+
+Process ----- Time
+
+> Perf tool vanilla:
+perf script raw: 1.425s
+perf script names: 0.915s
+perf script Python: 1.334s
+perf script Perl: 2.210s
+
+
+> Pre-optimizations:
+new_script raw C: 0.284s
+new_script raw Rust: 0.607s
+
+> Post-optimizations:
+new_script raw C batch=1MB: 0.306s 
+new_script raw C batch=2MB: 0.301s 
+new_script raw C batch=4MB: 0.296s 
+new_script raw Rust batch=1MB: 0.262s
\ No newline at end of file
diff --git a/tools/perf/new_script_templates/lib.rs b/tools/perf/new_script_templates/lib.rs
new file mode 100644
index 000000000000..1249d9e9099b
--- /dev/null
+++ b/tools/perf/new_script_templates/lib.rs
@@ -0,0 +1,108 @@
+// Stefan Ene's code, under Intel - Linux Kernel Team
+/*
+ * code for new perf script custom C script template
+ *
+ */
+
+ use std::os::raw::{c_char, c_int, c_void};
+ use std::slice;
+ use std::fmt::Write;
+ 
+ // =================== Needed stuff, DO NOT CHANGE ===================
+ 
+ #[repr(C)]
+ struct NewScript {
+     file: *mut c_char,
+     handle: *mut c_void,
+ 
+     begin: extern "C" fn(*mut c_void, *mut c_void),
+     end: extern "C" fn(*mut c_void, *mut c_void),
+ 
+     process_file_header: extern "C" fn(*mut c_void, *mut c_void) -> c_int,
+     process_event_header: extern "C" fn(*mut c_void, *mut c_void) -> c_int,
+     process_event_raw_data: extern "C" fn(*mut c_void, c_int, *mut c_void) -> c_int,
+ }
+ 
+ #[repr(C)]
+ struct ProcessedFileHeader {
+     size: u64,
+     data_size: u64,
+     data_offset: u64,
+ }
+ 
+ #[repr(C)]
+ struct ProcessedEventHeader {
+     event_type: u32,
+     misc: u16,
+     size: u16,
+ }
+ 
+ //  =================== Editable funtions begin ===================
+ 
+ #[no_mangle]
+ pub extern "C" fn print_begin(_data: *mut c_void, _ctx: *mut c_void) {
+     println!(">> in trace_begin with Rust");
+ }
+ 
+ #[no_mangle]
+ pub extern "C" fn process_file_header(data: *mut c_void, _ctx: *mut c_void) -> c_int {
+     if data.is_null() {
+         println!("> Error dynamically processing file header");
+         return -1;
+     }
+ 
+     let fh = unsafe { &*(data as *const ProcessedFileHeader) };
+ 
+     println!("\nFile header: size={:x}, data.size={}, data.offset={}", fh.size, fh.data_size, fh.data_offset);
+ 
+     0
+ }
+ 
+ #[no_mangle]
+ pub extern "C" fn process_event_header(data: *mut c_void, _ctx: *mut c_void) -> c_int {
+     if data.is_null() {
+         println!("> Error dynamically processing event header");
+         return -1;
+     }
+ 
+     let evh = unsafe { &*(data as *const ProcessedEventHeader) };
+ 
+     println!("\nRS Event header: size={}, type={}, misc={}", evh.size, evh.event_type, evh.misc);
+ 
+     0
+ }
+ 
+ #[no_mangle]
+ pub extern "C" fn process_event_raw_data(data: *mut c_void, size: c_int, _ctx: *mut c_void) -> c_int {
+     let byte_data = unsafe { slice::from_raw_parts(data as *const u8, size as usize) };
+     let mut output = String::new();
+ 
+     for (i, &byte) in byte_data.iter().enumerate() {
+         if i % 16 == 0 {
+             output.push('\n');
+         }
+         write!(&mut output, "{:02x} ", byte).unwrap();
+     }
+ 
+     println!("{}", output);
+     0
+ }
+ 
+ #[no_mangle]
+ pub extern "C" fn print_end(_data: *mut c_void, _ctx: *mut c_void) {
+     println!("\n>> in trace_end");
+ }
+ 
+ // =================== Needed stuff begin, DO NOT CHANGE ===================
+ 
+ #[no_mangle]
+ pub extern "C" fn initialize_new_script(s: *mut NewScript) {
+     if !s.is_null() {
+         let script = unsafe { &mut *s };
+         script.begin = print_begin;
+         script.end = print_end;
+         script.process_file_header = process_file_header;
+         script.process_event_header = process_event_header;
+         script.process_event_raw_data = process_event_raw_data;
+     }
+ }
\ No newline at end of file
diff --git a/tools/perf/new_script_templates/script.c b/tools/perf/new_script_templates/script.c
index e4942ba689db..787f67424d5e 100644
--- a/tools/perf/new_script_templates/script.c
+++ b/tools/perf/new_script_templates/script.c
@@ -1,3 +1,9 @@
+// Stefan Ene's code, under Intel - Linux Kernel Team
+/*
+ * code for new perf script custom C script template
+ *
+ */
+
 #include <stdlib.h>
 #include <stdio.h>
 
diff --git a/tools/perf/util/new_script_rs_lib.h b/tools/perf/util/new_script_rs_lib.h
new file mode 100644
index 000000000000..4a8d6f71b122
--- /dev/null
+++ b/tools/perf/util/new_script_rs_lib.h
@@ -0,0 +1,35 @@
+// Stefan Ene's code, under Intel - Linux Kernel Team
+/*
+ * new_script_lib_rs.h: header file for new_script Rust FFI
+ *
+ */
+
+#ifndef NEW_SCRIPT_LIB_RS_H
+#define NEW_SCRIPT_LIB_RS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdint.h>
+
+// Match the struct definitions with the Rust code
+struct NewScript {
+    char		*file;
+    void        *handle;
+
+    void (*begin)(void *data, void *ctx);
+	void (*end)(void *data, void *ctx);
+
+    int (*process_file_header)(void *data, void *ctx);
+    int (*process_event_header)(void *data, void *ctx);
+    int (*process_event_raw_data)(void *data, const int size, void *ctx);
+};
+
+void initialize_new_script(struct NewScript* s);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif // NEW_SCRIPT_LIB_RS_H
\ No newline at end of file
-- 
2.46.0

