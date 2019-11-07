From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/63] perf record: Put a copy of kcore into the perf.data directory
Date: Thu,  7 Nov 2019 15:59:14 -0300
Message-ID: <20191107190011.23924-7-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a new 'perf record' option '--kcore' which will put a copy of
/proc/kcore, kallsyms and modules into a perf.data directory. Note, that
without the --kcore option, output goes to a file as previously.  The
tools' -o and -i options work with either a file name or directory name.

Example:

  $ sudo perf record --kcore uname

  $ sudo tree perf.data
  perf.data
  ├── kcore_dir
  │   ├── kallsyms
  │   ├── kcore
  │   └── modules
  └── data

  $ sudo perf script -v
  build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
  build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
  Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
  Using CPUID GenuineIntel-6-8E-A
  Using perf.data/kcore_dir/kcore for kernel data
  Using perf.data/kcore_dir/kallsyms for symbols
             perf 19058 506778.423729:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423733:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423734:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
             perf 19058 506778.423736:        117 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
             perf 19058 506778.423738:       2092 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
             perf 19058 506778.423740:      37380 cycles:  ffffffffa2f121d0 perf_event_addr_filters_exec+0x0 (vmlinux)
            uname 19058 506778.423751:     582673 cycles:  ffffffffa303a407 propagate_protected_usage+0x147 (vmlinux)
            uname 19058 506778.423892:    2241841 cycles:  ffffffffa2cae0c9 unwind_next_frame.part.5+0x79 (vmlinux)
            uname 19058 506778.424430:    2457397 cycles:  ffffffffa3019232 check_memory_region+0x52 (vmlinux)

Committer testing:

  # rm -rf perf.data*
  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data (7 samples) ]
  # ls -l perf.data
  -rw-------. 1 root root 34772 Oct 21 11:08 perf.data
  # perf record --kcore uname
  Linux
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data (7 samples) ]
  ls[root@quaco ~]# ls -lad perf.data*
  drwx------. 3 root root  4096 Oct 21 11:08 perf.data
  -rw-------. 1 root root 34772 Oct 21 11:08 perf.data.old
  # perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  # perf evlist -v -i perf.data/data
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191004083121.12182-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt      |  3 ++
 .../perf.data-directory-format.txt            | 35 +++++++++++++
 tools/perf/builtin-record.c                   | 52 +++++++++++++++++++
 tools/perf/util/data.c                        | 33 ++++++++++++
 tools/perf/util/data.h                        |  2 +
 tools/perf/util/record.h                      |  1 +
 tools/perf/util/session.c                     |  4 ++
 tools/perf/util/util.c                        | 17 ++++++
 8 files changed, 147 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c6f9f31b6039..8a4506113d9f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -571,6 +571,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
 
 Implies --tail-synthesize.
 
+--kcore::
+Make a copy of /proc/kcore and place it into a directory with the perf data file.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/Documentation/perf.data-directory-format.txt b/tools/perf/Documentation/perf.data-directory-format.txt
index 4bf08908178d..f37fbd29112e 100644
--- a/tools/perf/Documentation/perf.data-directory-format.txt
+++ b/tools/perf/Documentation/perf.data-directory-format.txt
@@ -26,3 +26,38 @@ The current only version value 0 means that:
 
 Future versions are expected to describe different data files
 layout according to special needs.
+
+Currently the only 'perf record' option to output to a directory is
+the --kcore option which puts a copy of /proc/kcore into the directory.
+e.g.
+
+  $ sudo perf record --kcore uname
+  Linux
+  [ perf record: Woken up 1 times to write data ]
+  [ perf record: Captured and wrote 0.015 MB perf.data (9 samples) ]
+  $ sudo tree -ps perf.data
+  perf.data
+  ├── [-rw-------       23744]  data
+  └── [drwx------        4096]  kcore_dir
+      ├── [-r--------     6731125]  kallsyms
+      ├── [-r--------    40230912]  kcore
+      └── [-r--------        5419]  modules
+
+  1 directory, 4 files
+  $ sudo perf script -v
+  build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
+  build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
+  build id event received for /lib/x86_64-linux-gnu/libc-2.28.so: 5b157f49586a3ca84d55837f97ff466767dd3445
+  Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
+  Using CPUID GenuineIntel-6-8E-A
+  Using perf.data/kcore_dir/kcore for kernel data
+  Using perf.data/kcore_dir/kallsyms for symbols
+              perf 15316 2060795.480902:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
+              perf 15316 2060795.480906:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
+              perf 15316 2060795.480908:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
+              perf 15316 2060795.480910:        119 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
+              perf 15316 2060795.480912:       2109 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
+              perf 15316 2060795.480914:      37606 cycles:  ffffffffa2f121fe perf_event_addr_filters_exec+0x2e (vmlinux)
+             uname 15316 2060795.480924:     588287 cycles:  ffffffffa303a56d page_counter_try_charge+0x6d (vmlinux)
+             uname 15316 2060795.481067:    2261945 cycles:  ffffffffa301438f kmem_cache_free+0x4f (vmlinux)
+             uname 15316 2060795.481643:    2172167 cycles:      7f1a48c393c0 _IO_un_link+0x0 (/lib/x86_64-linux-gnu/libc-2.28.so)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e402459752e7..f6664bb08b26 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -55,6 +55,9 @@
 #include <signal.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/time64.h>
