Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CD5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D069461248
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJGRoI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233133AbhJGRoG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 13:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633628532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsjUpPJb1iTKpR4aN3cdz2aUWDLc3j7kcF/Y/CI7xlM=;
        b=Rh6Izgbt+ogEKh3wE/T1jnckFdcMsRDr5vB/SeVhM1rvxrsgPfj8z49c4hCWF+71mAn+X+
        xTweeWeKGOmjRcMmzUHzzCB4y5nJOCexhuQiIyMGdf7bSmtkNPB5XtoYg9awX8MJLqiWiM
        bqkLxBr5HjkJuYA0ZMzgr87y+2x+BtY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-slVHHIfnN1iPI3gPKZiDOQ-1; Thu, 07 Oct 2021 13:42:11 -0400
X-MC-Unique: slVHHIfnN1iPI3gPKZiDOQ-1
Received: by mail-wr1-f69.google.com with SMTP id m17-20020adffa11000000b00160c1ac74e9so5293665wrr.9
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 10:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsjUpPJb1iTKpR4aN3cdz2aUWDLc3j7kcF/Y/CI7xlM=;
        b=CXEjFQ4K5gPD8Q9t+MtOSQNAeaVkQ28zWnvB6IAq0BjIBCQt0xv3RfPfTGlOtZcnaU
         bu2kiAWvukT6YLsONQE8vi9OxwqaADLwAfLa6bveXYYjL8ZRnCn5nnFWsHUqyVsORog5
         NIuvKaS7a7ULPTctxrJxGmPtEe2iu7lVByuLEycTci/WjtePSOiIzffepRdFlPzZ3r50
         xSwvCro0/zA21OYDjTFIqOc4jZwP2/hylPJIkHHPckG3dZsSfqZGtEBMdauJYC//YeJn
         OMiouHHkUOgHb9WrJwdQhJpTOn0aNiirYhpVSZiZ35QmUbdgj/ANFt5YdydHt2SoK/Xs
         dfwg==
X-Gm-Message-State: AOAM533RiLOk/o+IAK08BRhKHf+vdQW5Tg5aGWM4rhTDJgs0EhUr3SG5
        T5eZ/2fWdpCdzNVbI+cCGrpxq07+1vcwOuW+xmfPi7arEvFjhZE4FFDTyWmmEoUJIwpRDvoKYDB
        JmG/Ba880SQMMA46IOyUfEw9AZDdpkg==
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr13686022wmi.190.1633628530242;
        Thu, 07 Oct 2021 10:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDmI/yGBLCgPg0WsPE3RvHXr6qIW67zZ3E4/qd73a3ZrztqgInsQUeO0qk0lUzJ61Xfwe7aw==
X-Received: by 2002:a05:600c:214:: with SMTP id 20mr13686006wmi.190.1633628530064;
        Thu, 07 Oct 2021 10:42:10 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c15sm16347wrs.19.2021.10.07.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:42:09 -0700 (PDT)
Date:   Thu, 7 Oct 2021 19:42:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     acme@kernel.org, michael@ellerman.id.au, eranian@google.com,
        mark.rutland@arm.com, namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/perf: Add reverse_fn to handle branch_stack
 endian issue
Message-ID: <YV8xbzWt7tEbBbZX@krava>
References: <20210930070410.52703-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930070410.52703-1-maddy@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 30, 2021 at 12:34:09PM +0530, Madhavan Srinivasan wrote:
> branch_stack struct has bit field definition which
> produces different bit ordering for big/little endian.
> Because of this, when branch_stack sample is collected
> in a BE system and viewed/reported in a LE system, bit
> fields of the branch stack are not presented properly.
> To address this issue, a evsel__reverse64_branch_stack_flags()
> is defined and introduced in evsel__parse_sample.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  tools/perf/util/evsel.c | 64 +++++++++++++++++++++++++++++++++++++++--
>  tools/perf/util/evsel.h |  5 ++++
>  2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index dbfeceb2546c..007be66b69a2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2221,6 +2221,46 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
>  	data->weight = *array;
>  }
>  
> +u64 evsel__reverse64_branch_stack_flags(u64 value)
> +{
> +	u64 new_val = 0;
> +
> +	/*
> +	 * branch_stack flag (u64)
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
> +	 */

please describe in comment how the bitfield is swapped


> +	if (bigendian()) {
> +		new_val = reverse_64(value, 0, 1);
> +		new_val |= reverse_64(value, 1, 1);
> +		new_val |= reverse_64(value, 2, 1);
> +		new_val |= reverse_64(value, 3, 1);
> +		new_val |= reverse_64(value, 4, 16);
> +		new_val |= reverse_64(value, 20, 4);
> +		new_val |= reverse_64(value, 24, 40);
> +	} else {
> +		new_val = reverse_64(value, 63, 1);
> +		new_val |= reverse_64(value, 62, 1);
> +		new_val |= reverse_64(value, 61, 1);
> +		new_val |= reverse_64(value, 60, 1);
> +		new_val |= reverse_64(value, 44, 16);
> +		new_val |= reverse_64(value, 40, 4);
> +		new_val |= reverse_64(value, 0, 40);
> +	}
> +
> +	return new_val;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -2408,6 +2448,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		const u64 max_branch_nr = UINT64_MAX /
>  					  sizeof(struct branch_entry);
> +		struct branch_entry *e;
> +		unsigned int i;
>  
>  		OVERFLOW_CHECK_u64(array);
>  		data->branch_stack = (struct branch_stack *)array++;
> @@ -2416,10 +2458,28 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
> +			e = (struct branch_entry *)&data->branch_stack->hw_idx;

hum, why do we convert hw_idx? it's the same struct as entries?
please explain this in comment as well

> +		}
> +
> +		if (swapped) {
> +			/*
> +			 * struct branch_flag does not have endian specific
> +			 * bit field definition. And bswap will not resolve the
> +			 * issue, since these are bit fields.
> +			 *
> +			 * evsel__reverse64_branch_stack_flags() uses a reverse64
> +			 * macro to reverse the bit position based on the host
> +			 * endians.
> +			 */
> +			for (i = 0; i < data->branch_stack->nr; i++, e++)
> +				e->flags.value = evsel__reverse64_branch_stack_flags(e->flags.value);
> +		}
> +
>  		OVERFLOW_CHECK(array, sz, max_size);
>  		array = (void *)array + sz;
>  	}
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 1f7edfa8568a..1127c23710cf 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -482,4 +482,9 @@ struct evsel *evsel__leader(struct evsel *evsel);
>  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> +
> +#define reverse_64(src, pos, size)	\
> +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))

hum, is this reversing anything?
could you please add comment describing what this is doing?

thanks,
jirka

> +
> +u64 evsel__reverse64_branch_stack_flags(u64 value);
>  #endif /* __PERF_EVSEL_H */
> -- 
> 2.31.1
> 

