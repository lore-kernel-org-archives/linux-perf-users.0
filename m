Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F923C5DA8;
	Fri, 13 Mar 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419076; cv=none; b=FF/dGDLrvKi0/DJ5eJ2Nb3Ue0ChCh4J4Wc8RGABbRscxe6uPCibczPz6kT/EkWqCjmyLAW2OoTSYHKgkvdntpx4JrbsIVjjwut35C6Bka8Zto/NeEQ9oabLZZufbBydCtH41/tVEiHN/+QxPVDGRRW+AF7r1wwMaK6vAvQP3xUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419076; c=relaxed/simple;
	bh=ZoX97Hc2cK3IVDnJOkD+OkVB773v7eoLiEHIgnkqf+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKTdfwAueq6ZZcgUE5AoN5nJCjUXcbk7Srv+9VTxoRsY8v6NLANW0jglqf1gbvLP25LqOeg5FG4+WDLLRJp8Nx9QsPEyChbW8ckdYxghS3fe8T9cB44KBtyXCbcPHWR/RBzw6AbhXnYEtQmwkMHGvfPTm5MhUfZBAEPzJfXzEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9629E1E7D;
	Fri, 13 Mar 2026 09:24:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599123F7BD;
	Fri, 13 Mar 2026 09:24:32 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:24:30 +0000
From: Leo Yan <leo.yan@arm.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 05/30] bpftool: Avoid adding EXTRA_CFLAGS to
 HOST_CFLAGS
Message-ID: <20260313162430.GR4153946@e132581.arm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
 <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>
 <20260313155600.GP4153946@e132581.arm.com>
 <cdc75030-e750-42ad-a068-55abe3a10d82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc75030-e750-42ad-a068-55abe3a10d82@kernel.org>

On Fri, Mar 13, 2026 at 04:07:27PM +0000, Quentin Monnet wrote:

[...]

> >>> +
> >>> +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
> >>> +# including flags that are not applicable to the host compiler.
> >>> +HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> >>> +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> >>> +
> >>>  ifneq ($(EXTRA_CFLAGS),)
> >>>  CFLAGS += $(EXTRA_CFLAGS)
> >>>  endif
> >>> @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
> >>>  LDFLAGS += $(EXTRA_LDFLAGS)
> >>>  endif
> >>>
> >>> -HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> >>> -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> >>>  HOST_LDFLAGS := $(LDFLAGS)
> >>
> >> Should HOST_LDFLAGS be similarly moved? Otherwise, it seems target
> >> flags in EXTRA_LDFLAGS will be added for the host.
> > 
> > Though this series is irrelevant to LDFLAGS, I am fine to move
> > HOST_LDFLAGS together.
> 
> 
> If we move the HOST_LDFLAGS earlier so that they no longer receive the
> EXTRA_LDFLAGS, then we lose the possibility to use any EXTRA variable to
> pass additional flags to HOST_LDFLAGS. So OK to move, but maybe add a
> "HOST_LDFLAGS += $(HOST_EXTRALDFLAGS)" to it for consistency with the
> processing of HOST_CFLAGS?

Adding HOST_EXTRALDFLAGS seems a bit over designed to me, as there is
no use case for it currently.  To avoid complexity, let's keep this
patch as it is, we can add HOST_EXTRALDFLAGS if later have requirement.

P.s. I saw that you already replied the same comment in the previous
version.  I should have confirmed at that time, sorry for the duplicate
discussion.
