Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5E1F4720
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064688; cv=none; b=b5OmXo+LZ9r6O/vmMkKlufcVWJlx/uFB/kp6GqVi6if55k/Hfb3f28pSLBdkgc9/fOU5hWQ1zdMJWVkJzNI8ZSmkQ3cvvZL2y9Piw93OCkZIW8BEiHqeyThcSiZogDG64QqRk9qwYaRTC1NZmSWVlUd+PivVH+gQb9VwkOQbeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064688; c=relaxed/simple;
	bh=UAdTXgXd4bkPJvBFqJCyLix7tEZo9Ca1gJq+BlphjRU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q8ViOS5f3ScKSkepFaf1mD0gLmMpeZCZWBroZtgi7WECCF1/lkJ2jmzEZXYJGcvtIf5yQP5NUUZ+Rj2JMfUEYFoLX9ef44AwHY43ssYSFU6ponC/nqTdnQKDbi76Rdt0YnhJwZFQFseXUt7bDPbQVYhT1kobpqJTqnh6gSaAUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r358NYWH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r358NYWH"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572f6dee18so7663913276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 21:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064685; x=1741669485; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWY3CQdN9GvCFBctugEPOsen4KmaxcXhCNBBJzS7Stg=;
        b=r358NYWHjdUDoD1ACceJeVt5U4kDcYhspV78yGe+JsK/MyMQe6Hu3KoRxznJToKnHe
         546adaFLWFZ9AjTliEMwpQaIfXyKHEoJ4aR9ZDJ38HKaIF0fzZP3bMj9UHC2Lih57Jdx
         Kb1PON5aUbqOE61fFboGw196198qu96VEmkQgxT7xG9nIU6NAH9plSj9hsbxI3Jl2y1P
         t+fjVZOm7gW/zRMkqUdFFRcF1L2i9P30UXUw2z0/d0pV3eFXEw1unJDXBbhvx8h47f9k
         /SzQl1DUpfiSq3CZoxbWomjfx7H6AqD5a8G4LPYsC4be2CIR/eA1s6m/0G4Z8K/T6kbq
         CW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064685; x=1741669485;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWY3CQdN9GvCFBctugEPOsen4KmaxcXhCNBBJzS7Stg=;
        b=YjW2FEDhxQRc2GRyqfQiKMOIhFM1l6ViLAh+hOiBkk4KrDIhMa9ZcTARA7GPpwVNUR
         OvB+F0spo9zuVOXpIJ8tkmsJxrEwlFSq6oK/uczZJbopH7MD9QWI3ppVL3sOvpJK/+ZE
         gkdtunEfuaQdw6oInKE06HdX/9VACO0hTmjcnHpAiw5crQIXCAPSRuhJrbic3Rr9AFX1
         tLoGUt3SVDDnyKqyjb8cn3twejCU7KB1KLy1WUjo5cO8eTmq3DtYok4bZFQvCATVfYKf
         kFXgyPMrA+2I8dtZl0JseH4OP0q7A4Say4P476omflKW/A4d349xZFzXP8D71JM2Ynwr
         hHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXgZ5R8gl4FFTimkl8/JeplKpU8n7aTCjBNJbUgeRY8yziOoFZPaYVJB8Muy6oLhywe5YBin17nCk0asH9XHr+D@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZdtWXG/MjUV3MDcYcCAPrVhAvXyW09H8j2EiSLAvJx3wg343
	jEBR3IO/c27nZ+UA+2txaTA7hZDEbwT+cdckVKqgcQhUamQQHNmo7CE0QvPY1kp4Bjc1pFZht+z
	hpdCsjQ==
X-Google-Smtp-Source: AGHT+IHh4Pay//m8IdDD/BM9F/1ItK/YFpkg8J2Ryf9cKAEsEfP/xU4ScJslyfFs74xvOqKJyusJ4dQbbTOq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a25:a442:0:b0:e5d:bd27:92a with SMTP id
 3f1490d57ef6-e60b2f332c6mr152091276.4.1741064685190; Mon, 03 Mar 2025
 21:04:45 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:04 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 10/11] perf build: Remove Makefile.syscalls
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Now a single beauty file is generated and used by all architectures,
remove the per-architecture Makefiles, Kbuild files and previous
generator script.

