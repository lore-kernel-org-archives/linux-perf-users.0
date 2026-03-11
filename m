Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713232741DF;
	Wed, 11 Mar 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217826; cv=none; b=hul7wgxrmmWZTS1hGb3Xk+hufU/V1za0Q8/HiCtJpwsjkDvhqIGdcLscxWkJi7T3UWGD7RZeWpIx+T4xwqqB4Od9GfX4IYtvrEDClvlgXvnL0t0LeBhGYICVC+tcHbUOWXRqtWItwGqD1LYlayxRy25tmuyFU5AjN8x2EcFfWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217826; c=relaxed/simple;
	bh=mkmGFFMWdiiEQbxcc15mMJc9KkOmMYC/dMkN1+6Ji9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJGsZzxrNWpna4FYylvr7qTi4xCIong/bw+wqSAfXOcJ9PKMFSMnuBt4Hh7+5NDCci1UxfEtLl5M74+FuB92Y1hARIpGRovxT6GeWkv77isvBFhEyo/oEakh/enZ8VV4MNXtiUy6Ajm5hwt/dK5l8MyNx2Ennq2CwSNayFfUnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F64A204C;
	Wed, 11 Mar 2026 01:30:14 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664FD3F73B;
	Wed, 11 Mar 2026 01:30:13 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 11 Mar 2026 08:29:28 +0000
Subject: [PATCH v4 03/30] tools: lib: thermal: Initialize CFLAGS before
 including Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-tools_build_fix_zero_init-v4-3-9e35bdb99cb3@arm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, 
 Qinxin Xia <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>, 
 Kent Gibson <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
 Len Brown <lenb@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773217789; l=1997;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mkmGFFMWdiiEQbxcc15mMJc9KkOmMYC/dMkN1+6Ji9s=;
 b=0hVcsSXNi9/47VYLKM1iq+lFejB1rgTLWX7/mNYrGYlGgEGqSFVH6DyiC19WaQkrCczMMA2d0
 E2ZRdzf1Ku4AZb5lSGjAAsBeesU5GmmAhfMlw1uF7aeaJs2FW9/bujm
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

tools/scripts/Makefile.include may expand EXTRA_CFLAGS in a future
change.  This could alter the initialization of CFLAGS in the thermal
Makefile, as the default options "-g -Wall" would never be set once
EXTRA_CFLAGS is expanded.

Prepare for this by moving the CFLAGS initialization before including
tools/scripts/Makefile.include, so it is not affected by the extended
EXTRA_CFLAGS.

Append EXTRA_CFLAGS to CFLAGS only after including Makefile.include and
place it last so that the extra flags propagate properly and can
override the default options.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/thermal/Makefile | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 09d8f4ba6a0ab7ab9c99ac7f64d52d0268bee340..b55fa42cefa47628b7f2fac32fc08fcd82580a0e 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -23,6 +23,14 @@ INSTALL = install
 DESTDIR ?=
 DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
 
+# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
+# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
+ifdef EXTRA_CFLAGS
+  CFLAGS :=
+else
+  CFLAGS := -g -Wall
+endif
+
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/Makefile.arch
 
@@ -39,13 +47,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -Wall
-endif
-
 NL3_CFLAGS = $(shell pkg-config --cflags libnl-3.0 2>/dev/null)
 ifeq ($(NL3_CFLAGS),)
 NL3_CFLAGS = -I/usr/include/libnl3
@@ -68,6 +69,7 @@ override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
 override CFLAGS += -Wl,-L.
 override CFLAGS += -Wl,-lthermal
+override CFLAGS += $(EXTRA_CFLAGS)
 
 all:
 

-- 
2.34.1

