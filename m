Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239C1531F8;
	Thu, 19 Sep 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782679; cv=none; b=M3s9GS8N119REyjU2V28JzmzutmIr5igRQCnYePRwtz1fqbx8y7fWfPCe9/WNxSHwojXuTHa9v81N6U6fgdS8izWEuMYdPX8xoeHtT4I8It3TBeE+5ZKwZoaKgOBk8s6myubWTW9+/NkCft0gmqcbnl101fYd1o5akqr6rJ9Mng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782679; c=relaxed/simple;
	bh=5dXFp2LdV4LF6UQOCBSwJS6XNTq7r538M4RfYGHjLUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcxiHa9nX6mlRPbirjyWOsqxZZaDplekMHlktG3dL6Qb9c+lQZC6QE8DYKv7MqPtxI96m6MszxFrzqTfAiCiHqPbhcvDX3Nxy/c9c3ew7Vvnt2fZDYS/lJCvvY6Tcnip81ggs5gOGJfV4MpPjeeblg4yDiwHK6fqslJ018yi8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=198.175.65.9
Authentication-Results:smtp.subspace.kernel.org; dkim=permerror (bad message/signature format)
X-CSE-ConnectionGUID: qzyEL1TRSKKvch5WtWR7qg==
X-CSE-MsgGUID: 9rBNSeZEQJKK2wMeAeUwBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48305699"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48305699"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:51:17 -0700
X-CSE-ConnectionGUID: DPJHZ1YlSJW4vfXj7UV3Gg==
X-CSE-MsgGUID: Nqhc0ZIwRvun1mLcu6otCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74866716"
Received: from b04f130c8410.jf.intel.com ([10.165.154.100])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2024 14:51:17 -0700
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
Subject: [RFC v1 2/3] C and Rust support for perf script
Date: Thu, 19 Sep 2024 14:51:03 -0700
Message-ID: <20240919215107.2263552-4-stefan.ene@intel.com>
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

[PATCH 2/3] added the C sample script

---
 tools/perf/new_script_templates/README   |  16 ++++
 tools/perf/new_script_templates/script.c | 107 +++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/perf/new_script_templates/README
 create mode 100644 tools/perf/new_script_templates/script.c

diff --git a/tools/perf/new_script_templates/README b/tools/perf/new_script_templates/README
new file mode 100644
index 000000000000..c2a55a65d444
--- /dev/null
+++ b/tools/perf/new_script_templates/README
@@ -0,0 +1,16 @@
+Linux kernel additions for C and Rust script support inside the perf-script tool set.
+
+Steps to use new feature:
+
+    First, use the provided update_perf_tools.sh script to make sure your perf toolset is up to date with the latest implementation:
+        $ bash update_perf_tools.sh
+
+    a) For C scripts:
+        1. Use the default C template test.c to write your own custom perf event processing
+
+        2. Compile the C script into a dynamic library using the following two commands:
+            $ gcc -c -I ~/include -fpic new_script_templates/script.c
+            $ gcc -shared -o test.so new_script_templates/script.o
+
+        3. Call the new perf script option to use the newly created .so file using the command:
+            $ sudo perf script --new_script new_script_templates/script.so
\ No newline at end of file
diff --git a/tools/perf/new_script_templates/script.c b/tools/perf/new_script_templates/script.c
new file mode 100644
index 000000000000..e4942ba689db
--- /dev/null
+++ b/tools/perf/new_script_templates/script.c
@@ -0,0 +1,107 @@
+#include <stdlib.h>
+#include <stdio.h>
+
+// =================== Needed stuff begin, DO NOT CHANGE ===================
+
+#include <linux/types.h>
+
+struct new_script {
+	char		*file;
+    void        *handle;
+
+    void (*begin)(void *data, void *ctx);
+	void (*end)(void *data, void *ctx);
+
+    int (*process_file_header)(void *data, void *ctx);
+    int (*process_event_header)(void *data, void *ctx);
+    int (*process_event_raw_data)(void *data, const int size, void *ctx);
+
+};
+
+struct processed_file_header {
+	__u64 size;
+	__u64 data_size;
+	__u64 data_offset;
+};
+
+struct processed_event_header {
+	__u32	type;
+	__u16	misc;
+	__u16	size;
+};
+
+//  =================== Editable funtions begin ===================
+
+void
+print_begin(void *data, void *ctx)
+{
+    printf(">> in trace_begin\n");
+}
+
+
+int
+process_file_header(void* data, void *ctx)
+{
+    if (!data) {
+        printf("> Error dynamically processing file header\n");
+        return -1;
+    }
+    
+    struct processed_file_header *fh = (struct processed_file_header *)data;
+
+    printf("\nFile header: size=%lx, data.size=%u, data.offset=%u\n", fh->size, fh->data_size,  fh->data_offset);
+
+    return 0;
+}
+
+
+int
+process_event_header(void* data, void *ctx)
+{
+    if (!data) {
+        printf("> Error dynamically processing event header\n");
+        return -1;
+    }
+    
+    struct processed_event_header *evh = (struct processed_event_header *)data;
+
+    printf("\nEvent header: size=%u, type=%u, misc=%u\n", evh->size, evh->type, evh->misc);
+
+    return 0;
+}
+
+
+int 
+process_event_raw_data(void* data, const int size, void *ctx)
+{
+    unsigned char *byte_data = (unsigned char *)data;
+    for (size_t i = 0; i < size; i++) {
+        // if (i >= 160) {
+        //     printf("\n...");
+        //     break;
+        // }
+        if ((i % 16) == 0)
+            printf("\n");
+        printf("%02x ", byte_data[i]);
+    }
+    printf("\n");
+}
+
+
+void
+print_end(void *data, void *ctx)
+{
+    printf("\n>> in trace_end\n");
+}
+
+// =================== Needed stuff begin, DO NOT CHANGE ===================
+
+void
+initialize_new_script(struct new_script* s)
+{
+    s->begin = print_begin;
+    s->end = print_end;
+    s->process_file_header = process_file_header;
+    s->process_event_header = process_event_header;
+    s->process_event_raw_data = process_event_raw_data;
+}
\ No newline at end of file
-- 
2.46.0

