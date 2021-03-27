Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59509C433DB
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 Mar 2021 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A8619BB
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 Mar 2021 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhC0NPl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0NPG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 Mar 2021 09:15:06 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F5C0613B1;
        Sat, 27 Mar 2021 06:15:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F6zpX6Zfwz9sRf;
        Sun, 28 Mar 2021 00:15:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616850902;
        bh=xls+amKq9a2UqqHe5tYvXJf76OIDuOI+WrJU2CpUwE8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nABiofRL4eKiuEcFKd/EuCctuw2IxIF5R9r0jvwB74JUobLq3Pg/S2ke2Ob+LBGST
         45L+BlSd5NkLsx4ZhXe6iZsjbpS9BUgpW/r8gdr8x4qbBhAiCWNnPANtDgRLvsnwMe
         3mQCwCHDmY+VGQFKMMh1UeNUGAbae213I6DshWJ1A63W/2PCbDikAGaozMRsUZuEKi
         7EN51eNO/F+XuLDcV9qBk5kw2VQRWyjMPLldIg6M5VUooYsCD1b0kdnxBoC8nFXr2S
         IxZSpijIHnplQ1mHrpdCiZ1uTwKCoZtzafBpSe5IszwgfB/8r4KMCj247fK63h4JBZ
         7XoR2SZ9Z56/w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnaldo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, jolsa@kernel.org,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH V2 1/5] powerpc/perf: Expose processor pipeline stage
 cycles using PERF_SAMPLE_WEIGHT_STRUCT
In-Reply-To: <2BAC42AE-6BD3-45EF-8867-1A15F25FE80B@gmail.com>
References: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1616425047-1666-2-git-send-email-atrajeev@linux.vnet.ibm.com>
 <d7dd633b-e28a-155a-a8e2-0e5a83b4eead@linux.ibm.com>
 <YFyJr+R24TlrMNrC@kernel.org>
 <YFygSdFOT5B0DwRU@hirez.programming.kicks-ass.net>
 <2BAC42AE-6BD3-45EF-8867-1A15F25FE80B@gmail.com>
Date:   Sun, 28 Mar 2021 00:14:56 +1100
Message-ID: <874kgwhh67.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arnaldo <arnaldo.melo@gmail.com> writes:
> On March 25, 2021 11:38:01 AM GMT-03:00, Peter Zijlstra <peterz@infradead.org> wrote:
>>On Thu, Mar 25, 2021 at 10:01:35AM -0300, Arnaldo Carvalho de Melo
>>wrote:.
>>> > > Also for CPU_FTR_ARCH_31, capture the two cycle counter
>>information in
>>> > > two 16 bit fields of perf_sample_weight structure.
>>> > 
>>> > Changes looks fine to me.
>>> > 
>>> > Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> 
>>> So who will process the kernel bits? I'm merging the tooling parts,
>>
>>I was sorta expecting these to go through the powerpc tree. Let me know
>>if you want them in tip/perf/core instead.
>
> Shouldn't matter by which tree it gets upstream, as long as it gets picked :-)

I plan to take them, just haven't got around to it yet :}

cheers
