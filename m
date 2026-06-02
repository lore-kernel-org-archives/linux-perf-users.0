Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088293E2ABF;
	Tue,  2 Jun 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411456; cv=none; b=u539fYNp8sxrhSZYXwF4T4lbvfoQkA64WdbADUn0BZJWxPs2smjSwB4a0M759ziAbYelcP+LVXwcPMyQ+mSUP3R5g26zd4YzTWfF4RyeDC1ZaIjVvvvaIK0PcYuHJ9GmfOWxV47i+A0Ym9M1rKCl/GDngOHmwOHOiVDo5PL1FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411456; c=relaxed/simple;
	bh=mYlThUq1iAN/tIV3PsjLtm1fJPfV0aj3FB6Qm/569bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPjft/dhSV3H/Px44zSS1z66evw919t7nDSU8RLeoJ2FRWnygTFUFMtFukh0FXZ0pKMqFhHtnLsELAN6o3cB4kIgjj0XQkW/+L47yxxTVwV+2jVli6NE8Ap243y71gUJso/nTz0C5TIA8e7wvznmGi5Xpp7hQHAEGMClh0juXjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kqI1NCqu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kqI1NCqu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B7B9357A;
	Tue,  2 Jun 2026 07:44:09 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBEFF3F905;
	Tue,  2 Jun 2026 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411454; bh=mYlThUq1iAN/tIV3PsjLtm1fJPfV0aj3FB6Qm/569bA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kqI1NCquPKWNTXuRZqX4PZOuMahkkKENnv50nK2LKocnaMqX0QVhiKCX6IB5j3mIi
	 vwM46unbxwHozfK0PK6Y+r9m6IR1ChULjg5TFgsBZ0xhPmNOyJCgAftObm1ZRX4jTe
	 o6QnELuK0+cjtllmP/6oQtwqM3TEjkWUcdVbzFtM=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:56 +0100
Subject: [PATCH v7 22/23] tools: usb: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-22-631baf679fe7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411244; l=672;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mYlThUq1iAN/tIV3PsjLtm1fJPfV0aj3FB6Qm/569bA=;
 b=eCJ/9Gg4Hcn3j7HQGFkdq4/6P+CV+CPUFSB0wPXpsH3JrHVvW2Afg01GrLwVmM9jaR4kGXfHz
 9lTE9qS5vEpCWS0sl42MTh1nHH+G/jtqAevSHxE5iEGfXXr2stRqI7y
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/usb/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/usb/Makefile b/tools/usb/Makefile
index c6235667dd46223b646bbab5c82c810221750182..42362dcdf2743dace62a5385a7d2707c42bdd3c0 100644
--- a/tools/usb/Makefile
+++ b/tools/usb/Makefile
@@ -14,6 +14,7 @@ endif
 MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
+override CFLAGS += $(EXTRA_CFLAGS)
 override LDFLAGS += -lpthread
 
 ALL_TARGETS := testusb ffs-test

-- 
2.34.1

