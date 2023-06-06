Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2BC7EE24
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jun 2023 00:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFFAq5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 20:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjFFAq4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 20:46:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D99ED
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 17:46:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53482b44007so2917336a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 17:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686012415; x=1688604415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yI11++T/L5lBeXkeNTjihRq2YfRTI8fGCX9agASUvk=;
        b=KhiEIuWwisJ64nb7oADv/W5nqmaBtNa8G1RmqvZUesa4csOL1T/m1/xO3Ro6OXBcQB
         JM46wGBSgfb3tepOH7zmW44Po9kVidHv3fde6PXWKpHx4wlivJx5wQsSdaX+IlCWqfT0
         BpkWjkKmSal2JQH1WoxQXcajnA9fG87qCYoEMGJ/bJbY8xUvb4IbZkEy1ejj3SLdKLMf
         aLHIj9xNftG16pkkqEKSzoHqNmtYcdy/68Ctc1rY3cYAhEyTuk51nT05S5ojXfx2p2Nt
         XcAclcy/lUws7WybpPtBjpcQgfE7/Dr2gYwuS2uD236mAbXLV8XW+LiW5VfIUl8HoIm5
         XicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686012415; x=1688604415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yI11++T/L5lBeXkeNTjihRq2YfRTI8fGCX9agASUvk=;
        b=hse/3CkphFaRAgQiDt4l2WG3MZN+yyGtAALz8gv3KS0i0xD/ZpXyBpPG2k1Rg/Docr
         467e3/KoekE1qe2QxIqU8lSFXp9AGphPLj7CaNHNBTnP1pGxqvKPUl0OOjIHxdv40/wv
         Rp0V1YLosuEvomNGhxBtYmJy3bC5ijwFh4WX0F5uXAsLeOA9RrizZmDzwjW1R/BxMjgu
         +9LOTK15IXCXYRFvJZAUlHtBiXpp8WR3faTl9p0NJUcka42u8tsXF900DPn5yDJLudeW
         1sfqiVI8JiktxG/flFD2LmbbYrK1inyE56VM9eLNpaesddeqFmT5mMiE2VzRXtioy1jH
         jAoA==
X-Gm-Message-State: AC+VfDwtoZFLE1LdM0rSJGfs0w3Z3d5HNp4doAAKErx0/iQeO8/aiuCN
        VdxitZEfpKEz/BF4Yt42KhMayA==
X-Google-Smtp-Source: ACHHUZ7cyZ3JhDDLWNI9zaNMYxv9oSFHsCJyasxO3QHJZy1+i8dryMEVT93ZWSy5z2tRoQHKLHipyA==
X-Received: by 2002:a05:6a20:4428:b0:115:197c:e7d4 with SMTP id ce40-20020a056a20442800b00115197ce7d4mr560388pzb.35.1686012415379;
        Mon, 05 Jun 2023 17:46:55 -0700 (PDT)
Received: from leoy-huanghe ([156.59.96.151])
        by smtp.gmail.com with ESMTPSA id jh1-20020a170903328100b001a6cd1e4205sm7136386plb.279.2023.06.05.17.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:46:54 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:46:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        denik@chromium.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf cs-etm: Track exception level
Message-ID: <20230606004648.GB18315@leoy-huanghe>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <ZH47LeSnwY2uKs//@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH47LeSnwY2uKs//@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Mon, Jun 05, 2023 at 04:44:45PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 24, 2023 at 02:19:54PM +0100, James Clark escreveu:
> > Some fixes to support an issue reported by Denis Nikitin where decoding
> > trace that contains different EL1 and EL2 kernels can crash or go into
> > an infinite loop because the wrong kernel maps are used for the decode.
> > 
> > This still doesn't support distinguishing guest and host userspace,
> > we'd still have to fix the timestamps and do a bit more work to
> > correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
> > possible outcome of cs_etm__cpu_mode(). As far as I know this could
> > never have been returned anyway because machine__is_host(machine) was
> > always true due to session.machines.host being hard coded. And I'm not
> > sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
> > and PERF_RECORD_MISC_HYPERVISOR in this scenario.
> > 
> > The first commit is a tidy up, second fixes a bug that I found when
> > comparing the exception level and thread of branch records, the third
> > is the main fix, and the last commit is some extra error checking. 
> > 
> > Applies to acme/perf-tools (4e111f0cf0)
> 
> So there seems to be agreement the first two patches can be applied? May
> I go ahead and do that now?

Could you pick up the first patch in this series?

I would like ask James to refine a bit for the second patch.

Thanks,
Leo
