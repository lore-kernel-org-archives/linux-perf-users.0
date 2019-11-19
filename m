From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/25] perf probe: Show correct statement line number by perf probe -l
Date: Tue, 19 Nov 2019 08:32:38 -0300
Message-ID: <20191119113245.19593-19-acme@kernel.org>
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

The dwarf_getsrc_die() can return the line which is not a statement nor
the least line number among the lines which shares same address.

This can lead perf probe --list shows incorrect line number for probed
address.

To fix this, this introduces cu_getsrc_die() which returns only a
statement line and which is the least line number (we call it the
representive line for an address), and use it in cu_find_lineinfo().

Also, if the given address is the entry address of a real function,
cu_find_lineinfo() returns the function declared line number instead of
the start line number of the function body.

For example, without this change perf probe -l shows incorrect line as
below.

  # perf probe -a kernel_read:2
  Added new event:
    probe:kernel_read    (on kernel_read:2)

  You can now use it in all perf tools, such as:

  	perf record -e probe:kernel_read -aR sleep 1

  # perf probe -l
    probe:kernel_read    (on kernel_read:1@linux-5.0.0/fs/read_write.c)

With this fix, it shows correct line number as below;

  # perf probe -l
    probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406471067.24476.17463149618465494448.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 62 ++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 5544bfbd0f6c..aa898014ad12 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -59,6 +59,51 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
 	return dwarf_formstring(&attr);
 }
 
+/* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
+static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
+{
+	Dwarf_Addr laddr;
+	Dwarf_Lines *lines;
+	Dwarf_Line *line;
+	size_t nlines, l, u, n;
+	bool flag;
+
+	if (dwarf_getsrclines(cu_die, &lines, &nlines) != 0 ||
+	    nlines == 0)
+		return NULL;
+
+	/* Lines are sorted by address, use binary search */
+	l = 0; u = nlines - 1;
+	while (l < u) {
+		n = u - (u - l) / 2;
+		line = dwarf_onesrcline(lines, n);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0)
+			return NULL;
+		if (addr < laddr)
+			u = n - 1;
+		else
+			l = n;
+	}
+	/* Going backward to find the lowest line */
+	do {
+		line = dwarf_onesrcline(lines, --l);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0)
+			return NULL;
+	} while (laddr == addr);
+	l++;
+	/* Going foward to find the statement line */
+	do {
+		line = dwarf_onesrcline(lines, l++);
+		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
+		    dwarf_linebeginstatement(line, &flag) != 0)
+			return NULL;
+		if (laddr > addr)
+			return NULL;
+	} while (!flag);
+
+	return line;
+}
+
 /**
  * cu_find_lineinfo - Get a line number and file name for given address
  * @cu_die: a CU DIE
@@ -72,17 +117,26 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
 		    const char **fname, int *lineno)
 {
 	Dwarf_Line *line;
-	Dwarf_Addr laddr;
+	Dwarf_Die die_mem;
+	Dwarf_Addr faddr;
 
-	line = dwarf_getsrc_die(cu_die, (Dwarf_Addr)addr);
-	if (line && dwarf_lineaddr(line, &laddr) == 0 &&
-	    addr == (unsigned long)laddr && dwarf_lineno(line, lineno) == 0) {
+	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
+	    && die_entrypc(&die_mem, &faddr) == 0 &&
+	    faddr == addr) {
+		*fname = dwarf_decl_file(&die_mem);
+		dwarf_decl_line(&die_mem, lineno);
+		goto out;
+	}
+
+	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
+	if (line && dwarf_lineno(line, lineno) == 0) {
 		*fname = dwarf_linesrc(line, NULL, NULL);
 		if (!*fname)
 			/* line number is useless without filename */
 			*lineno = 0;
 	}
 
+out:
 	return *lineno ?: -ENOENT;
 }
 
-- 
2.21.0
