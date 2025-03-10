Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA51E0E0B;
	Mon, 10 Mar 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641239; cv=none; b=upn8UEZyNUe4fy0uABe9mjy8htLsQfPBL/1GmffTLJ1vu9dYi1T+oltUeJnxZTA8gr/lMMKAVcazTTx39SSMlRBdY+snwskcPu6sIgegobqDLIKBqAhXDTGEYiG6c29q+8wB3/P1tzMlaRGPs7WoU3PyNyt1KeGLnJtPGkOn9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641239; c=relaxed/simple;
	bh=ofonAGYkuJD+XxID+8fbp4tmBpONyoJozUMiWHGHFQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCXW3goRyaKJKMXmasOP5V2Rw5III1D7Op2TzrCywGGYFKiwwgfki4jb0I1P/iFTwIzEmvm2XKBiW+90o3nvnfCg+sJdoFXxSr69QmdMCh89y+4r6gw0uaNvzOqhq8ZmVsgiFQa6Q8CyUGztKNYl8ecSsDrpIBh/cL4cHd1G39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNTnyBgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNTnyBgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F158C4CEE5;
	Mon, 10 Mar 2025 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741641238;
	bh=ofonAGYkuJD+XxID+8fbp4tmBpONyoJozUMiWHGHFQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNTnyBgv5ZEXhsVleSIt/nVR2j56/f24Rg4RVedUFhX5n270mDWY6b0dr0Q0f4G14
	 oy9OXWlXqizoY/fHnfvLTjOxr8jXxALGJYrs2jUx6n6kkltQ33LnqwQUahx04ifAEP
	 PMrwASNRu4epFCiVK1FcJHK6xDtP9Oqi2qbGMc2BSQvCanH8uVgPEmp9d+rd9ruvTD
	 LjaQUu/3cOx2BhU8ZdEszGUM9ZO9iFPXNXcIT02CvvpqEs8e0qdpAqION12AZ4Rgpm
	 EiZMIx5XfgDBhx2dps5nH7w2g4OtqbfY6viJUoL9WPgkSMw3jJNEkw141OggFku+Di
	 aIaqYbnloVKnw==
Date: Mon, 10 Mar 2025 14:13:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Martin Liska <martin.liska@hey.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH] perf script: Update brstack syntax documentation
Message-ID: <Z89WFKPIxWBgN6q2@google.com>
References: <20250225061736.1698175-1-yujie.liu@intel.com>
 <Z8q51Mcz/9QenjnC@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8q51Mcz/9QenjnC@yujie-X299>

Hello,

On Fri, Mar 07, 2025 at 05:18:12PM +0800, Yujie Liu wrote:
> Hi, friendly ping on this perf script doc fix. Thanks.

Sorry for the late reply.

> 
> On Tue, Feb 25, 2025 at 02:17:36PM +0800, Yujie Liu wrote:
> > The following commits appended new fields to the end of the branch info
> > list, such as branch type and branch speculation info.
> > 
> > commit 1f48989cdc7d ("perf script: Output branch sample type")
> > commit 6ade6c646035 ("perf script: Show branch speculation info")
> > 
> > Update brstack syntax documentation to be consistent with the latest
> > branch info list. Improve the descriptions to help users interpret the
> > fields accurately.

Thanks for your work, but can you please update it again with recent
changes from Leo?

https://lore.kernel.org/linux-perf-users/20250304111240.3378214-1-leo.yan@arm.com/

Thanks,
Namhyung

> > 
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index b72866ef270b..8bd105084280 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -239,13 +239,15 @@ OPTIONS
> >  	i.e., -F "" is not allowed.
> >  
> >  	The brstack output includes branch related information with raw addresses using the
> > -	/v/v/v/v/cycles syntax in the following order:
> > -	FROM: branch source instruction
> > -	TO  : branch target instruction
> > -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> > -	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> > -	A/- : A=TSX abort entry, -=not aborted region or not supported
> > -	cycles
> > +	FROM/TO/PRED/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> > +	FROM  : branch source instruction
> > +	TO    : branch target instruction
> > +	PRED  : M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> > +	INTX  : X=branch inside a transactional region, -=not in transaction region or not supported
> > +	ABORT : A=TSX abort entry, -=not aborted region or not supported
> > +	CYCLES: the number of cycles that have elapsed since the last branch was recorded
> > +	TYPE  : branch type
> > +	SPEC  : branch speculation info
> >  
> >  	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
> >  
> > -- 
> > 2.34.1
> > 
