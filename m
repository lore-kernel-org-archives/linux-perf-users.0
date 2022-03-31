Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89961C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Mar 2022 12:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiCaMU7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCaMU7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Mar 2022 08:20:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3557169
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 05:19:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so47706105ejd.5
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Mar 2022 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D36Yn+ejM2DXUE0h/u3XBGcr71EqZPBwHQPlqRXqPLQ=;
        b=QHu5Zs2xUoKvVhqkj6wK2uZrS/6gc4dA8wI5nKJoeTpLAEV7/ZXceJJ221pS1cMg9f
         JvhK3PvxQVzRv7dq0DjzRKDmxiIw+EO0J69YGnn+qIoSTW0qYvPOkIiBSAJjk8B15a7h
         P7ccVF8jQhjCPxRXwFsO8r8FAB/0zbZqthGqLAYOSZr602HiSFMaMWl1GbtEFc2nmyMc
         yLphvLEmxLbJSyyPDwASg3ClI/q/NljTYoFCi0QfI5P9Wgt6oDDqIR/nMMjK/yGEaQ+p
         CkWT6bniNj9VXnN/M6AkjI99lIp6DPKG/rLIE8cx7v5nPlHvZ7Eh6QC+lVQprxcs5FFI
         47ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D36Yn+ejM2DXUE0h/u3XBGcr71EqZPBwHQPlqRXqPLQ=;
        b=4BaZF5qD7xxGiSnWvKjAeb4S/ZqlORwOgzjWkPNTDmjukvtjPfCzLdvu1KtS0DBH4H
         8yuiGhF2toQIvsP09AI1GPTMHVi1+AGVS4ffCsWkzntQZYy5V4AysJeGPkUnp9TIosba
         Ns9/zKYXdSBL/NXIzaOn4sflHoxKN6d5+og0WAPEzHMhtu735/Fjz9J7BJn3Eef1r+oK
         k+UNgrWCvnCc2D0yRkGNUTxUTI5j7E8iK5DtcHUluGkBcRCQPDpHBbjwb0p+IttSscn+
         soHgpfolR9AV7YEDO2JwOoNqVbVEP3cRFKFuZwypNk+y8jsARVKPLmGVmgb3Qv5KMiin
         L3vw==
X-Gm-Message-State: AOAM532xQNB3OA+jyhEm0ME85OnjXh9f8tpj5zKRn+xb8vREPdJN+D/w
        hooKp8Oj3Iq6gYFPyWVlP1pTpA==
X-Google-Smtp-Source: ABdhPJxmJMnsTNRsdqZxrtv4RgtdwiawUFjBrcIQbDJn0VDT4ZfrbQnG4vIteN6+nqduvCgYCN/cYg==
X-Received: by 2002:a17:907:3e0c:b0:6e0:7d7e:58 with SMTP id hp12-20020a1709073e0c00b006e07d7e0058mr4518430ejc.597.1648729150471;
        Thu, 31 Mar 2022 05:19:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id gn1-20020a1709070d0100b006e012aaa918sm9351455ejc.139.2022.03.31.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:19:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 20:19:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 2/4] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220331121902.GA1704284@leoy-ThinkPad-X240s>
References: <20220328130547.GA360814@leoy-ThinkPad-X240s>
 <20220329143214.12707-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329143214.12707-1-alisaidi@amazon.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ali,

On Tue, Mar 29, 2022 at 02:32:14PM +0000, Ali Saidi wrote:

[...]

> > I still think we should consider to extend the memory levels to
> > demonstrate clear momory hierarchy on Arm archs, I personally like the
> > definitions for "PEER_CORE", "LCL_CLSTR", "PEER_CLSTR" and "SYS_CACHE",
> > though these cache levels are not precise like L1/L2/L3 levels, they can
> > help us to map very well for the cache topology on Arm archs and without
> > any confusion.  We could take this as an enhancement if you don't want
> > to bother the current patch set's upstreaming.
> 
> I'd like to do this in a separate patch, but I have one other proposal. The
> Neoverse cores L2 is strictly inclusive of the L1, so even if it's in the L1,
> it's also in the L2. Given that the Graviton systems and afaik the Ampere
> systems don't have any cache between the L2 and the SLC, thus anything from
> PEER_CORE, LCL_CLSTR, or PEER_CLSTR would hit in the L2, perhaps we
> should just set L2 for these cases? German, are you good with this for now? 

If we use a single cache level (no matterh it's L2 or ANY_CACHE) for
these data sources, it's hard for users to understand what's the cost
for the memory operations.  So here I suggested for these new cache
levels is not only about cache level, it's more about the information
telling the memory operation's cost.

[...]

> > Alternatively, I think it's good to pick up the patch series "perf c2c:
> > Sort cacheline with all loads" [1], rather than relying on HITM tag, the
> > patch series extends a new option "-d all" for perf c2c, so it displays
> > the suspecious false sharing cache lines based on load/store ops and
> > thread infos.  The main reason for holding on th patch set is due to we
> > cannot verify it with Arm SPE at that time point, as the time being Arm
> > SPE trace data was absent both store ops and data source packets.
> 
> Looking at examples I don't, at least from my system, data-source isn't set for
> stores, only for loads.

Ouch ...  If data source is not set for store operation, then all store
samples will absent cache level info.  Or should we set ANY_CACHE as
cache level for store operations?

> > I perfer to set PERF_MEM_SNOOP_HIT flag in this patch set and we can
> > upstream the patch series "perf c2c: Sort cacheline with all loads"
> > (only needs upstreaming patches 01, 02, 03, 10, 11, the rest patches
> > have been merged in the mainline kernel).
> > 
> > If this is fine for you, I can respin the patch series for "perf c2c".
> > Or any other thoughts?
> 
> I think this is a nice option to have in the tool-box, but from my point of
> view, I'd like someone who is familiar with c2c output on x86 to come to an
> arm64 system and be able to zero in on a ping-ponging line like they would
> otherwise. Highlighting a line that is moving between cores frequently which is
> likely in the exclusive state by tagging it an HITM accomplishes this and will
> make it easier to find these cases.  Your approach also has innaccurancies and
> wouldn't be able to differentiate between core X accessing a line a lot followed
> by core Y acessing a line alot vs the cores ping-ponging.  Yes, I agree that we
> will "overcount" HITM, but I don't think this is particularly bad and it does
> specifically highlight the core-2-core transfers that are likely a performance
> issue easily and it will result in easier identification of areas of false or
> true sharing and improve performance.

I don't want to block this patch set by this part, and either I don't
want to introduce any confusion for later users, especially I think
users who in later use this tool but it's hard for them to be aware any
assumptions in this discussion thread.  So two options would be fine
for me:

Option 1: if you and Arm mates can confirm that inaccuracy caused by
setting HITM is low (e.g. 2%-3% inaccuracy that introduced by directly
set HITM), I think this could be acceptable.  Otherwise, please
consider option 2.

Option 2: by default we set PERF_MEM_SNOOP_HIT flag since now actually
we have no info to support HITM.  Then use a new patch to add an extra
option (say '--coarse-hitm') for 'perf c2c' tool, a user can explictly
specify this option for 'perf c2c' command; when a user specifies this
option it means that the user understands and accepts inaccuracy by
forcing to use PERF_MEM_SNOOP_HITM flag.  I think you could refer to
the option '--stitch-lbr' for adding an option for 'perf c2c' tool.

Thanks,
Leo
