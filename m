Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA136167E;
	Fri, 13 Mar 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417364; cv=none; b=TzzqrMNXI0ofnCueq177hAYAieC04qRtRYYb9Lr1MGfyEx+HzdX4S87xcFM8SEBpcrbayiirUY/eqaB319IevTn9tRfEI86OH1cELHDsGN46lUsx8NJgQnjaWEnqTIvc+Dq2o/dA7L7T1+rmGBlj94au5GLsNpRvfZIgLOTq6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417364; c=relaxed/simple;
	bh=6ooeKtjYil+mRAJH+ITgn5AMUBCanAMgyseJSfl/7Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ8Bm8VssnNaPLeG7xFDYsJqIGfwvOJ5sW+bj/AbDvF/+B/0CxMKwq4Q99MVMe0DjSG1Sw3zNrSVBwKIzVpc8QBn/9WQ+gHepmlBaTR9suEEovdgPoTuCMIev8KZlmZpW6/1+YpWT+B5I+51t512U6XDBnlgNwqQ1nLFxSOMvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D61D176A;
	Fri, 13 Mar 2026 08:55:56 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19FD93F73B;
	Fri, 13 Mar 2026 08:56:02 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:56:00 +0000
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
Subject: Re: [PATCH v4 05/30] bpftool: Avoid adding EXTRA_CFLAGS to
 HOST_CFLAGS
Message-ID: <20260313155600.GP4153946@e132581.arm.com>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-5-9e35bdb99cb3@arm.com>
 <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUOYsnbB4B0khUetRWOFMtHuO6_ESG30b1ZW01n_-gt6g@mail.gmail.com>

On Thu, Mar 12, 2026 at 10:19:01AM -0700, Ian Rogers wrote:
> On Wed, Mar 11, 2026 at 1:30 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Prepare for future changes where EXTRA_CFLAGS may include flags not
> > applicable to the host compiler.
> >
> > Move the HOST_CFLAGS assignment before appending EXTRA_CFLAGS to
> > CFLAGS so that HOST_CFLAGS does not inherit flags from EXTRA_CFLAGS.
> >
> > Acked-by: Quentin Monnet <qmo@kernel.org>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/bpf/bpftool/Makefile | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 519ea5cb8ab1c0ee31acc67fc5f96b40e21005c2..3e7d8359e1b2a81a29a47544be8539e3b191a0e8 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -81,6 +81,12 @@ CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
> >  ifneq ($(BPFTOOL_VERSION),)
> >  CFLAGS += -DBPFTOOL_VERSION='"$(BPFTOOL_VERSION)"'
> >  endif
> > +
> > +# This must be done before appending EXTRA_CFLAGS to CFLAGS to avoid
> > +# including flags that are not applicable to the host compiler.
> > +HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> > +               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> > +
> >  ifneq ($(EXTRA_CFLAGS),)
> >  CFLAGS += $(EXTRA_CFLAGS)
> >  endif
> > @@ -88,8 +94,6 @@ ifneq ($(EXTRA_LDFLAGS),)
> >  LDFLAGS += $(EXTRA_LDFLAGS)
> >  endif
> >
> > -HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> > -               $(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
> >  HOST_LDFLAGS := $(LDFLAGS)
> 
> Should HOST_LDFLAGS be similarly moved? Otherwise, it seems target
> flags in EXTRA_LDFLAGS will be added for the host.

Though this series is irrelevant to LDFLAGS, I am fine to move
HOST_LDFLAGS together.

Quentin, how about you think?
