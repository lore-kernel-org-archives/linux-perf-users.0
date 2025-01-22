Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293A1D47AE;
	Wed, 22 Jan 2025 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513139; cv=none; b=Q6jlOZSi7/GZC3ntlk1EHv1jC5WvwYXfZ7IzcXFWaKJzqcG6gbo/iDZcifbbeyd2tcb5MGI/Z1B0V4SwWnv2hSNT4YqgSzVUH+sQHRbk5y4Bi0TsY/FNflPP7v1YJMf4uo2oj++MlB+MZROozw6flRRtuaTb5EpxaNjdwF4pOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513139; c=relaxed/simple;
	bh=B3rzqWK+3dbuAMW6Yd/wHbo0urS3X1S4CoqxAu7Q/kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU/Hjkzhqkxy3Rg3isCtRc2X6jsX9j9CgjvMkUwE4pqPYzcHLoj/1unhF2tuG0B17+ze+PLL1OsThSnqlWJRiY2Rln1YNfbr9i8RGNwh9Q4cp1S84sQIMpeRr6G5e7Z29p9CXD7Yh1QW4YmvFQgeghiGCoXRUr+T5/rnnsfYFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOs7iLC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOs7iLC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482D1C4CEE2;
	Wed, 22 Jan 2025 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513139;
	bh=B3rzqWK+3dbuAMW6Yd/wHbo0urS3X1S4CoqxAu7Q/kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOs7iLC+5Y5SrGTs+eo1KrPvKXGsuXcr6f96sJ+5cNCVKFqeCSgWZOfXyOSj+RxxN
	 GVMtk7EWG6cvLgFcM5uDToqIKjSMYcN2WGCMOTlx/8smeoo0SFRVHCeaEIBd6KD2bB
	 3bS5cpt4MN8xVWDNzlc2VldfshL979OlZH2Tr655aqQ35ZTE1YQe71gzifVOUFvl5V
	 Wzr6ve+JcAEpG6dQftuBERuN1RsPlGb/bODQsLn1kSkfTKGR1sX82b4rEMAzWJ8DyA
	 MWnbv/FjR8YnvXWGc0T6y5lyU3QlJD4p6Cn0jElKRpb8Uyy1mf3YnK1q3J4+d21lM+
	 nI+R1/HzDkmhQ==
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
Subject: [PATCH v4 26/39] unwind_user/sframe: Enable debugging in uaccess regions
Date: Tue, 21 Jan 2025 18:31:18 -0800
Message-ID: <990b28ae7855b67c5e6d6385b9de78ffa336dd73.1737511963.git.jpoimboe@kernel.org>
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

Objtool warns about calling pr_debug() from uaccess-enabled regions, and
rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
uaccess before doing the dynamic printk, and use that to add debug
messages throughout the uaccess-enabled regions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/unwind/sframe.c       | 59 ++++++++++++++++++++++++++++--------
 kernel/unwind/sframe_debug.h | 31 +++++++++++++++++++
 2 files changed, 77 insertions(+), 13 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f463123f9afe..a2ca26b952d3 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -53,12 +53,15 @@ static __always_inline int __read_fde(struct sframe_section *sec,
 			      sizeof(struct sframe_fde), Efault);
 
 	ip = sec->sframe_start + fde->start_addr;
-	if (ip < sec->text_start || ip > sec->text_end)
+	if (ip < sec->text_start || ip > sec->text_end) {
+		dbg_sec_uaccess("bad fde num %d\n", fde_num);
 		return -EINVAL;
+	}
 
 	return 0;
 
 Efault:
+	dbg_sec_uaccess("fde %d usercopy failed\n", fde_num);
 	return -EFAULT;
 }
 
@@ -85,16 +88,22 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		unsafe_get_user(func_off, (s32 __user *)mid, Efault);
 
 		if (ip_off >= func_off) {
-			if (func_off < func_off_low)
+			if (func_off < func_off_low) {
+				dbg_sec_uaccess("fde %u not sorted\n",
+						(unsigned int)(mid - first));
 				return -EFAULT;
+			}
 
 			func_off_low = func_off;
 
 			found = mid;
 			low = mid + 1;
 		} else {
-			if (func_off > func_off_high)
+			if (func_off > func_off_high) {
+				dbg_sec_uaccess("fde %u not sorted\n",
+						(unsigned int)(mid - first));
 				return -EFAULT;
+			}
 
 			func_off_high = func_off;
 
@@ -140,6 +149,8 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 		__UNSAFE_GET_USER_INC(to, from, u32, label);		\
 		break;							\
 	default:							\
+		dbg_sec_uaccess("%d: bad UNSAFE_GET_USER_INC size %u\n",\
+				__LINE__, size);			\
 		return -EFAULT;						\
 	}								\
 })
@@ -158,24 +169,34 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	u8 info;
 
 	addr_size = fre_type_to_size(fre_type);
-	if (!addr_size)
+	if (!addr_size) {
+		dbg_sec_uaccess("bad addr_size in fde info %u\n", fde->info);
 		return -EFAULT;
+	}
 
-	if (fre_addr + addr_size + 1 > sec->fres_end)
+	if (fre_addr + addr_size + 1 > sec->fres_end) {
+		dbg_sec_uaccess("fre addr+info goes past end of subsection\n");
 		return -EFAULT;
+	}
 
 	UNSAFE_GET_USER_INC(ip_off, cur, addr_size, Efault);
