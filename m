Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72F3A6EEC;
	Wed, 18 Mar 2026 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825580; cv=none; b=eU9iPEZ/Sp/HPr8diXnvage0SsW6sRq6VoqoRAaGH3xwe25unU4G6W41Ii3K7rc3fSBoSnqTfncuyNrhBhSEvyNQ5OhwPtgFfpYSsnIJk/AbUmbX5mfcN1RCUTVjyiB9X9R26p12vvrT/Aqcq/BPFALP7+1mYvqxqWlTLGolP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825580; c=relaxed/simple;
	bh=wVjQowvxpAB2zn18RKm3JYBDwmaeJ2pheT83qKWdB5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcpQjfQaNAZiPc27i0gyFBluo+l7MuZPPVVP7YxglrIiv46k3au486FHScpPr+ZhtnJ6LCyq9fxKRWqFABunJnlgel1XKvkD4hKUk0I5ZRvfrRCq85wTrLXxW1uK6Lh5oGpgSDyjztkWy7uVOb7/AIy3WjBmkCqnU9CDyWsYO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC487204C;
	Wed, 18 Mar 2026 02:19:32 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D00393F73B;
	Wed, 18 Mar 2026 02:19:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 18 Mar 2026 09:17:00 +0000
Subject: [PATCH v5 16/26] tools: mm: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-tools_build_fix_zero_init-v5-16-bbeffd8da199@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773825421; l=615;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=wVjQowvxpAB2zn18RKm3JYBDwmaeJ2pheT83qKWdB5M=;
 b=OfIPz2NK+eKf4M/YHZZRCeJ8LVckjXpTtx4gGc+J5cizMQkF0kZl47pUTo8qSv9h4/doPBc2G
 VhDFahFTMdkCZDJZ9HH6SFXcWo28JZ+fa1g6N7Oxb/fQCKR78HUTvIe
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/mm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mm/Makefile b/tools/mm/Makefile
index f5725b5c23aa261994b5b42f37c443bee2edebf2..d48491da2edc95fca57c0707c42961fde7b02072 100644
--- a/tools/mm/Makefile
+++ b/tools/mm/Makefile
@@ -10,6 +10,7 @@ LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
 
 CFLAGS += -Wall -Wextra -I../lib/ -pthread
+CFLAGS += $(EXTRA_CFLAGS)
 LDFLAGS += $(LIBS) -pthread
 
 all: $(BUILD_TARGETS)

-- 
2.34.1

