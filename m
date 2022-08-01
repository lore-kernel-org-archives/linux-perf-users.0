Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44266C00144
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Aug 2022 11:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHALqH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiHALqG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 Aug 2022 07:46:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E62CDF0
        for <linux-perf-users@vger.kernel.org>; Mon,  1 Aug 2022 04:46:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tk8so19814768ejc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Aug 2022 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WBE7JiuZZ2jU9paVTeguzhA90wR1T04XPqUxNbs3ffc=;
        b=eYZqdT8l68Fwz64K4ZVZoUG/4DrNnQBSOtsniZYWu2BDmnvmyOXUjLMafRsLVqcSxq
         kEPGApKNCqqWpe7iw3twrQpmGvdnmKNSsScdKdO6obRbWpOX4iZoUorBrzakUtjMZH0a
         f+gUZKyAjBp7eicGlL4+d3fLfKFXkT6CJLxSJqk7kZKGApANplFW4EdlvAU7wY7255MO
         BCh4Nre9li7f6E5hhWDHjN8in3N/UKki744YAzmh9B0nT3FBJ2y/qGgFTD8YbB/RjqQH
         wleZ5h2KTbS2hcNhbqkaz36wx0IJPO9T0UzlSpyQyPlpnEZmizfRQXS/GQw0m9p9n1Aw
         lflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WBE7JiuZZ2jU9paVTeguzhA90wR1T04XPqUxNbs3ffc=;
        b=0IPU06J2Hgq+nbOTRml29OSV6beqNiw98+hTk4jIwxRCkatvzPxRJwzphMsGobXF++
         wR1mXN3BchQp8H38etXbiB0VWT6uSrXTUVdH2iESSpnejVZ6b30lq4jPQCzVWhT7LJkZ
         LNxFljjXyg9LySfncQzW+xU1Gm4BZtjlox2J9yaCP+IGp+UB59VoSD2BSRHrZOjIPDFx
         hifAgs1Rlxv60h45vwWE862bwza5iASljzBGQlYDiiVzEDXblJ3Ssq3U6VjtedUUiGpH
         Fuj4E/BIN2DiZa70bzuKJPuGnyOvj+1FrboPZr1Q10sS/ctTU5MXs+zZZ8jpIAudq5n8
         5O/w==
X-Gm-Message-State: AJIora+CdwFmMXbC2wB2aoNhMCCoBHd+uM8dyCp2F08Sr3EpeWEfD7Qe
        ABML4/ALDxyV7jBcP/OC9z31WQ==
X-Google-Smtp-Source: AGRyM1sE5hfkOOXQpHXoqKcX6x/Y4vdeFJD7RCZnlSrNZ0DGHQxXuLmXNQhU4Zbzmck5c7APkubPkw==
X-Received: by 2002:a17:907:1c11:b0:72f:20:e1ea with SMTP id nc17-20020a1709071c1100b0072f0020e1eamr12032887ejc.427.1659354363610;
        Mon, 01 Aug 2022 04:46:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id wc7-20020a170907124700b0072b55713daesm1340370ejb.56.2022.08.01.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:46:02 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:45:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, songliubraving@fb.com,
        james.clark@arm.com
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <20220801114558.GB73228@leoy-ThinkPad-X240s>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729161244.10522-2-adrian.herrera@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 29, 2022 at 04:12:44PM +0000, Adrián Herrera Arcila wrote:
> The described --delay behaviour is to delay the enablement of events, but
> not the execution of the command, if one is passed, which is incorrectly
> the current behaviour.
> 
> This patch decouples the enablement from the delay, and enables events
> before or after launching the workload dependent on the options passed
> by the user. This code structure is inspired by that in perf-record, and
> tries to be consistent with it.
> 
> Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>

bpf_counter() is not enabled for delay in this patch, but I think this
is purposed to keep the same behaviour with before.  I would leave it
to Song for a call.

The patch LGTM and I tested with commands:

$ time ./perf stat --delay 2000 --quiet sleep 2
Events disabled
Events enabled

real	0m2.039s
user	0m0.007s
sys	0m0.016s

$ ./perf stat --delay 2000 --quiet echo "marking"
Events disabled
marking
Events enabled

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

P.s. I took a bit time to get clear how 'perf stat' set enable_on_exec
flag, which is set in the function create_perf_stat_counter(), so this
can enable PMU event for the case when delay is zero, and this can
avoid losing PMU tracing for workload.
