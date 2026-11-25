Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587404;
	b=sXIccYB5djWQeTKYFYHAi2H9LAQyuAM4Q/ZZUT0gsaq7vXo0FuqUc+Rv6t0VOea/OTDo
	 da6+wqZHmz1JTFp8UPDfkVz+V4PGiwc7KyDDHZzCn7iRQ13O1xOaw0Wn5WZWofresZyxC
	 +UzQPJ+0Xe0zHxPnBf1Oi2rL3yIHwXNWOWlUoV4EzuWCmi9+dxrxuJcN+zPmAPbr7c3Dh
	 MYU9vdf8IgCzx61oqlSeW1pDl+NMhd14Ykn9u4uuuaNxsbHL3Tn+s5xkleZw4j0OZ9LqZ
	 tWyxtcniLVtqcrS6RsSx/bFEzF+AmP/yGPMVtEy21fwh7xKPp8ZgBBq3WBR0wwLmpaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+QmErJox492f/cV643DmQCmOGVVcvGNSWKULs52mChM=;
	b=ByZx9FwYs6dkb/+AI3LXtRBkGOnU+M44UJVcfMVfubVhgfoyQTcCoqxBA1LzRFnBDyxf
	 oPwTbKi8bxglmTaZS4cVi07GSoK13iQNFo3vV0BYZez4W0sPgf8PmsBFMKIXAI+28M6n8
	 spsZl8CirNEhImaXHp0uC7ynrAgLpmdsiIzHpiX2FvsxwJar/P2C2qsitZaMel/tA6Xj9
	 4ogYqZ9vBxrCbvKilhxy1wc/mybrcnHpGXzDurav9KyQPvk05KBr0IA8/BM2aPOq0Qihf
	 0XPM15mZ5EN36NHCIn7LL5uxlfc02RJN6bvVmWvmb6GpcOa2+oVZCvIxvFY2nteor6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MEbKO0Lo;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0611606D337
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0611606D337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MEbKO0Lo
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-38355b03cb8so5261809eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587403; x=1796192203; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QmErJox492f/cV643DmQCmOGVVcvGNSWKULs52mChM=;
        b=MEbKO0LoHQwLj1bIZk09lifr35NGJ2VkRQ1VTaeJHoksy5TSvXTmTG1xywHP2uaKBn
         cY/1HmHGrV/+b+xxzYRSipC/l/7+wlN2JpSHhDpn+y463ivmz3lPFC4mYLIZonZPJlay
         wVwWerAbSXBxdqhc87qBis7556YTNw3V8W5mYQcTdw0V0sbPhVLiA5FM1qMEbcjm3Zys
         ClOR/usB8LIJXtdhCpIh5jLvlNzXyrK6p4Nf3sgsGk+moC8JZnk3Qb4/3z3Xnwf9zfjO
         j394iLRKNLzQaDay1BmH51N1d9voxfr3Qd1eQRJHoE4LDyzd6xwY1B1Hb3qiIHxTz2pG
         N9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587403; x=1796192203;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+QmErJox492f/cV643DmQCmOGVVcvGNSWKULs52mChM=;
        b=U3DqykUpO+ydyJPm3TEWqiDd7fCMGgURY75nUVHumHO2yPM05TAvKgpou7qRO6fZjb
         FMd+knJ0tnNV1iXiyQ5C4vZjUEw4CBxVnwFxTX8lfwniEEjoKoRRfmdb/sHacN8KG/Ca
         VKMfY93H2S8lMrKWadO9BAm725ikvmel3Ctw4fERkgdvkBa6Nv2zLb5Esd0PPBFSngxI
         9vZ7lmeF3oNyjg0BXOp1PsWrFB8caRn4aVXgeeh7AuXYQcoE6I5cHTPqQUOmL97HHmE/
         STEWvqDTn5KBIpQHuE0q8Rj6dwc2GoVKNssXY49fOjnjkH8GEw5e2aSXT9cm9o1zF+Q/
         54+A==