Note: there was conversation with Charlie Jenkins
<charlie@rivosinc.com> and they'd written an alternate approach to
support multiple architectures:
https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
It would have been better to have helped Charlie fix their series (my
apologies) but they agreed that the approach taken here was likely
best for longer term maintainability:
https://lore.kernel.org/lkml/Z6Jk_UN9i69QGqUj@ghost/

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                      |  1 -
 tools/perf/arch/alpha/entry/syscalls/Kbuild   |  2 -
 .../alpha/entry/syscalls/Makefile.syscalls    |  5 --
 tools/perf/arch/arc/entry/syscalls/Kbuild     |  2 -
 .../arch/arc/entry/syscalls/Makefile.syscalls |  3 -
 tools/perf/arch/arm/entry/syscalls/Kbuild     |  4 -
 .../arch/arm/entry/syscalls/Makefile.syscalls |  2 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild   |  3 -
 .../arm64/entry/syscalls/Makefile.syscalls    |  6 --
 tools/perf/arch/csky/entry/syscalls/Kbuild    |  2 -
 .../csky/entry/syscalls/Makefile.syscalls     |  3 -
 .../perf/arch/loongarch/entry/syscalls/Kbuild |  2 -
 .../entry/syscalls/Makefile.syscalls          |  3 -
 tools/perf/arch/mips/entry/syscalls/Kbuild    |  2 -
 .../mips/entry/syscalls/Makefile.syscalls     |  5 --
 tools/perf/arch/parisc/entry/syscalls/Kbuild  |  3 -
 .../parisc/entry/syscalls/Makefile.syscalls   |  6 --
 tools/perf/arch/powerpc/entry/syscalls/Kbuild |  3 -
 .../powerpc/entry/syscalls/Makefile.syscalls  |  6 --
 tools/perf/arch/riscv/entry/syscalls/Kbuild   |  2 -
 .../riscv/entry/syscalls/Makefile.syscalls    |  4 -
 tools/perf/arch/s390/entry/syscalls/Kbuild    |  2 -
 .../s390/entry/syscalls/Makefile.syscalls     |  5 --
 tools/perf/arch/sh/entry/syscalls/Kbuild      |  2 -
 .../arch/sh/entry/syscalls/Makefile.syscalls  |  4 -
 tools/perf/arch/sparc/entry/syscalls/Kbuild   |  3 -
 .../sparc/entry/syscalls/Makefile.syscalls    |  5 --
 tools/perf/arch/x86/entry/syscalls/Kbuild     |  3 -
 .../arch/x86/entry/syscalls/Makefile.syscalls |  6 --
 tools/perf/arch/xtensa/entry/syscalls/Kbuild  |  2 -
 .../xtensa/entry/syscalls/Makefile.syscalls   |  4 -
 tools/perf/scripts/Makefile.syscalls          | 61 ---------------
 tools/perf/scripts/syscalltbl.sh              | 76 -------------------
 33 files changed, 242 deletions(-)
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/scripts/Makefile.syscalls
 delete mode 100755 tools/perf/scripts/syscalltbl.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f949ec72f3d2..f3cd8de15d1a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -339,7 +339,6 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
 FEATURE_TESTS := all
 endif
 endif
-include $(srctree)/tools/perf/scripts/Makefile.syscalls
 include Makefile.config
 endif
 
