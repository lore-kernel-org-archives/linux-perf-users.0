Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0741CEAD8;
	Wed, 22 Jan 2025 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513138; cv=none; b=RVQIyHzxecaIkmvCQM+UFF4wZERnirdorHQ+QDxzCnOqvamy5tWkOfkt0y1MQsL8fp8MzR8yZO697jgSQWZi4MGSvfxmF9r46PVCwAi3SzWJ6oh3/Y6eiR1FiTJtXPfSvdUb9ZuvgTnmCIVmmeBoZiF9DGcmQJIG45gOSSy30xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513138; c=relaxed/simple;
	bh=EszPaQitQ6vk4pAWHbHTmWoDPqRPjbKYb1AQBUCFYns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClTTT+g3Nqq4m2p1nPeWvZR070du5YwxFmHwjJ+CxoJCX2jCdaZxStCvrwG9AStxbT3XByT2fQQIpZXU57Y+N596jNZG5wPxkdW8Sc9ww4OtKFktUvIyDZpw+izZbN78VDpuJ8i5LfsSWAnRvbhKrMTyFPrH5S75uC4uzzFk4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LatzYg7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LatzYg7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6FEC4CEE8;
	Wed, 22 Jan 2025 02:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513138;
	bh=EszPaQitQ6vk4pAWHbHTmWoDPqRPjbKYb1AQBUCFYns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LatzYg7q5LodYyDEjCscsl+C7yxyjLsyY1jOcvt+hpM4fDi5ISm8xSFVSeO5yw9QX
	 AqqHPiwwRazGhHK1h6G0gu6N4tC1i3HhEXDMhK+rxX6+xrma4DPP2hiioSvtHpn1lV
	 FH7CDCWTbh3f009eEIuNs4ITlOKvVb/9q37tHFVCwAEOrFsv12b2QNRWWam1O27f6f
	 0N9fAYsVbnr8ZILgkvWJy5tQ6RLPRm92yaX0PLBsfBsf9ZibilDdPXcVtdMdE0Mz8u
	 IsDuSpEHJKuKakYlKx4prR2rKG3Pqx1l1lLEdGhXyBk00eqgWnF++xavv/oUGMptEZ
	 r/b/Iy+ktszsw==
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
Subject: [PATCH v4 25/39] unwind_user/sframe: Show file name in debug output
Date: Tue, 21 Jan 2025 18:31:17 -0800
Message-ID: <7bfb7ffad5fe384fe3dbe6c8ca985f35b98b48bb.1737511963.git.jpoimboe@kernel.org>
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

When debugging sframe issues, the error messages aren't all that helpful
without knowing what file a corresponding .sframe section belongs to.
Prefix debug output strings with the file name.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/sframe.h       |  4 +++-
 kernel/unwind/sframe.c       | 23 ++++++++++++--------
 kernel/unwind/sframe_debug.h | 41 ++++++++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index 2e70085a1e89..18a04d574090 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -10,7 +10,9 @@
 
 struct sframe_section {
 	struct rcu_head	rcu;
-
+#ifdef CONFIG_DYNAMIC_DEBUG
+	const char	*filename;
+#endif
 	unsigned long	sframe_start;
 	unsigned long	sframe_end;
 	unsigned long	text_start;
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 66b920441692..f463123f9afe 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -295,14 +295,17 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 end:
 	user_read_access_end();
 
-	if (ret == -EFAULT)
+	if (ret == -EFAULT) {
+		dbg_sec("removing bad .sframe section\n");
 		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+	}
 
 	return ret;
 }
 
 static void free_section(struct sframe_section *sec)
 {
+	dbg_free(sec);
 	kfree(sec);
 }
 
@@ -313,7 +316,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	unsigned int num_fdes;
 
 	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
-		dbg("header usercopy failed\n");
+		dbg_sec("header usercopy failed\n");
 		return -EFAULT;
 	}
 
