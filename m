Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5622A4F8;
	Sun,  8 Mar 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988412; cv=none; b=IJxu3b2SJ1JneUaKocxP9/3S5Wu9qlYJrqtmGGqQX8Y7jHL7ns0u6WtDgotSksedZ4cU3ZFzNmoykI1TprfDd+QEg3pP5iKNs1dgHvzcCDN+C0Spr2SJNdJjIffDvA/35IhGl8wlb5WhNM0eldnoj1JS/MUrfpSzDWAGvqNE/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988412; c=relaxed/simple;
	bh=DS9wptZ8jThmZ/lpf2k8m7DOYoUI+aNA/rW5Mc3JbVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0lQPeXkc9vW6AfvJKJEO2+rIS1o22dNidhKZoN21ZynEr2eASB1Br+ubX5VYp0VL6WFrcKSKevFTq1ctjIq0/R3/V3RFeOGqSDiedroEbJB76hFw0anyI7qXPZRM6YHGsxyIDmUuWB+GWwfkVNM5gSAyqaaIFzI/5+yxLvsrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CCCB1CE0;
	Sun,  8 Mar 2026 09:46:43 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70A173F694;
	Sun,  8 Mar 2026 09:46:41 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 08 Mar 2026 16:46:07 +0000
Subject: [PATCH v3 02/30] libbpf: Initialize CFLAGS before including
 Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-tools_build_fix_zero_init-v3-2-6477808123b7@arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772988384; l=1465;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=DS9wptZ8jThmZ/lpf2k8m7DOYoUI+aNA/rW5Mc3JbVU=;
 b=d9xKAfdNPWJwpch2bvQExPbCwjxXtXHZNmURM5MEn1YIJs5Fpa6pHxmgT/Tv77TNCMQKp1NXe
 2OU8OngjUTcDBQ1nLo5e3uBQCuqTBVZSCQ8CDaGDh693DavaCNcLahj
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Initialize CFLAGS to the default value before including
tools/scripts/Makefile.include.

Defer appending EXTRA_CFLAGS to CFLAGS until after including
Makefile.include, as it may extend EXTRA_CFLAGS in the future.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/bpf/Makefile | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e6461bd06db40e23d21a3fb8847ccbf4..76cc802375f67b9d8f589904bd9764040947e5dd 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -49,6 +49,14 @@ man_dir_SQ = '$(subst ','\'',$(man_dir))'
 export man_dir man_dir_SQ INSTALL
 export DESTDIR DESTDIR_SQ
 
+# Defer assigning EXTRA_CFLAGS to CFLAGS until after including
+# tools/scripts/Makefile.include, as it may add flags to EXTRA_CFLAGS.
+ifdef EXTRA_CFLAGS
+  CFLAGS :=
+else
+  CFLAGS := -g -O2
+endif
+
 include $(srctree)/tools/scripts/Makefile.include
 
 # copy a bit from Linux kbuild
@@ -70,14 +78,8 @@ LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
 LIB_FILE	= libbpf.a libbpf.so*
 PC_FILE		= libbpf.pc
 
-# Set compile option CFLAGS
-ifdef EXTRA_CFLAGS
-  CFLAGS := $(EXTRA_CFLAGS)
-else
-  CFLAGS := -g -O2
-endif
-
 # Append required CFLAGS
+override CFLAGS += $(EXTRA_CFLAGS)
 override CFLAGS += -std=gnu89
 override CFLAGS += $(EXTRA_WARNINGS) -Wno-switch-enum
 override CFLAGS += -Werror -Wall

-- 
2.34.1

