Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3874EC6FD18
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Mar 2023 03:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjC3DNS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Mar 2023 23:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3DNR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2023 23:13:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E620B4EFC
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c18so16825905ple.11
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680145995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCg6ynzMxsrJHzdReGq2w6T9esplKe2G2nwmJ+uwMSk=;
        b=R6FlPuP7QN/VqYKtQ7COJpyc8MTkHY2gm4Lts2H1x1/cJomKJQZViPH2mdB8Mwj4bC
         uElDQaM11CRQPKmy8Z42ZYbkfZZ6Hbinoyn/0S0pLiOYH6/VsbcfAxnE/IMtLXkuaE30
         043qMbzWWJCr27kY0zqW+4pwhLxtQnoqRUo9z9G61haXfh9MKOWPJPKUrpU8TCfWJ7rl
         4oJ5beMaM+XO10BfV6qM695M+ppvZ8pI+RiI3T9/q4TM9STQkjAfF9oEyTw3uB/nwlVk
         i0WiB1NgIljehHHkSKQVGVCYRLKwKx6ADhudgSE/bGFVc9+3aaeHI3ipWtPR7GmTM2Po
         NjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680145995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCg6ynzMxsrJHzdReGq2w6T9esplKe2G2nwmJ+uwMSk=;
        b=zCr4jRaDJ74QjvDkx2zTYFN3j6kVCUymMmHgM/WQ+Ex6r8MBK+p+ul+HH+jcVlHSVa
         g+SHrx3V9JY+TZnzM21PbQHK54WMdfsnt78LACgQV6PDA6zbbzqwW+8wdwxCZLR4E3M7
         ewgaYxm7tnbsYuZ7SsQylJX9WrnbUWWD9gZ/aMnEkSSNeRvS/6VIPmFTAVnCh7T+IBDT
         E75lwhvKq5vw7J66EuUpocA6rbDr8N9tPL2L7TEZlenu9G9j8jtXB6swqgoHbuk7yFHp
         SeczeD8u1Ia9ZiX2Ej/1zUtbx8iULyfa+CplOdxzkZgtxlkcyn5b+Nry5/GQnAmjF+Qc
         7lvA==
X-Gm-Message-State: AAQBX9dLEVryOMeL+JapyP2k3/ocse831fiaTbgL19/+VsfO25g6OReX
        stdlEU+ftYlv/ORYRptOh7tMVQ==
X-Google-Smtp-Source: AKy350bevnhgi7ch9vGSubFn23BHtfiEnN9OxinnIYOj9g9dbzrQC+pyV5yjwQfolRFnNWfqylARcg==
X-Received: by 2002:a17:902:f542:b0:19e:e172:2a40 with SMTP id h2-20020a170902f54200b0019ee1722a40mr26853081plf.65.1680145995145;
        Wed, 29 Mar 2023 20:13:15 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.100.185])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709028f9700b001a043e84bf0sm23598172plo.209.2023.03.29.20.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:13:14 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:13:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        gankulkarni@os.amperecomputing.com, darren@os.amperecomputing.com,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <20230330031307.GD252145@leoy-yangtze.lan>
References: <20230329111422.3693-1-mike.leach@linaro.org>
 <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org>
 <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org>
 <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
 <ZCSRU8zvjjBHhq+x@kernel.org>
 <ZCS4XJaWg7NvaWb7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCS4XJaWg7NvaWb7@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 29, 2023 at 07:14:52PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Not here, I'll check after a call:
> > 
> >   50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >     arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
> >     arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
> >       data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> >                                  ^~~~~~~~~~~~~~~~~~~~~~
> 
> This function was removed in:
> 
> Author: Mike Leach <mike.leach@linaro.org>
> Date:   Wed Mar 29 12:14:21 2023 +0100
> 
>     perf cs-etm: Update record event to use new Trace ID protocol
> 
>     Trace IDs are now dynamically allocated.
> 
> I'm removing this series from perf-tools-next, please address this issue
> and send a v9.

I can reproduce this building failure.  I am curious for how to verify
building for patch wise, the link [1] gives me some hints and below
command works for me:

  $ git rebase -i --exec "make -C tools/perf clean && \
    make -C tools/perf VF=1 DEBUG=1 CORESIGHT=1 && \
    make -C tools/perf clean && \
    make -C tools/perf VF=1 DEBUG=1" HEAD~3

Thanks,
Leo

[1] https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit
