Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A9BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 03:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465DE60E09
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 03:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJRDsg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Oct 2021 23:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhJRDsg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Oct 2021 23:48:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691EC06161C;
        Sun, 17 Oct 2021 20:46:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXjTn3q3Hz4xbb;
        Mon, 18 Oct 2021 14:46:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1634528783;
        bh=GOtut4lMGzs2qzyZ65KTwOJYjfGYz9zHALN0yg+X+/Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JMHchNrzOTUkxCl+BdvdSLLICSmbzkyyoAk3TULnCBr5nWi7Qav68ikqmpNA8rSlN
         q/+QyOJdg0KqaVGZiB7ia0Jf7FecSBTxKmLqGHFsTA90U12o8ls6IHTtYbjlS43kLa
         RvSnCRdg6zdwnSNjT6pO0CaT9srSHvuPj+qQal12hLND5/9J0E1NkU2ijFCILwsRdg
         tTx0vOKUNO3woGskvM4XkJthoy7NNdvY63goNxz+vYZp3FAmQuf6dNYE1b5C+wP0XV
         EPuKlQA4j0iKD/y1z+/fSAGSCpPFTy8L7v8XiVzj7tRrdprQoF7XgiWs61y8xjt+gS
         0kdLnDUYVGkSg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kajol Jain <kjain@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: Re: [PATCH v3 0/4] Add mem_hops field in perf_mem_data_src structure
In-Reply-To: <20211007064933.GK174703@worktop.programming.kicks-ass.net>
References: <20211006140654.298352-1-kjain@linux.ibm.com>
 <20211007064933.GK174703@worktop.programming.kicks-ass.net>
Date:   Mon, 18 Oct 2021 14:46:18 +1100
Message-ID: <87pms3c7w5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Wed, Oct 06, 2021 at 07:36:50PM +0530, Kajol Jain wrote:
>
>> Kajol Jain (4):
>>   perf: Add comment about current state of PERF_MEM_LVL_* namespace and
>>     remove an extra line
>>   perf: Add mem_hops field in perf_mem_data_src structure
>>   tools/perf: Add mem_hops field in perf_mem_data_src structure
>>   powerpc/perf: Fix data source encodings for L2.1 and L3.1 accesses
>> 
>>  arch/powerpc/perf/isa207-common.c     | 26 +++++++++++++++++++++-----
>>  arch/powerpc/perf/isa207-common.h     |  2 ++
>>  include/uapi/linux/perf_event.h       | 19 ++++++++++++++++---
>>  tools/include/uapi/linux/perf_event.h | 19 ++++++++++++++++---
>>  tools/perf/util/mem-events.c          | 20 ++++++++++++++++++--
>>  5 files changed, 73 insertions(+), 13 deletions(-)
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> How do we want this routed? Shall I take it, or does Michael want it in
> the Power tree?

It's mostly non-powerpc, so I think you should take it.

There's a slim chance we could end up with a conflict in the powerpc
part, but that's no big deal.

cheers