-	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size)
+	if (fde_type == SFRAME_FDE_TYPE_PCINC && ip_off > fde->func_size) {
+		dbg_sec_uaccess("fre starts past end of function: ip_off=0x%x, func_size=0x%x\n",
+				ip_off, fde->func_size);
 		return -EFAULT;
+	}
 
 	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
 	offset_count = SFRAME_FRE_OFFSET_COUNT(info);
 	offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
-	if (!offset_count || !offset_size)
+	if (!offset_count || !offset_size) {
+		dbg_sec_uaccess("zero offset_count or size in fre info %u\n",info);
 		return -EFAULT;
-
-	if (cur + (offset_count * offset_size) > sec->fres_end)
+	}
+	if (cur + (offset_count * offset_size) > sec->fres_end) {
+		dbg_sec_uaccess("fre goes past end of subsection\n");
 		return -EFAULT;
+	}
 
 	fre->size = addr_size + 1 + (offset_count * offset_size);
 
@@ -184,8 +205,10 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 
 	ra_off = sec->ra_off;
 	if (!ra_off) {
-		if (!offset_count--)
+		if (!offset_count--) {
+			dbg_sec_uaccess("zero offset_count, can't find ra_off\n");
 			return -EFAULT;
+		}
 
 		UNSAFE_GET_USER_INC(ra_off, cur, offset_size, Efault);
 	}
@@ -196,8 +219,10 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 		UNSAFE_GET_USER_INC(fp_off, cur, offset_size, Efault);
 	}
 
-	if (offset_count)
+	if (offset_count) {
+		dbg_sec_uaccess("non-zero offset_count after reading fre\n");
 		return -EFAULT;
+	}
 
 	fre->ip_off		= ip_off;
 	fre->cfa_off		= cfa_off;
@@ -208,6 +233,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	return 0;
 
 Efault:
+	dbg_sec_uaccess("fre usercopy failed\n");
 	return -EFAULT;
 }
 
@@ -241,13 +267,20 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		which = !which;
 
 		ret = __read_fre(sec, fde, fre_addr, fre);
-		if (ret)
+		if (ret) {
+			dbg_sec_uaccess("fde addr 0x%x: __read_fre(%u) failed\n",
+					fde->start_addr, i);
+			dbg_print_fde_uaccess(sec, fde);
 			return ret;
+		}
 
 		fre_addr += fre->size;
 
-		if (prev_fre && fre->ip_off <= prev_fre->ip_off)
+		if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+			dbg_sec_uaccess("fde addr 0x%x: fre %u not sorted\n",
+					fde->start_addr, i);
 			return -EFAULT;
+		}
 
 		if (fre->ip_off > ip_off)
 			break;
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index 4d121cdbb760..3bb3c5574aee 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -13,6 +13,26 @@
 #define dbg_sec(fmt, ...)						\
 	dbg("%s: " fmt, sec->filename, ##__VA_ARGS__)
 
+#define __dbg_sec_descriptor(fmt, ...)					\
+	__dynamic_pr_debug(&descriptor, "sframe: %s: " fmt,		\
+			   sec->filename, ##__VA_ARGS__)
+
+/*
+ * To avoid breaking uaccess rules, temporarily disable uaccess
+ * before calling printk.
+ */
+#define dbg_sec_uaccess(fmt, ...)					\
+({									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor)) {				\
+		user_read_access_end();					\
+		__dbg_sec_descriptor(fmt, ##__VA_ARGS__);		\
+		BUG_ON(!user_read_access_begin(				\
+				(void __user *)sec->sframe_start,	\
+				sec->sframe_end - sec->sframe_start));	\
+	}								\
+})
+
 static __always_inline void dbg_print_header(struct sframe_section *sec)
 {
 	unsigned long fdes_end;
@@ -27,6 +47,15 @@ static __always_inline void dbg_print_header(struct sframe_section *sec)
 		sec->ra_off, sec->fp_off);
 }
 
+static __always_inline void dbg_print_fde_uaccess(struct sframe_section *sec,
+						  struct sframe_fde *fde)
+{
+	dbg_sec_uaccess("FDE: start_addr:0x%x func_size:0x%x "
+			"fres_off:0x%x fres_num:%d info:%u rep_size:%u\n",
+			fde->start_addr, fde->func_size,
+			fde->fres_off, fde->fres_num, fde->info, fde->rep_size);
+}
+
 static inline void dbg_init(struct sframe_section *sec)
 {
 	struct mm_struct *mm = current->mm;
@@ -53,8 +82,10 @@ static inline void dbg_free(struct sframe_section *sec)
 
 #define dbg(args...)			no_printk(args)
 #define dbg_sec(args...	)		no_printk(args)
+#define dbg_sec_uaccess(args...)	no_printk(args)
 
 static inline void dbg_print_header(struct sframe_section *sec) {}
+static inline void dbg_print_fde_uaccess(struct sframe_section *sec, struct sframe_fde *fde) {}
 
 static inline void dbg_init(struct sframe_section *sec) {}
 static inline void dbg_free(struct sframe_section *sec) {}
-- 
2.48.1

