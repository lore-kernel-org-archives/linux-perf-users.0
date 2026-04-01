Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881B372ECA;
	Wed,  1 Apr 2026 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085062; cv=none; b=O9gv3tENHRLYzdEhcDZcD1o/cxPOdTqABZk+b2ylQL0o39uYuSQYtb4O2HB/QBZ1iOwJYOzUBw+/JMdtsKf8pfUXFsBGed/Nb8fABeYJOGQDfBdtRhXYRrVT2Z9PxlzZWxGZ6zLlkCCiD6wyxD7IL5KjESOaN+0w0VWxsSd9VG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085062; c=relaxed/simple;
	bh=R+BbafY/MWNl2F0rJjaN7HWCLk1z/Hsh+Y46fnEr+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBYMPPy4oy9rl3yOZT1fEfyFINlvkNjdYDsl+gpXYMaUXNlPWiILbfSOI5/9TizUfgoHIDMxtOrQAdO2ojdcRJz7VuAfyZMY0nWQLopUi70SksAy37zJNzwlmiayYgcjwMoEnAqasEWg/alS1YavJ1IlO2gNCF06Mk3p/pYcrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPpjx/EJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPpjx/EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE5C4CEF7;
	Wed,  1 Apr 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775085061;
	bh=R+BbafY/MWNl2F0rJjaN7HWCLk1z/Hsh+Y46fnEr+hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPpjx/EJYHALDzxgXG5CYRuEKAMBdq9vdE8CoLjhGuFRDgvCLHBwcIGmKAnG1sAIW
	 qbKmc20gdLcBp/5pfUElYfsNpXzcJKrBkaKivyuD9EOfchOar6/PG9kkQLL4O19FwY
	 gTxZxujr0XQrbWNNfoa0Sscr2y9XJfZtUYbRVQhTEJfPYXWz7IbJTDuSphzSOGKYNn
	 UnDY2rjnETcHWBuUti9mssvZdVVzY2UCyHWWpCpG8NRAFWotvNl8CdkVCiVuQ6bk45
	 q2DpCK9kKXIzGLLmQBFYnX+90PRtItOf6j3PyQZBYwKlxUKTEKq6sMyL4w0LX0DnvE
	 OU/Q1k5RE5Zdw==
Date: Wed, 1 Apr 2026 16:10:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 4/4] perf symbol: Add missing libgen.h include to get
 basename() prototype
Message-ID: <ac2mAyErikb4r85Q@google.com>
References: <20260401210203.2150651-1-acme@kernel.org>
 <20260401210203.2150651-7-acme@kernel.org>
 <CAP-5=fXEVn8BBcQBfXSWwWYPfWV50Xk6FAgm1gCBxu=qqxoJpw@mail.gmail.com>
 <39DC6936-48D7-4284-9EA3-F3C31192A12C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39DC6936-48D7-4284-9EA3-F3C31192A12C@gmail.com>

On Wed, Apr 01, 2026 at 06:41:28PM -0300, Arnaldo Melo wrote:
> 
> 
> On April 1, 2026 6:08:16 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >On Wed, Apr 1, 2026 at 2:02 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>
> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >> This works in some places because there are tricks to prefer a GNU
> >> version instead of the XPG version, but started breaking in some musl
> >> libc systems due to some unrelated change that made libgen.h stop being
> >> included by chance.
> >>
> >> Since symbol.h is using basename(), make it include libgen.h.
> >>
> >> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> ---
> >>  tools/perf/tests/make    | 2 +-
> >>  tools/perf/util/symbol.h | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> >> index 6587dc326d1b272e..e12ff6397077806e 100644
> >> --- a/tools/perf/tests/make
> >> +++ b/tools/perf/tests/make
> >> @@ -148,7 +148,7 @@ run += make_extra_tests
> >>  run += make_no_jevents
> >>  run += make_jevents_all
> >>  run += make_no_bpf_skel
> >> -run += make_gen_vmlinux_h
> >> +#run += make_gen_vmlinux_h
> >
> >This looks like something removed during testing that you meant to put back.
> 
> 
> Yeah, unrelated, I'll send a v2 removing the header dir move that was already merged, as you noted.
> 
> This gen vmlinux test is failing and I still need to figure out, seems like a newer clang is complaining about some struct forward declarations I'm vmlinux.h.

Right, I've seen this too.

Thanks,
Namhyung