X-Forwarded-Encrypted: i=1; AL+hErGxcbn5IVjc3EJiIzB8mhKWIXiNdS1F4GfLS1No5fmLqZePxiYOtIe/JCY4qowllxU5fHwoUpg8egpzTePIYVJD@vger.kernel.org
X-Gm-Message-State: APuU4Z9sOSd3o2hOhON+hKNedM/PKvj7LMUqfMBlojQAfrsW9AWYe+I3
	p/hs+cSm2fL3wwXp90HknLsWSUBEbwg63VBqd5F3Dx6mbh8jXyZwuCviSooGblotqaKaxV2xs+c
	/bdBO1lxnTA==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:383:6d6a:6b7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1505:b0:384:df31:6a07
 with SMTP id 5a478bee46e88-386a87efea0mr9863448eec.30.1795587402758; Tue, 24
 Nov 2026 22:16:42 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:16 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-24-irogers@google.com>
Subject: [RFC PATCH v2 23/30] tools headers: Add linux/nospec.h copy from the
 kernel sources
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Copy include/linux/nospec.h to tools/include/linux/nospec.h (using the
standard /* ... */ header SPDX comment style), include
<asm-generic/bitsperlong.h> in tools/include/linux/kernel.h for
BITS_PER_LONG, and register linux/nospec.h in
tools/perf/check-headers.sh.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kernel.h |  1 +
 tools/include/linux/nospec.h | 74 ++++++++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh  |  1 +
 3 files changed, 76 insertions(+)
 create mode 100644 tools/include/linux/nospec.h

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index c8c18d3908a9..e0108edc2251 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -11,6 +11,7 @@
 #include <linux/panic.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <asm-generic/bitsperlong.h>
 #include <linux/container_of.h>
 
 #ifndef UINT_MAX
diff --git a/tools/include/linux/nospec.h b/tools/include/linux/nospec.h
new file mode 100644
index 000000000000..464a9a9e16ba
--- /dev/null
+++ b/tools/include/linux/nospec.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright(c) 2018 Linus Torvalds. All rights reserved.
+// Copyright(c) 2018 Alexei Starovoitov. All rights reserved.
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+
+#ifndef _LINUX_NOSPEC_H
+#define _LINUX_NOSPEC_H
+
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+
+struct task_struct;
+
+#ifndef barrier_nospec
+# define barrier_nospec() do { } while (0)
+#endif
+
+/**
+ * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * When @index is out of bounds (@index >= @size), the sign bit will be
+ * set.  Extend the sign bit to all bits and invert, giving a result of
+ * zero for an out of bounds index, or ~0 if within bounds [0, @size).
+ */
+#ifndef array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	/*
+	 * Always calculate and emit the mask even if the compiler
+	 * thinks the mask is not needed. The compiler does not take
+	 * into account the value of @index under speculation.
+	 */
+	OPTIMIZER_HIDE_VAR(index);
+	return ~(long)(index | (size - 1UL - index)) >> (BITS_PER_LONG - 1);
+}
+#endif
+
+/*
+ * array_index_nospec - sanitize an array index after a bounds check
+ *
+ * For a code sequence like:
+ *
+ *     if (index < size) {
+ *         index = array_index_nospec(index, size);
+ *         val = array[index];
+ *     }
+ *
+ * ...if the CPU speculates past the bounds check then
+ * array_index_nospec() will clamp the index within the range of [0,
+ * size).
+ */
+#define array_index_nospec(index, size)					\
+({									\
+	typeof(index) _i = (index);					\
+	typeof(size) _s = (size);					\
+	unsigned long _mask = array_index_mask_nospec(_i, _s);		\
+									\
+	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
+	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
+									\
+	(typeof(_i)) (_i & _mask);					\
+})
+
+/* Speculation control prctl */
+int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which);
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl);
+/* Speculation control for seccomp enforced mitigation */
+void arch_seccomp_spec_mitigate(struct task_struct *task);
+
+#endif /* _LINUX_NOSPEC_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 76fc6e20096c..3e684c851a86 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -193,6 +193,7 @@ check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
+check include/linux/nospec.h	      '-I "^.*[S]PDX-License-Identifier:"'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
 
 # diff non-symmetric files
-- 
2.56.1.831.g720f3f5937-goog

