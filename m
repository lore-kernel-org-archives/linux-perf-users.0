Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C993A169D;
	Wed, 11 Mar 2026 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220567; cv=none; b=YnjFdgtCHNiFBwgdrHaKHbBpfhyKnUX8L/G2LORZlTQhKPiGNwIpGMrwAyTGyjFFD1Nji1AOMUm1YPPZ+e0tJJ9z/7+pBvI0SGhHLHe3GnTCJ/jPDbTMkE72ehy3hL1L5U8kJElRvUUzptCUP7wOaxfkdw1Xp7/R/P5oxRwJN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220567; c=relaxed/simple;
	bh=uHnK/2BgJQZqQxP4TdFCBAsxYefW+BFRldYNcFj5Q2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDLPOC6lgS71CmtqDjl3jYhJYbaszSYQgV5tzeRr5tupSgbd9gPTxlm8JWZlVMeWqYbADCOiS0sQa29gYAsOnW3Vjj+rVM1QJqe9a3TSazm9GAqzmLP/QiT4qRf1eZBLiCwOJ6JVq16EJ03+IuF5AomAr1fu0jtOWEI8p8oucsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3C3169C;
	Wed, 11 Mar 2026 02:15:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D3E03F73B;
	Wed, 11 Mar 2026 02:15:57 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:15:55 +0000
From: Leo Yan <leo.yan@arm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/30] tools build: Append
 -fzero-init-padding-bits=all option
Message-ID: <20260311091555.GF4153946@e132581.arm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <6707888c-a31a-4d38-a99a-86ae42351561@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6707888c-a31a-4d38-a99a-86ae42351561@oss.qualcomm.com>

Hi Daniel,

On Wed, Mar 11, 2026 at 09:44:16AM +0100, Daniel Lezcano wrote:

[...]

> > In this version, the changes are organized into three parts:
> > 
> >    Patches 01 – 07: Preparation before adding the new compiler option.
> >                     Fix typos, adjust Makefiles to ensure the newly
> >                     introduced option does not cause regressions.
> >    Patch 08:        Propagate -fzero-init-padding-bits=all to
> >                     EXTRA_CFLAGS and HOST_EXTRACFLAGS for the
> >                     CC and HOSTCC compilers, respectively.
> >    Patches 09 – 30: Apply EXTRA_CFLAGS and HOST_EXTRACFLAGS in
> >                     project Makefiles.
> > 
> Through which tree do you expect these patch to be picked up ? Each
> maintainer picks the patches related to their subsystem ?

I can propose a pickup sequence, but this may need confirmation from the
tools maintainers (especially perf, bpftool, BPF).

I expect patches 01-08 can be merged in one go, as this would be safe
not break anything.  Afterwards, patches 09–30 can be picked up
separately by subsystem maintainers, or merged together.

So far, IIUC, there are no maintainers for the tools build.  If no
objection from maintainers to merge in one go, I think we have chance
via perf-tools-next tree.  Arnaldo, Namhyung, how about you think ?
(sorry this might introduce extra efforts for you).

Thanks,
Leo
