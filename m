Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD963BF675;
	Tue, 10 Mar 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158802; cv=none; b=ulVeHXy68WUiBMm9grCCOrEKEByqFzoYrWJ3xyLJ6qB28mCbw4N607qMFOUr2rVkK8CT9WctWLF8Ie614vT/B99h209SeV3gNctqUNLISd5en2A4nLU/HRyiHOGpdA3Ue+QQz1vzHwGrRCEUP76t1+zPSRyHbYJKuBcz3ovuVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158802; c=relaxed/simple;
	bh=pFTE7f4sOuYyaW3cEsKIhXjgl8+epJV62o4SfIfOkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4sWZa6C63fhcUkoZsdTv0Zb9CUAYytQbjzA4ZUZklxuDCIppLBeRjwCOjUKLAaxE1L2j4BaM4uZVoijrLcDQKAu5CAXJPyRB1Ztyq8RAy1S11Yhpty1NDApEQfEi4ESuF/uLInCCITIh7tAeAg74MvMD007Vn7Xws9fHSULxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499781596;
	Tue, 10 Mar 2026 09:06:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E69A3F73B;
	Tue, 10 Mar 2026 09:06:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:06:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
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
Subject: Re: [PATCH v3 29/30] selftests/nolibc: Append extra cflags
Message-ID: <20260310160638.GD4153946@e132581.arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-29-6477808123b7@arm.com>
 <bb278652-8654-4473-b12e-b24b36ec3845@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb278652-8654-4473-b12e-b24b36ec3845@t-8ch.de>

On Mon, Mar 09, 2026 at 11:24:58PM +0100, Thomas Weißschuh wrote:
> Hi Leo,
> 
> On 2026-03-08 16:46:34+0000, Leo Yan wrote:
> > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> > the compiler.
> > 
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/testing/selftests/nolibc/Makefile.nolibc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
> > index f5704193038f7da935d57e0f894970b6e29b78da..e58b2f5eb2b231bb1c194db7365fff7b4e244e5d 100644
> > --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> > +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> > @@ -252,6 +252,9 @@ endif
> >  # Modify CFLAGS based on LLVM=
> >  include $(srctree)/tools/scripts/Makefile.include
> >  
> > +# Append EXTRA_CFLAGS if it is set in tools/scripts/Makefile.include
> > +CFLAGS  += $(EXTRA_CFLAGS)
> 
> Makefile.nolibc here is completely self-contained. It is not expected to
> inherit any flags from the regular selftests. So I don't think this makes
> sense. There is a similar, custom "CFLAGS_EXTRA" variable, which could
> be aligned, but probably not as part of this series.
> 
> There is a regular 'Makefile' in this directory which *is* integrated
> with the regular selftest build system. If you could make sure that
> it works correctly with what you are doing, that would be great.

Sure, I will update the regular Makefile.

As you suggested, I also will drop patch 18 in new version.

Thanks for suggestions!
