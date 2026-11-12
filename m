Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513274;
	b=RAVp0PA8W6a74tqqEriyq2WLBgZ7qzszW+w6rnC7iG+Ow2aNYO1h35Lkt6EAelycnuM5
	 /J99OquTg9TUWOsXa11Gt0qcCbOwc0KwHQ/FeQfipcHyRLj91/pNVKbAsoIZocAwVNIGC
	 ucVZOwWAqmGeFailWhxjezHIVUVKq3+7myTuTmYdHMovwDtf6GoQxuYqCR3qbFwOmwG8F
	 I9q1uhBlrIxP4ZgOvr/EKE9+3rh6ETRD8peVMPZPvDz9B0HjfPBtgJmognSu8YmrSWS4L
	 6zmLqeqlDx40oipgBD+bsOyuuyxQtctTSQB1Pxphf5fAWDCHUrAt02ZAK3ofkV64vtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=obEsgLblQBIWl8a18cZtDAHySJ503T0PQpQZjZ7IJWo=;
	b=M23GW5cmnqy6WdUaT/Bzgx6e9PtZOHaHMQb4vc1U09Jp1JIrkfX2B7cNGTUuYxlEwNIU
	 5FdPzMLYDFe8GxDYk18XRX6GB6nFGW7QjZkeO455+iyDfjzmd6BkV7haL5iLP9gUryrIG
	 eVhnWp4QHF2gcm4islifq10PmZM0AGFBNjc8+pELZlbuUZ1hZPB/ez7RsLonGuNwwhfyX
	 JXP+3EiFuvkUo7QajKhrq3mzxAV5Zc2R/6ARV+wdGYTqfUKCHt7sL8qn7eJ/Q7ZtBZxb3
	 iFBWQ7LwkN2n48KaPhLukxa36bzD6FYnv2jVTydauKlenE9PBC/E4yfX8PMIy4peJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw9JyNGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78435606A899;
	Thu, 12 Nov 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw9JyNGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEBC1F000C6;
	Thu, 12 Nov 2026 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513274;
	bh=obEsgLblQBIWl8a18cZtDAHySJ503T0PQpQZjZ7IJWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iw9JyNGAVTjuvo0xfQeWvBjozZKkXvrPw08qdliZ4knj1CysGlzdd3PuxDd99rib7
	 nUgc8nQ7G6PRgC6M6Wcowb+eR3WPQs3iigg4WvU3Ap9/WIsyjSc5t5SPPl4O6TRmGx
	 O5rF+RjPqdinmrKY5DjhlB1rY1cA2cvkASvQbH66UZ1U+CUfAvV69CnfUneWoTivrZ
	 mVnH4s1TFDS690WwhAh2ZpG9/oqAcekc2LDZenZDv3/u3bwHDPmmqdRdGLX/82+qm0
	 8g0VnnsWtANV3uV6Wt3uW4AMCBZ26u48nAoikTEIqCzk6+0Xjp+XPTfv+VSyQdNqrA
	 4iMCOd46iRsXg==
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
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] kbuild: factor the userspace ABI flags out into KBUILD_USERABI
Date: Thu, 12 Nov 2026 14:54:21 -0500
Message-ID: <20261112195427.3411746-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f895752d4b05f..58bc69b4996e1 100644
--- a/Makefile
+++ b/Makefile
@@ -656,7 +656,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KPGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD TAR
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS KBUILD_PROCMACROLDFLAGS LDFLAGS_MODULE
-export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
+export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS KBUILD_USERABI
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
@@ -1262,15 +1262,17 @@ endif
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

