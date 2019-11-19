From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/25] perf probe: Do not show non representive lines by perf-probe -L
Date: Tue, 19 Nov 2019 08:32:40 -0300
Message-ID: <20191119113245.19593-21-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since perf probe -L shows non representive lines, it can be mislead
users where user can put probes.  This prevents to show such non
representive lines so that user can understand which lines user can
probe.

  # perf probe -L kernel_read
  <kernel_read@/build/linux-pvZVvI/linux-5.0.0/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
           {
        2         mm_segment_t old_fs;
                  ssize_t result;

                  old_fs = get_fs();
        6         set_fs(get_ds());
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);

Committer testing:

Before:

  # perf probe -L kernel_read
  <kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
        1  {
        2         mm_segment_t old_fs;
        3         ssize_t result;

        5         old_fs = get_fs();
        6         set_fs(KERNEL_DS);
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);
  #

See the 1, 3, 5 lines? They shouldn't be there, after this patch:

  # perf probe -L kernel_read
  <kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
           {
        2         mm_segment_t old_fs;
                  ssize_t result;

                  old_fs = get_fs();
        6         set_fs(KERNEL_DS);
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406473064.24476.2913278267727587314.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index ef1b320cedf8..f12ad507a822 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1734,12 +1734,19 @@ static int line_range_walk_cb(const char *fname, int lineno,
 			      void *data)
 {
 	struct line_finder *lf = data;
+	const char *__fname;
+	int __lineno;
 	int err;
 
 	if ((strtailcmp(fname, lf->fname) != 0) ||
 	    (lf->lno_s > lineno || lf->lno_e < lineno))
 		return 0;
 
+	/* Make sure this line can be reversable */
+	if (cu_find_lineinfo(&lf->cu_die, addr, &__fname, &__lineno) > 0
+	    && (lineno != __lineno || strcmp(fname, __fname)))
+		return 0;
+
 	err = line_range_add_line(fname, lineno, lf->lr);
 	if (err < 0 && err != -EEXIST)
 		return err;
-- 
2.21.0
