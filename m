Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91527C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Mar 2022 12:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiCaMqW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiCaMqV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Mar 2022 08:46:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D914864B
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 05:44:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bq8so33893733ejb.10
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u2E6iZH4vqaN/paASsb9/5JiTf0b1m5qdb10iYTnEXE=;
        b=j+QhpYpfOQq+udSbmUsuT5Zz9iEk/cMj4q8EgU1QeOC8tH7Wwb+bEqgrw56SVAWKzw
         KYMtAsUmWnwiN0VeTHkYPNk0YBE4qwcSds9UlUDw1pVDzWVRhMXTEnTQeQcOQLEqUdUh
         LMG22ZPdk4wFqjuOLTEWmyB5q18f3VpGqSo6j6i5xIag1jDFZWOquvKBkOvvHHfcqPdr
         kZJ0JUAwEZ0VwoeWNcV/KOU7DN8TEjY/ZG6hP/XcAdJIgxMGWKGsxO2zwXvQ3XoerZ/6
         USYUmyqd8uRB4MpvGTcPUdEmHJannnS6zX6lco0AvHDdJw5qHE5FGSZw/8sAtGTgrM0O
         p5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2E6iZH4vqaN/paASsb9/5JiTf0b1m5qdb10iYTnEXE=;
        b=YtmiiFJ84OW5cySL5K1I05LKLNvqSvAttl5ocpaUdHA5jHxsX2LOPRT1ttN3rUccQP
         180nC6jPhy3V+dVzTdrjKQNS/eldHwdw3vaJLxKBS5xi0ugEnqifbPzPO8Nk17Q2Ehgy
         7AVPDUKGi/ep+0pH2+Js/vLtFrfq8C0nvN1lY+D8bj40I/oI9R3eP5OaBjVDjakT+/Ai
         9Gpx5WoSokHmz2WBEtbuqFB7b+v+ugLZsOsk4j6TRv+XdwblgyIUZLpL4bHJE7ZxlozS
         IcNKR5GVf0sSOA4JtRWQVyga45NG0vy4Rzr5zOfIAScBFTPXizGr8b2HTFeqdo1Jr9Rr
         CONA==
X-Gm-Message-State: AOAM530tmh03idv0B0qvg4S3cT5+9Puc9TxAy6PQdya4V65QQewmy0cQ
        otPd1SdQLwdZRrvdDlI7pikkEg==
X-Google-Smtp-Source: ABdhPJzC1TZHRiZ4ercOvfulsYZ7N2MPHEwfLnwj9lldpUf0NHaBY5GrDnEqN7tDPoDJJ1bO/1jAkw==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr4706766ejx.396.1648730672768;
        Thu, 31 Mar 2022 05:44:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id p24-20020a056402045800b0041614c8f79asm2935368edw.88.2022.03.31.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:44:32 -0700 (PDT)
Date:   Thu, 31 Mar 2022 20:44:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, Nick.Forrington@arm.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220331124425.GB1704284@leoy-ThinkPad-X240s>
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
 <20220329143214.12707-1-alisaidi@amazon.com>
 <4710b4b2-5dcd-00a4-3976-1bd5340f401d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4710b4b2-5dcd-00a4-3976-1bd5340f401d@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 31, 2022 at 01:28:58PM +0100, German Gomez wrote:
> Hi all,
> 
> It seems I gave the Review tags a bit too early this time. Apologies for
> the inconvenience. Indeed there was more interesting discussions to be
> had :)
> 
> (Probably best to remove by tags for the next re-spin)

Now worries, German.  Your review and testing are very helpful :)

> On 29/03/2022 15:32, Ali Saidi wrote:
> > [...]
> >
> >> I still think we should consider to extend the memory levels to
> >> demonstrate clear momory hierarchy on Arm archs, I personally like the
> >> definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
> >> though these cache levels are not precise like L1/L2/L3 levels, they can
> >> help us to map very well for the cache topology on Arm archs and without
> >> any confusion.  We could take this as an enhancement if you don't want
> >> to bother the current patch set's upstreaming.
> > I'd like to do this in a separate patch, but I have one other proposal. The
> > Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
> > it's also in the L2. Given that the Graviton systems and afaik the Ampere
> > systems don't have any cache between the L2 and the SLC, thus anything from
> > PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
> > should just set L2 for these cases? German, are you good with this for now? 
> 
> Sorry for the delay. I'd like to also check this with someone. I'll try
> to get back asap. In the meantime, if this approach is also OK with Leo,
> I think it would be fine by me.

Thanks for the checking internally.  Let me just bring up my another
thinking (sorry that my suggestion is float): another choice is we set
ANY_CACHE as cache level if we are not certain the cache level, and
extend snoop field to indicate the snooping logics, like:

  PERF_MEM_SNOOP_PEER_CORE
  PERF_MEM_SNOOP_LCL_CLSTR
  PERF_MEM_SNOOP_PEER_CLSTR

Seems to me, we doing this is not only for cache level, it's more
important for users to know the variant cost for involving different
snooping logics.

Thanks,
Leo
