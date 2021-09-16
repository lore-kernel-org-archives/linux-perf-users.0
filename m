Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087A5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD05561242
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 10:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhIPK7K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhIPK7J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 06:59:09 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85614C061574;
        Thu, 16 Sep 2021 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631789866;
        bh=ZispAWzioAVbjxueTjRm+hiDj1TZC69+PxYkYh1lWBA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=j+eAgDzFwK8z9d+QuWLV+d7slJps5jsQp4dRysMAI+bc19oxRoC8W4gbJ+tvcEdnd
         OV2H7AyiQ98cJ1M1hJPOy9WzyJZGxPXetztdknB+TV3itWhfCbwUYqNda2H7F5rKGl
         v5PQOTfUBCoqPjOcUHDrFXrCHKBTRaWHnRljM57KoahGZ14xe4Sym8HQsqfCoxiGrL
         yvcZVavQ4K++0YtDp2ga0MRoW53N+PSqS04tLBKAsidBQPPNGm8+aTwzrp5OpyqfRw
         vzHUXrwm9n8fw2XHX9ZJzr30Rl33MOMtza+QITtUVgXy8QQfXoMkk9SAlT5UJ6ujxi
         mleoa0SUsg08Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H9DZJ1Ny9z9sW8;
        Thu, 16 Sep 2021 20:57:44 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, yao.jin@linux.intel.com, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, paulus@samba.org
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
In-Reply-To: <YUCMUZbchMjD54eY@hirez.programming.kicks-ass.net>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
 <87ilzbmt7i.fsf@mpe.ellerman.id.au>
 <YTiBqbxe7ieqY2OE@hirez.programming.kicks-ass.net>
 <87czphnchp.fsf@mpe.ellerman.id.au>
 <YTob/xfn1gt901K4@hirez.programming.kicks-ass.net>
 <87k0jjl9sp.fsf@mpe.ellerman.id.au>
 <YUCMUZbchMjD54eY@hirez.programming.kicks-ass.net>
Date:   Thu, 16 Sep 2021 20:57:33 +1000
Message-ID: <87fsu4kcte.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Tue, Sep 14, 2021 at 08:40:38PM +1000, Michael Ellerman wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>
>> > I'm thinking we ought to keep hops as steps along the NUMA fabric, with
>> > 0 hops being the local node. That only gets us:
>> >
>> >  L2, remote=0, hops=HOPS_0 -- our L2
>> >  L2, remote=1, hops=HOPS_0 -- L2 on the local node but not ours
>> >  L2, remote=1, hops!=HOPS_0 -- L2 on a remote node
>> 
>> Hmm. I'm not sure about tying it directly to NUMA hops. I worry we're
>> going to see more and more systems where there's a hierarchy within the
>> chip/package, in addition to the traditional NUMA hierarchy.
>> 
>> Although then I guess it becomes a question of what exactly is a NUMA
>> hop, maybe the answer is that on those future systems those
>> intra-chip/package hops should be represented as NUMA hops.
>> 
>> It's not like we have a hard definition of what a NUMA hop is?
>
> Not really, typically whatever the BIOS/DT/whatever tables tell us. I
> think in case of Power you're mostly making things up in software :-)

Firmware is software so yes :)

> But yeah, I think we have plenty wriggle room there.

OK.

cheers
