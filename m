Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2913D55D;
	Tue, 23 Jul 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748402; cv=none; b=Xd25/TgRsmzLTpz/qKuH0huCtFf80+NwtHzSY7UoVlXZc1k1itXSt20e6Q4+E0BtlQHGJ5kjB4tPWknqihol0S+ujfxSSiw2GQ1uqai6VcrbbvXRxYxPeOOiaiFE+DijB7SX+BxTq4tZoBZBPo64FuK3Vt6QbWN6aIfx35qso10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748402; c=relaxed/simple;
	bh=xryDImbUX1dlt+hgOfpuRXIdJMiHobsAfX+ipkb2WVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAwBb6is1ueORy218yGZBJO1iaIPTr8W9aoH83O/MdPbMKV4RCS2gYywvBy1lCdOP4m2KZQtnLcy1KabxdKUgnyXFG+kniFZ1L1BJKbuhrzjTMqDSayIUxXZXmJjLXEqGXBmJEd6Nerp8RgSAiiOZfRBvxDO3kDaiJGVhjE5O7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjxG6FnG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjxG6FnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721748401; x=1753284401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xryDImbUX1dlt+hgOfpuRXIdJMiHobsAfX+ipkb2WVU=;
  b=CjxG6FnGPmpik9BY5tbwIkmDZIpFaDiUYcbe1mhHAU2ORSj0COn/g/UO
   moIGeFhovRYCFAq14G4NYV9ZBCAn7AVcCBxWq1fIP4ngnkugqsshciSIa
   yvAwimwnM3FTnpDjkCPizjkh5ArHdd378p147+S1hQn4WjkFLuPut9u7p
   akmT++ZdtHvqBkj5d4k6AK2j6k7txDZFEBHB2u32mT8wtCGGYh0x0rbBW
   SQ8crPRzBMRg9JHMiUHmcLok8M92ZzPMXfgkoSM674LKQAu4yO2/CAei+
   diJ5TxMvrxdogXxqtxWg7PPT4Po1hErqf9lDj1dlr4NMpazG0T33RLBUy
   g==;
X-CSE-ConnectionGUID: U9+H3gzfTTyGIC8obSEPKA==
X-CSE-MsgGUID: YGpj1bL8RBiCDNI2R94NQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19565359"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19565359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 08:26:40 -0700
X-CSE-ConnectionGUID: 4483HzCGTgy0cbrnFGvjNA==
X-CSE-MsgGUID: WxdP7TkHSsKqGc157zuTdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="57382588"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 08:26:40 -0700
Date: Tue, 23 Jul 2024 08:26:38 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
Message-ID: <Zp_Lrlz1S5uVlovH@tassilo>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
 <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>

> > For some reason I only get the metric: lines when I record with -a. I
> > noticed this because Andi's test doesn't use -a so it fails.
> >
> > I'm not sure if that's expected or it's related to your disclaimer below?
> 
> It is. When you don't do -a the cpu map just contains -1 and for some

The intention was to make it work without -a

> reason it is busted. The whole indirections to arrays of arrays,

That's what I tried to fix earlier with my patch that remapped to index 0,
but it ran into the problem that it conflicted with the perf stat report setup.

The metrics code doesn't really need a map, all it wants to do is to
process the last contiguous group. 

That is at some point perhaps it would be nice to extend it to multiple
groups, but I wasn't trying to support that here.

> counts, stats, aggregations, with indices into various other arrays
> and a lack of helpers. The code works for perf stat, but there is a
> lot of complexity that I don't fully grok in that. Here I've tried to

I don't really know how we ended up with such convoluted code, but that's
a different issue.

-Andi
