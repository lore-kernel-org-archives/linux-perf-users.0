Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45934A3B4;
	Sun,  8 Mar 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772988522; cv=none; b=Q26iP4dzwp8I/9FTP6/65nMgnnHcgs+kwRDc1p2FpI5aAKZqP+8NP8UeCJPw8Ay7OrSpZq2AB6YQKJeJSiwpejxUwQlNfSXU8exx2zhm2jBuw0xNmUJEGYrhqb5H6P8trKDxqZQ9gHzeQni56G9/z2Ewdn3KunAXTbBG+bWDQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772988522; c=relaxed/simple;
	bh=fkf/zlqrIfnebG/RdFS0MlAsAXXN8IFUwXNXXxMzUGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmlJwFo7TppHrmX6OJXKmlFrdJTAqfbrS8MltR3VVK9/HKiBqtV8yAumvXjFEB04EH4AhL+smTWG+8zcdg+EA9p8hlmCdABhq85FoaxfTBy10tA1z+kqgWf5NRbXrj1QOTZhTpSlEq6tWWTBnGGZZZVylxELH6VTFH0xX5U9veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C991CE2;
	Sun,  8 Mar 2026 09:48:30 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D761D3F694;
	Sun,  8 Mar 2026 09:48:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 08 Mar 2026 16:46:20 +0000
Subject: [PATCH v3 15/30] tools: hv: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-tools_build_fix_zero_init-v3-15-6477808123b7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772988384; l=685;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=fkf/zlqrIfnebG/RdFS0MlAsAXXN8IFUwXNXXxMzUGI=;
 b=Yu9uqkc2uVWKlNic7iEKsNilQ1Fn0jLboaTqYJ2puHgxFW2xEwmYtY/tD+hTG7P8L6nhbZ9cv
 bUjwAFUJ0ZJBhjwFf/BOjPI2SnlHXqi8lZn/0QDsWzGU/DwL0tmgrQ/
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/hv/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 34ffcec264ab0fdf7075d25456ef012cb866796b..e39c16325b451ee7c2ddc581cc4d168915472ed6 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -16,6 +16,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
+override CFLAGS += $(EXTRA_CFLAGS)
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
 

-- 
2.34.1