@@ -699,6 +702,37 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 
 #endif
 
+static bool record__kcore_readable(struct machine *machine)
+{
+	char kcore[PATH_MAX];
+	int fd;
+
+	scnprintf(kcore, sizeof(kcore), "%s/proc/kcore", machine->root_dir);
+
+	fd = open(kcore, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+
+	return true;
+}
+
+static int record__kcore_copy(struct machine *machine, struct perf_data *data)
+{
+	char from_dir[PATH_MAX];
+	char kcore_dir[PATH_MAX];
+	int ret;
+
+	snprintf(from_dir, sizeof(from_dir), "%s/proc", machine->root_dir);
+
+	ret = perf_data__make_kcore_dir(data, kcore_dir, sizeof(kcore_dir));
+	if (ret)
+		return ret;
+
+	return kcore_copy(from_dir, kcore_dir);
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
@@ -1383,6 +1417,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	session->header.env.comp_type  = PERF_COMP_ZSTD;
 	session->header.env.comp_level = rec->opts.comp_level;
 
+	if (rec->opts.kcore &&
+	    !record__kcore_readable(&session->machines.host)) {
+		pr_err("ERROR: kcore is not readable.\n");
+		return -1;
+	}
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1414,6 +1454,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
+	if (rec->opts.kcore) {
+		err = record__kcore_copy(&session->machines.host, data);
+		if (err) {
+			pr_err("ERROR: Failed to copy kcore\n");
+			goto out_child;
+		}
+	}
+
 	err = bpf__apply_obj_config();
 	if (err) {
 		char errbuf[BUFSIZ];
@@ -2184,6 +2232,7 @@ static struct option __record_options[] = {
 		     parse_cgroups),
 	OPT_UINTEGER('D', "delay", &record.opts.initial_delay,
 		  "ms to wait before starting measurement after program start"),
+	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
 	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
 		   "user to profile"),
 
@@ -2322,6 +2371,9 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
+	if (rec->opts.kcore)
+		rec->data.is_dir = true;
+
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
 		rec->no_buildid = true;
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 964ea101dba6..c47aa34fdc0a 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -424,3 +424,36 @@ unsigned long perf_data__size(struct perf_data *data)
 
 	return size;
 }
+
+int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz)
+{
+	int ret;
+
+	if (!data->is_dir)
+		return -1;
+
+	ret = snprintf(buf, buf_sz, "%s/kcore_dir", data->path);
+	if (ret < 0 || (size_t)ret >= buf_sz)
+		return -1;
+
+	return mkdir(buf, S_IRWXU);
+}
+
+char *perf_data__kallsyms_name(struct perf_data *data)
+{
+	char *kallsyms_name;
+	struct stat st;
+
+	if (!data->is_dir)
+		return NULL;
+
+	if (asprintf(&kallsyms_name, "%s/kcore_dir/kallsyms", data->path) < 0)
+		return NULL;
+
+	if (stat(kallsyms_name, &st)) {
+		free(kallsyms_name);
+		return NULL;
+	}
+
+	return kallsyms_name;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index f68815f7e428..75947ef6bc17 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -87,4 +87,6 @@ int perf_data__open_dir(struct perf_data *data);
 void perf_data__close_dir(struct perf_data *data);
 int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
+int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
+char *perf_data__kallsyms_name(struct perf_data *data);
 #endif /* __PERF_DATA_H */
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 00275afc524d..948bbcf9aef3 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -44,6 +44,7 @@ struct record_opts {
 	bool	      strict_freq;
 	bool	      sample_id;
 	bool	      no_bpf_event;
+	bool	      kcore;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0266604b8bc2..f07b8ecb91bc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -230,6 +230,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
 				if (ret)
 					goto out_delete;
 			}
+
+			if (!symbol_conf.kallsyms_name &&
+			    !symbol_conf.vmlinux_name)
+				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3096654377c2..969ae560dad9 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -182,6 +182,21 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+static int rm_rf_kcore_dir(const char *path)
+{
+	char kcore_dir_path[PATH_MAX];
+	const char *pat[] = {
+		"kcore",
+		"kallsyms",
+		"modules",
+		NULL,
+	};
+
+	snprintf(kcore_dir_path, sizeof(kcore_dir_path), "%s/kcore_dir", path);
+
+	return rm_rf_depth_pat(kcore_dir_path, 0, pat);
+}
+
 int rm_rf_perf_data(const char *path)
 {
 	const char *pat[] = {
@@ -190,6 +205,8 @@ int rm_rf_perf_data(const char *path)
 		NULL,
 	};
 
+	rm_rf_kcore_dir(path);
+
 	return rm_rf_depth_pat(path, 0, pat);
 }
 
-- 
2.21.0
