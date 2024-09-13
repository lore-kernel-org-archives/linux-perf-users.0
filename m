Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773618785F;
	Fri, 13 Sep 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268583; cv=none; b=mf6rOsLnoq7/hom0hUepCI5BUCwo1toMxzQpvd9yWQfzH+iTzCoBk4P/CNsakMyAbPGZ81mwhBMbATC11+L5Iu/mhb+dWT1rxp377XRp5fHJWdHgl8NSKf69CO0hq1K2WxFNvV5qz74Bfq0Mw9n3eKSty26q9pBQMh/N3tIlxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268583; c=relaxed/simple;
	bh=Ab1OGV8cOmFkRUQsKiONmAb7LX06hR3QPA6EWPVv8pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfG6XO5T+zg1lcvc7mSJA2IWzPKjpgdOEG6GMVDpMXmDakXqMv5XcZJsrUrJmMPtyo3wm2iRroH4Wus7CSCjl+5PE5VK+V/nqBu44xx3jWz6uG+h6LUYCl4l0Wujp+Jj0NeKGKBlPPjXFjJjLTkSzIiyS6ck42iUc4k7dLtN34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exNg8iID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exNg8iID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7209DC4CEC0;
	Fri, 13 Sep 2024 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268583;
	bh=Ab1OGV8cOmFkRUQsKiONmAb7LX06hR3QPA6EWPVv8pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exNg8iIDO52bZLTNsYVzcfuj2qrWaBXxX/uwLXJ7QlY2PgBGLtRilC7LnQO+k0Zn8
	 FD7JdoUyaHzdYrFJcrMBuvbOMSDTDqPpuSevIr5MNDxPSpsNexKwrr5SpX42uXRxOV
	 Ce2P8xEkrCyg0Nh721o++DBCtCBKH5SWzc3uWcgFTvg6SAOULhWitIvSLG6JontQt5
	 MKiI7DSQ9SeFzpHz/UiKvMhSicxnHN1jMRVnJAeAZJK15YIeC/1d35naR29ZM8ktiO
	 YsW4XwNY3DLxiPp3xzYTlYCBcX9zlJ4d8kTRIyKZKHSQxZcYZXoi2UrGVM55ckga7S
	 yd0eAy654HLNw==
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
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 02/11] unwind/x86: Add HAVE_USER_UNWIND
Date: Sat, 14 Sep 2024 01:02:04 +0200
Message-ID: <82ef19a767cb75e76a985ecc0d47a39400b4fdf5.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable HAVE_USER_UNWIND accordinlgy so the user unwind
interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/user_unwind.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/user_unwind.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..266edff59058 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -286,6 +286,7 @@ config X86
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
+	select HAVE_USER_UNWIND
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
diff --git a/arch/x86/include/asm/user_unwind.h b/arch/x86/include/asm/user_unwind.h
new file mode 100644
index 000000000000..8c509c65cfb5
--- /dev/null
+++ b/arch/x86/include/asm/user_unwind.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_USER_UNWIND_H
+#define _ASM_X86_USER_UNWIND_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.cfa_off	= (s32)sizeof(long) * 2,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_USER_UNWIND_H */
-- 
2.46.0

