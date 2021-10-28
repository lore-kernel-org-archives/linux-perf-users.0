Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36953C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2DD610C7
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 00:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhJ1AMN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhJ1AMM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 20:12:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D36560EC0;
        Thu, 28 Oct 2021 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635379785;
        bh=osHe5qQZL4+EsqRTmg0smsm97CQxSIioocJlwg5ueBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJvCsgn/fH5TMlG+wpAzKS7+9l7kL2689hFO2Z4HlgiW8S3ULVSpzJH3j2TGhU3qk
         C/G/sMA0YqcxVhYCpDnHyUdzc+Zuyq8BBrjyUmqHI5ig5YhWd6QhjxO+tdV+Mz2AFS
         UjfbGD+H2rJe412cZ+sBG+JUZUhGNw26UwcmGXz8YtJ7M7uRMGlHs5+7jLxH0C2lD6
         H6HEcJRFHm0CKCRDEXCWYSBn6KKfAHoINkom4guaBwkJz1l2FJKKOcZPXzJvDaUk2X
         MEHJCSLv/3hCEpD82BwRXGwIb5wikqZ+6GIh8SHw5SNiFeb3DjKEDzctimVb8TXXxu
         vnowSwHW3e9TQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8F373410A1; Wed, 27 Oct 2021 21:09:42 -0300 (-03)
Date:   Wed, 27 Oct 2021 21:09:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Madhavan Srinivasan <maddy@linux.ibm.com>, michael@ellerman.id.au,
        eranian@google.com, mark.rutland@arm.com, namhyung@kernel.org,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle
 branch_stack endian issue
Message-ID: <YXnqRgcNkRSfijGp@kernel.org>
References: <20211016125059.691856-1-maddy@linux.ibm.com>
 <YXad+y2VCyC6y+CE@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXad+y2VCyC6y+CE@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Oct 25, 2021 at 02:07:23PM +0200, Jiri Olsa escreveu:
> On Sat, Oct 16, 2021 at 06:20:58PM +0530, Madhavan Srinivasan wrote:
> > branch_stack struct has bit field definition which
> > produces different bit ordering for big/little endian.
> > Because of this, when branch_stack sample is collected
> > in a BE system and viewed/reported in a LE system, bit
> > fields of the branch stack are not presented properly.
> > To address this issue, a evsel__bitfield_swap_branch_stack()
> > is defined and introduced in evsel__parse_sample.
> > 
> > Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> for both patches
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> > Changelog v1:
> > - Renamed function and macro
> > - Added comments in code
> > 
> >  tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
> >  tools/perf/util/evsel.h | 13 ++++++++
> >  2 files changed, 85 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbfeceb2546c..746e642d4d32 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> >  	data->weight = *array;
> >  }
> >  
> > +u64 evsel__bitfield_swap_branch_flags(u64 value)
> > +{
> > +	u64 new_val = 0;
> > +
> > +	/*
> > +	 * branch_flags
> > +	 * union {
> > +	 * 	u64 values;
> > +	 * 	struct {
> > +	 * 		mispred:1	//target mispredicted
> > +	 * 		predicted:1	//target predicted
> > +	 * 		in_tx:1		//in transaction
> > +	 * 		abort:1		//transaction abort
> > +	 * 		cycles:16	//cycle count to last branch
> > +	 * 		type:4		//branch type
> > +	 * 		reserved:40
> > +	 * 	}
> > +	 * }
> > +	 *
> > +	 * Avoid bswap64() the entire branch_flag.value,
> > +	 * as it has variable bit-field sizes. Instead the
> > +	 * macro takes the bit-field position/size,
> > +	 * swaps it based on the host endianness.
> > +	 */
> > +	if (bigendian()) {
> > +		new_val = bitfield_swap(value, 0, 1);
> > +		new_val |= bitfield_swap(value, 1, 1);
> > +		new_val |= bitfield_swap(value, 2, 1);
> > +		new_val |= bitfield_swap(value, 3, 1);
> > +		new_val |= bitfield_swap(value, 4, 16);
> > +		new_val |= bitfield_swap(value, 20, 4);
> > +		new_val |= bitfield_swap(value, 24, 40);
> > +	} else {
> > +		new_val = bitfield_swap(value, 63, 1);
> > +		new_val |= bitfield_swap(value, 62, 1);
> > +		new_val |= bitfield_swap(value, 61, 1);
> > +		new_val |= bitfield_swap(value, 60, 1);
> > +		new_val |= bitfield_swap(value, 44, 16);
> > +		new_val |= bitfield_swap(value, 40, 4);
> > +		new_val |= bitfield_swap(value, 0, 40);
> > +	}
> > +
> > +	return new_val;
> > +}
> > +
> >  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >  			struct perf_sample *data)
> >  {
> > @@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >  	if (type & PERF_SAMPLE_BRANCH_STACK) {
> >  		const u64 max_branch_nr = UINT64_MAX /
> >  					  sizeof(struct branch_entry);
> > +		struct branch_entry *e;
> > +		unsigned int i;
> >  
> >  		OVERFLOW_CHECK_u64(array);
> >  		data->branch_stack = (struct branch_stack *)array++;
> > @@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> >  			return -EFAULT;
> >  
> >  		sz = data->branch_stack->nr * sizeof(struct branch_entry);
> > -		if (evsel__has_branch_hw_idx(evsel))
> > +		if (evsel__has_branch_hw_idx(evsel)) {
> >  			sz += sizeof(u64);
> > -		else
> > +			e = &data->branch_stack->entries[0];
> > +		} else {
> >  			data->no_hw_idx = true;
> > +			/*
> > +			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
> > +			 * only nr and entries[] will be output by kernel.
> > +			 */
> > +			e = (struct branch_entry *)&data->branch_stack->hw_idx;
> > +		}
> > +
> > +		if (swapped) {
> > +			/*
> > +			 * struct branch_flag does not have endian
> > +			 * specific bit field definition. And bswap
> > +			 * will not resolve the issue, since these
> > +			 * are bit fields.
> > +			 *
> > +			 * evsel__bitfield_swap_branch_flags() uses a
> > +			 * bitfield_swap macro to swap the bit position
> > +			 * based on the host endians.
> > +			 */
> > +			for (i = 0; i < data->branch_stack->nr; i++, e++)
> > +				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
> > +		}
> > +
> >  		OVERFLOW_CHECK(array, sz, max_size);
> >  		array = (void *)array + sz;
> >  	}
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 1f7edfa8568a..2e82cdbe2c08 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
> >  bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
> >  bool evsel__is_leader(struct evsel *evsel);
> >  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> > +
> > +/*
> > + * Macro to swap the bit-field postition and size.
> > + * Used when,
> > + * - dont need to swap the entire u64 &&
> > + * - when u64 has variable bit-field sizes &&
> > + * - when presented in a host endian which is different
> > + *   than the source endian of the perf.data file
> > + */
> > +#define bitfield_swap(src, pos, size)	\
> > +	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
> > +
> > +u64 evsel__bitfield_swap_branch_flags(u64 value);
> >  #endif /* __PERF_EVSEL_H */
> > -- 
> > 2.31.1
> > 

-- 

- Arnaldo
