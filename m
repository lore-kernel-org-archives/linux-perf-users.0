Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC24ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 12:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiHaMRc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHaMRb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 08:17:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2730D345E
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 05:17:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nc14so23047849ejc.4
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 05:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=EQwAVWOYu1smF9HWgIKONGZof8TcBcJZfeqOzv82cgA=;
        b=UU6MTM5xrjjybbBT4IWLXbrnbEtw1ttQdRo9vCZ6hUr9qhNdejAvGHz1ATfaqPDvy8
         DqLBS56aGeMyDc33wuomcdd4E0o7Cxx6wQWwJfN6k5Cl1Xn7fg3mjJapwkf+NZxiTMk7
         yHK8JbqY5E3lhM/bGZbRKooRi7S1YJKUEQ9ZUvXxwuaOUWjg6+MBXbgkr7MwRZH1cmIq
         R9Kb3c8p723NxQqR6qGZz196eiI5CqExhgfRu/YjrQ0aNWCQ6iYHi6+XT659IBjLDI5u
         se/ZNBwANa4aGSbphvQpHyDkO9EFuGP2mFpZO0j4MPRxZcKPz6BsDet/W8EcYqYdPxDJ
         KnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EQwAVWOYu1smF9HWgIKONGZof8TcBcJZfeqOzv82cgA=;
        b=GvRvZSxEhiSjGIZ8sOkx1tW9KHNyqF7YuctOhpWNtO4CHlUYVNAleXuP+bBH+OyN7b
         SlvzIs3RUmaQHpotBslGZBuGiwg8aFlZPU6pyG4IEt9Wyvd16CUaT3ij4S6iZzuGEapD
         mbSvnyrFU5vXIfjH7r7zt3gnFDwCyp5tKkxRIlFQCm/DqrLh2F7bPAS4+fslYppdiZSZ
         oGUDAEgY3peINSaw/AP9wAUGctu7jUWFDfCB7FDWQ2VsaJkkDGbFfxdbg/r7d1pFA6CS
         61QpUo9HIQL43K1s+Y2PcJJft3i4kInHehKodwk817z8qAmWiofqlmhBZ+Kkj7uaC/yY
         dGag==
X-Gm-Message-State: ACgBeo068SweqS8CY2416uFhV8f5pDtyEWGdcc3kw5VLORbp/5RZgUPU
        C0osCUR81mkLEcC9RCydpK0=
X-Google-Smtp-Source: AA6agR5sa526C4FKv+4/rr+lVtlyijoSEFKsq4aMjbio1SIwEB0KMNE6slLEbMZ+DRgFSH7YlyQxvw==
X-Received: by 2002:a17:907:a04d:b0:741:37f5:56d2 with SMTP id gz13-20020a170907a04d00b0074137f556d2mr15304295ejc.668.1661948248163;
        Wed, 31 Aug 2022 05:17:28 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n11-20020aa7db4b000000b004482dd03fe8sm6888773edt.91.2022.08.31.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:17:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 31 Aug 2022 14:17:26 +0200
To:     William Cohen <wcohen@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: PROBLEM: The --call-graph=fp data does do not agree with the
 --call-graph=dwarf results
Message-ID: <Yw9RVlb3YxpTxROw@krava>
References: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb3efad5-37eb-29e4-03b0-f0bcc8be9918@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 30, 2022 at 10:21:28AM -0400, William Cohen wrote:
> With a perf Fedora 36 perf-tools-5.18.13-200.fc36 I was examining
> where perf-report was spending its time when generating its report and
> found there was an efficiency issue in Fedora 36's binutils-2.37.  The
> efficient issue been addressed in Fedora rawhide and will be
> backported to Fedora 36
> (https://bugzilla.redhat.com/show_bug.cgi?id=2120752).  This was

nice :)

> initially discovered when processing perf.data files created with
> --call-graph=dwarf.  The output of the perf-report call-graph for
> dwarf information notes inlined functions in the report. The excessive
> time spent in binutils bfd's lookup_func_by_offset was caused by perf-report
> building up a red-black tree mapping IP addresses to functions
> including inlined functions.
> 
> I ran a similar experiment with --call-graph=fp to see if it triggered
> the same execessive overhead in building the red-black tree for
> inlined functions.  It did not.  The resulting output of the perf-report
> for --call-graph=fp does not include information about inlined functions.
> 
> I have a small reproducer in the attached perf_inlined.tar.gz that
> demonstrates the difference between the two methods of storing
> call-chain information. Compile and collect data with:
> 
> tar xvfz perf_inlined.tar.gz
> cd perf_inlined
> make all
> perf report --input=perf_fp.data > fp.log
> perf report --input=perf_dwarf.data > dwarf.log
> 
> The dwarf.log has the expected call structure for main:
> 
> 
>                main
>                |          
>                 --85.72%--fill_array (inlined)
>                           |          
>                           |--78.09%--rand
>                           |          |          
>                           |           --75.10%--__random
>                           |                     |          
>                           |                      --9.14%--__random_r
>                           |          
>                           |--1.58%--compute_sqrt (inlined)
>                           |          
>                            --1.32%--_init
> 
> The fp.log looks odd given program:

what's odd about that? perhaps the confusion is that you are
in children mode? you could try --no-children

> 
>    99.99%     0.00%  time_waste  libc.so.6             [.] __libc_start_call_main
>             |
>             ---__libc_start_call_main
>                |          
>                |--66.07%--__random
>                |          
>                |--21.28%--main
>                |          
>                |--8.42%--__random_r
>                |          
>                |--2.91%--rand
>                |          
>                 --1.31%--_init
> 
> Given how common that functions are inlined in optimized code it seems
> like perf-report of --call-graph=fp should include information about
> time spent in inlined functions.

hum, so 'fp' call graph is tracersing frame pointers which I would
not expect for inlined functions

jirka
