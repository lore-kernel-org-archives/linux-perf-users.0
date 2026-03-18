Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0653A4F58;
	Wed, 18 Mar 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825488; cv=none; b=guQTNyf09d27p0pHZj7WT+T+tfzRSeLf9Hpvk8ha+v5Rpg32eZVkfewbpm3pVr/hEZ6iVKQAADJSkzU3te0jgmUFhRc+Sj02mHU0ZzSo1ImAhK4hYn1uMi7OlyGz0QsF8QdDRi4jD5KDIU0ltG+xrLKrIMoe6Xu3Tek03mQsFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825488; c=relaxed/simple;
	bh=NWqH78wsmi6y4jjQ8qhIYxcnenhctkfjAsE0nlrnoMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mh41jhImbQnqyaHV8QWyKfWd9TYkXS9mYIYyyDzUBxkcJ/OKWilZkZuXhx+W4XmbP816qaZ8j/PabFQkBrwD3kSAnFTam+gL0wVFSNGbjp+oPfGgilf3ksxbbpmxAx2MutkXbn5FYUI6tQwf8amrXIrLBeEEh4+6JhLEeTMe3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3122050;
	Wed, 18 Mar 2026 02:18:00 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B7C03F73B;
	Wed, 18 Mar 2026 02:17:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 18 Mar 2026 09:16:50 +0000
Subject: [PATCH v5 06/26] tools build: Append -fzero-init-padding-bits=all
 to extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-tools_build_fix_zero_init-v5-6-bbeffd8da199@arm.com>
References: <20260318-tools_build_fix_zero_init-v5-0-bbeffd8da199@arm.com>
In-Reply-To: <20260318-tools_build_fix_zero_init-v5-0-bbeffd8da199@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773825421; l=2805;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=NWqH78wsmi6y4jjQ8qhIYxcnenhctkfjAsE0nlrnoMY=;
 b=ZLkbvcXOX3PkxAekwdn8fM/JPifcfasBLi/XuEFNVYwA0/OSpc72JF/Z7EZieR1mIqObBil51
 GgbE0G8j2udDz8IKOrdWsMSU0m9KcB4/uTcbeHlFYng6yhwxUMvfng4
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

GCC-15 release claims [1]:

  {0} initializer in C or C++ for unions no longer guarantees clearing
  of the whole union (except for static storage duration initialization),
  it just initializes the first union member to zero. If initialization
  of the whole union including padding bits is desirable, use {} (valid
  in C23 or C++) or use -fzero-init-padding-bits=unions option to
  restore old GCC behavior.

As a result, this new behaviour might cause unexpected data when we
initialize a union with using the '{ 0 }' initializer.

Since commit dce4aab8441d ("kbuild: Use -fzero-init-padding-bits=all"),
the kernel has enabled -fzero-init-padding-bits=all to zero padding bits
in unions and structures.  This commit applies the same option for tools
building.

The option is not supported by any version older than GCC 15, nor is it
supported by LLVM.  This patch adds the cc-option and host-cc-option
functions to dynamically detect compiler option and append it to the
EXTRA_CFLAGS and HOST_EXTRACFLAGS respectively.

[1] https://gcc.gnu.org/gcc-15/changes.html

Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/scripts/Makefile.include | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index b5ecf137febcae59f506e107a7f2e2ad72f4bef4..a2397ceae512c1bc54adb15cb1a111ff34e28e43 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -137,6 +137,36 @@ else
 EXTRA_WARNINGS += -Wshadow
 endif
 
+# output directory for tests below
+TMPOUT = .tmp_$$$$
+
+# try-run
+# Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
+# Exit code chooses option. "$$TMP" serves as a temporary file and is
+# automatically cleaned up.
+try-run = $(shell set -e;		\
+	TMP=$(TMPOUT)/tmp;		\
+	trap "rm -rf $(TMPOUT)" EXIT;	\
+	mkdir -p $(TMPOUT);		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi)
+
+# cc-option
+# Usage: CFLAGS += $(call cc-option,-march=winchip-c6,-march=i586)
+cc-option = $(call try-run, \
+	$(CC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+
+host-cc-option = $(call try-run, \
+	$(HOSTCC) -Werror $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+
+# Explicitly clear padding bits with the initializer '{ 0 }'
+FLAG_ZERO_INIT := $(call cc-option,-fzero-init-padding-bits=all)
+override EXTRA_CFLAGS += $(FLAG_ZERO_INIT)
+HOST_FLAG_ZERO_INIT := $(call host-cc-option,-fzero-init-padding-bits=all)
+override HOST_EXTRACFLAGS += $(HOST_FLAG_ZERO_INIT)
+
 ifneq ($(findstring $(MAKEFLAGS), w),w)
 PRINT_DIR = --no-print-directory
 else

-- 
2.34.1

