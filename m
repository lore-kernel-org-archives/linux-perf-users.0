Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CDC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Mar 2022 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiCPMVg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbiCPMVf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 08:21:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087460A89;
        Wed, 16 Mar 2022 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5pNCmyMwLlhDtqajbX8GPeOHBzCF8vz6r7PEhnW3xc=; b=ls7rHnG1dpzhabBoztBYrRisA1
        54dfeD23UuKfpyARMO6qUgKH0DPk6Ujv/Ww9QeY5RK1v7CfeUgqZSewu3D/7M3zLecxnFV6PHCqI0
        vvQH2wmAlWB4D2NBic3IQc6i1eDn97UJPhFvmhMWB+mEA1wVyTQTfieLKO7q3Tq7iGqQhX2IUa6bO
        qE4wZPgNeJBWCNg+HvDuzFY5XjnyPtzt6D7z5MCXP6bPhhZeo8/XxipJ9TK5uze8Kn5NmXvy5GnQg
        OPm2l/KZWGaEy4M2Er1+PUNseAvndWqw+GJBCxpd3NFQJ8mu/FBSOfhvb7+JdzbsXcrayvbkb3VDy
        Ztx8Jmyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUSdI-001XX3-H2; Wed, 16 Mar 2022 12:20:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB79030003A;
        Wed, 16 Mar 2022 13:20:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EE59306DC35A; Wed, 16 Mar 2022 13:20:01 +0100 (CET)
Date:   Wed, 16 Mar 2022 13:20:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Suzuki Poulose <suzuki.poulose@arm.com>,
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
Message-ID: <YjHV8dJpEq/M8gHC@hirez.programming.kicks-ass.net>
References: <20220315053516.431515-1-anshuman.khandual@arm.com>
 <20220315053516.431515-4-anshuman.khandual@arm.com>
 <20220315112232.GF8939@worktop.programming.kicks-ass.net>
 <0df5c352-1f0d-55f8-5d7f-e28ba33d623b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df5c352-1f0d-55f8-5d7f-e28ba33d623b@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 15, 2022 at 01:06:42PM +0000, Robin Murphy wrote:
> On 2022-03-15 11:22, Peter Zijlstra wrote:
> > On Tue, Mar 15, 2022 at 11:05:09AM +0530, Anshuman Khandual wrote:
> > > branch_entry.type now has ran out of space to accommodate more branch types
> > > classification. This will prevent perf branch stack implementation on arm64
> > > (via BRBE) to capture all available branch types. Extending this bit field
> > > i.e branch_entry.type [4 bits] is not an option as it will break user space
> > > ABI both for little and big endian perf tools.
> > > 
> > > Extend branch classification with a new field branch_entry.new_type via a
> > > new branch type PERF_BR_EXTEND_ABI in branch_entry.type. Perf tools which
> > > could decode PERF_BR_EXTEND_ABI, will then parse branch_entry.new_type as
> > > well.
> > > 
> > > branch_entry.new_type is a 4 bit field which can hold upto 16 branch types.
> > > The first three branch types will hold various generic page faults followed
> > > by five architecture specific branch types, which can be overridden by the
> > > platform for specific use cases. These architecture specific branch types
> > > gets overridden on arm64 platform for BRBE implementation.
> > 
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index 26d8f0b5ac0d..d29280adc3c4 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -255,9 +255,22 @@ enum {
> > >   	PERF_BR_IRQ		= 12,	/* irq */
> > >   	PERF_BR_SERROR		= 13,	/* system error */
> > >   	PERF_BR_NO_TX		= 14,	/* not in transaction */
> > > +	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
> > >   	PERF_BR_MAX,
> > >   };
> > 
> > 
> > >   #define PERF_SAMPLE_BRANCH_PLM_ALL \
> > >   	(PERF_SAMPLE_BRANCH_USER|\
> > >   	 PERF_SAMPLE_BRANCH_KERNEL|\
> > > @@ -1372,7 +1385,8 @@ struct perf_branch_entry {
> > >   		abort:1,    /* transaction abort */
> > >   		cycles:16,  /* cycle count to last branch */
> > >   		type:4,     /* branch type */
> > > -		reserved:40;
> > > +		new_type:4, /* additional branch type */
> > > +		reserved:36;
> > >   };
> > 
> > Hurmpf... this will effectively give us 5 bits of space for the cost of
> > 8, that seems... unfortunate.
> > 
> > Would something like:
> > 
> > 		type:4,
> > 		ext_type:4,
> > 		reserved:36;
> > 
> > and have all software do:
> > 
> > 	type = pbe->type | (pbe->ext_type << 4);
> > 
> > Then old software will only know about the old types. New software on
> > old kernels will add 4 0's, which is harmless, while new software on new
> > kernels will get 8 bytes of type.
> > 
> > Would that work?
> 
> Depends how bad the effects of aliasing in existing software would be, I
> guess - e.g. new kernel outputs type 0x23 which software then interprets as
> 0x3 since it doesn't know about the extended bits. I'm guessing that's more
> likely "confusing to the user" than "catastrophically fatal", but it might
> still matter.
> 
> If software had an explicit opt-in to receiving extended types when
> requesting branch sampling in the first place we could avoid that worry, but
> then we'd need some additional complexity to sanitise records depending on
> that option :/

Bah.. I see.. One option is PERF_SAMPLE_BRANCH_STACK2, but yes, yuck.
