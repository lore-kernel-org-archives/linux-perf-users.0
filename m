Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920CDC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 May 2022 11:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiEWLJy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 May 2022 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiEWLJy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 May 2022 07:09:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F987326D1
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 04:09:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg25so8511788wmb.4
        for <linux-perf-users@vger.kernel.org>; Mon, 23 May 2022 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99YcopuxEHSV216JNe5FsgqI+gRxWQSyQwsE3zpuh2Y=;
        b=BBKu3I/ET2v+HPBt9vTcV3TA0IwtGnt4/j/iNss/AQ0oFWrd6C02gRXpniLS6Kz30q
         200f7jZdTx3WozJzoV8qxRzE/oylamRODPnQ8C3lhC/n097VXBNft3r8mStM8fazMnOt
         2CrZmyBD12Diito5QxaG7kGlEwygUQdv6cXu6ek+ZYPBSP0KX5ofIeZoAGsN6LvmJBXj
         wHh/QNnybUJ7Gto49gHMOB8hVM2rPfzUzBCR+j/Uf2pFiZdNbLPILPnUYF9FYsZRGpZ4
         NeUuwxxB6PXmi2XyMyfEdyq5AAo/3c1SMocvi+h6Ooqp/NpSVBUCgGajsH0tSWciQwUW
         KUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99YcopuxEHSV216JNe5FsgqI+gRxWQSyQwsE3zpuh2Y=;
        b=sDHELTceUtsnY2KCFP0X1Az/pRFKoQNvG7K6MqAPcF+cusF9NNx4OoqMcMBxMuWcWl
         o0vZ5/KbjGMV/zfFnXK0poEP8kuW3it6FPafL2zG1qF6MeqyqZQQ9d/aINRHwtu2bq6K
         sCj33Lxi1iJwrcsDcIDVH/dQHW/V+73nDUpi8RRKh9GPEZGPePaMVijegyaCtZzqerNB
         3C+Hvrz2YAgsfdPZezV3LRqtd3XR6y2OBtF6zNkWGLp7Q1QHsBDzxbdP6WnQh81zUVur
         iG5np96vptIdr2fVC91sMN/xFS1159QgkCuLxMubTrhcId2w/VKvH2xTq4wILDvEhUEJ
         eoUg==
X-Gm-Message-State: AOAM532LTdckQCWFX47MMN5DTU1guhpVO9nft6XANQAD0+qGyLwrJ3VC
        CCUllo83mkGAwzbLaD/z8Pk=
X-Google-Smtp-Source: ABdhPJxSXjryZS/U97ADqi33yoAB4RKASlwoGcr/onihR0hI6+ZYWys7IE9KfXBYGgjsBKtl1Pb3hA==
X-Received: by 2002:a7b:c933:0:b0:397:463c:cc82 with SMTP id h19-20020a7bc933000000b00397463ccc82mr7699580wml.187.1653304191110;
        Mon, 23 May 2022 04:09:51 -0700 (PDT)
Received: from krava (net-93-65-240-241.cust.vodafonedsl.it. [93.65.240.241])
        by smtp.gmail.com with ESMTPSA id 186-20020a1c02c3000000b003973e27b789sm7285429wmc.27.2022.05.23.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:09:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 May 2022 13:09:47 +0200
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        vasily Gorbik <gor@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: perf test case 40 LLVM search and compile runs endless (eBPF
 linkage issue)
Message-ID: <YotrewGfs8c2sXfV@krava>
References: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 23, 2022 at 12:52:06PM +0200, Thomas Richter wrote:
> On s390 the test case 40 'LLVM search and compile' runs for ever:
> 
>   # date; timeout 30s perf test -F 40; date
>   Mon May 23 12:35:48 PM CEST 2022
>    40: LLVM search and compile   :
>    40.1: Basic BPF llvm compile  :
>   Mon May 23 12:36:18 PM CEST 2022
>   #
> 
> Investigation by Ilya Leoshkevich revealed:
> On s390 we hit an endless loop where bpf_object__next_program and bpf_program__next 
> infinitely call each other. We tracked this down to ld.so preferring the perf's 
> bpf_object__next_program weak copy over the libbpf's strong one.
> 
> This is introduced with commit 2a4898fc264a ("perf tools: Add more weak libbpf functions")
> 
> Also see discussion in 
> https://lore.kernel.org/lkml/YY%2FAR2Dcaws0BAE9@kernel.org/
> 
> How can this be fixed asap? Thanks a lot.

I was just suggesting to remove that:
  https://lore.kernel.org/bpf/Yos8hq3NmBwemoJw@krava/T/#mda8abccbf475b99d25abe5498a5df1af2da82ee8

it's no longer needed and can cause problem apparently

jirka
