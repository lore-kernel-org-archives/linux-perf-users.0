Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Jul 2022 03:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiGGDOB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGGDOA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Jul 2022 23:14:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850E43057D
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2022 20:13:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o12so3166224pfp.5
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Jul 2022 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQhuv4p8GauGmBVlgFf1kFkX9TY2qVKxcRjGpSIYSz4=;
        b=irQFsrojtSsStyUhfXCi4mWWL4q6IPfix7TMvl1irtrA1pJeZfKoACzwL49rGnPNMl
         dUciv5tRK60KQdpQGN2QepuOWqDg7cvFey4tth/lWgKBND2cbZZ7S1UryCYuJzPDgLgS
         OoCuGcMyY5D1gJdMUAAltiAkqyll4XRR4LC1DH6gxotJYcrZBz4cdK2nH6a0tOd72IYR
         rhlKM4ZZvk2E6Uc3eT1JdoPKsBiFMunJFuV6ik+rbBZhmKx6Ml3lDQZgCc22rP2XS8QE
         Wpfq6QhKhi5y+ASGoSwWbZNaNSr1uoZTyYjruZLgwi81VjDjOyX4LloCFZcVuZHR2aXW
         Pd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQhuv4p8GauGmBVlgFf1kFkX9TY2qVKxcRjGpSIYSz4=;
        b=t4CnAyLzLvDV0uLS/HirL9jIsJURnKfUGqH/gyHpBEBaORREGtLTQJEhyW3ZTQO4JF
         8hkkp3MjoqyVx6r3CjoTC/yD0WV7w8/OSMxo2x2Pd/LePzSyH+jMYySR052hBBSPzIkX
         ZeAZXfi3Uy9/Em5MqY4KLav/rW4E2KAIuhGIxy89RY5hoMtwjAvNSO9RqmsgM2IkY5K0
         wLjNbK6pMOD9iqIbx9PcRJIq43h39F2Q6SPXARIh2RWFyIcDiCUrVBQfGiwW33LOFSSo
         nZGQLoUXxl56WQwr8NXTCJfAP7OP9xIV1cXs+S7B199cVy9coJbRLrFsIweEDfDevd4z
         pdcg==
X-Gm-Message-State: AJIora/y/UH9AYWpMHAVH9hm9BYTiXQBmE11STlFzKCJGCcM2o4MWTgE
        csxq9zbLauZmCE3PRCB1TYn2LA==
X-Google-Smtp-Source: AGRyM1s51eKTtJLYt46YMy0FM41IBP/1FzSuK5sgLZHnQ2CcALy2sFaVvmlTL3jlp61cz2TSV2bJzA==
X-Received: by 2002:a17:903:2441:b0:16c:9d1:192 with SMTP id l1-20020a170903244100b0016c09d10192mr3916934pls.67.1657163638648;
        Wed, 06 Jul 2022 20:13:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id n2-20020a056a0007c200b0051c758a3957sm26195126pfu.149.2022.07.06.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 20:13:58 -0700 (PDT)
Date:   Thu, 7 Jul 2022 11:13:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v3] perf test: Add ARM SPE system wide test
Message-ID: <20220707031352.GB631004@leoy-ThinkPad-X240s>
References: <20220701230932.1000495-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701230932.1000495-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 01, 2022 at 04:09:32PM -0700, Namhyung Kim wrote:
> In the past it had a problem not setting the pid/tid on the sample
> correctly when system-wide mode is used.  Although it's fixed now it'd
> be nice if we have a test case for it.
> 
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested for both root user and non-privileged user, both works as
expected:

Tested-by: Leo Yan <leo.yan@linaro.org>