@@ -321,18 +324,18 @@ static int sframe_read_header(struct sframe_section *sec)
 	    shdr.preamble.version != SFRAME_VERSION_2 ||
 	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
 	    shdr.auxhdr_len) {
-		dbg("bad/unsupported sframe header\n");
+		dbg_sec("bad/unsupported sframe header\n");
 		return -EINVAL;
 	}
 
 	if (!shdr.num_fdes || !shdr.num_fres) {
-		dbg("no fde/fre entries\n");
+		dbg_sec("no fde/fre entries\n");
 		return -EINVAL;
 	}
 
 	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
 	if (header_end >= sec->sframe_end) {
-		dbg("header doesn't fit in section\n");
+		dbg_sec("header doesn't fit in section\n");
 		return -EINVAL;
 	}
 
@@ -344,7 +347,7 @@ static int sframe_read_header(struct sframe_section *sec)
 	fres_end   = fres_start + shdr.fre_len;
 
 	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
-		dbg("inconsistent fde/fre offsets\n");
+		dbg_sec("inconsistent fde/fre offsets\n");
 		return -EINVAL;
 	}
 
@@ -400,6 +403,8 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 	sec->text_start		= text_start;
 	sec->text_end		= text_end;
 
+	dbg_init(sec);
+
 	ret = sframe_read_header(sec);
 	if (ret) {
 		dbg_print_header(sec);
@@ -408,8 +413,8 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
 	if (ret) {
-		dbg("mtree_insert_range failed: text=%lx-%lx\n",
-		    sec->text_start, sec->text_end);
+		dbg_sec("mtree_insert_range failed: text=%lx-%lx\n",
+			sec->text_start, sec->text_end);
 		goto err_free;
 	}
 
@@ -431,7 +436,7 @@ static int __sframe_remove_section(struct mm_struct *mm,
 				   struct sframe_section *sec)
 {
 	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
-		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
+		dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
 		return -EINVAL;
 	}
 
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index 055c8c8fae24..4d121cdbb760 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -10,26 +10,55 @@
 #define dbg(fmt, ...)							\
 	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
 
+#define dbg_sec(fmt, ...)						\
+	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
+
 static __always_inline void dbg_print_header(struct sframe_section *sec)
 {
 	unsigned long fdes_end;
 
 	fdes_end = sec->fdes_start + (sec->num_fdes * sizeof(struct sframe_fde));
 
-	dbg("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
-	    "fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
-	    "ra_off:%d fp_off:%d\n",
-	    sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
-	    sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
-	    sec->ra_off, sec->fp_off);
+	dbg_sec("SEC: sframe:0x%lx-0x%lx text:0x%lx-0x%lx "
+		"fdes:0x%lx-0x%lx fres:0x%lx-0x%lx "
+		"ra_off:%d fp_off:%d\n",
+		sec->sframe_start, sec->sframe_end, sec->text_start, sec->text_end,
+		sec->fdes_start, fdes_end, sec->fres_start, sec->fres_end,
+		sec->ra_off, sec->fp_off);
+}
+
+static inline void dbg_init(struct sframe_section *sec)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	guard(mmap_read_lock)(mm);
+	vma = vma_lookup(mm, sec->sframe_start);
+	if (!vma)
+		sec->filename = kstrdup("(vma gone???)", GFP_KERNEL);
+	else if (vma->vm_file)
+		sec->filename = kstrdup_quotable_file(vma->vm_file, GFP_KERNEL);
+	else if (!vma->vm_mm)
+		sec->filename = kstrdup("(vdso)", GFP_KERNEL);
+	else
+		sec->filename = kstrdup("(anonymous)", GFP_KERNEL);
+}
+
+static inline void dbg_free(struct sframe_section *sec)
+{
+	kfree(sec->filename);
 }
 
 #else /* !CONFIG_DYNAMIC_DEBUG */
 
 #define dbg(args...)			no_printk(args)
+#define dbg_sec(args...	)		no_printk(args)
 
 static inline void dbg_print_header(struct sframe_section *sec) {}
 
+static inline void dbg_init(struct sframe_section *sec) {}
+static inline void dbg_free(struct sframe_section *sec) {}
+
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 
 #endif /* _SFRAME_DEBUG_H */
-- 
2.48.1

