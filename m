Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742E3921D0;
	Tue, 11 Aug 2026 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461156; cv=none; b=BI4xxWQcLvBk1x3m2hDj7FYFOOEjhx1qxwGmUUTMj4Dd+eJU18SBy/h3B0mXgP70uGshSnxBIirt9onq+QzBAop+Zw0NZ5bP2uAX+e0r4zEkTMBTRLAqB8vBwgGbBXmo4bmmie/Xc83Zg+tPU53dcFTetPEoKw7HyHkMqWrEo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461156; c=relaxed/simple;
	bh=X5bqa2yCFbfPgcX/+CLwQlcc9TS2I8QY4eRpTrTNxyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THYSz9CJCoK5HSZS/khHjG4kCLr5w9q4/idWRk/UyoG7613HFAhK5Xk6LNaShHARVC5fAhfuuIIzNPDSMmg1MoprXE+8sw/tzokh2LO8c6UandmtTJuDWP3NP0WfOGgVzoPn9Kuhuhm8X+mRVFcYDnIlE3osXqpl+dK8wcEuxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hseIw+02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hseIw+02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D641F000E9;
	Tue, 11 Aug 2026 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461150;
	bh=+BXvLb7cu7OYeArpE33yeiUjgpXx5DCGhcJwcueaKB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hseIw+02BjZaT9PQiFpYpAae9SfE533m7P4+KqdUUnO+XHxSEJrm4789bZlovQpSX
	 Y0vWj91GIvrqzORBdv1pemRXjr2IoGYWxw8J6XuQ/P05y6Tx9hMmCivZXo5fyaQG3q
	 iMdJdhparkCLsUVCi9O6dezrmIcqFcaf/VPg0pWIGPQl0M762UupofvfIIqBe/aKP8
	 6ImnkL2GvT1q/4EeQYewvvQI/579aq0JTnVCqSePzlsGoIQnWpSAH9rX5lFEOV7g3k
	 DkGR6RI1U0PMpHA+Jz5XdHsAyxObjKOjFmaJB0IiodmQQdcD8ec5DYaIT9IjhCXZLo
	 f4pLMVSsD9UkA==
Date: Tue, 11 Aug 2026 12:12:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/7] tools build: Only probe the compiler at parse time
 when it is installed
Message-ID: <ans72o4MAC03XILw@x1>
References: <20260810154437.15946-1-acme@kernel.org>
 <20260810154437.15946-2-acme@kernel.org>
 <CAP-5=fWRQuo29kBXzOP9jobO6rcTPqZ5PLt42G+0+0Rh2tm7bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWRQuo29kBXzOP9jobO6rcTPqZ5PLt42G+0+0Rh2tm7bw@mail.gmail.com>

On Mon, Aug 10, 2026 at 11:07:40AM -0700, Ian Rogers wrote:
> On Mon, Aug 10, 2026 at 8:44 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Two parse-time probes still invoke $(CC) unconditionally:

> > - LP64 in tools/scripts/Makefile.arch, probing with
> >   $(CC) -E -x c, pulled in twice by tools/perf/Makefile.perf;
> > - CC_NO_CLANG in tools/scripts/Makefile.include, probing with
> >   $(CC) -dM -E -x c /dev/null.

> > In the corner case where gcc is not yet installed, the very setup the
> > install-build-deps target, added in the next patch of this series, is
> > meant for, these probes make even targets that never compile parse-time
> > spew errors like:

> >     /bin/sh: 1: gcc: not found
> >     /bin/sh: 1: gcc: not found
> >     /bin/sh: 1: gcc: not found

> > Guard both probes with 'command -v' using the first word of CC so a
> > missing compiler is handled silently with the same result as a failing
> > probe (CC_NO_CLANG and LP64 unset/0), and with no behavior change when
> > the compiler is installed.

> > Only the first word is consulted because CC may carry arguments such as
> > 'ccache gcc', and shell implementations differ in how 'command -v'
> > handles multiple words (dash only checks the first, bash any of them),
> > so validating the whole CC value would silently disable both probes on
> > some make SHELLs.

> > Assisted-by: opencode:deepseek-v4-flash-free
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>

> > +++ b/tools/scripts/Makefile.arch
> > @@ -38,7 +38,7 @@ ifeq ($(ARCH),loongarch64)
> >         SRCARCH := loongarch
> >  endif

> > -LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> > +LP64 := $(shell if command -v $(firstword ${CC}) >/dev/null 2>&1; then echo __LP64__ | ${CC} ${CFLAGS} -E -x c -; fi | tail -n 1)
> 
> nit: It might be worth adding a comment to explain this fairly complex
> one-liner.

Sure, will add explanations, see below.

> As there are minimum requirements to build the kernel
> (https://www.kernel.org/doc/html/latest/process/changes.html) does it
> make sense to be defensive about CC not being installed?

Well, the point of this series is to install what is needed to build
perf, gcc included, so on a freshly installed machine the user can just
do:

cd tools/perf
make install-build-deps

And the machine will have all the packages that are needed.

> Perhaps install-build-deps.sh can be part of the wider kernel build
> with flags to specify if you are building the kernel or a tool, where
> depencies are different (e.g. perf doesn't need quota-tools but
> libcapstone is useful).

I think this can be a followup series, i.e. making the kernel have that
target as well.

Having it in perf will showcase its usability and may entice the Kbuild
guys to consider accepting such a functionality.

- Arnaldo

acme@number:~/git/perf-tools-next$ git diff ca62b23f83ddfb8e..
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
index e0bca6808ec44ed8..ed5f008d400ed238 100644
--- a/tools/scripts/Makefile.arch
+++ b/tools/scripts/Makefile.arch
@@ -38,6 +38,12 @@ ifeq ($(ARCH),loongarch64)
        SRCARCH := loongarch
 endif

+# Probe for __LP64__ only when the compiler is installed: this runs at
+# parse time for every target, including ones that never compile, e.g.
+# install-build-deps, and would otherwise spew "gcc: not found" when the
+# compiler is not yet installed. Only the first word of CC is consulted,
+# as CC may carry arguments, e.g. 'ccache gcc'. When the guard fails it
+# prints nothing, leaving LP64 unset, as if the probe had failed.
 LP64 := $(shell if command -v $(firstword ${CC}) >/dev/null 2>&1; then echo __LP64__ | ${CC} ${CFLAGS} -E -x c -; fi | tail -n 1)
 ifeq ($(LP64), 1)
   IS_64_BIT := 1
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index fff453aac187536e..378387f629603e92 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -98,6 +98,12 @@ else
   $(call allow-override,LLVM_STRIP,llvm-strip)
 endif

+# The CC_NO_CLANG probe also runs at parse time for targets that never
+# compile, so guard it with 'command -v': when the compiler is not yet
+# installed, e.g. the first install-build-deps run, it would otherwise
+# spew "gcc: not found". Only the first word of CC is consulted, as CC
+# may carry arguments, e.g. 'ccache gcc'. A missing compiler leaves
+# CC_NO_CLANG at 1, as if the probe had failed.
 CC_NO_CLANG := $(shell if command -v $(firstword $(CC)) >/dev/null 2>&1; then $(CC) -dM -E -x c /dev/null; fi | grep -Fq "__clang__"; echo $$?)

 # Some tools require bpftool
acme@number:~/git/perf-tools-next$
