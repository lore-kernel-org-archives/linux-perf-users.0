Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A83BC69A;
	Mon, 23 Mar 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278882; cv=none; b=i3agjAjouAzO4FVPUyrGfo4Pz/wYeCNlDLmFcw7CeOAwdQ8wM9TwKop6qESIORA+2sdp5DN4cy0vFgjC3OHzba5sVmB6tee5K109K4aud2g5+IWIOYljWZ1taJzGlNNIEOZfPcopp4B67z/xL1y0a3K+TFAm+MojpaFs3RDTw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278882; c=relaxed/simple;
	bh=G2cI6gno4ym5dTpFGJCwLPZT6MUzcUe+/hvBAAojmWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9yuov2MkYQzP32KmK2YvEETPcWyPxJ2yByqg3mvMxQC9KlXrdvq7ysXsjG1P7c8zFlMuXIo31+9XlHABUQeF0+tBbhgF4JSkh2IVgJJ59VEQzmIKi2D4liABwvy/ZdWEH2utx3BBUks+PCsY39rkrpGqY4zJf6zzpGobvRNRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B44169C;
	Mon, 23 Mar 2026 08:14:34 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155923F694;
	Mon, 23 Mar 2026 08:14:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 23 Mar 2026 15:13:28 +0000
Subject: [PATCH v6 07/24] tools build: Append extra host cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-tools_build_fix_zero_init-v6-7-235858c51af9@arm.com>
References: <20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com>
In-Reply-To: <20260323-tools_build_fix_zero_init-v6-0-235858c51af9@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774278819; l=1108;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=G2cI6gno4ym5dTpFGJCwLPZT6MUzcUe+/hvBAAojmWk=;
 b=5QKebDBeAZ/pc2accguDTj5Sfm0RY13rOKw4uq6t7UVkkEvooa460dzl2DMYhTZBmGqvxqe28
 x4ISV3PEB4oCUXW8jVN5Y4pPA1urohAOAaiBQAL1Z+j+lBN3vyXF1s6
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
applied to the host compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 3a5a3808ab2a1dedd40f35ea322913e8a0788130..44e50a7c182484e18ff80f4205c49a77e8c8abd9 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -40,14 +40,16 @@ endif
 FIXDEP		:= $(OUTPUT)fixdep
 FIXDEP_IN	:= $(OUTPUT)fixdep-in.o
 
+HOSTCFLAGS	:= $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+
 # To track fixdep's dependencies properly, fixdep needs to run on itself.
 # Build it twice the first time.
 $(FIXDEP_IN): FORCE
 	$(Q)if [ ! -f $(FIXDEP) ]; then						\
-		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)";	\
+		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(HOSTCFLAGS)";		\
 		rm -f $(FIXDEP).o;						\
 	fi
-	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)"
+	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(HOSTCFLAGS)"
 
 
 $(FIXDEP): $(FIXDEP_IN)

-- 
2.34.1

