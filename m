From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/35] kallsyms: Simplify update_iter_mod()
Date: Wed, 15 Aug 2018 12:06:09 -0300
Message-ID: <20180815150611.32080-34-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The logic in update_iter_mod() is overcomplicated and gets worse every
time another get_ksymbol_* function is added.

In preparation for adding another get_ksymbol_* function, simplify logic
in update_iter_mod().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: (ftrace changes only) Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1528289651-4113-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/kallsyms.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..aa31aa07f2ef 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -506,27 +506,24 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	}
 }
 
+/*
+ * The end position (last + 1) of each additional kallsyms section is recorded
+ * in iter->pos_..._end as each section is added, and so can be used to
+ * determine which get_ksymbol_...() function to call next.
+ */
 static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 {
 	iter->pos = pos;
 
-	if (iter->pos_ftrace_mod_end > 0 &&
-	    iter->pos_ftrace_mod_end < iter->pos)
-		return get_ksymbol_bpf(iter);
-
-	if (iter->pos_mod_end > 0 &&
-	    iter->pos_mod_end < iter->pos) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
+	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
+	    get_ksymbol_mod(iter))
 		return 1;
-	}
 
-	if (!get_ksymbol_mod(iter)) {
-		if (!get_ksymbol_ftrace_mod(iter))
-			return get_ksymbol_bpf(iter);
-	}
+	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
+	    get_ksymbol_ftrace_mod(iter))
+		return 1;
 
-	return 1;
+	return get_ksymbol_bpf(iter);
 }
 
 /* Returns false if pos at or past end of file. */
-- 
2.14.4
