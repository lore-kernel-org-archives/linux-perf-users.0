Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663E131E2D;
	Mon, 30 Sep 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726823; cv=none; b=pc/xfqdf0Qb7Gy/u8ow+3oT9bRem+AtzqZzbnRaCkEMGBQULC0esP/L26FDXl6Jv49mz9rojKXQOSAR4mQgM6NtGDkyb1eBmRUarzo+GBBHEja5XYddvA0vJRZILWDnU4+TyL4g22YmWNRIimsv4ed+qp35TNj4S20dukdmFAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726823; c=relaxed/simple;
	bh=u8i8etc6+eZRoqPdoiYunQbu/KLZyDOvHnDYGlaj/kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIMnJR9R0GeuShiD+oYkh6+kyMn+6gw2Wc52EGrGovb0G2pYvo3oPJ2Pzkss0vv6AHN1cEQrnE1GdqRCS63mSD6uoFCGBeS0J7QNMWDau7qXYmZfUC8DZVHLGCKBq99G4uzxmbhrmToU7hYXEKchAOPRrSt6H3c/t+Go5kl4bTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWSiBBql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWSiBBql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7165C4CEC7;
	Mon, 30 Sep 2024 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727726822;
	bh=u8i8etc6+eZRoqPdoiYunQbu/KLZyDOvHnDYGlaj/kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWSiBBqlVOKrwewjy/yBJ7J9w50uv4GaMOz4O8eU6kOGjl0B01zX+1joYgzhMDE57
	 PzEUzzB532bvRGAD98kWFJSOc+ZuVlEscDRy7h+LStoyv1P9aYp1BQEMFAnJrbkg0g
	 DqM50ucsiYU8hsQqFIUQZ6G9vFEbTzT3uCaAotlb/5yKI5255ZQFAqiHgGhp4j6HyY
	 a8XyDFiTs0iS+jJQgke6pmG2vRelVA8lauHx7s+zSTHmXVYIbQ8RuQ7S3DPrACDUWo
	 5U3ibZf4Qo/0i3gq2yqLkNXNzG1kYuijpzF6cPw2Vjmqye6Nh9HME01S21Fr+MrzDN
	 0ENSVhHqFCOWg==
Date: Mon, 30 Sep 2024 13:07:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
Message-ID: <ZvsE5IQtEkYooDA8@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
 <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
 <ZvMfVe1VXwhCIOB9@google.com>
 <01c8dcaa-d557-407e-9ef3-babf90eb37d3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01c8dcaa-d557-407e-9ef3-babf90eb37d3@linux.intel.com>

On Wed, Sep 25, 2024 at 09:49:14AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-24 4:21 p.m., Namhyung Kim wrote:
> > On Mon, Sep 23, 2024 at 09:47:17AM +0100, James Clark wrote:
> >>
> >> On 06/09/2024 3:33 pm, Liang, Kan wrote:
> >>>
> >>> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> >>>> This option is to support the old behavior of setting exclude_guest by
> >>>> default.  Now it doesn't set the bit so users want the old behavior can
> >>>> use this option.
> >>>>
> >>>>    $ perf stat true
> >>>>
> >>>>     Performance counter stats for 'true':
> >>>>
> >>>>                  0.86 msec task-clock:u                     #    0.443 CPUs utilized
> >>>>                     0      context-switches:u               #    0.000 /sec
> >>>>                     0      cpu-migrations:u                 #    0.000 /sec
> >>>>                    49      page-faults:u                    #   56.889 K/sec
> >>>>                   ...
> >>>>
> >>>>    $ perf stat --exclude-guest true
> >>>>
> >>>>     Performance counter stats for 'true':
> >>>>
> >>>>                  0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
> >>>>                     0      context-switches:Hu              #    0.000 /sec
> >>>>                     0      cpu-migrations:Hu                #    0.000 /sec
> >>>>                    49      page-faults:Hu                   #   62.078 K/sec
> >>>>                   ...
> >>>>
> >>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>>> ---
> >>>>   tools/perf/Documentation/perf-stat.txt | 7 +++++++
> >>>>   tools/perf/builtin-stat.c              | 2 ++
> >>>>   2 files changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> >>>> index 2bc06367248691dd..d28d8370a856598f 100644
> >>>> --- a/tools/perf/Documentation/perf-stat.txt
> >>>> +++ b/tools/perf/Documentation/perf-stat.txt
> >>>> @@ -382,6 +382,13 @@ color the metric's computed value.
> >>>>   Don't print output, warnings or messages. This is useful with perf stat
> >>>>   record below to only write data to the perf.data file.
> >>>> +--exclude-guest::
> >>>> +Don't count event in the guest mode.  It was the old behavior but the
> >>>> +default is changed to count guest events also.  Use this option if you
> >>>> +want the old behavior (host only).  Note that this option needs to be
> >>>> +before other events in case you added -e/--event option in the command
> >>>> +line.
> >>> I'm not sure if we really need this option. I think it may bring more
> >>> trouble than what we get.
> >>>
> >>> The name of the "--exclude-guest" sounds like a replacement of the event
> >>> modifier "H". But in fact, it's not. It should only affect the default.
> >>> It doesn't set the "H" for any events.
> > Well I think it's tricky but it'd set "H" modifier events after the
> > option.  But I have to agree that it can bring more troubles.
> 
> I may have miss-read something before. After some simple tests, yes, the
> "H" is applied with the option.

Ok.

> 
> Since there is a limit for the "--exclude-guest" option, can we print a
> warning if the option becomes invalid because of the order?

Well.. I'm thinking of removing this option for now.

> 
> > 
> >>> Except for the perf kvm user, I don't think there are many users which
> >>> care the exclude_guest. The behavior of the perf kvm is not changed. So
> >>> the option seems not that important. If we really want an option to
> >>> restore the old behavior, it's better to choose a better name and update
> >>> the description.
> > Personally I don't want to this option but just worried if there's a
> > case where exclude_guest is preferred.
> 
> The only case I can imagine is that, with the new vPMU passthrough
> introduced, some users may want to explicitly set the exclude_guest to
> avoid the fallback. But I'm not sure how useful it is for them.

Because of overhead?  They'll get exclude_guest eventually, right?

So I think I can drop this patch for now.  And consider this later when
we can find a real usecase.

Thanks,
Namhyung

