Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C820299B;
	Fri, 13 Mar 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418303; cv=none; b=BT1ThlxDApQlm56o/QkwHn+RDbkfYSB8rFX2vhKo/Zxk9+sCl6mXsw5c6arrnplE+kRjlDqUHvlvVBSHLDHii4SxkPP1eSPqezNnOV/f7K/0ONcCRfDmi6o69ML4T5hrvLgqibrVwD/8+r1x2FZKCvxubTr/LE9NLpStg6KqSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418303; c=relaxed/simple;
	bh=yptxkvCEXqxxf0Cys8YHm8ORXgLzeZnsQAtuIrE0x2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQvE4IxLiDxJe3haKMNSOQjTR59hMJ3xnKm+66YlgiEhpphStTdgaMXnpBbPxZg6IFZS6u4PGDHCQYK104uBRBHZhSL2ipGO5Wxs2ip5cSaACp+1UJJxnADUWHEOxxbgylhlNdxyfKMYYsDPYDAQRR9Tdk3UEoTQAsjM7XHsMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E20E1E7D;
	Fri, 13 Mar 2026 09:11:35 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 788FA3F7BD;
	Fri, 13 Mar 2026 09:11:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:11:39 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 27/30] selftests/bpf: Append extra cflags
Message-ID: <20260313161139.GQ4153946@e132581.arm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-27-9e35bdb99cb3@arm.com>
 <CAP-5=fXjd15e5YpCM9KMjEhpjLxvxc6qUk0g7BprCfkzcRZ5_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXjd15e5YpCM9KMjEhpjLxvxc6qUk0g7BprCfkzcRZ5_g@mail.gmail.com>

On Thu, Mar 12, 2026 at 10:24:48AM -0700, Ian Rogers wrote:
> On Wed, Mar 11, 2026 at 1:33 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> > the compiler.
> >
> > urandom_read is built with clang.  Introduce URANDOM_READ_CFLAGS to copy
> > the compiler flags without appending EXTRA_CFLAGS, which may contain
> > incompatible options with clang.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 72a9ba41f95ebb825d25799c07ba3f0311243e45..27112f08c9a5b6cabc41902207d00897070b41b4 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -71,6 +71,12 @@ ifneq ($(LLVM),)
> >  CFLAGS += -Wno-unused-command-line-argument
> >  endif
> >
> > +# urandom_read is built with clang. Copy $(CFLAGS) before EXTRA_CFLAGS are
> > +# appended so that it does not inherit potentially incompatible options.
> > +URANDOM_READ_CFLAGS := $(CFLAGS)
> 
> Later in the Makefile, include ../lib.mk is executed and it appends
> CFLAGS like -D_GNU_SOURCE= which will be missing from
> URANDOM_READ_CFLAGS here. Perhaps move these assignments below the
> include?

Will do, thanks!
