Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6140FDB3;
	Fri,  6 Feb 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389853; cv=none; b=HLBQLRxaWAfJivCaGgLbJb4gIDrm+jiILkVWsDM35n/cbzEprtMBCcV7h2hmrU/COXcbsWmPIZTw7K9GDZJdijktikz7ZJYN3+CXObfyYPbDzv33jv7AL7pQbdlSUwAKVhEdqmPqgnU5dcGT9AIwJHA+oNwEdsdf4Nr00A6eWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389853; c=relaxed/simple;
	bh=L1wCqtqBbXKQ9bunNkuH1wXzXBjn3AtwBsS6rsKAPrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faO71Qa9wMHfgDCltNeyvitqsH98JQQw4hca8fXIYzlkNyo7uzWtYWcZ5eC0G5Qpi43f1cu+fs2e656GSrFKuM65WeQqkQevB8wbpJRmbGJHBt5bCh3cYw/HNgLRren9KEOHX8AbM9sRQ601oclqx9IwqwJb5NWC849nq6XM+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcGnxVdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcGnxVdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B55C116C6;
	Fri,  6 Feb 2026 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770389852;
	bh=L1wCqtqBbXKQ9bunNkuH1wXzXBjn3AtwBsS6rsKAPrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcGnxVdct++Mx57Tfoc6UFdGMfsqGXZTFG1CYTJ9Rnf7WPO0Ih25V7Pdhh+d2whtU
	 m1ewenJT9GB0BTstLB5gyttCZ5jcfe67scV0CYPKKj3JWapxGLkRMmbb4wY3Hz4L5e
	 t9/D6w1grNWEsdfwmu53O9kVP1kXqgm9UNQSilQ86rDIrPL+7RQAm8cHvVNLRzP9+b
	 PV6RUGXLtcY8US1KcyrBCMGMu72UKRM8+O33U5ms8eabWmNvjnURMLVOJxKt0Dpnts
	 +vkGAdzgBAeDmNg+ZwucUQLnaAzikcrtWe0htJWuYuaR3ljMhhitFsTOi+wlTz15Dz
	 Myy/5L/nEExMg==
Date: Fri, 6 Feb 2026 11:57:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf tests: build-test coverage for NO_JEVENTS=1
Message-ID: <aYYBWKc-EOQyGeMi@x1>
References: <20260205183603.459363-1-irogers@google.com>
 <20260206085349.GD3529712@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206085349.GD3529712@e132581.arm.com>

On Fri, Feb 06, 2026 at 08:53:49AM +0000, Leo Yan wrote:
> On Thu, Feb 05, 2026 at 10:36:02AM -0800, Ian Rogers wrote:
> > Leo reported the NO_JEVENTS=1 build being broken and this highlighted
> > it being missing from the build-test, add it.
> 
> To be clear, I did not say the build is broken.
> 
> The issue I reported is that `perf stat` is broken, both with
> NO_JEVENTS=1 enabled and without that configuration.
> 
> With updating the commit log, this patch LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> > Reported-by: Leo Yan <leo.yan@arm.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20260205175250.GC3529712@e132581.arm.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/make | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index eb41516c0562..6587dc326d1b 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -70,6 +70,7 @@ make_python_perf_so := $(python_perf_so)
> >  make_debug          := DEBUG=1
> >  make_nondistro      := BUILD_NONDISTRO=1
> >  make_extra_tests    := EXTRA_TESTS=1
> > +make_no_jevents     := NO_JEVENTS=1
> >  make_jevents_all    := JEVENTS_ARCH=all
> >  make_no_bpf_skel    := BUILD_BPF_SKEL=0
> >  make_gen_vmlinux_h  := GEN_VMLINUX_H=1
> > @@ -144,6 +145,7 @@ ifneq ($(new_libbfd),)
> >  run += make_nondistro
> >  endif
> >  run += make_extra_tests
> > +run += make_no_jevents
> >  run += make_jevents_all
> >  run += make_no_bpf_skel
> >  run += make_gen_vmlinux_h
> > -- 
> > 2.53.0.rc2.204.g2597b5adb4-goog
> > 
