Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DAD3016EB;
	Fri, 24 Oct 2025 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293435; cv=none; b=IUathZ6Oq1BHi2w1TXPj3fmAwExX1BiukQK6l1QuMOTpdtfdXiOKSE9I5Dd8HtvA3qYFtgYg5avspLybpm5gTAFE2zn4KgMpOYro8dLHfCg/UDvoVUyKc7epnd0j0w+8xNT5VQIZpVfl0Pcd0uXwfAAqh97ASS90PVBH2jAFhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293435; c=relaxed/simple;
	bh=AwJSNrrD5lYEFe9sVj0ryarWF08vscc3DImzfrYWBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcyCKdTkLsrv2qNGS3UU/03YQ2/siApDsI8PTel5TUZAM19U5jaO4bjiBmojv/G9QbvzR71Qe8JwvKhaZokRsx/CfZ/yB5ZfojmS9Vg/Cc2uiS4JLILM7U8qOZEsWKVa7y/x0bOANNOz9EB9yFYuptK0incWv7BRaN+0Wy8lgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DCC1175A;
	Fri, 24 Oct 2025 01:10:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E93043F66E;
	Fri, 24 Oct 2025 01:10:31 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:10:29 +0100
From: Leo Yan <leo.yan@arm.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: tanze <tanze@kylinos.cn>, james.clark@linaro.org, leo.yan@linux.dev,
	irogers@google.com, john.g.garry@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	graham.woodward@arm.com, mike.leach@linaro.org
Subject: Re: [PATCH v2] perf arm_spe: Add a macro definition to handle offset
 value
Message-ID: <20251024081029.GT281971@e132581.arm.com>
References: <20251016083019.27935-1-tanze@kylinos.cn>
 <20251017021540.45930-1-tanze@kylinos.cn>
 <22b7b11e-b1fe-4d9d-8749-afe57ea1c35c@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b7b11e-b1fe-4d9d-8749-afe57ea1c35c@intel.com>

On Fri, Oct 24, 2025 at 09:27:25AM +0300, Adrian Hunter wrote:

[...]

> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -1732,7 +1732,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
> >  	attr.sample_period = spe->synth_opts.period;
> >  
> >  	/* create new id val to be a fixed offset from evsel id */
> > -	id = evsel->core.id[0] + 1000000000;
> > +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
> >  
> >  	if (!id)
> >  		id = 1;
> 
> Functionally this is to find a free range of IDs for synthesized events,
> but also the range can only have one user e.g. in this case auxtrace
> 
> So add to auxtrace.c
> 
> #define AUXTRACE_SYNTH_EVENT_ID_OFFSET	1000000000ULL
> 
> /*
>  * Event IDs are allocated sequentially, so a big offset from any
>  * existing ID will reach a unused range.
>  */
> u64 auxtrace_synth_id_range_start(struct evsel *evsel)
> {
> 	u64 id = evsel->core.id[0] + AUXTRACE_SYNTH_EVENT_ID_OFFSET;
> 
>   	if (!id)
>   		id = 1;
> 
> 	return id;
> }
> 
> And then use that:
> 
> - 	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = auxtrace_synth_id_range_start(evsel);
> -
> -	if (!id)
> -		id = 1;

Agreed, much better than I suggested!

Just remind updating subject as well, like:

  perf auxtrace: Refactor AUX event ID calculation
  perf auxtrace: Add auxtrace_synth_id_range_start() helper

Thanks,
Leo
