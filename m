Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30D340D9A;
	Tue,  2 Jun 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411328; cv=none; b=rCFvopGupgAfX1zniSfe9wtQ9Hz7TwFodCYFfsYQZZtUHgmOZAGebexgrZK/c2XAlbnalk1ImwAUU/i7hdv2tesKmsXSaVoHbVVD1FbO7z3mYp79h/ufpqXEEoOkaN6qCIYWE3kd/CYfjfWEsqdG9omhX/nvJ8T/TiL1TuTcs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411328; c=relaxed/simple;
	bh=htZbWwa5Gdk7tv9jGCiKr3dJMcl5OIZKDDrOhcVl33k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQXc1jiHERunX3Y3dinEUCrmYMfH0ByLroVW9vt+ycEhIv7dzz7RHdywQ3fzpBsqh+V/5sRvBXDhitlu9HnU2Ku0Fx20N7kcz8qAqf7dFDzGJQWXI5loHR5oLpFubHnMr0QNtEQTDQ6KoU0ImAyDkIZZGDQPeo4zRxsMu7btOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wo1bxRSJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wo1bxRSJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A56E3574;
	Tue,  2 Jun 2026 07:42:01 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D48C3F632;
	Tue,  2 Jun 2026 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411326; bh=htZbWwa5Gdk7tv9jGCiKr3dJMcl5OIZKDDrOhcVl33k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wo1bxRSJ8A1ZTr3nZgklb9IdyE0N2hVdaXzxUtV+5sxKRxQhkVMxHL/nEusJy5811
	 hadgTDlnWr0jnm+GVJKHkX5U/THcs3P7glyVuvOn1oE/aMfV5pNTlbK+CgvB14cuDU
	 ojasDevFtC/MaNw2HKQJcOLSmER8QOck0oYANsTE=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:42 +0100
Subject: [PATCH v7 08/23] tools build: Append extra host CFLAGS for fixdep
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-8-631baf679fe7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411243; l=1426;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=htZbWwa5Gdk7tv9jGCiKr3dJMcl5OIZKDDrOhcVl33k=;
 b=+SWSpV9Rwitfnqj+GmuN+VKrOJrZAfwEWYCitXYiw3Ni+mA9aBPD87WK9S42cT6GcW36bEccJ
 QlXK15fFrVEA3qiCR0a/b8kB0NPhQYylqYanzeTJ/ewZpuodn6pLBLt
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

tools/scripts/Makefile.include can add host compiler options through
HOST_EXTRACFLAGS. Make sure the tools build uses those flags when building
fixdep.

Create a local HOST_CFLAGS variable from KBUILD_HOSTCFLAGS and
HOST_EXTRACFLAGS, and pass it to the fixdep build.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 3a5a3808ab2a1dedd40f35ea322913e8a0788130..2761f80df7611c4731ef1d4529cae7dfe279bad0 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -40,18 +40,20 @@ endif
 FIXDEP		:= $(OUTPUT)fixdep
 FIXDEP_IN	:= $(OUTPUT)fixdep-in.o
 
+HOST_CFLAGS	:= $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+
 # To track fixdep's dependencies properly, fixdep needs to run on itself.
 # Build it twice the first time.
 $(FIXDEP_IN): FORCE
 	$(Q)if [ ! -f $(FIXDEP) ]; then						\
-		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)";	\
+		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(HOST_CFLAGS)";		\
 		rm -f $(FIXDEP).o;						\
 	fi
-	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)"
+	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(HOST_CFLAGS)"
 
 
 $(FIXDEP): $(FIXDEP_IN)
-	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(KBUILD_HOSTLDFLAGS) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(HOST_CFLAGS) -o $@
 
 FORCE:
 

-- 
2.34.1

