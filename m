Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936CFC433B4
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA48616EB
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhEKPip (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhEKPin (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 11:38:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE39C06174A
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 08:37:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so1385579pjy.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 May 2021 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKp71YaU0JXBYBsb0mkN6lX6rK/S4/DoKGSWP1tuOHg=;
        b=gtgwzsn6DcTHb/gNDvXWSsL0FXdGuu0cQDL47A1OypEUl0C3QuLrB2+9YCZZ3bo05q
         NkPu4gwD87l84cAAE5DfOOqz+kDfRml4YSP6yNEOEbnnJi8OkTGjvXsD74ZqtyRafVCN
         bibn7lZc3yc5SfEG++Ts7VfWEE/es5Jlgcnu2MSwisAtnFi38C2A6obU3pmLJHcqwECE
         UL03ZelFQYqzvL5etX4ZXHOkjFrlM5060sEEO0g9Y1O3RHTJyyKQQLYnbqHEiuepE9vn
         CN3mpzv+ucSTcqHpGLmXYr/VicKTp5s2c8udNkHR/IFqUGx+JHP8FakLDlQ2ddECWo9s
         Cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKp71YaU0JXBYBsb0mkN6lX6rK/S4/DoKGSWP1tuOHg=;
        b=peNBNzS9KkoB1YC4rXrCYKFPu2zDCPhbhLMftOpuL03qZCLsr7AOhh01guFqTduqhR
         NsQDU2XzD9WtBLDtRKsidvZlGNySsXH3V+7xQ4T3GQPfBro/c8/QpI12mRqJ59EGUOmR
         NFiOSQrfGBUXXxUBqNun+fThhWBHEU5Gl4InAVBQxd6h1q1+3bQH2wfu1R5q8XfSupBB
         CLyq3NiG6FMLUZp6c2HvGhdh0R+Wp4XifZ/5cyaUoqj/3BX0mXA0BIMT0MzFHJ5NBqn6
         juFOifHb2+Gcgzt9sU0yKdC7JG3IZhiy3RjvNBPvpFvamDmUjjZXSyowgML1KTfLJk5C
         Anvw==
X-Gm-Message-State: AOAM5300SqORcRFvRk5QnPNxgY4+1REu2QV9lekYZ87i1xYbq3lhWSjc
        COXU+prYuvZPn9y6Dtb0cbp3og==
X-Google-Smtp-Source: ABdhPJyoMSJad0vMIKhXC9GddSk1MpU/4y5VA5Qonxo6xr60ccVI4hkupkUgJlYs0pbbKdta9XcaPw==
X-Received: by 2002:a17:902:7d87:b029:ef:176:843b with SMTP id a7-20020a1709027d87b02900ef0176843bmr25924176plm.61.1620747454998;
        Tue, 11 May 2021 08:37:34 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t9sm14245033pgg.6.2021.05.11.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:37:33 -0700 (PDT)
Date:   Tue, 11 May 2021 09:37:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210511153731.GB124805@xps15>
References: <20210510143248.27423-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510143248.27423-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 10, 2021 at 05:32:46PM +0300, James Clark wrote:
> Changes since v2:
>   * Collect acked and reviewed-by tags from v1 that were
>     missed in v2
>   * Add comment and commit message suggestions from Suzuki
>   * Rebase onto next-20210510 (also applies to perf/core)
> 
> Thanks
> James
>

Arnaldo,

Please condiser for inclusion in your tree.

Thanks,
Mathieu
 
> 
> James Clark (2):
>   perf cs-etm: Refactor timestamp variable names
>   perf cs-etm: Set time on synthesised samples to preserve ordering
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++---
>  tools/perf/util/cs-etm.c                      | 57 +++++++++++--------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 44 insertions(+), 35 deletions(-)
> 
> -- 
> 2.28.0
> 
