Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F2384236;
	Tue, 10 Mar 2026 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143324; cv=none; b=PvzO6ePC+INk1UrGH3gzGH9JJ/qDfGlqpNhnUQIB/7LVwUd9kaF0w5eFrMD44zadBdbUITT3MW/9kikzweEY5sZIWy8DcnUvo4oZuTLcYrgg8bY+jHcaY81KR5sxOyxj/WuJTAiYvn0Gyyt6G91hBACD8MD3U2gsAqRQNPk5K+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143324; c=relaxed/simple;
	bh=wmnudj8wOvC5q2tPSSZ1fMwaPxqqty8WnEeN4Tgn5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMSt2zJoqdev5CWL5tjEh0HLO2ftQWAhskEdzH1Dxaz8bvzTh6DzDrhRImNlMrZk0FKxgNGFWviO25WejWblOAVxXC6Z8E5xkJFqENNNix7lg6y+CJOKgZVWQ/IM/kT4vfHREvSDWahlG55a0EDuSEkothIhuDHvxprCAJC9x7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B4716A3;
	Tue, 10 Mar 2026 04:48:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93203F73B;
	Tue, 10 Mar 2026 04:48:40 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:48:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 24/30] tools: tracing: Append extra cflags
Message-ID: <20260310114838.GA4153946@e132581.arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-24-6477808123b7@arm.com>
 <20260309114413.09e05127@gandalf.local.home>
 <CAP-5=fU4JF6=aocKhgyZqyqm0NOKpAKEmruFj2mgBHfkqbN2yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU4JF6=aocKhgyZqyqm0NOKpAKEmruFj2mgBHfkqbN2yw@mail.gmail.com>

On Mon, Mar 09, 2026 at 09:37:07AM -0700, Ian Rogers wrote:
> On Mon, Mar 9, 2026 at 8:44 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sun, 08 Mar 2026 16:46:29 +0000
> > Leo Yan <leo.yan@arm.com> wrote:
> >
> > > Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> > > the compiler.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> >
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Not a problem with the change but running this patch through an AI
> agent brought up:
> 
>   Should CFLAGS be initialized with default optimization and warning flags
>   (e.g., -g -O2 -Wall)?
> 
>   Currently, latency-collector is built without these standard compilation
>   flags because they are missing from the Makefile. In other commits in this
>   series (like for libbpf and thermal), CFLAGS was explicitly initialized to
>  -g -O2 or -g -Wall when EXTRA_CFLAGS is not set.
> 
>   Additionally, should EXTRA_WARNINGS (provided by
>   tools/scripts/Makefile.include) be appended to CFLAGS here, similar to
>   how it is done for other tools?

Thanks for sharing this, Ian.

I would like to keep the scope of this series focused on appending the
-fzero-init-padding-bits=all option.  The comment above from AI is not
relevant to this purpose, I'd leave it to the project maintainer for
further refactoring.

As you suggested in other reples, I will update to append EXTRA_CFLAGS
at the last so that it can override the default values.  I will also
collect Steven's ACK tag.

If there are any concerns, please let me know.

Leo
