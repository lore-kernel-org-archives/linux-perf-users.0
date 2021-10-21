Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59859C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4996103D
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhJUN1n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhJUN1g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 09:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634822720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkppuMobEIHKB0sez/ioBJ9Xfdh1AlpgLhgQ5nmiOuA=;
        b=fjBWDuLWC/5WL3b0u08x/x1mkBxouYFVk4QMMu+NZEd05KE2Vth04c2lwmyQaRmo6T8t4F
        NYfb7Z38NzY1UFptdEDvRAaFL5Qm0XXzsdGUW1amAJV3Za7IaUpJpR9TbtH7Yso4XCBbvi
        Qs/TTmlJMZmZWatOqI4MbMpAuWKEiOA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-UaysX3BxNs-YrC_gf-iDbA-1; Thu, 21 Oct 2021 09:25:18 -0400
X-MC-Unique: UaysX3BxNs-YrC_gf-iDbA-1
Received: by mail-ed1-f72.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso329943edf.7
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Oct 2021 06:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NkppuMobEIHKB0sez/ioBJ9Xfdh1AlpgLhgQ5nmiOuA=;
        b=2BaIoojNZ4YR3f+j+TxOLl4FvaA2qZq8+OvXF3NFr54yDkI5fjo8dKMkrTWp6QkBr5
         z5VGrNOmn8sYcWjhYi9S60WJTH3pIom5rl/6VSBy32JoaRpYaaxrrjTX1d0Ol2lvQWup
         h5m9C2lTA2Edjj6rV58ydXXgpso1OqSvzt4olhNQNPRVFKYNNas4ZPdftZdG7fNVuq/W
         7RuvZ6SRvWcOV2eA0e/coHl3P6wDyjFKW4Liy5Gm4z4ZLvWqqlUKnEoAwaP0e5qkbbTu
         rp5uSRhF8PmXaW8x1Np2rWO4oG5SwOlMGlSv9MVSAHYMeZ5cMmnTuBi4x/KkzKTelEsr
         nZ1A==
X-Gm-Message-State: AOAM533SiqLY0MB81X5eUJ6ZFQMLlPTO1EcYJM9JB9IgpTc6f823tEyc
        ZNWcgenSLiaplqPwOTKt+9j1D47HTnTpb4iKvxCWz2gsfkYA7WBm5NKJANxnE6ZImO8fN7ahO1V
        Y/BpVvVxFbLeOtVGqY1p3ZohfzoJB7Q==
X-Received: by 2002:a50:c355:: with SMTP id q21mr2064277edb.161.1634822717620;
        Thu, 21 Oct 2021 06:25:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFjOV/ylQQMALuxiAyz0iJ8blr1z08y94yE9g1hAByMOvPKYeKua3Qlc6daZzoBrkgVqAk+w==
X-Received: by 2002:a50:c355:: with SMTP id q21mr2064244edb.161.1634822717435;
        Thu, 21 Oct 2021 06:25:17 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id y6sm2588772ejf.58.2021.10.21.06.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:25:17 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:25:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     acme@kernel.org, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
Message-ID: <YXFqO+8N61a9Cqy+@krava>
References: <20211016125059.691856-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016125059.691856-1-maddy@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan wrote:
> branch_stack struct has bit field definition which
> produces different bit ordering for big/little endian.
> Because of this, when branch_stack sample is collected
> in a BE system and viewed/reported in a LE system, bit
> fields of the branch stack are not presented properly.
> To address this issue, a evsel__bitfield_swap_branch_stack()
> is defined and introduced in evsel__parse_sample.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Changelog v1:
> - Renamed function and macro
> - Added comments in code
> 
>  tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evsel.h | 13 ++++++++
>  2 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..746e642d4d32 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
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
> +	 */
> +	if (bigendian()) {
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
> @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		const u64 max_branch_nr = UINT64_MAX /
>  					  sizeof(struct branch_entry);
> +		struct branch_entry *e;
> +		unsigned int i;
>  
>  		OVERFLOW_CHECK_u64(array);
>  		data->branch_stack = (struct branch_stack *)array++;
> @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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

thanks for all the comments, make it easy to review

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

one last thing that confuses me.. the sample is already swapped at this
point, right? with perf_event__all64_swap function

should you swap it back first and then do the proper bitfield swap?
like we do in PERF_SAMPLE_RAW to get proper u32 values

thanks,
jirka

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
> 