diff --git a/tools/perf/arch/alpha/entry/syscalls/Kbuild b/tools/perf/arch/alpha/entry/syscalls/Kbuild
deleted file mode 100644
index 9a41e3572c3a..000000000000
--- a/tools/perf/arch/alpha/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls b/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 690168aac34d..000000000000
--- a/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_64  +=
-
-syscalltbl = $(srctree)/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
deleted file mode 100644
index 11707c481a24..000000000000
--- a/tools/perf/arch/arc/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 391d30ab7a83..000000000000
--- a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arm/entry/syscalls/Kbuild b/tools/perf/arch/arm/entry/syscalls/Kbuild
deleted file mode 100644
index 9d777540f089..000000000000
--- a/tools/perf/arch/arm/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += oabi
-syscalltbl = $(srctree)/tools/perf/arch/arm/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 11707c481a24..000000000000
--- a/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arm64/entry/syscalls/Kbuild b/tools/perf/arch/arm64/entry/syscalls/Kbuild
deleted file mode 100644
index 84c6599b4ea6..000000000000
--- a/tools/perf/arch/arm64/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index e7e78c2d1c02..000000000000
--- a/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 +=
-syscall_abis_64 += renameat rlimit memfd_secret
-
-syscalltbl = $(srctree)/tools/perf/arch/arm64/entry/syscalls/syscall_%.tbl
diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
deleted file mode 100644
index 11707c481a24..000000000000
--- a/tools/perf/arch/csky/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index ea2dd10d0571..000000000000
--- a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Kbuild b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
deleted file mode 100644
index 9a41e3572c3a..000000000000
--- a/tools/perf/arch/loongarch/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 47d32da2aed8..000000000000
--- a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_64 +=
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
deleted file mode 100644
index 9a41e3572c3a..000000000000
--- a/tools/perf/arch/mips/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 9ee914bdfb05..000000000000
--- a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_64 += n64
-
-syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
diff --git a/tools/perf/arch/parisc/entry/syscalls/Kbuild b/tools/perf/arch/parisc/entry/syscalls/Kbuild
deleted file mode 100644
index 84c6599b4ea6..000000000000
--- a/tools/perf/arch/parisc/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index ae326fecb83b..000000000000
--- a/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32  +=
-syscall_abis_64  +=
-
-syscalltbl = $(srctree)/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Kbuild b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
deleted file mode 100644
index 84c6599b4ea6..000000000000
--- a/tools/perf/arch/powerpc/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index e35afbc57c79..000000000000
--- a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += nospu
-syscall_abis_64 += nospu
-
-syscalltbl = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/riscv/entry/syscalls/Kbuild b/tools/perf/arch/riscv/entry/syscalls/Kbuild
deleted file mode 100644
index 9a41e3572c3a..000000000000
--- a/tools/perf/arch/riscv/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 9668fd1faf60..000000000000
--- a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += riscv memfd_secret
-syscall_abis_64 += riscv rlimit memfd_secret
diff --git a/tools/perf/arch/s390/entry/syscalls/Kbuild b/tools/perf/arch/s390/entry/syscalls/Kbuild
deleted file mode 100644
index 9a41e3572c3a..000000000000
--- a/tools/perf/arch/s390/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 9762d7abf17c..000000000000
--- a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_64 += renameat rlimit memfd_secret
-
-syscalltbl = $(srctree)/tools/perf/arch/s390/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/sh/entry/syscalls/Kbuild b/tools/perf/arch/sh/entry/syscalls/Kbuild
deleted file mode 100644
index 11707c481a24..000000000000
--- a/tools/perf/arch/sh/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls b/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 25080390e4ed..000000000000
--- a/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 +=
-syscalltbl = $(srctree)/tools/perf/arch/sh/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/sparc/entry/syscalls/Kbuild b/tools/perf/arch/sparc/entry/syscalls/Kbuild
deleted file mode 100644
index 84c6599b4ea6..000000000000
--- a/tools/perf/arch/sparc/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index 212c1800b644..000000000000
--- a/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32  +=
-syscall_abis_64  +=
-syscalltbl = $(srctree)/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/x86/entry/syscalls/Kbuild b/tools/perf/arch/x86/entry/syscalls/Kbuild
deleted file mode 100644
index 84c6599b4ea6..000000000000
--- a/tools/perf/arch/x86/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
-syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index db3d5d6d4e56..000000000000
--- a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32 += i386
-syscall_abis_64 +=
-
-syscalltbl = $(srctree)/tools/perf/arch/x86/entry/syscalls/syscall_%.tbl
diff --git a/tools/perf/arch/xtensa/entry/syscalls/Kbuild b/tools/perf/arch/xtensa/entry/syscalls/Kbuild
deleted file mode 100644
index 11707c481a24..000000000000
--- a/tools/perf/arch/xtensa/entry/syscalls/Kbuild
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls b/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
deleted file mode 100644
index d4aa2358460c..000000000000
--- a/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-syscall_abis_32  +=
-syscalltbl = $(srctree)/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
diff --git a/tools/perf/scripts/Makefile.syscalls b/tools/perf/scripts/Makefile.syscalls
deleted file mode 100644
index 8bf55333262e..000000000000
--- a/tools/perf/scripts/Makefile.syscalls
+++ /dev/null
@@ -1,61 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# This Makefile generates headers in
-# tools/perf/arch/$(SRCARCH)/include/generated/asm from the architecture's
-# syscall table. This will either be from the generic syscall table, or from a
-# table that is specific to that architecture.
-
-PHONY := all
-all:
-
-obj := $(OUTPUT)arch/$(SRCARCH)/include/generated/asm
-
-syscall_abis_32  := common,32
-syscall_abis_64  := common,64
-syscalltbl := $(srctree)/tools/scripts/syscall.tbl
-
-# let architectures override $(syscall_abis_%) and $(syscalltbl)
--include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Makefile.syscalls
-include $(srctree)/tools/build/Build.include
--include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Kbuild
-
-systbl := $(srctree)/tools/perf/scripts/syscalltbl.sh
-
-syscall-y   := $(addprefix $(obj)/, $(syscall-y))
-
-# Remove stale wrappers when the corresponding files are removed from generic-y
-old-headers := $(wildcard $(obj)/*.h)
-unwanted    := $(filter-out $(syscall-y),$(old-headers))
-
-quiet_cmd_remove = REMOVE  $(unwanted)
-      cmd_remove = rm -f $(unwanted)
-
-quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
-		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
-		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
-		   $< $@
-
-all: $(syscall-y)
-	$(if $(unwanted),$(call cmd,remove))
-	@:
-
-$(obj)/syscalls_%.h: $(syscalltbl) $(systbl) FORCE
-	$(call if_changed,systbl)
-
-targets := $(syscall-y)
-
-# Create output directory. Skip it if at least one old header exists
-# since we know the output directory already exists.
-ifeq ($(old-headers),)
-$(shell mkdir -p $(obj))
-endif
-
-PHONY += FORCE
-
-FORCE:
-
-existing-targets := $(wildcard $(sort $(targets)))
-
--include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
-
-.PHONY: $(PHONY)
diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscalltbl.sh
deleted file mode 100755
index a39b3013b103..000000000000
--- a/tools/perf/scripts/syscalltbl.sh
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate a syscall table header.
-#
-# Each line of the syscall table should have the following format:
-#
-# NR ABI NAME [NATIVE] [COMPAT]
-#
-# NR       syscall number
-# ABI      ABI name
-# NAME     syscall name
-# NATIVE   native entry point (optional)
-# COMPAT   compat entry point (optional)
-
-set -e
-
-usage() {
-	echo >&2 "usage: $0 [--abis ABIS] INFILE OUTFILE" >&2
-	echo >&2
-	echo >&2 "  INFILE    input syscall table"
-	echo >&2 "  OUTFILE   output header file"
-	echo >&2
-	echo >&2 "options:"
-	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
-	exit 1
-}
-
-# default unless specified by options
-abis=
-
-while [ $# -gt 0 ]
-do
-	case $1 in
-	--abis)
-		abis=$(echo "($2)" | tr ',' '|')
-		shift 2;;
-	-*)
-		echo "$1: unknown option" >&2
-		usage;;
-	*)
-		break;;
-	esac
-done
-
-if [ $# -ne 2 ]; then
-	usage
-fi
-
-infile="$1"
-outfile="$2"
-
-sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
-grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
-
-echo "static const char *const syscall_num_to_name[] = {" > $outfile
-# the params are: nr abi name entry compat
-# use _ for intentionally unused variables according to SC2034
-while read nr _ name _ _; do
-	echo "	[$nr] = \"$name\"," >> $outfile
-done < $sorted_table
-echo "};" >> $outfile
-
-echo "static const uint16_t syscall_sorted_names[] = {" >> $outfile
-
-# When sorting by name, add a suffix of 0s upto 20 characters so that system
-# calls that differ with a numerical suffix don't sort before those
-# without. This default behavior of sort differs from that of strcmp used at
-# runtime. Use sed to strip the trailing 0s suffix afterwards.
-grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > $sorted_table
-while read name nr; do
-	echo "	$nr,	/* $name */" >> $outfile
-done < $sorted_table
-echo "};" >> $outfile
-
-rm -f $sorted_table
-- 
2.48.1.711.g2feabab25a-goog

