Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D3143894;
	Thu, 19 Sep 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782677; cv=none; b=DXB+0o2Dqyxr4HlvaXp6lERQA4Sstpi+NayYhUd10hjmzVnwy56C+1B4cjvkT1GZUUUg7qTv3OtkqGhZnMII3QSLfSTnb5kr8EeY8b6p9u/P1B2DPSPU8pv2MUbUUPAfEENo/ogMLni3aaMbN2ntlaWYKhLH+H+8/5Bd4QjSaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782677; c=relaxed/simple;
	bh=O45RSXVGNnmT1HUaNGw+sKFJYkv7NAadZV0kR3tgGFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNPUOk4KY9lTAnZADFQcZ+IHSoryshuu3wuh8QhosBjZ6gTEt9v2bs9OxfTsex6P+mjumqNDXqxc7Y5zOKzeubnM2tDNnUfeUdCNnX/BI5KL23swOqnEw9gYDerIv9MA1eRj5ltzadLB3ejXgp3ry1WKf/vj+Wk513O5jLqrJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=permerror (bad message/signature format); arc=none smtp.client-ip=198.175.65.9
Authentication-Results:smtp.subspace.kernel.org; dkim=permerror (bad message/signature format)
X-CSE-ConnectionGUID: tvou8fjfTp+QVaqF3QbayA==
X-CSE-MsgGUID: Soor9oTtRA6qzX8rkeUAhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48305692"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48305692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:51:16 -0700
X-CSE-ConnectionGUID: TI9Fc/ynRnWg0JDhqVA9GA==
X-CSE-MsgGUID: cBf+vcvkTZaOdDucv1KOZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74866708"
Received: from b04f130c8410.jf.intel.com ([10.165.154.100])
  by orviesa003.jf.intel.com with ESMTP; 19 Sep 2024 14:51:15 -0700
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
Subject: [RFC v1 1/3] C and Rust support for perf script
Date: Thu, 19 Sep 2024 14:51:02 -0700
Message-ID: <20240919215107.2263552-3-stefan.ene@intel.com>
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

[PATCH 1/3] add the new perf script option (--new_script) and related
 changes

---
 tools/perf/builtin-script.c  |  22 +-
 tools/perf/util/Build        |   1 +
 tools/perf/util/new_script.c | 376 +++++++++++++++++++++++++++++++++++
 tools/perf/util/new_script.h |  54 +++++
 4 files changed, 452 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/new_script.c
 create mode 100644 tools/perf/util/new_script.h

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..e91a1e2481bb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,6 +63,7 @@
 #include "util/util.h"
 #include "util/cgroup.h"
 #include "perf.h"
+#include "util/new_script.h"
 
 #include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
@@ -88,6 +89,7 @@ static struct perf_stat_config	stat_config;
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
+static struct new_script	*new_struct;
 static int			dlargc;
 static char			**dlargv;
 
@@ -3898,6 +3900,7 @@ int cmd_script(int argc, const char **argv)
 	struct utsname uts;
 	char *script_path = NULL;
 	const char *dlfilter_file = NULL;
+	const char *new_script_file = NULL;
 	const char **__argv;
 	int i, j, err = 0;
 	struct perf_script script = {
@@ -3954,6 +3957,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_STRING('g', "gen-script", &generate_script_lang, "lang",
 		   "generate perf-script.xx script in specified language"),
 	OPT_STRING(0, "dlfilter", &dlfilter_file, "file", "filter .so file name"),
+	OPT_STRING(0, "new_script", &new_script_file, "file", "specify .so file name"),
 	OPT_CALLBACK(0, "dlarg", NULL, "argument", "filter argument",
 		     add_dlarg),
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
@@ -4355,6 +4359,21 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 	}
 #endif
+
+	if (new_script_file) {
+		new_struct = new_script__new(new_script_file);
+
+		if (!new_struct) {
+			perror("cannot create new_script objects\n");
+			goto out_delete;
+		}
+		if (new_script__start(new_struct, &data) < 0) {
+			perror("cannot start new_script object\n");
+			goto out_delete;  
+		}
+		goto out_delete;
+	}
+
 	if (generate_script_lang) {
 		struct stat perf_stat;
 		int input;
@@ -4458,7 +4477,8 @@ int cmd_script(int argc, const char **argv)
 	if (script_started)
 		cleanup_scripting();
 	dlfilter__cleanup(dlfilter);
+	new_script__cleanup(new_struct);
 	free_dlarg();
 out:
 	return err;
-}
+}
\ No newline at end of file
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b..386cdd0fe13c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -140,6 +140,7 @@ perf-util-y += parse-sublevel-options.o
 perf-util-y += term.o
 perf-util-y += help-unknown-cmd.o
 perf-util-y += dlfilter.o
+perf-util-y += new_script.o
 perf-util-y += mem-events.o
 perf-util-y += mem-info.o
 perf-util-y += vsprintf.o
