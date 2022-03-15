Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F4C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Mar 2022 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiCOLYC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiCOLYA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Mar 2022 07:24:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBB631F;
        Tue, 15 Mar 2022 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ul9b8YQaPGFJIzLg4O7EZ8BuJh4nEAPn8uLCo67QHe0=; b=Q7xpYHxRR2cIPtVMvd+GXrt1E4
        M+7WVfOhHTLT7CrXI6JZTs2mSi2JnYwSgR5RGTK9odO9Tla4PsLVnjQYvn9GLdqDZ8ApxtXjXXQsH
        giIuzg4sZ4Bsl8k5WEb0iMdE/Vw0DQG5fV0R6kdV3WePth0TDG/kt4DADd8xq/nfiqo7MlWjexAu8
        dsWzQaOCVIqmIaaFvAx9TKrMmaPQqzh+00txpavVsEKq0EAfSsvveat9LbUOcmsiFhKcUum0bUT3A
        AEPRAaKQe51KT1GhzQYPyyPEHtDZzXNHi9/ilKhCsqvWLwfhmkmxbCmRt+NcYaeKKjRRGac+CfsIP
        w649oCkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU5G6-004ytk-K8; Tue, 15 Mar 2022 11:22:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C562B98620D; Tue, 15 Mar 2022 12:22:32 +0100 (CET)
Date:   Tue, 15 Mar 2022 12:22:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 03/10] perf: Extend branch type classification
Message-ID: <20220315112232.GF8939@worktop.programming.kicks-ass.net>
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
 <20220315053516.431515-4-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315053516.431515-4-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 15, 2022 at 11:05:09AM +0530, Anshuman Khandual wrote:
> branch_entry.type now has ran out of space to accommodate more branch types
> classification. This will prevent perf branch stack implementation on arm64
> (via BRBE) to capture all available branch types. Extending this bit field
> i.e branch_entry.type [4 bits] is not an option as it will break user space
> ABI both for little and big endian perf tools.
> 
> Extend branch classification with a new field branch_entry.new_type via a
> new branch type PERF_BR_EXTEND_ABI in branch_entry.type. Perf tools which
> could decode PERF_BR_EXTEND_ABI, will then parse branch_entry.new_type as
> well.
> 
> branch_entry.new_type is a 4 bit field which can hold upto 16 branch types.
> The first three branch types will hold various generic page faults followed
> by five architecture specific branch types, which can be overridden by the
> platform for specific use cases. These architecture specific branch types
> gets overridden on arm64 platform for BRBE implementation.

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 26d8f0b5ac0d..d29280adc3c4 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -255,9 +255,22 @@ enum {
>  	PERF_BR_IRQ		= 12,	/* irq */
>  	PERF_BR_SERROR		= 13,	/* system error */
>  	PERF_BR_NO_TX		= 14,	/* not in transaction */
> +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
>  	PERF_BR_MAX,
>  };


>  #define PERF_SAMPLE_BRANCH_PLM_ALL \
>  	(PERF_SAMPLE_BRANCH_USER|\
>  	 PERF_SAMPLE_BRANCH_KERNEL|\
> @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
>  		abort:1,    /* transaction abort */
>  		cycles:16,  /* cycle count to last branch */
>  		type:4,     /* branch type */
> -		reserved:40;
> +		new_type:4, /* additional branch type */
> +		reserved:36;
>  };

Hurmpf... this will effectively give us 5 bits of space for the cost of
8, that seems... unfortunate.

Would something like:

		type:4,
		ext_type:4,
		reserved:36;

and have all software do:

	type = pbe->type | (pbe->ext_type << 4);

Then old software will only know about the old types. New software on
old kernels will add 4 0's, which is harmless, while new software on new
kernels will get 8 bytes of type.

Would that work?
