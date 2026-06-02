Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584D3F787E;
	Tue,  2 Jun 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411392; cv=none; b=XOZyLZ20lzp9Fz8/wDIfGdETpwg9VZEoLEx3wprO7gpGD1Ew2nwUIZ0ypH/bOiVT/OE6Op4WrY7nFabrBZGM8O4DwSKsgML7Dsgmn2hR316TPdACi+WUniQls3pp5e5bXiGjzTbA/g1+m2fhUrHWqiYZAVWtkk/u4c5O1ELSeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411392; c=relaxed/simple;
	bh=wVjQowvxpAB2zn18RKm3JYBDwmaeJ2pheT83qKWdB5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/vDENNVKx21vXfDoKEEc+yz8MLnHzlfjNlx6NdMUUxYrlCZcD1FR7zd5NjShcXOY7df/amyejTHeAKJUCifISPkV7XK2vWSpTUBeLgJTSae1pgvAGmNuwUFkc8Dmz/WWHBEbRKAihz4P5/4Wpk3wuYqtwBSpgsT5MIViwHQwNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SYnbiD18; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SYnbiD18"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DE83582;
	Tue,  2 Jun 2026 07:43:05 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7AED3F632;
	Tue,  2 Jun 2026 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411390; bh=wVjQowvxpAB2zn18RKm3JYBDwmaeJ2pheT83qKWdB5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SYnbiD18YSC5RtRt3kCU1cxA4nBFT4SckeFPb+XF+wS79bJ027RIHQ6hKSwiQrYmr
	 qS1PvMJyxmZp/MvznCKXSA87RBBg11+LnE3uujq5jFWumQ+IZUwyl91isvydPmZi4d
	 F0/mB7CqXqifmvZMg58inXRGHgVI12N4oUpj9EnA=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:49 +0100
Subject: [PATCH v7 15/23] tools: mm: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-15-631baf679fe7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411243; l=615;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=wVjQowvxpAB2zn18RKm3JYBDwmaeJ2pheT83qKWdB5M=;
 b=570E7PV6NtyfJm5ALZp2PMkm39mr87poKx+ebkJkO+lUpLtPSDTqXejfM1LQT3jDiHKyN0CKO
 7Sumsl2o77uDGIw4bOvki3zDL97steregg26W/UY9o9swH/rz96g2xJ
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

