Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3C2D0C92;
	Fri,  2 Oct 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961250; cv=none; b=aMWQrqqaSEo6jZGuBeBq+wUqugv2oYpi7eFG5qYwNUQSOFlS4yIVBSueKHpBH4VyWuRewNmn+1XwU0a7ODcgy44kAk+HIga+8pPdcl5Dh9G3chbuG0OuHdAczqua2IYA0O5dgsQNWBVtqhaG5Iq43ljBSrXkQgDS/4CXTCKGEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961250; c=relaxed/simple;
	bh=bl3TUcuEor0ntvv140M+GUV3h7G2r8r6Edcjw0sDACk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WW76VNfA7tO6iOcmM7EPZl+ZBzQ4ZH4Ov4w5JsHQu0m5ZO7T56am7lHzfc9KWV96cJxYdY41sDdu4qBqnsvjpfsmtAM1pVsLHfw4pHs0bDkQXxxsO65xPsOsqyN/CcGqB0pXT1asE7+weyNZb3pw6uqmFJrQExQ1VdgIj03C07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FygPz1yn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FygPz1yn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F012F;
	Fri,  2 Oct 2026 10:14:04 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4FA3F85F;
	Fri,  2 Oct 2026 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790961247; bh=bl3TUcuEor0ntvv140M+GUV3h7G2r8r6Edcjw0sDACk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FygPz1ynvgOKgzWas1VAzqnRikEpOTFZb0IC5AyA9jGyaYTxxZl8eM4HuSAUY2mV/
	 E6oewknrFjcMEvJ5Xf+8ef2VmNhnrqwSNd/XrP9OxY8guAXR0sTc6pFwcjQtnwkJjx
	 lf8PTo+eWjaYdkMl4vw+MdT6nBdZz+r6CrSs1RdA=
Date: Fri, 2 Oct 2026 18:14:05 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] perf cs-etm: Synthesize missing HW_ID mappings
 for raw trace
Message-ID: <20261002171405.GG1208404@e132581.arm.com>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-3-1d8b6ef339c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-3-1d8b6ef339c8@linaro.org>

On Fri, Oct 02, 2026 at 12:15:13PM +0100, James Clark wrote:

[...]

>  static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
> @@ -314,12 +317,11 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
>  		return -EINVAL;
>  
>  	/*
> -	 * If the queue is unformatted then only save one mapping in the
> -	 * queue associated with that CPU so only one decoder is made.
> +	 * Ignore HW_IDs for unformatted, a decoder will be made
> +	 * unconditionally later.
>  	 */
>  	if (etmq->format == UNFORMATTED)
> -		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
> -						    cpu_metadata);
> +		return 0;

Nitpick: It seems to me that we can move the
etmq->format == UNFORMATTED check into cs_etm__process_aux_output_hw_id().

This avoids duplicating the check in both cs_etm__map_trace_id_v0()
and cs_etm__process_trace_id_v0_1(), and makes it more apparent that
the unformatted case does not use HW_ID at all.

It's up to you whether to keep it as is or update it. Either way:

Reviewed-by: Leo Yan leo.yan@arm.com

P.S. Although I contributed the initial idea, the change is now quite
different from the original patch I shared. Please feel free to drop my
name if you prefer.
