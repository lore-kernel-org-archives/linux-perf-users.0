Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CF3BC661;
	Wed, 11 Mar 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217953; cv=none; b=dufIkiSCNsgHSEqSllEw8TS01fiKYm0TzEwXuMiVcDKnwB8kR0SFc0cdejQDABbnWXILO8EvldjWQfhZBBLcuhhvBzc0FPdO5Lz+0pDUoP5ZacHqBPRgwsvX6W8qr6UDkjp5pnuJnKu2L5mAAQKHubHT7TkDNVYFWLOonvVWK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217953; c=relaxed/simple;
	bh=cFSMsG9Pr0YdGX8EY/I3Z9KhblrIaRqQRvL58Tq489M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwUCTwpc17hIU9xEkDpuo7cGmqd9wkKc541OtU5QWAhYj90CtLwgIQPQ767b7G1zOVwB5azmLrYPO9afQ3UODjG5bCZ2qcS50sKtEx4NVjPGtj2n18KQiKJGnRC629EGr4j2LdE340NeNzLtux5HJgG/0q+BKSlCdhztbIMr56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F1E1169C;
	Wed, 11 Mar 2026 01:32:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7FF43F73B;
	Wed, 11 Mar 2026 01:32:23 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 11 Mar 2026 08:29:45 +0000
Subject: [PATCH v4 20/30] tools: objtool: Append extra host cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-tools_build_fix_zero_init-v4-20-9e35bdb99cb3@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773217790; l=851;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cFSMsG9Pr0YdGX8EY/I3Z9KhblrIaRqQRvL58Tq489M=;
 b=1QV/D3mTckwFZ/TBe6ak7xJvbouFzaunxLGUbs8rJ9yYhCKFOeqBLpj+Z0tPZT1SCXVUoOWfY
 Q/L9JA3cUSWB+aLZCdZ0yVym8s2+Johz/Eb21iaQ98AzgmEPO0EuL6V
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
applied to the host compiler.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/objtool/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 76bcd4e85de345048bba0a6e0066c3cf61dac979..716e84cc33eaccb0e4ae592746eb1888edc2f850 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -60,6 +60,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
 
+HOSTCFLAGS      += $(HOST_EXTRACFLAGS)
+
 OBJTOOL_CFLAGS  := -std=gnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
 		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
 

-- 
2.34.1

