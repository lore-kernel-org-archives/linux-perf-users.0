Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324021146B;
	Fri, 10 Jan 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520124; cv=none; b=UgPHRIjKE/yhIJDhjIBIOvDp6eGLdsC5rDnqQZWXVz9YC/0JrQwzKIkyoIw77Y53eAnREbjwWBHpFTaKwVazPuMsLYRBuWPoLKLoBfE1k3a0tDRAMS0Zy75fBXmOqk7wHOlJ85kmaJ1i8cp/GlNEZKK4Vi44NaIW57Fpa/0vhvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520124; c=relaxed/simple;
	bh=lb+wVe0+J4H9x3lB5D2vEHQDXPLCxRllOwTUALIRyn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSzva8yaz20ou3xu+EQbpEuyMTQAut75BTGRUuoG2m0kDFEiZZQbiTUGMX43NtIrfoywqW1Kf7VEPnGCfFGxmIdr0OtJm8YlSNys2DciePBQxEQ+E5tfbgjJxjPor6rhTrZLSvlVq94U8rt0q2UxricJO/AcRmcvCpVpZvd3yIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/OipGSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/OipGSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EC6C4CED6;
	Fri, 10 Jan 2025 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736520124;
	bh=lb+wVe0+J4H9x3lB5D2vEHQDXPLCxRllOwTUALIRyn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/OipGSg2qATuvB/9o4hUldf79jfd3cLA0gQ1TnxmWxycwVMqWYkaAWr6+zFduUMr
	 91E6OO8ANgbT//CrjWdpw5WAgFpflZ/1mK8U3npo20TLaeHdMLrLJcub0De563IPme
	 Jrrv2xmrSq56lC7uCAw+Nzu+SbkjaZESz5KA1pH8D/22GH/ioeFZjH4eZGtNHB4f2S
	 OO5lF9arj36v/cWl5oIr+30T1m+In6WnAmsGjC64XUF9zndbJXbU2ymnQJUgODPQb4
	 4Pplcre4iQHCi2pwBEjqPSMbbM08UKBzpK7m7XU/vQiy0Asu8/6RdKrfbY15doWdKY
	 MchTfCV0e6YfQ==
Date: Fri, 10 Jan 2025 11:42:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiachen Zhang <me@jcix.top>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] perf: Fix a wrong help message
Message-ID: <Z4ExucFqWB0mETh7@x1>
References: <20250109152220.1869581-1-me@jcix.top>
 <Z4BqBewL5zZFVl0J@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4BqBewL5zZFVl0J@google.com>

On Thu, Jan 09, 2025 at 04:29:57PM -0800, Namhyung Kim wrote:
> On Thu, Jan 09, 2025 at 11:22:19PM +0800, Jiachen Zhang wrote:
> > The wrong help message may mislead users. This commit fixes it.
> > 
> > Fixes: 328ccdace885 ("perf report: Add --no-demangle option")
> > Signed-off-by: Jiachen Zhang <me@jcix.top>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > ---
> >  tools/perf/builtin-report.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 048c91960ba9..a5672749f781 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -1422,7 +1422,7 @@ int cmd_report(int argc, const char **argv)
> >  	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> >  		   "addr2line binary to use for line numbers"),
> >  	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> > -		    "Disable symbol demangling"),
> > +		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
> >  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> >  		    "Enable kernel symbol demangling"),
> >  	OPT_BOOLEAN(0, "mem-mode", &report.mem_mode, "mem access profile"),
> > -- 
> > 2.34.1
> > 
