Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E54EA38C;
	Fri, 16 Oct 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161110; cv=none; b=USTV6u12MAXD+Pi67lafYeqy1CCl7FHkNfcG+TR5JYm1X9r93UfJ1hM39SxPrbfO5DNwPtFExED+TBr1Wy04F42PEHfkKLwW7LOOSPWWcmRfeNo7Jr0to8JLUyRPaBF5tNU9c/QskRmzrhblXNvYN8kjr92pirBVI2BS3AVavDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161110; c=relaxed/simple;
	bh=Wrfu9DaqsDJBSZMc1n0g4k3f2sNdA7iB7nhZpwXz42Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipUqUohn2VXsJpagU7ay5scI2RAEafyDiGmhWoDGK1ykVD1AVeKLhydix/VDZFuPCBZtUGmLLrkg4Xs4ptXbPVMzhODLgTEEv9e8ZnCOV9t91zk5BN9Gn8jrLVV9bJqfFgZn3y3sPyrH99XIpEFaqqkVSpIBCfIiaT0GjlO09b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqZs7e9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqZs7e9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB901F000C5;
	Fri, 16 Oct 2026 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161108;
	bh=3dLiCf5+L0FPVXM+Q7P2mSN5eq5k+oT697lrUTAajqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqZs7e9+zpBvB1vutwQ+PfhLPwhYy6hxbGmPVuHWJBYLo2hLPCfaYRmXv2kSM+4YF
	 TBeXqNDusQo9QFu3gIHT+axCi2PEqZZHMoTeog0Cr5/3hBCPV5E3X05Z5Ov9mJAHe+
	 8U/yUImgYQDPfsduS2g2IhGTLdfw+dzkkA+vb1t/QLAzdBq6aFMkhNoXEEgvrylWSs
	 h54AXR84UJO/XUrjvmzIJhNybAyjqqJhtfgIk/KDI96qaWo+6+LSuSujs7SeIBBTqJ
	 EXFUaIgRxbKpZ66ujoNMZiO5kbHZ5jKby9u05n0qGPO4YzWSxz4Y40B5NwX4TFuU2/
	 nd4CS2Pex7AAQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/7] kbuild: factor the userspace ABI flags out into KBUILD_USERABI
Date: Fri, 16 Oct 2026 10:31:37 -0400
Message-ID: <20261016143143.3613501-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016143143.3613501-1-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS pick up the flags that select
the target ABI for userspace programs: --target= under clang, -m32/-m64,
or CONFIG_ARCH_USERFLAGS. Collect those in KBUILD_USERABI and export it,
so programs built outside of kbuild's userprogs can be compiled for the
same ABI without also inheriting kbuild's warning and language flags.

No functional change: KBUILD_USERCFLAGS and KBUILD_USERLDFLAGS keep the
same value.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7c855e6fe5448..8c94aff229b21 100644
--- a/Makefile
+++ b/Makefile
@@ -650,7 +650,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD TAR
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS KBUILD_PROCMACROLDFLAGS LDFLAGS_MODULE
-export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
+export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS KBUILD_USERABI
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
@@ -1270,15 +1270,17 @@ endif
 USERFLAGS_FROM_KERNEL := --target=%
 
 ifdef CONFIG_ARCH_USERFLAGS
-KBUILD_USERCFLAGS += $(CONFIG_ARCH_USERFLAGS)
-KBUILD_USERLDFLAGS += $(CONFIG_ARCH_USERFLAGS)
+KBUILD_USERABI := $(CONFIG_ARCH_USERFLAGS)
 else
+KBUILD_USERABI :=
 # If not overridden also inherit the bit size
 USERFLAGS_FROM_KERNEL += -m32 -m64
 endif
 
-KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERABI += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+
+KBUILD_USERCFLAGS  += $(KBUILD_USERABI)
+KBUILD_USERLDFLAGS += $(KBUILD_USERABI)
 
 # userspace programs are linked via the compiler, use the correct linker
 ifdef CONFIG_CC_IS_CLANG
-- 
2.53.0