diff --git a/tools/perf/util/new_script.c b/tools/perf/util/new_script.c
new file mode 100644
index 000000000000..ff3234b20738
--- /dev/null
+++ b/tools/perf/util/new_script.c
@@ -0,0 +1,376 @@
+// Stefan Ene's code, under Intel - Linux Kernel Team
+/*
+ * new_script.c: code for new scripting object allowing C and Rust event processing
+ * 
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <dlfcn.h>
+#include <errno.h>
+
+#include <linux/types.h>
+#include <perf/event.h>
+
+#include "data.h"
+#include "sample.h" 
+#include "header.h" 
+#include "new_script.h"
+#include "ordered-events.h"
+
+// rust lib
+#include "new_script_rs_lib.h"
+
+
+#define PATH_MAX 4096
+#define MMAP_SIZE (32 * 1024 * 1024ULL)
+#define	EINVAL		22	/* Invalid argument */
+
+
+static char *
+find_new_script(const char* file)
+{
+    char path[PATH_MAX];
+
+    if (strchr(file, '/'))
+		goto out;
+
+    if (!access(file, R_OK)) {
+        snprintf(path, sizeof(path), "./%s", file);
+		file = path;
+    }
+
+out:
+    return strdup(file);
+}
+
+
+static int
+new_script_open(struct new_script* s)
+{
+    void (*initialize)(struct new_script*);
+
+    s->handle = dlopen(s->file, RTLD_NOW);
+    if (!s->handle)
+        return -1;
+
+    initialize = (void (*)(struct new_script*))dlsym(s->handle, "initialize_new_script");
+
+    if (!initialize) {
+        dlclose(s->handle);
+        return -1;
+    }
+    initialize(s);
+
+    return 0;
+}
+
+
+static int 
+new_script__init(struct new_script *s, const char *file)
+{
+    memset(s, 0, sizeof(*s));
+    s->file = find_new_script(file);    // not freed since file string used somewhere else
+    if (!s->file)
+        return -1;
+    
+    return 0;
+}
+
+
+struct new_script *
+new_script__new(const char *file)
+{
+    struct new_script *s = malloc(sizeof(*s));
+    if(!s)
+        return NULL;
+
+    if (strcmp(file, "langs") == 0) {
+        printf("\n");
+        printf("Languages dynamic library can be based on:\n\n");
+        printf("\tC\t\t\t\t[file.c ]\n");
+        printf("\tRust\t\t\t\t[file.rs]\n\n");
+        fflush(stdout);
+        return NULL;
+    }
+
+    if (new_script__init(s, file) < 0) {
+        printf("Error finding .so file\n");
+        return NULL;
+    }
+
+    if (new_script_open(s) < 0) {
+        printf("Error opening dynamic library\n");
+        return NULL;
+    }
+
+    return s;
+    
+}
+
+
+static int
+new_script__validate_data(struct perf_data *data)
+{
+    if (!data) {
+        printf("> no data\n");
+        return -1;
+    }
+    printf("> has data at %s \n", data->path);
+    fflush(stdout);
+
+    return 0;
+
+}
+
+
+static long
+process_file_header(int fd, struct new_script *s)
+{
+    struct perf_file_header fh;
+    u64 data[3];
+    void *ctx = NULL;
+    size_t e;
+
+    e = read(fd, &fh, sizeof(struct perf_file_header));
+    if (e != sizeof(struct perf_file_header)) {
+        if (fd == -1)
+            return -1;
+    }
+    
+    data[0] = fh.size;
+    data[1] = fh.data.size;
+    data[2] = fh.data.offset;
+    
+    if (fh.attr_size != sizeof(struct perf_file_attr)) {
+        printf("Error matching file attributes size\n");
+        return -1;
+    }
+    
+    if (s->process_file_header((void *)data, ctx) <  0)
+       return -1;
+
+    lseek(fd, fh.data.offset, SEEK_SET);
+
+    return fh.data.size;
+}
+
+
+static int
+process_event_header(struct perf_event_header *header, struct new_script *s)
+{
+    void *ctx = NULL;
+   
+    if (!header)
+        return -1;
+    
+    if (s->process_event_header((void *)header, ctx) <  0)
+       return -1;
+
+    return 0;
+}
+
+
+static void
+process_sample_mmap(void *buffer)
+{
+    struct perf_record_mmap mmap;
+    
+    memcpy(&mmap, buffer, sizeof(struct perf_record_mmap));
+    
+    printf("\tMMAP data: %u %llx %s\n", mmap.pid, mmap.start, mmap.filename);
+    fflush(stdout);
+
+}
+
+
+static void
+process_sample_data(void *buffer, size_t size)
+{
+    long count = size / sizeof(u64);
+ 
+    u64 *array = malloc(count * sizeof(u64));
+ 
+    memcpy(array, buffer + sizeof(struct perf_event_header), count * sizeof(u64));
+
+    printf("\tSample data: ");
+    for (int i = 0; i < count; i++) {
+        printf(" %lu", array[i]);
+    }
+    printf("\n");
+    fflush(stdout);
+}
+
+
+static int
+process_sample(struct perf_event_header *header, void *buffer)
+{
+    switch(header->type) {
+        case PERF_RECORD_MMAP:
+            process_sample_mmap(buffer);
+            break;
+        // case PERF_RECORD_COMM:
+        // case PERF_RECORD_FORK:
+        // case PERF_RECORD_EXIT:
+        case PERF_RECORD_SAMPLE:
+            process_sample_data(buffer, header->size - sizeof(*header));
+            break;
+        case PERF_RECORD_FINISHED_ROUND:
+            printf("\tEvent: PERF_RECORD_FINISHED_ROUND\n");
+            fflush(stdout);
+            break;
+        default:    // skip event
+            printf("\tSkipped event\n");
+            fflush(stdout);
+            break;
+    }
+    return 0;
+}
+    
+
+
+static int
+process_event_data(struct new_script *s, struct perf_event_header *header, void* buffer, size_t processed)
+{
+    void *ctx = NULL;
+    const size_t size = header->size; 
+
+    s->process_event_raw_data(buffer + processed, size, ctx);
+    
+    process_sample(header, buffer + processed);
+
+    return 0;
+}
+
+
+static int
+new_perf__process_all_data(struct perf_data *data, struct new_script *s)
+{
+    long data_size = 0;
+    long curr_size = 0;
+    size_t batch_size = 1024 * 1024;
+    char *buffer;
+    size_t processed = 0;
+    size_t event_size = 0;
+    
+    int fd = open(data->path, O_RDONLY);
+    if (fd == -1) {
+        printf("Error opening perf data file\n");
+        close(fd);
+        return -1;
+    }
+
+    
+    if ((data_size = process_file_header(fd, s)) < 0) {
+        printf("Error processing file header\n");
+        close(fd);
+        return -1;
+    }
+
+    buffer = malloc(batch_size);
+    if (!buffer) {
+        printf("Error allocating memory for file buffer\n");
+        close(fd);
+        return -1;
+    }
+
+    while (curr_size < data_size) {
+        size_t bytes_read = 0; 
+        
+        // final batch case
+        if ((curr_size + (long)batch_size) > data_size) {
+            batch_size = data_size - curr_size;
+        }
+
+        bytes_read = read(fd, buffer, batch_size);
+
+        processed = 0;
+        while (processed < bytes_read) {
+            struct perf_event_header *header;
+
+            if ((bytes_read - processed) >= sizeof(*header)) {
+                header = (struct perf_event_header *)(buffer + processed);
+            } else {
+                lseek(fd, -(bytes_read - processed), SEEK_CUR);
+                break;
+            }
+
+            event_size = header->size;
+
+            if ((processed + event_size) > bytes_read) { // split event case
+                lseek(fd, -(bytes_read - processed), SEEK_CUR);
+                break;
+            }
+            
+            if (process_event_header(header, s) < 0) {
+                close(fd);
+                return -1;
+            }
+
+            if (process_event_data(s, header, buffer, processed) < 0) {
+                printf("Error processing event data\n");
+                close(fd);
+                return -1;
+            }
+            
+            processed += event_size;
+            curr_size += event_size;
+        }
+    }
+    
+    close(fd);
+    return 0;
+}
+
+
+int
+new_script__start(struct new_script *s, struct perf_data *data)
+{
+    int ret;
+    void *d = NULL, *ctx = NULL;
+
+    if (!s)
+        goto out; 
+
+    if (new_script__validate_data(data) < 0)
+        goto out; 
+
+    printf("\n");
+    fflush(stdout);
+    
+    s->begin(d, ctx);
+   
+    ret = new_perf__process_all_data(data, s);
+    if (ret < 0) {
+        printf("Error processing data in new_script\n");
+        goto out;
+    }
+
+    s->end(d, ctx);
+
+    printf("\n");
+    fflush(stdout);
+    return 0;
+
+out:
+    return -1;
+}
+
+
+static int
+new_script__close(struct new_script *s)
+{
+	return dlclose(s->handle);
+}
+
+
+void
+new_script__cleanup(struct new_script *s)
+{
+    if (s)
+        new_script__close(s);
+    free(s);
+}
\ No newline at end of file
diff --git a/tools/perf/util/new_script.h b/tools/perf/util/new_script.h
new file mode 100644
index 000000000000..9dc4760b3a33
--- /dev/null
+++ b/tools/perf/util/new_script.h
@@ -0,0 +1,54 @@
+// Stefan Ene's code, under Intel - Linux Kernel Team
+/*
+ * new_script.h: header file for new scripting object allowing C and Rust event processing
+ *
+ */
+#ifndef __PERF_NEW_SCRIPT_H
+#define __PERF_NEW_SCRIPT_H
+
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
+struct perf_event_header;
+
+struct perf_data;
+
+union perf_event;
+
+struct perf_file_section;
+
+struct perf_file_header;
+
+struct perf_event_attr;
+
+struct perf_file_attr {
+	struct perf_event_attr	    attr;
+	struct perf_file_section	ids;
+};
+
+
+struct perf_sample;
+
+struct ip_callchain;
+
+struct perf_record_mmap;
+
+struct new_script *new_script__new(const char *);
+
+void new_script__cleanup(struct new_script *);
+
+int new_script__start(struct new_script *, struct perf_data *);
+
+
+#endif /* __PERF_NEW_SCRIPT_H */
\ No newline at end of file
-- 
2.46.0

