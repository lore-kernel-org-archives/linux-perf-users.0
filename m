Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58E359A81;
	Tue,  2 Jun 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411291; cv=none; b=KUJIkBZ3Ab4O40pLSvQMgNqVbfV9p9+IbZdlytH2vIWJtce649iVSXJK9jzPWDYA0BzLpxjNPRkAK7dZLyXrzRAec1CdMnm2HxwoDFvUnM6Giksqqeve0LULWCS0YLdxNAgPneaHupHL1DuHjV91KYR9eeub+CqVGkAd4Bi3h8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411291; c=relaxed/simple;
	bh=BFehMj28QR2IYXlxOIJtUAyqZ+kYk51QCcp6lZ5W+HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjZNVKRLZ/SoibBI7l4WBh42oBaa2F47KLGBnFUn6IMIj7v5ZbDTfpAymYRb8rS0LKrRrpSI3IcNEsO5xYi0BlnGrYIx29IMNaUufuEbFT6cDZ/l+QAXhnNoy7cZccSSevkUbV7Dgia4TNHkPeR6mJvI+rb6IOSVbSbY5+Phg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rAnScVtJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rAnScVtJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8880356E;
	Tue,  2 Jun 2026 07:41:24 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07AE3F632;
	Tue,  2 Jun 2026 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411289; bh=BFehMj28QR2IYXlxOIJtUAyqZ+kYk51QCcp6lZ5W+HY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rAnScVtJOH7FkyWDRDrTF/dsfxlykPChQbJ+Y6O6GQGGPTjtX8y1ASdxVjlCkgwR7
	 6IZNOCzJTuwG2NDL0HBi7Wx8+Vlu44gp98/yOOE3YlKpYQE8WxooO7d500+SmX5ITM
	 jgiJsHn7+kVSUgiERMZODRU0HxePWSNlcpBT1BKE=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:38 +0100
Subject: [PATCH v7 04/23] tools/thermal: Initialize CFLAGS before including
 Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-4-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
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
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411243; l=1994;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BFehMj28QR2IYXlxOIJtUAyqZ+kYk51QCcp6lZ5W+HY=;
 b=PGGTdqvcjJTXbrdI37469J7YKtSMq6K7A0+Y/Hqc3vJo/pgFVDGGj7kwhuE3ZUXjbboylXRXZ
 K2juhBnc9nNC3giIH/RaTTiigqCsbufCsrjlowlh7ewQuMqUP5v8N+Z
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

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/thermal/lib/Makefile | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index 8c9a37f999b826855dad11c0d9574b41d5b24244..333b711bc7f0f9610e165ff7dc72c42980c59c99 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
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
 INCLUDES = \
 -I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
@@ -62,6 +63,7 @@ override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -Wl,-L.
 override CFLAGS += -Wl,-lthermal
+override CFLAGS += $(EXTRA_CFLAGS)
 
 all:
 

-- 
2.34.1

