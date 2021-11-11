Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDCC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1788460FE3
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKHaL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhKKHaK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 02:30:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40497C061767
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 23:27:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so3544474pjr.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 23:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JCdi6ova47Widl1JEkNIXeu43n0j2ewnGf1cGDnwtV0=;
        b=US3oy7TDXGqlv+iD6HgB37PbwzQ7XNDYZ32d3X6CTgd5bPJ1O3HSs6x3K7qvqOVilX
         dOFcMQx9Nn4sGOQtc6A96itXD5JSmFGpUiY3XKaJY3dwcRM0CeMUVrOEy5ZwEnwS9qeh
         I+7t6OLPYxHdQQdf07cPV2yxAqG1HeabCbfb93nd+vsNCy/aXWT4JUTlDqaoYwuCN6WX
         x3fC74kJXI+HCAvgLLWI8q3T3wodkCvCOMD+aKrKhPYwgvjpHM0FNYqnpuVoW2nlnHX9
         mFrZfVFNexc8U2rCPbflXArxI5VnlvxS3Ic786qJCwZ/Zed7q9bmJ+uSLOzxupf0uk71
         JAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JCdi6ova47Widl1JEkNIXeu43n0j2ewnGf1cGDnwtV0=;
        b=Qq83mmrn0uLo/f3xDE5ApAEKlBeunDSRm+AEytufraJdRwgLeQQ1g1urselC341HAw
         yIQKzDBR5eY9wiU9ZzIzPUkkwEkDEwW7N0wfn96uh5P2NAzBzfVHHC3ENW7GbysqLJJg
         NTtQkT3Gtd/4XntBtjA/s1CegD4QFOR5jYEzAeHUSKHmL8a5LFjyarT5bVlci4W7Df1m
         jprI/FMWfBglM39E1ZSeH6vvmDaoNhnEovZ4RRrHX4vjAprV0JUSRJhjObYwR5gsO08T
         f5m++g40vulIS1AbS5Lb6beteQxPySWk1l1paRhdEViM5kohtoqoCaLjvuHfjDJerg0r
         7Tfg==
X-Gm-Message-State: AOAM5331LRE1HlHvPN1JByu9E0Z6gSHPca9zDlnSz5YpNlQSiXQUJZe1
        MuTLvyn1/Kh+7oaOXmbPbbRDOg==
X-Google-Smtp-Source: ABdhPJyJk2/3R7hXGyXSsqGDrrLFGqP8DLHcuOIFzzXZCsDFdZhpiWT7lexHtz0bwW+eDvu+9ijFTQ==
X-Received: by 2002:a17:902:9897:b0:143:84c3:4341 with SMTP id s23-20020a170902989700b0014384c34341mr6034559plp.64.1636615641738;
        Wed, 10 Nov 2021 23:27:21 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id o18sm1427790pgb.83.2021.11.10.23.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:27:21 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:27:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] perf arm-spe: Track pid/tid for Arm SPE samples
Message-ID: <20211111072714.GB102075@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109115020.31623-1-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Tue, Nov 09, 2021 at 11:50:16AM +0000, German Gomez wrote:
> The following patchset is an iteration on RFC [1] where pid/tid info is
> assigned to the Arm SPE synthesized samples. Two methods of tracking
> pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
> context-switch events (from perf) as fallback.
> 
>   - Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
>   - Patch #2 updates perf-record documentation and arm-spe recording so
>     that they are consistent.
>   - Patch #3 saves the value of SPE CONTEXT packet to the arm_spe_record
>     struct.
>   - Patch #4 enables hardware-based pid tracking using SPE CONTEXT
>     packets.

I have tested this patch set, it works well on Hisilicon D06 board,
please consider to pick up.  Thanks!

Leo
