Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7BC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 21:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiCVVz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiCVVz0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 17:55:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3185F8DD
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 14:53:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2737844wmb.3
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NFZgSZlsMJ92K4ZsfQkNqEehB4rKg2VsDcu/AaRN3q0=;
        b=kFcRmFoukS3hfat2xkguRcRqtzGASe1LE8sm1SP3/dtxwuk7sO63/bJIgCxoO18vSA
         y9JgKTWcB/bof/nn2Ggc718WQXVkUY+8GVA1GKlBMTRcq02lbMX1iZPlE1/KyXKtVbT/
         d/pTr/zuOiiBrz4J2BOeiq8QjBCrKjTDAUD8kxD9tzDo7oU+jsmFoLzJovq7LJr0qyhP
         /aQdBwDrBiLQG8mUTxAFpQtvGOxGwSPyevvUhxoy5rBNP+mNytPadUIxL6BD/gDjCUzx
         TIFSPBkVBaJ7OXN05TgsyrcHU7pBXMm5kJvFMCn1oQiVQOm+oJ11E9WIn9hlUZN+Gt3b
         Trjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NFZgSZlsMJ92K4ZsfQkNqEehB4rKg2VsDcu/AaRN3q0=;
        b=JjpGbhM+yojggN0WE/90ObwXfxiUhakLmXjfzdxcgBSS97pfbqFIP6Ii5+mulSFVNn
         q4/iGkUYo3TL1ztntS2xjgQ6AXkts7toW6tHyF6n9rCLDlBwpAPWrWdsJGG6db/G6z+x
         wlaOMCLF+/qzmdlB3M3z/4eXzuvlGXqDPZrOEZ0v+iBVWXIvyjAdlFAdxSPCR/E6s6b9
         81QvkWbLntjZU6udF1Rdq7e2PFfScK3eWhKRnOPgbrDvq488P/+9zgdCbdwpBErOMAk/
         M05RifSXoWxQVM/r6EmAalP8AqPVG2Fd7oWAvApRK3ec6iy8Pdng69sitQGhdc9NUOJC
         4GIA==
X-Gm-Message-State: AOAM530Au0Nknm0n9S5bIZhonS9eKzeTSHi1QoFgCQ+TWKV+yw5cF5li
        8OKYZXHttMG5vBMZzzbjJV1yLw==
X-Google-Smtp-Source: ABdhPJz9ag7to1Ba2g9ltxrje4ed9WpcWwoG6ffWynoEYXnKEX4v04WmfxAg7wCDdqEw8O8Q6c3wQQ==
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id 4-20020a05600c22c400b0038c70f525a9mr5865344wmg.119.1647986036658;
        Tue, 22 Mar 2022 14:53:56 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id g1-20020a1c4e01000000b003899c8053e1sm3725917wmh.41.2022.03.22.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:53:55 -0700 (PDT)
Date:   Tue, 22 Mar 2022 22:53:52 +0100
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <YjpFcLiCTjHZWzzA@google.com>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjpAYjdgHWwkid5N@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 22, 2022 at 06:32:18PM -0300, Arnaldo Carvalho de Melo wrote:
> I saw there was some issue, should I proceed and apply this v3 patch or
> wait for some v4?

There are two issues in play:

 1. PT event synth doesn't support reading inline information from DWARF
    yet, and my patch to add it runs into some problems. This is not
    relevant for this patch at all.
 2. The results from v3 don't quite match the ones from v1, and neither
    of us are entirely sure why. My personal feeling is that the one
    from v1 are the wrong ones, but it's up to Adrian to say whether we
    want to try to investigate deeply here.

/* Steinar */
