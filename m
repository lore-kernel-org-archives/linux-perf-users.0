Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D521ABA4;
	Thu, 24 Apr 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525789; cv=none; b=Oajgv36pDo/rNJMv5JIVQ30c6jg5c4VjIH0e16cDMStmZeLMNAYtCncLOB45aeVNg8yEiIr3iVDWzHlFJhtuu5lUY8vJ9FInEG95gwMinFbdfYOFOiskmpCVEzDJL1TwhoJnSKGDvuTIFP8e7FnLd+11Ufz+06DDsrQZM55fTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525789; c=relaxed/simple;
	bh=qV7wU9+LfnHUmeEvAFCpYvuT1wevvZA+8tcBBa3R9Jo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KQvknMRqUeBKwMl4av1OT0bovk9RAaIoUZCrJ2vroWjPA58LIQvzJsZ0n9qmiXBnjiEAAc33xmSAsnxAfAnSqKYd2Yw9s/8VJy7ojml60Wz+Cw3RBJY14kiD4ObL16Z5W5NriEQ+2XTcr6IgL//GToOJ4A+KwBDthDW3h6gmNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA42C4CEEE;
	Thu, 24 Apr 2025 20:16:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u831d-0000000H3yG-2h9H;
	Thu, 24 Apr 2025 16:18:25 -0400
Message-ID: <20250424201825.486232533@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 16:15:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 12/12] unwind_user/sframe: Add .sframe validation option
References: <20250424201511.921245242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add a debug feature to validate all .sframe sections when first loading
the file rather than on demand.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig           | 19 ++++++++++
 kernel/unwind/sframe.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9ba467006774..72bd3ef8f570 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -450,6 +450,25 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config SFRAME_VALIDATION
+	bool "Enable .sframe section debugging"
+	depends on HAVE_UNWIND_USER_SFRAME
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .sframe section for a task, validate the entire
+	  section immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out .sframe
+	  section issues.  If the .sframe section is corrupt, it will fail to
+	  load immediately, with more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading of the
+	  entire .sframe section for every loaded executable and shared
+	  library.  Also, it's done for all processes, even those which don't
+	  get stack traced by the kernel.  Not recommended for general use.
+
+	  If unsure, say N.
+
 config HAVE_PERF_CALLCHAIN_DEFERRED
 	bool
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 4d2313a701f0..3f7cc9bc27eb 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -337,6 +337,83 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_SFRAME_VALIDATION
+
+static __always_inline int __sframe_validate_section(struct sframe_section *sec)
+{
+	unsigned long prev_ip = 0;
+	unsigned int i;
+
+	for (i = 0; i < sec->num_fdes; i++) {
+		struct sframe_fre *fre, *prev_fre = NULL;
+		unsigned long ip, fre_addr;
+		struct sframe_fde fde;
+		struct sframe_fre fres[2];
+		bool which = false;
+		unsigned int j;
+		int ret;
+
+		ret = __read_fde(sec, i, &fde);
+		if (ret)
+			return ret;
+
+		ip = sec->sframe_start + fde.start_addr;
+		if (ip <= prev_ip) {
+			dbg_sec_uaccess("fde %u not sorted\n", i);
+			return -EFAULT;
+		}
+		prev_ip = ip;
+
+		fre_addr = sec->fres_start + fde.fres_off;
+		for (j = 0; j < fde.fres_num; j++) {
+			int ret;
+
+			fre = which ? fres : fres + 1;
+			which = !which;
+
+			ret = __read_fre(sec, &fde, fre_addr, fre);
+			if (ret) {
+				dbg_sec_uaccess("fde %u: __read_fre(%u) failed\n", i, j);
+				dbg_print_fde_uaccess(sec, &fde);
+				return ret;
+			}
+
+			fre_addr += fre->size;
+
+			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+				dbg_sec_uaccess("fde %u: fre %u not sorted\n", i, j);
+				return -EFAULT;
+			}
+
+			prev_fre = fre;
+		}
+	}
+
+	return 0;
+}
+
+static int sframe_validate_section(struct sframe_section *sec)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start)) {
+		dbg_sec("section usercopy failed\n");
+		return -EFAULT;
+	}
+
+	ret = __sframe_validate_section(sec);
+	user_read_access_end();
+	return ret;
+}
+
+#else /*  !CONFIG_SFRAME_VALIDATION */
+
+static int sframe_validate_section(struct sframe_section *sec) { return 0; }
+
+#endif /* !CONFIG_SFRAME_VALIDATION */
+
+
 static void free_section(struct sframe_section *sec)
 {
 	dbg_free(sec);
@@ -445,6 +522,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 		goto err_free;
 	}
 
+	ret = sframe_validate_section(sec);
+	if (ret)
+		goto err_free;
+
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
 		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
-- 
2.47.2


