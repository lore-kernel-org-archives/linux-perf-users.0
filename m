Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B76375F67;
	Sun,  8 Mar 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988605; cv=none; b=OGLroHHq1AusD15Jr4ixRXJXut+mgSuH5lN6SOi0167fDP3X5sjVOX9FNtBWAoY1vG0/2xoHVTRY45A0YmO8jWdI/+KOAIj1wrOO0aLD3ha1FWJGz+BbGWxPBCN/VZ/g8FdIagp0Lq3U9+C8Gh80qvA6D3cIsxTvnaseRZxepPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988605; c=relaxed/simple;
	bh=aQDQhEmGOj/4xgyuOo7wTgcGfAdaILM48C6FWs5qRSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mc7Hgb0aGkvE2Ai7lj7pKP6WNr4NCgc6KWQ4xlIDxHs8Q4USHjwus16a8cnK/bvJysndxtfPQlAvh2MGyjbtM2kPW/pf0YmzeqklCdmatqCyEB1+TkvkkZFtOfAkPRKwQhCfRykQyhauYrfxBNLfHZsEMLlSdmGCAQ6IPJ7NSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D791E32;
	Sun,  8 Mar 2026 09:49:53 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A09453F694;
	Sun,  8 Mar 2026 09:49:51 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 08 Mar 2026 16:46:30 +0000
Subject: [PATCH v3 25/30] tools: usb: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-tools_build_fix_zero_init-v3-25-6477808123b7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772988384; l=706;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=aQDQhEmGOj/4xgyuOo7wTgcGfAdaILM48C6FWs5qRSI=;
 b=TYqp0riPivwOJo3/nknFfsEXJ36CXlBq1vJXJfwAT2udmj1IqJK3R7YzGgn6Ai6v85a+LU7Dv
 1zoL5ZbSpHTD2VLkxfev9LXJrwXA6KE98sB8dAR7FSVsllyP73RoxDP
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/usb/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/usb/Makefile b/tools/usb/Makefile
index c6235667dd46223b646bbab5c82c810221750182..db2ff5b8e5ab7b76e424df32ed5a9458daa5d516 100644
--- a/tools/usb/Makefile
+++ b/tools/usb/Makefile
@@ -13,6 +13,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
+override CFLAGS += $(EXTRA_CFLAGS)
 override CFLAGS += -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
 override LDFLAGS += -lpthread
 

-- 
2.34.1

