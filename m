Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB31C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28B2610FF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1MfU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhJ1MfU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 08:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04789610FC;
        Thu, 28 Oct 2021 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635424373;
        bh=JHELoj2mmW10VXh13e2V2GRYKvOf6aNdym1rcKygtbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwaQWf8cBWqfv25YTmI/8UHeSBbLwa+Z0AHrjcPK+FX7IYXFY1a8+RY/hgpCPA5aN
         8s1+w1C/hNwoTIJMKx4NKCRHGH6OuK0Y/wmSIlhQxVlcn4yHnobSdM/gyua19RkffP
         tYbcGF279NecELnLR360bqEUu5LBN0c3hfyr/CJD7HaCisHn5jR/glcjRd/eUmQnYB
         bXYsZqIqE96E8GZAIGGoCUojQm4J06RbdLphByL3jZ9uVqVgbdd1mFb3xZqY7EH1fy
         ez5MnO4H9cUfBk4TxlZeW/MrpPTm0fUEfmwTZ0d7Ykr2HJ1/XQNL1waWEMb0xk1X3b
         UgyhgZmH3meBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC6EC410A1; Thu, 28 Oct 2021 09:32:48 -0300 (-03)
Date:   Thu, 28 Oct 2021 09:32:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Madhavan Srinivasan <maddy@linux.ibm.com>, jolsa@redhat.com,
        michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
Message-ID: <YXqYcEu9flGFMHX1@kernel.org>
References: <20211028113714.600549-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028113714.600549-1-maddy@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 28, 2021 at 05:07:13PM +0530, Madhavan Srinivasan escreveu:
> branch_stack struct has bit field definition which
> produces different bit ordering for big/little endian.
> Because of this, when branch_stack sample is collected
> in a BE system and viewed/reported in a LE system, bit
> fields of the branch stack are not presented properly.
> To address this issue, a evsel__bitfield_swap_branch_stack()
> is defined and introduced in evsel__parse_sample.

Jiri,

	This is a minor change, he just switched to an inline equivalent
(the code is slightly different, but should be ok), can I apply yout
v2 Acked-by tags?

- Arnaldo
 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Changelog v2:
> - used tep_is_bigendian() instead bigendian()
>   to avoid perf test python fail.
>  
> Changelog v1:
> - Renamed function and macro
> - Added comments in code
> 
>  tools/perf/util/evsel.c | 77 +++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evsel.h | 13 +++++++
>  2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..4e929b9d9718 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2221,6 +2221,54 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>  	data->weight = *array;
>  }
>  
> +u64 evsel__bitfield_swap_branch_flags(u64 value)
> +{
> +	u64 new_val = 0;
> +
> +	/*
> +	 * branch_flags
> +	 * union {
> +	 * 	u64 values;
> +	 * 	struct {
> +	 * 		mispred:1	//target mispredicted
> +	 * 		predicted:1	//target predicted
> +	 * 		in_tx:1		//in transaction
> +	 * 		abort:1		//transaction abort
> +	 * 		cycles:16	//cycle count to last branch
> +	 * 		type:4		//branch type
> +	 * 		reserved:40
> +	 * 	}
> +	 * }
> +	 *
> +	 * Avoid bswap64() the entire branch_flag.value,
> +	 * as it has variable bit-field sizes. Instead the
> +	 * macro takes the bit-field position/size,
> +	 * swaps it based on the host endianness.
> +	 *
> +	 * tep_is_bigendian() is used here instead of
> +	 * bigendian() to avoid python test fails.
> +	 */
> +	if (tep_is_bigendian()) {
> +		new_val = bitfield_swap(value, 0, 1);
> +		new_val |= bitfield_swap(value, 1, 1);
> +		new_val |= bitfield_swap(value, 2, 1);
> +		new_val |= bitfield_swap(value, 3, 1);
> +		new_val |= bitfield_swap(value, 4, 16);
> +		new_val |= bitfield_swap(value, 20, 4);
> +		new_val |= bitfield_swap(value, 24, 40);
> +	} else {
> +		new_val = bitfield_swap(value, 63, 1);
> +		new_val |= bitfield_swap(value, 62, 1);
> +		new_val |= bitfield_swap(value, 61, 1);
> +		new_val |= bitfield_swap(value, 60, 1);
> +		new_val |= bitfield_swap(value, 44, 16);
> +		new_val |= bitfield_swap(value, 40, 4);
> +		new_val |= bitfield_swap(value, 0, 40);
> +	}
> +
> +	return new_val;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -2408,6 +2456,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		const u64 max_branch_nr = UINT64_MAX /
>  					  sizeof(struct branch_entry);
> +		struct branch_entry *e;
> +		unsigned int i;
>  
>  		OVERFLOW_CHECK_u64(array);
>  		data->branch_stack = (struct branch_stack *)array++;
> @@ -2416,10 +2466,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			return -EFAULT;
>  
>  		sz = data->branch_stack->nr * sizeof(struct branch_entry);
> -		if (evsel__has_branch_hw_idx(evsel))
> +		if (evsel__has_branch_hw_idx(evsel)) {
>  			sz += sizeof(u64);
> -		else
> +			e = &data->branch_stack->entries[0];
> +		} else {
>  			data->no_hw_idx = true;
> +			/*
> +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
> +			 * only nr and entries[] will be output by kernel.
> +			 */
> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
> +		}
> +
> +		if (swapped) {
> +			/*
> +			 * struct branch_flag does not have endian
> +			 * specific bit field definition. And bswap
> +			 * will not resolve the issue, since these
> +			 * are bit fields.
> +			 *
> +			 * evsel__bitfield_swap_branch_flags() uses a
> +			 * bitfield_swap macro to swap the bit position
> +			 * based on the host endians.
> +			 */
> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
> +				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
> +		}
> +
>  		OVERFLOW_CHECK(array, sz, max_size);
>  		array = (void *)array + sz;
>  	}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..2e82cdbe2c08 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> +
> +/*
> + * Macro to swap the bit-field postition and size.
> + * Used when,
> + * - dont need to swap the entire u64 &&
> + * - when u64 has variable bit-field sizes &&
> + * - when presented in a host endian which is different
> + *   than the source endian of the perf.data file
> + */
> +#define bitfield_swap(src, pos, size)	\
> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
> +
> +u64 evsel__bitfield_swap_branch_flags(u64 value);
>  #endif /* __PERF_EVSEL_H */
> -- 
> 2.31.1

-- 

- Arnaldo
