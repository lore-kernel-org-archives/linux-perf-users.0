Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1091FC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Apr 2022 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiD0QZW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiD0QZG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Apr 2022 12:25:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADC236E24
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 09:19:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so2015296plo.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Apr 2022 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fB+D/7pJaYmPUCdn8kycmM+Ul0B8R84B43ZQd5gS8Kc=;
        b=gIiaVIaQWTRSTYO0iYSxismgtGatUVsnHjsreouyLf2MOb9MUu/wnU4zqgB5cLTxgX
         ROBO6loS1ZzQ9c3K4+heCtVCySqvO8yulB8m9PzGXIB80JNY8KbbYNf0ippFZ82sA0gW
         Dfx6gtUdAp38Ae7mwl133SlUtYWxa+MBJe10b8PAcQ8PBooPuOOXu3rz/AEfDEobWEh9
         emOr42AABxdRsOegkMJPUEAunHrf8V0foOoeiPEEPC95Uia/bPGuLK0w07ecNtOhrY0W
         jjW5qiSbK66lahdI3MB20owZwmOdaksuGRcjSywwOeg17cTeppFGSbctYPFk0WMBgaxs
         Z4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fB+D/7pJaYmPUCdn8kycmM+Ul0B8R84B43ZQd5gS8Kc=;
        b=ERjVawRRZEDiwfarQzbgOnmwZLBsF9M+7LQSaEc0+3ZWkc2ZCSZSZFVHKW0QmQRgtZ
         udeowPtbPJ1R3zv+6k70BPilm3C9DGwYI/j8gIcbt+iU2QJDujomuhiVEvWF3Nklkg0F
         9cNLBz034pNbQiwcGdvSLQGiSpU1AaIG1XDIGzcOY3b4q8CKOHH4JWSOBjFJ/NPgwJ5d
         iCSOTXueYyIQ2wW8aFzkwU3Hteyyex5eYy10Edkc0J+OMh1YtvKOdy81Rix9PjckRs42
         OuPRzcDeuoaZzebhNj/NpBpFXINiDVAIxCb3lG4R4vnabNvtGGTv5wyL08xEfO+/4o43
         UYLg==
X-Gm-Message-State: AOAM532+c6Jdr1Z3QmCOaKAmwdBD2d4/NxuRrWrrpvqPR6oGaJrGXwVO
        fbdSxS0jMw3MqKkzMhf5PGYNEQ==
X-Google-Smtp-Source: ABdhPJzQQPPVMZgiQeJ7XCwAvPLUZIpex/aF9/4xYQH7aShixtfieF9c2Ptwb0v2h8v8gaVdOZLevg==
X-Received: by 2002:a17:902:cec4:b0:15d:50ba:d9bf with SMTP id d4-20020a170902cec400b0015d50bad9bfmr4430492plg.28.1651076358662;
        Wed, 27 Apr 2022 09:19:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f10-20020a63de0a000000b003aab55ad590sm17681133pgg.93.2022.04.27.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:19:18 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:19:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Ali Saidi <alisaidi@amazon.com>,
        Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <20220427161908.GE562576@leoy-ThinkPad-X240s>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
 <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
 <20220424114302.GB978927@leoy-ThinkPad-X240s>
 <b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Kan,

On Mon, Apr 25, 2022 at 01:01:40PM -0400, Liang, Kan wrote:
> 
> 
> On 4/24/2022 7:43 AM, Leo Yan wrote:
> > On Sat, Apr 23, 2022 at 05:53:28AM -0700, Andi Kleen wrote:
> > > 
> > > > Except SNOOPX_FWD means a no modified cache snooping, it also means it's
> > > > a cache conherency from *remote* socket.  This is quite different from we
> > > > define SNOOPX_PEER, which only snoop from peer CPU or clusters.
> > > > 
> 
> The FWD doesn't have to be *remote*. The definition you quoted is just for
> the "L3 Miss", which is indeed a remote forward. But we still have
> cross-core FWD. See Table 19-101.
> 
> Actually, X86 uses the PERF_MEM_REMOTE_REMOTE + PERF_MEM_SNOOPX_FWD to
> indicate the remote FWD, not just SNOOPX_FWD.

Thanks a lot for the info.

> > > > If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
> > > > this would be easier for us to distinguish the semantics and support the
> > > > statistics for SNOOPX_FWD and SNOOPX_PEER separately.
> > > > 
> > > > I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.
> > > 
> > > Yes seems better to keep using a separate flag if they don't exactly match.
> > > 
> 
> Yes, I agree with Andi. If you still think the existing flag combination
> doesn't match your requirement, a new separate flag should be introduced.
> I'm not familiar with ARM. I think I will leave it to you and the maintainer
> to decide.

It's a bit difficult for me to make decision is because now SNOOPX_FWD
is not used in the file util/mem-events.c, so I am not very sure if
SNOOPX_FWD has the consistent usage across different arches.

On the other hand, I sent a patch for 'peer' flag statistics [1], you
could review it and it only stats for L2 and L3 cache level for local
node.

The main purpose for my sending this email is if you think the FWD can
be the consistent for both arches, and even the new added display mode
is also useful for x86 arch (we can rename it as 'fwd' display mode),
then I am very glad to unify the flag.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20220427155013.1833222-5-leo.yan@linaro.org/
