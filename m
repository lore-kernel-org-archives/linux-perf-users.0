Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556572C2363;
	Tue, 10 Mar 2026 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152733; cv=none; b=krTaZq0fM+oh+rHgAizle2KBGgF3Z/n4WDFw7phlH4AiVuj6KbUZUOpMy+xXS9kQ5pq2XR0sYlMNvb3NzepBz+o+cY4NwNxUZBf5MYYQXndqABFkvG/r9TRg/ReNiRsv/LVJBXOVkapjMNps/vFktegaq0CsanBxhCFYvFea4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152733; c=relaxed/simple;
	bh=ocle/VN/4WgPVAINWiYhmUV/8XKxVhPdrde6hqn6gPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1OjcI4i0eIDQDCpJ/bbdGYSJbU/+JCLfvu3GmMX3zvVfbdaFYZ4YZQsir3oNAx7nOnG3FeoOXrnAYqD1tK2ghNPGi5DFbrhPx+9JbQgNlNMdPgHwpxoSbL6WjePoxFYh45+OgV1eBU8Ow/+g0xw/5OcV/HVHGjnR3plQpHvToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49BC216A3;
	Tue, 10 Mar 2026 07:25:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 309D53F7BD;
	Tue, 10 Mar 2026 07:25:30 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:25:28 +0000
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
Subject: Re: [PATCH v3 10/30] tools build: Append extra cflags for feature
Message-ID: <20260310142528.GB4153946@e132581.arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-10-6477808123b7@arm.com>
 <CAP-5=fW83wsZfWpa9777ze-RNSFhAB9PnBa3xkVMu0LN64CThg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW83wsZfWpa9777ze-RNSFhAB9PnBa3xkVMu0LN64CThg@mail.gmail.com>

On Mon, Mar 09, 2026 at 10:51:43AM -0700, Ian Rogers wrote:
> On Sun, Mar 8, 2026 at 9:47 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> > the feature build.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/build/feature/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..103d8b71e7a4e8d0979242cfc95c1c0b946222b5 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -1,6 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  include ../../scripts/Makefile.include
> >
> > +CFLAGS += $(EXTRA_CFLAGS)
> > +
> 
> Is this necessary? In Makefile.feature:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/build/Makefile.feature#n11
> The build invocation does "CFLAGS="$(EXTRA_CFLAGS)" and so the locally
> set CFLAGS appear to be ignored.

You are right.  So far, some projects (perf, latency, rtla and
verification/rv) calls feature_check with "CFLAGS=$(EXTRA_CFLAGS) ...".
I confirmed with pref build, the -fzero-init-padding-bits=all option
has been properly appended and passed to feature build:

  gcc -fzero-init-padding-bits=all -I/usr/include/python3.12 ...

As a result, it is useless for this patch.  I will drop it.

Thanks,
Leo
