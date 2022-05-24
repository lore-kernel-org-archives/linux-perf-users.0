Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD9C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 May 2022 12:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiEXMKX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 May 2022 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiEXMKW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 May 2022 08:10:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641C68FAA
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 05:10:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ee42so2148281edb.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 May 2022 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqjBlbfOFsl5TUBF1M2MxoL6zErRxcfavrGqAXdBsRk=;
        b=DBOE0PffwqbypJOoPsKdgQ9N+Py5FHvbrq32Lci5rLmCI/6OKxgOSz77CptaCi9Y9a
         55cC9VTI6oUXo/dX7dOI2SOWO6t7dS+k2po2lvxqjC9xLVwkKraKTnIRIX3bMasTDtku
         UYWz74aOt9Fehz5EH0cXOj5ryeFLM7hiSXMvL/ISq1/RHwbuJLlh/UJRTEcGJUm2biM0
         lVQY9Pp59GMry4pT/WHgj3quWSXbAmqv8THtwpMcSknIbrsCvl8L5nsVkwhH1vk1MWMr
         pELSBGhUCipzKtK5c66+i1+etGSYCirw4uCiC074NyXWC9ZtUCx/1pxMev5CSnWaYCaJ
         Uf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqjBlbfOFsl5TUBF1M2MxoL6zErRxcfavrGqAXdBsRk=;
        b=uhbYV5YE75akgm0mlaLBtZbn+DtH9nlesVOmmj5Sdw9UgaRwt+RXw8xtAVtPuNjhDZ
         Hvl2W8X3fPi6Qd4v58EiwH9QnN3f2y8a6yn55OoSCRqZqeJwaaYaL8yd7DbUmKnR/1ws
         abiTx2fKIKHxkdZYyyU3FibEbjPmBi4Ma+NQTxw05sFeQSrtejGuQlee4p5Sa6iCubmy
         Wl+9jmeUoIgu5V3dbObjGR5aiGC31PkRSwGDiIlQ2v1LKUJI1EWQ2kasfYOqopEh8ASP
         NUzCti0X9yQ7euHj5GCEAK9J/e1H2i6kdHW1KTEUQqmQkvUcd/IVDrFKm9MVOsYtf1b/
         KoeA==
X-Gm-Message-State: AOAM531D2hNmMsXglKgC5oK06gsPh02j0wFkBIdRj+wIV8giGLFzpNem
        DpJQNfiP/GuxOEQF46Nzuhw=
X-Google-Smtp-Source: ABdhPJy9hkllC5OUf9ipZ+CqDjAPsuieoQbOlhmFtLJ/EDj8a6XRVWNOjyu6x3sHVs/zpPYb+M6dLA==
X-Received: by 2002:a05:6402:424b:b0:42b:3871:75fa with SMTP id g11-20020a056402424b00b0042b387175famr17976424edb.92.1653394220270;
        Tue, 24 May 2022 05:10:20 -0700 (PDT)
Received: from krava (net-93-147-242-253.cust.vodafonedsl.it. [93.147.242.253])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7d3d2000000b0042a96c77e9esm9253067edr.91.2022.05.24.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 05:10:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 24 May 2022 14:10:17 +0200
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
Message-ID: <YozLKby7ITEtchC9@krava>
References: <bac4efca-c61e-5f62-daa1-f508b64d6a7f@linux.ibm.com>
 <YotrewGfs8c2sXfV@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YotrewGfs8c2sXfV@krava>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 23, 2022 at 01:09:51PM +0200, Jiri Olsa wrote:
> On Mon, May 23, 2022 at 12:52:06PM +0200, Thomas Richter wrote:
> > On s390 the test case 40 'LLVM search and compile' runs for ever:
> > 
> >   # date; timeout 30s perf test -F 40; date
> >   Mon May 23 12:35:48 PM CEST 2022
> >    40: LLVM search and compile   :
> >    40.1: Basic BPF llvm compile  :
> >   Mon May 23 12:36:18 PM CEST 2022
> >   #
> > 
> > Investigation by Ilya Leoshkevich revealed:
> > On s390 we hit an endless loop where bpf_object__next_program and bpf_program__next 
> > infinitely call each other. We tracked this down to ld.so preferring the perf's 
> > bpf_object__next_program weak copy over the libbpf's strong one.
> > 
> > This is introduced with commit 2a4898fc264a ("perf tools: Add more weak libbpf functions")
> > 
> > Also see discussion in 
> > https://lore.kernel.org/lkml/YY%2FAR2Dcaws0BAE9@kernel.org/
> > 
> > How can this be fixed asap? Thanks a lot.
> 
> I was just suggesting to remove that:
>   https://lore.kernel.org/bpf/Yos8hq3NmBwemoJw@krava/T/#mda8abccbf475b99d25abe5498a5df1af2da82ee8
> 
> it's no longer needed and can cause problem apparently

after discussing with Arnaldo we decided to go for another fix,
could you please try this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/weak

thanks,
jirka
