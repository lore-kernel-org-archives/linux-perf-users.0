Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631811CD16;
	Fri, 26 Jul 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004611; cv=none; b=Ccigm/wYSE1+wWL3Gs1VO3ivElI/fId2Pf1YrM3pCs0U47FK58mLCg3KC3pn1KyxrpSS2QSJ6XilB+MGQAePrNVeIZkxv/AdnjCSuEFcCHD776g9P8DOh4wUZH8qe/fguqrIfpfYY18fArnaZVg9JfkTZsMv6MuBYeJwCYfAuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004611; c=relaxed/simple;
	bh=lIzwLwtjjuzMoZA0qMHAziQc5mVvde+Jky8Kkncq7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugdI0zjjMSqQngW5CiJccshR5BT1NuonQL/In7vh+VgLQWvn4chhnJy0xDIoZrWko+fTGduaI7DNK8h2RSctLsYToMDy6sbZ6ekqjsTP0VKHc537V+TU9KfqwJxjSBO8d8m3UFi2Q/Bfg5hWUajbHjW0yZPTKGQPA5xKFsplWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXVR8WUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXVR8WUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9BCC32782;
	Fri, 26 Jul 2024 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004610;
	bh=lIzwLwtjjuzMoZA0qMHAziQc5mVvde+Jky8Kkncq7Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXVR8WUrV86+JaLoNf1q9nihIN2NFpuZu8WPF9M+Gmmim/iCTOS0pYYTMhdkTTGXX
	 6sQcXDxbAYUwNgihPwab861RfXdm8IZCXGHsBTg83mDtFFn+Rro1TorN60RrSiqE+8
	 QkhPmrtTwHQ7q5uO7P2xaM/8SXRotetJzPVtfAhmaTGa7yu4fwci+LNlYZoLeKfyCR
	 ORQQ+Qq5YKpKNJMgLA66Vwy9j1At/OffyQuItxyd/VSF/B2f8XIlE7+DzsqX86+nWM
	 B6uEhZm8inPgH/hGmbBXh3d6DOiks6pkRWpREjb0g2JMzlVqEAGBNw8hKmnZVRPwSA
	 3Jb4NrdceBabg==
Date: Fri, 26 Jul 2024 11:36:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
	suzuki.poulose@arm.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: cs-etm: Restore first sample log in
 verbose mode
Message-ID: <ZqO0gJUd7N6y7GWY@x1>
References: <20240723132858.12747-1-james.clark@linaro.org>
 <7616d1dc-73e9-425e-9a62-1f3b20bec6e9@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7616d1dc-73e9-425e-9a62-1f3b20bec6e9@arm.com>

On Tue, Jul 23, 2024 at 05:05:09PM +0100, Leo Yan wrote:
> On 7/23/2024 2:28 PM, James Clark wrote:
> > 
> > The linked commit moved the early return on the first sample to before
> > the verbose log, so move the log earlier too. Now the first sample is
> > also logged and not skipped.
> > 
> > Fixes: 2d98dbb4c9c5 ("perf scripts python arm-cs-trace-disasm.py: Do not ignore disam first sample")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to tmp.perf-tools-next,

- Arnaldo
 
> > ---
> >  tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > index d973c2baed1c..7aff02d84ffb 100755
> > --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> > @@ -192,17 +192,16 @@ def process_event(param_dict):
> >         ip = sample["ip"]
> >         addr = sample["addr"]
> > 
> > +       if (options.verbose == True):
> > +               print("Event type: %s" % name)
> > +               print_sample(sample)
> > +
> >         # Initialize CPU data if it's empty, and directly return back
> >         # if this is the first tracing event for this CPU.
> >         if (cpu_data.get(str(cpu) + 'addr') == None):
> >                 cpu_data[str(cpu) + 'addr'] = addr
> >                 return
> > 
> > -
> > -       if (options.verbose == True):
> > -               print("Event type: %s" % name)
> > -               print_sample(sample)
> > -
> >         # If cannot find dso so cannot dump assembler, bail out
> >         if (dso == '[unknown]'):
> >                 return
> > --
> > 2.34.1
> > 
