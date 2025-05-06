Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A833EA;
	Tue,  6 May 2025 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515402; cv=none; b=EG6DQTvdo4tEIPozMlyMsVUbLunL2j1T6P+cL+DD9hfB74hiWyrM/Jzkm22MEjIx439olQvjFpyI7pY9O3fxeqJLTMsSB4EotV/pPU//3KTHCULSUEBJFe7p/+THExgkjiK73oOI14/XLRiJlW2pkBgbcY6qIsuwjjMUX/Y91Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515402; c=relaxed/simple;
	bh=5AXeBeEF+J/21XsmPSVnCY4XFCpU1taRMQ2tRUKWab8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc10llhkWouEw8Yz/MGBVitreUFo6gxTVv6jjXuyJc7RLtopiRK8n8q+RM/h8gjPA64l95gP6fdsEyc7ABSjQEMg9+UOmCELwL0YdbOjAkhtHwf0xwWG6LA55tFgSbvCx6drVIzl/h0cRg3AiifJeNd1yB3cGQza/Aiwsy0i9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiMG4r2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiMG4r2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C833C4CEE4;
	Tue,  6 May 2025 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746515401;
	bh=5AXeBeEF+J/21XsmPSVnCY4XFCpU1taRMQ2tRUKWab8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiMG4r2olWryenqyst1ycyxs+EpgZCQIogcP8SZGR7Xa1fmRdw+1BlaVSAmH/+/Pl
	 V5FY+v0NQ4dmsuWUkGW7pwsYuFcjHPdFab7tMi4Xyu31JigpgaA/81WUdcH+Il2tJ5
	 wiaNGJtOPsW3bmP5EMrMO6o0hIlyGS1Y4CB6OiWXoT59Lnf/IzqggxFSz42vXAXxft
	 cif+QNGpeNaVOXEMJ0lRokTMIhshtq0qIQI1xHsAd20LAds4T2MFdURq8iYC3GM6Dn
	 R3912mjwqPTJ3dlwbBQbdlW1AmTPpf9t5aIEqiuVva6Jl1xRLevHFJPWDPgpyTGyPo
	 bUX2KYCb0qrBA==
Date: Tue, 6 May 2025 00:09:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aBm1x2as1fraHXHz@google.com>
References: <20250503003620.45072-1-namhyung@kernel.org>
 <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
 <aBmei7cMf-MzzX5W@google.com>
 <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com>
 <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>

On Tue, May 06, 2025 at 08:46:20AM +0200, Dmitry Vyukov wrote:
> On Tue, 6 May 2025 at 08:43, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, May 06, 2025 at 07:55:25AM +0200, Dmitry Vyukov wrote:
> > > Where does the patch check that this mode is used only for system-wide profiles?
> > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> >
> > Basically yes, but you can use --sample-cpu to add it.
> 
> Are you sure? --sample-cpu seems to work for non-system-wide profiles too.

Yep, that's why I said "Basically".  So it's not 100% guarantee.

We may disable latency column by default in this case and show warning
if it's requested.  Or we may add a new attribute to emit sched-switch
records only for idle tasks and enable the latency report only if the
data has sched-switch records.

What do you think?

Thanks,
Namhyung

> 
> > In util/evsel.c::evsel__config():
> >
> >         if (target__has_cpu(&opts->target) || opts->sample_cpu)
> >                 evsel__set_sample_bit(evsel, CPU);
