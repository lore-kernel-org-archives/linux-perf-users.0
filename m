Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E66DC433DB
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Mar 2021 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4273861A26
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Mar 2021 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYQnD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCYQmw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Mar 2021 12:42:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE173C06174A;
        Thu, 25 Mar 2021 09:42:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g15so2410463qkl.4;
        Thu, 25 Mar 2021 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=nQz2FFQOVbXdb1nbA7usuQscVjdcM+pKQXNSzOfg+hY=;
        b=ALPbykLRvkeSQXAwHyRm4zfDOnJh4b6/wRGs+aUYsGZSIjDlbhhMFjIDFemRMdYPMq
         V0mugNl66OVvvLY4jcKxG7wlEQuZ2tLNJdsfpx92KDNEcH49zxOL/VVSD7apxqvXSUIa
         cZzdX2nJ79iU7+K/cs9CqIYV/Q01Y35WOKKOyv0S/g79GK0wo8hDMCU68nlXyohluUUN
         pDP/R++uPfjtJVXnpDEYJK8/A0SerROMRL4of8IsPM/gk69UYSZhANaIOS3vPEK2L7IQ
         eVUj5BnMsLefSjObFHH8VfsrWGXoAl1+QTErTvGryQrBIXXp+I5IxNEgU3CnnKc34rVj
         Sszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=nQz2FFQOVbXdb1nbA7usuQscVjdcM+pKQXNSzOfg+hY=;
        b=ESEJ4V4L31W7Tm0BDekVLFEzgsKMy1rJ4nBtxDIdLX/1Cta5FrbdO5CshY0iSK3Eb2
         hvl42/ge2fyHRNIMZbrHJrdGhGjr5z+BVcTe3lynE9IVJGttKYDkuSJecenB76KnD7LH
         XifV+NUEsqAkAtnxxF79wgkowJsW0DnUH0bxkkNcas2x9WllWO64U/85aV2Rr4Og6Clr
         EyH5gudXS90ltFspR64MfsFzOIjON2R6l0SCZ4bg89a6cc0td4vT7hwD0f2U5yXM13hU
         ufaopkCEm/UMlof9e3E8y6TKsaK0iaqtmY7fQYr2UHuCRANrCbcMBJLUZXLhH6q+djfo
         2e6A==
X-Gm-Message-State: AOAM533iULsqqB3DwQZUlvXLa5x62jzLPRgl/cAD4hT9iL3bE3ushJrq
        O5f71aUrP0juF0obSF3KupWW/TmVdRh1GQ==
X-Google-Smtp-Source: ABdhPJwFootViaDnm/L5OAhIV4/loi9y5igxc62Na47b2/oBl1G7aIZhhS0rvK90N5qsxuI7E3p/ZA==
X-Received: by 2002:a37:9e4e:: with SMTP id h75mr8931214qke.180.1616690571930;
        Thu, 25 Mar 2021 09:42:51 -0700 (PDT)
Received: from [172.16.141.208] ([187.68.194.76])
        by smtp.gmail.com with ESMTPSA id a187sm4512112qkd.69.2021.03.25.09.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 09:42:51 -0700 (PDT)
Date:   Thu, 25 Mar 2021 13:42:23 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <YFygSdFOT5B0DwRU@hirez.programming.kicks-ass.net>
References: <1616425047-1666-1-git-send-email-atrajeev@linux.vnet.ibm.com> <1616425047-1666-2-git-send-email-atrajeev@linux.vnet.ibm.com> <d7dd633b-e28a-155a-a8e2-0e5a83b4eead@linux.ibm.com> <YFyJr+R24TlrMNrC@kernel.org> <YFygSdFOT5B0DwRU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 1/5] powerpc/perf: Expose processor pipeline stage cycles using PERF_SAMPLE_WEIGHT_STRUCT
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mpe@ellerman.id.au,
        jolsa@kernel.org, ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <2BAC42AE-6BD3-45EF-8867-1A15F25FE80B@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On March 25, 2021 11:38:01 AM GMT-03:00, Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>On Thu, Mar 25, 2021 at 10:01:35AM -0300, Arnaldo Carvalho de Melo
>wrote:=2E
>> > > Also for CPU_FTR_ARCH_31, capture the two cycle counter
>information in
>> > > two 16 bit fields of perf_sample_weight structure=2E
>> >=20
>> > Changes looks fine to me=2E
>> >=20
>> > Reviewed-by: Madhavan Srinivasan <maddy@linux=2Eibm=2Ecom>
>>=20
>> So who will process the kernel bits? I'm merging the tooling parts,
>
>I was sorta expecting these to go through the powerpc tree=2E Let me know
>if you want them in tip/perf/core instead=2E

Shouldn't matter by which tree it gets upstream, as long as it gets picked=
 :-)

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
