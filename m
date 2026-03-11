Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29240374739;
	Wed, 11 Mar 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217807; cv=none; b=pAUE0TS4XgvTbRsnuXwxNmphrw9GQaQ7pjZ0ZvMF9K/MBxxbDp+2JZwLmaQm6ciTwwJnZ2qiJowCtpvFisMHkifXmes7bfVDFCEDg9qoJzY4gOmjfv7jIJUKdHHS7UC/g3aQaowb8+7bl0izqObpms3R9S05jceYm9GI3Sld2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217807; c=relaxed/simple;
	bh=8ymoW4HHQoUtYOFJa+6mY7ccDMk6/HOaddOLgnwOTic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btNKuRJK5uX2vepjvmRq1OJtgFxSDmcDW4Hr0DJQm97fQyM+2xkqlnjYhDg8NwOgOqClN6fMSf7vucuKYOWFSllkC+RRA96EPSOdx7CdRMmkvnjNN/4x7BXzpJhLf3pdId4KBW1Fw0QuRfTj2c8RdmlxkqHDGT5n7X5JnpN/s+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5562D165C;
	Wed, 11 Mar 2026 01:29:59 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187EF3F73B;
	Wed, 11 Mar 2026 01:29:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 11 Mar 2026 08:29:26 +0000
Subject: [PATCH v4 01/30] tools: lib: thermal: Fix typo
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-tools_build_fix_zero_init-v4-1-9e35bdb99cb3@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773217789; l=766;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=8ymoW4HHQoUtYOFJa+6mY7ccDMk6/HOaddOLgnwOTic=;
 b=cvedBwezyVxz3woz/mFMPU1/oGrXh8ose15WeulRq3YItL1fn/zM11RUvC6hEaDB5F3xZMcpU
 f1JSZ7IFq34CoOmgnW1hWfu7e2TF7IPPuG4XqEx0fYPisOU3IgUc5zR
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

s/CFGLAS/CFLAGS

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/thermal/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 41aa7a324ff4d76351b89d7d7cf382df3fc14052..09d8f4ba6a0ab7ab9c99ac7f64d52d0268bee340 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -66,8 +66,8 @@ override CFLAGS += -fPIC
 override CFLAGS += $(NL3_CFLAGS)
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
-override CFGLAS += -Wl,-L.
-override CFGLAS += -Wl,-lthermal
+override CFLAGS += -Wl,-L.
+override CFLAGS += -Wl,-lthermal
 
 all:
 

-- 
2.34.1

