Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24391D5CCC;
	Wed, 22 Jan 2025 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513140; cv=none; b=FptLNt/NPCO2ooSlKnvmMg/TiN6r6oLX+4ekK3vwo14EbtjDyYf/P3WoApBvo12b/zrvePC5+UZ9wFTBuWAV/Hnj92c7EDDmHd9wGuFJnHLuNfBqbB5lrqt+VFqggp/jtcuJnwSf0NlytXrEwsg+LOnSok6UD/r/GOrINHgQl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513140; c=relaxed/simple;
	bh=YdokVxORLyw0FxMyJUC9g39qf45hCSMsY+ha4iDY2z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfPmgXN64vMZrcKFWuQRQIdBWH1aasyHT+b+4ytz68KHWoxDvFZpyHjJQi6GEJYjSoK3r/pBRnbN/eAyddCPnleF8wp/sjhA/y0aIB/Oe/63hlKUjwfq3o4p3OUZwVnJTtUM4ItgTf5c/Uo8FdVZdkFRgUk74GpALkOfT+VZrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONBj9H+M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONBj9H+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C119C4CEDF;
	Wed, 22 Jan 2025 02:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513140;
	bh=YdokVxORLyw0FxMyJUC9g39qf45hCSMsY+ha4iDY2z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONBj9H+M9B5Xi79oMeluW0MFsqv4B12Wm9Kgs0AtvwcMN91PavPN4dw38XCl0hfQd
	 ymjxZG+WXlLYfq15A0AR1cBwMEKvuENcTnmsU7rD6wqawyQONeBREoEsgLUOcu23gs
	 BhQ4XENgRZRoqa0+uXYxh5rJ7uV9E38JSLzQwx3clDr4RvbI937eXR4Rpbe1Nzz6b0
	 COXlynXlGTfKZtqi6k3/zm/mWS+ZjKUhfbrkcqMUCRKM6rZsRS/UkoY6UEUqmgDR+X
	 +V1Yi5qZpO1DNTQgFKZ8qCk/OADJ+bvjqdYBJQrsOxD94MFcsQLJmKtQbuh5+8GnC1
	 TJx+QYOUDo5Nw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 27/39] unwind_user/sframe: Add .sframe validation option
Date: Tue, 21 Jan 2025 18:31:19 -0800
Message-ID: <3c7be3db0795ba8d660ee21ef5980e8ab7780c12.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debug feature to validate all .sframe sections when first loading
the file rather than on demand.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig           | 19 ++++++++++
 kernel/unwind/sframe.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 12a3b73cbe66..b3676605bab6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -453,6 +453,25 @@ config HAVE_UNWIND_USER_SFRAME
 config AS_SFRAME
 	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
 
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
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index a2ca26b952d3..bba14c5fe0f5 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -336,6 +336,83 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
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
@@ -444,6 +521,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
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
2.48.1

