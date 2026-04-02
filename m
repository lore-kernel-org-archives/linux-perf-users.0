Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D93659ED;
	Thu,  2 Apr 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121185; cv=none; b=vDSi162lqENcKxl35QOB9kJfnWJ71Sn6AAFkQOTuWaeI7bdBkeXVdUm4+i723EubK7ADaKQu+4D+6JN4g2JqAvi+z41y9XyaABNozcnuWc64yIK19b/0cIfwrsWEyvjWaOT3/u6uSx34bMAko1aPt/alNP+K8zB6L+S5pKoDeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121185; c=relaxed/simple;
	bh=Mzyz2lM98qhjrd6WKUqnPakVkh/Tsgt+PoT9pOr9X1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm2DpcIvcE9EVAm+hUBt4ZFUKtlvket4fx93SkvIxJFXNKs/OPEwQj1DxCaQEORU2sqwvhbqnWzRw0Q5s4/bEBTA/YOhc36lOp0PBKX0q/5WvrtKAPAyKr0spFlt8/xTME1Q0JAcHSuQzEICDsTKO5RXxgekZ9zCweR7yTdjegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PzQukNqu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PzQukNqu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FAD22C43;
	Thu,  2 Apr 2026 02:12:56 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55E83F641;
	Thu,  2 Apr 2026 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775121182; bh=Mzyz2lM98qhjrd6WKUqnPakVkh/Tsgt+PoT9pOr9X1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzQukNquWmRZjCnECMC89K9qmFETkg6LT8vpDTT2XVLMTfqlRDWzAFRQsC/3RLAFT
	 S7/djY0vMiKjvuEl7FJPW2bp+d3WlqBuRlNE1EFj28NwJe1PMu3fY8E7a9/7/J5n2E
	 M/rtTotBqTePBOU8sSwXrJLzGVNSFbWyxGwLx18Q=
Date: Thu, 2 Apr 2026 10:13:00 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] perf arm_spe: Turn event name mappings into an array
Message-ID: <20260402091300.GF356832@e132581.arm.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-james-spe-impdef-decode-v1-2-ad0d372c220c@linaro.org>

On Wed, Apr 01, 2026 at 03:25:50PM +0100, James Clark wrote:
> This is so we can have a single function that prints events and can be
> used with multiple mappings from different CPUs. Remove any bit that was
> printed so that later we can print out the remaining unknown impdef
> bits.
> 
> No functional changes intended.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 88 +++++++++++-----------
>  1 file changed, 43 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 5769ba2f4140..c880b0dec3a1 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -276,6 +276,48 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
>  	return ret;
>  }
>  
> +struct ev_string {
> +	u8 event;
> +	const char *desc;
> +};

Maybe we can have more ambition to define a more general structure:

  struct packet_field_string {
  	u64 bit_mask;
  	u64 bit_val;
  	const char *desc;
  };

Thus, this also can be used by other bit fields decoding.  We can do
this now or if later refactor for other packets.

Either way is fine for me:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> +
> +static const struct ev_string common_ev_strings[] = {
> +	{ .event = EV_EXCEPTION_GEN, .desc = "EXCEPTION-GEN" },
> +	{ .event = EV_RETIRED, .desc = "RETIRED" },
> +	{ .event = EV_L1D_ACCESS, .desc = "L1D-ACCESS" },
> +	{ .event = EV_L1D_REFILL, .desc = "L1D-REFILL" },
> +	{ .event = EV_TLB_ACCESS, .desc = "TLB-ACCESS" },
> +	{ .event = EV_TLB_WALK, .desc = "TLB-REFILL" },
> +	{ .event = EV_NOT_TAKEN, .desc = "NOT-TAKEN" },
> +	{ .event = EV_MISPRED, .desc = "MISPRED" },
> +	{ .event = EV_LLC_ACCESS, .desc = "LLC-ACCESS" },
> +	{ .event = EV_LLC_MISS, .desc = "LLC-REFILL" },
> +	{ .event = EV_REMOTE_ACCESS, .desc = "REMOTE-ACCESS" },
> +	{ .event = EV_ALIGNMENT, .desc = "ALIGNMENT" },
> +	{ .event = EV_TRANSACTIONAL, .desc = "TXN" },
> +	{ .event = EV_PARTIAL_PREDICATE, .desc = "SVE-PARTIAL-PRED" },
> +	{ .event = EV_EMPTY_PREDICATE, .desc = "SVE-EMPTY-PRED" },
> +	{ .event = EV_L2D_ACCESS, .desc = "L2D-ACCESS" },
> +	{ .event = EV_L2D_MISS, .desc = "L2D-MISS" },
> +	{ .event = EV_CACHE_DATA_MODIFIED, .desc = "HITM" },
> +	{ .event = EV_RECENTLY_FETCHED, .desc = "LFB" },
> +	{ .event = EV_DATA_SNOOPED, .desc = "SNOOPED" },
> +	{ .event = EV_STREAMING_SVE_MODE, .desc = "STREAMING-SVE" },
> +	{ .event = EV_SMCU, .desc = "SMCU" },
> +	{ .event = 0, .desc = NULL },
> +};
> +
> +static u64 print_event_list(int *err, char **buf, size_t *buf_len,
> +			    const struct ev_string *ev_strings, u64 payload)
> +{
> +	for (const struct ev_string *ev = ev_strings; ev->desc != NULL; ev++) {
> +		if (payload & BIT(ev->event))
> +			arm_spe_pkt_out_string(err, buf, buf_len, " %s", ev->desc);
> +		payload &= ~BIT(ev->event);
> +	}
> +	return payload;
> +}
> +
>  static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  				  char *buf, size_t buf_len)
>  {
> @@ -283,51 +325,7 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>  	int err = 0;
>  
>  	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
> -
> -	if (payload & BIT(EV_EXCEPTION_GEN))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-GEN");
> -	if (payload & BIT(EV_RETIRED))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
> -	if (payload & BIT(EV_L1D_ACCESS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS");
> -	if (payload & BIT(EV_L1D_REFILL))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL");
> -	if (payload & BIT(EV_TLB_ACCESS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS");
> -	if (payload & BIT(EV_TLB_WALK))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL");
> -	if (payload & BIT(EV_NOT_TAKEN))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
> -	if (payload & BIT(EV_MISPRED))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
> -	if (payload & BIT(EV_LLC_ACCESS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
> -	if (payload & BIT(EV_LLC_MISS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
> -	if (payload & BIT(EV_REMOTE_ACCESS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
> -	if (payload & BIT(EV_ALIGNMENT))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " ALIGNMENT");
> -	if (payload & BIT(EV_TRANSACTIONAL))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TXN");
> -	if (payload & BIT(EV_PARTIAL_PREDICATE))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
> -	if (payload & BIT(EV_EMPTY_PREDICATE))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
> -	if (payload & BIT(EV_L2D_ACCESS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS");
> -	if (payload & BIT(EV_L2D_MISS))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS");
> -	if (payload & BIT(EV_CACHE_DATA_MODIFIED))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
> -	if (payload & BIT(EV_RECENTLY_FETCHED))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
> -	if (payload & BIT(EV_DATA_SNOOPED))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
> -	if (payload & BIT(EV_STREAMING_SVE_MODE))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-SVE");
> -	if (payload & BIT(EV_SMCU))
> -		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
> +	print_event_list(&err, &buf, &buf_len, common_ev_strings, payload);
>  
>  	return err;
>  }
> 
> -- 
> 2.34.1
> 
> 
