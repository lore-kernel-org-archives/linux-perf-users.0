Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585579;
	b=hUP9LS8pmhCZYVU0o+dMFocCG/ulCdA7XqScM81JOiDC7LoGfXb6D5BAbz+il0KWzbHw
	 5at9BxSrfRYZGit0VQu3wfD8uVYRcOCie/63gid4OpAWIuETTGhpXtPxEZJgUi9KmJaLT
	 3rIDR+62CiT4QR/xpV2WU7KfzxT1Ziw+J8TwEPlFbKFfFcky9hQBNVbaFoI/tmjD4wg2r
	 7Ekc9K6CL+CHrFKsRZDYuXJqhUJ7e3JFuHnY9lokzmuKhP/9vov4rR0jnhtXwZl5uJYhX
	 GZMMBWG6cAY2nGxNcJ0pCL6T+rIaV9VvbRKKnXbsdg/PtfmMtpXK9f5asBPw7zW/4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=obEsgLblQBIWl8a18cZtDAHySJ503T0PQpQZjZ7IJWo=;
	b=3e0fFVTZWYzdwmFbi+fbb5S9FNJ54Af6b8Jt/fcoYpzuQKe5aZjof1G92kqKyyMqD+CN
	 ck32wgfMRJowevNZf6Kg8e4ZDxWEW2+JnpCAFV8kvurpE8ARA4DFgvLvc78734SMmVcu1
	 TVBxf5M/hJ9q/Xus9yt8svi7apG6tI3+IRrhyWxCdkzdcU+l7ZhUwtuvzYZoRxd5HKfP9
	 Kr2FYVFsLy3rDrvV8myJ7eqh7MScBcxsQ6s7jSXHSx1YRJprM3ki7SJNpThgvs4asmrgB
	 JpHETe5NE7E+Xf00Yf9Xk6q/ZJGcRvCZtgM4JJ4WgiE8alAWZ852BP4UJ4Z88j7KXVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBNcj9k1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6435606A32F;
	Mon,  2 Nov 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBNcj9k1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA181F00A02;
	Mon,  2 Nov 2026 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585578;
	bh=obEsgLblQBIWl8a18cZtDAHySJ503T0PQpQZjZ7IJWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBNcj9k1mD/PT4xrixvgEEhQ5VnFDs/YxcBkEwK/YDogizDwyC99eZeL4uqR49uBv
	 dmWc5gQlLjhuxI1xmkeQimNkgigtV/Z9jX15/oC8CorZQUTzh0N2hP8o2FjRddhOFM
	 jgNBUKSUctT3yXx1D4keAPQnlKTCSjPwDWOG5zm6kj/FMWr87rfTb2h627Ue74Xive
	 /iNekqTEzaD8ww9wFJPG4Y9p2oNeSdwWeiTUYXyHMKwme4A7g0HWWw+xy4lNuc/IAl
	 Pr8bY//poZWnLnGtXJ9/Sdu5uCQTg9KFBQziAgg9J6z4l6l4i0ziSiOYcemhuGDSe6
	 s3ZkCYmgWef0w==
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
Subject: [PATCH v3 1/7] kbuild: factor the userspace ABI flags out into KBUILD_USERABI
Date: Sun,  1 Nov 2026 21:12:47 -0500
Message-ID: <20261102021253.2545235-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102021253.2545235-1-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
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

