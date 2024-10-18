Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C883207;
	Fri, 18 Oct 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255133; cv=none; b=AJOJvb8w8nNTmeckG2By8Q4FTL4kAUDDEcGFYvRN2TWYMa6XWLItcro3sa1rWf5ZjXbDaDUBezBdsdqr+08KcliHs7tvgHZyyytxkofRoaaU+IvpJnHdKEp6LkfCcpEtWuKrCOnWPIMdQutldHATYT7+fAM/88LWBInbZK8x14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255133; c=relaxed/simple;
	bh=sU/wRbtKow9we8Zf+qCDeQEEsMJU+g0mnXx23BYtbA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCSvlDME77WYzDXy3qit00VUYk6C5xcIRJrKc0FNaLZPNYots27tUEJMcvg2H1SXogzQxaANH5tyhEnnNhAR96Kc39Nq48DfKKBgm4i7NsWec5tp2rvUsBouFH3H20P+Zl+vvd+naf8OzpufcOEue4J242laPdjK1j1g3OMZGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA5GoAes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA5GoAes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FAC4CEC3;
	Fri, 18 Oct 2024 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729255132;
	bh=sU/wRbtKow9we8Zf+qCDeQEEsMJU+g0mnXx23BYtbA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA5GoAesEqAU/DNZU2RPz4why8OlFmiPitY6WA37oi1TX+tlcLHBhsHsYJWHpyfa9
	 8RzHUh73FtNdDr3CeUbfBb1Rtl0irEoXqROwB6MTHtDQa9JIJmbZDHQGWvfnLjnshq
	 sqfnlXVhZuzx9Z+DYWvBygfaeSyzlmrKUKvoJNmluV4PHud+GemcSv0PJA3XjgFMfH
	 PjvPrqbv7L1HAGwsKF6Bee82nPwFv49GM5A0D8dXlLvC5SZZnN7FT0E0WxCxtuXnyp
	 iCRZJLa95/eazkaWvgouHLP7wfT95UP99xWvpFeY8O1cdl2VejmTyJt70kmv2IMeUf
	 hh6ZhIKYIOEsA==
Date: Fri, 18 Oct 2024 09:38:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/3] perf test: Document the -w/--workload option
Message-ID: <ZxJW2euCP4qi4mmZ@x1>
References: <20241011171449.1362979-1-acme@kernel.org>
 <20241011171449.1362979-4-acme@kernel.org>
 <d4d5528a-2420-4f0b-a251-cc3db26345fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d5528a-2420-4f0b-a251-cc3db26345fc@linaro.org>

On Mon, Oct 14, 2024 at 09:41:03AM +0100, James Clark wrote:
> On 11/10/2024 6:14 pm, Arnaldo Carvalho de Melo wrote:
> > +++ b/tools/perf/Documentation/perf-test.txt
> > @@ -48,3 +48,17 @@ OPTIONS
> >   --dso::
> >   	Specify a DSO for the "Symbols" test.
> > +
> > +-w::
> > +--workload=::
> > +	Run a built-in workload, to list them use '-w --list', current ones include:
> 
> Should be --list-workloads now

Oops, fixed now.

Thanks,

- Arnaldo
