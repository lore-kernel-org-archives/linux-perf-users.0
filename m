Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F43C0B;
	Mon, 12 Aug 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441427; cv=none; b=VWepbMT8h2rbFM362pJPoDmu7OU4UMLnyPQBenCmg5N83G7q1qS3ouy6QOnTzfJBeenCNeujHerf8Rcfs8d4xsJFo7T+B52KyuQj2P2EQPVH8f/ho84rPBZ5b/4J1zL96p9mvU/9+5Nbl3lhYtDrIFFj+wzcW+a4NgJQPfbAOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441427; c=relaxed/simple;
	bh=T3bceQXwRmtOpEjDnmHH1SQO2+2ahfvVKrcXfD+52Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4EXyVC/quuHAb9eVvPxXO+YYoiSIQlJa3yZZnYWrGp16B5FYbfwuD1C26enVVI+4/Es/g5K4F/nYN3/VqI5udKdQIoRtp/bz8e2QociK1DB4/2NbFcXqt8+k9MWQHcc153FKHLlLu/2LN1xothY7XJVx+f5fsr5CncE3nKduoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hK9xShKS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hK9xShKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723441425; x=1754977425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T3bceQXwRmtOpEjDnmHH1SQO2+2ahfvVKrcXfD+52Ao=;
  b=hK9xShKSDcL1fFwZr9wtHehnlxUHt34BoJMZ/49MlYtj2csazBEi4VZv
   SjEceOjmQirRVumZLZlfcB0gTFMkMFcohnWOLtuFf2yPQYy/U7qfQsD91
   slv54ncA633J4pvfSCLTguV/UDDS6xos3KEPiwk0eej80KFoPABuK3w1w
   ggBQiia4TQBogSiU1DvtGkbeXtUv0ke2KyGego7AJ3y1pB+HzfSZrv6F9
   2Mh2IfpglRvxj78IKc42DJLR8f8Biw6wMVVQyjM8Em2KkZo3VohWgINlc
   uisb1oe6ssBK/D3LwXMrOYnfbla5LaAo9Hl70DdFksmijxe5a/w59VugI
   g==;
X-CSE-ConnectionGUID: jehLFYAiSOeZ9ywlIt+VGQ==
X-CSE-MsgGUID: Hy6svMerTzeIkBXVXBsH3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32153776"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32153776"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:43:44 -0700
X-CSE-ConnectionGUID: uUdWvm/HReGP3Y9eUIrytg==
X-CSE-MsgGUID: kCjzPuSKQO2kyDGmBwJp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62993880"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.203]) ([10.124.232.203])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:43:42 -0700
Message-ID: <5de31aa1-8103-4f73-8134-4efe04a73295@linux.intel.com>
Date: Mon, 12 Aug 2024 13:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/5] Bug fixes on topdown events reordering
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

Kindly ping, any comments here? Thanks.

On 7/13/2024 1:03 AM, Dapeng Mi wrote:
> Changes:
> v2 -> v3:
>   * Refine arch_is_topdown_metrics() (Kan Liang)
>   * Only move topdown metric events forward when they are not in the
>     group with previous event (Ian)
>   * Check if topdown events is supported before test topown events
>     leader sampling (Kan Liang)
>
> History:
>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
>
>
> Dapeng Mi (5):
>   perf x86/topdown: Complete topdown slots/metrics events check
>   perf x86/topdown: Correct leader selection with sample_read enabled
>   perf x86/topdown: Don't move topdown metric events in group
>   perf tests: Add leader sampling test in record tests
>   perf tests: Add topdown events counting and sampling tests
>
>  tools/perf/arch/x86/util/evlist.c  | 13 +++++--
>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>  tools/perf/arch/x86/util/topdown.c | 62 +++++++++++++++++++++++++++++-
>  tools/perf/arch/x86/util/topdown.h |  2 +
>  tools/perf/tests/shell/record.sh   | 45 ++++++++++++++++++++++
>  tools/perf/tests/shell/stat.sh     |  6 +++
>  6 files changed, 124 insertions(+), 7 deletions(-)
>
>
> base-commit: 73e931504f8e0d42978bfcda37b323dbbd1afc08
