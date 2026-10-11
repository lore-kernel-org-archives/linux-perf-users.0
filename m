Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0C43A80B;
	Sun, 11 Oct 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761812; cv=none; b=kAmP+KX0/Vt4k0CE9eydyQcYFT9khTm9Mr1jEoc171SFiVqWpb26sBTNP+oEe17l+JPLfkvc44P/sNpHQOjiqQIUWsrCn0XytMOvhsw44aNm450vQw7H4R84lNlc388LqViE3dKn6qi/AqJlbyfngrYntBap8Aehs1QMlsX9VUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761812; c=relaxed/simple;
	bh=H5CwiAyiq2T5g7/2GPLTpRxK5bRwr4KGLBeWtScCr8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg3t7Mq4ehZlSNQdUhTwTGC/GT9JlMdkDIqrPKm1totGEnCEHbpvjDbcD9ZIxEpn/qlu7+GDdy51rH6XTJU2vN8mnoZRAk9wxlZD6OshiJP10fF5l5TANShGRkrqeXTYrs4IITfak5hKDlDee3V0FRpjoK4lWv3AAcau7uqek6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3w1oqbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3w1oqbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28CC1F0089C;
	Sun, 11 Oct 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761810;
	bh=MQJ4hLwhmuVCO+Ob8DY9SeaN9DQAxFOFi4SkwzG4sF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3w1oqbzEIlb2KXDQpCx5VxOMBGhyrPERMrghou2R99QzYXANU3gkkmhXnfYEeLjx
	 tymQRBLGnLf4aO+W82phi/CfD1MDbzi2SUBklPAAqrLCw5lCMwmETp/dKa9KpJwjQ2
	 6q/hBXA14B7XD9DSj+1Lq9qTsILC9LPKfVpVvLaF3XqX6ttpcZJyZzrb+PAJ5BusM1
	 e1rEcDvqNGVtmzszp6YMBZfiwSkglH+aRNFUl0cy2rJriAKYZbNnR4F3zIE5gc4FvZ
	 M/ONaWwyScKoPEQPWvFRRWdmMOAll9Zm/xqXRsIaUfSy76JxcEyv3mLfn0SDiezrjx
	 Gw5AnHSlIWgqg==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 1/6] kbuild: factor the userspace ABI flags out into KBUILD_USERABI
Date: Sun, 11 Oct 2026 19:36:40 -0400
Message-ID: <20261011233647.2454648-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011233647.2454648-1-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

