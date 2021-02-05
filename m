Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB179C43381
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55E164EEC
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Feb 2021 03:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBFDRO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhBFCug (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Feb 2021 21:50:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D6C08ED90
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Feb 2021 15:56:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c12so9552072wrc.7
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Feb 2021 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/zFHaa9IYS/CSYVykC+3HP4MPkwjNTYFLUvDizDIrM=;
        b=eb2D2BLwNTVVbFV9N2mBMn2gPu4fpO7xMVfkiF4wfhWsW8x3cH8pq2B1AGDpR5JzT2
         NXyBZR/QPzDoLuJbdhOMz/7LYFlxBdmK3mKyJ7G4fAHJooOzvPyhdE86TgBwOq7nT1sv
         1+YOAmXL7uMFwV26VZh+UZVjDZTXZ3EqGd//aZbLWxaPAoScdYNc3j4g6ubwAFgz9QCb
         JiYgBnF7VMNoMjO9uzm0k1OQxCJyo2JKyJ8UFFA1jVcy7cI4GEnapxi2ue6YEWwXH79+
         SSBzVwD4C6Y/D8PtYB/6vM1Lyz9MrZpECMEldBM00YKczE1ZYHO4OTEFgXB4xEPnOlIK
         w3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/zFHaa9IYS/CSYVykC+3HP4MPkwjNTYFLUvDizDIrM=;
        b=a59D1hfZ1rW2x6B3ApTe3wGthxV3sOHvnN/aLD0en94ywsRSVs9SS6YH0tO4RxPzFi
         DFopy9ZFcdltS097TREI2ye8q/sNUlTgcIMS2bRSBxfS2OENEVAGSsBTOd1M8FvwtdwV
         YXjomNdsFp4udW6lXVZu/tteA5Sw8M2+o52Lc+x6u4vq/lWoLokHq0zoDHZ7gfbjthDl
         g6TVhGGdM4JjqZQeLvMCOEocNY4/edjqfFzRyY5rPcmOmY7mFN1HKwnggoNdsCLtUG24
         LqNU2frt6eQNu8OZQEi+Cc4DGHIk2S0r88u20WIdtJtKR6WRcVSYOlgaGlju2nK3piUt
         JDUA==
X-Gm-Message-State: AOAM530Stu2XDHsWpjdUBnO+BocXj7jNkUzXFvLZEeiWAWbF4Pisd4JA
        W/qDmiEDNpMFX15T5GBurwTgebkGd9f/G7gn9REFQebEdrw=
X-Google-Smtp-Source: ABdhPJyhbPd+ApBOecoULvETNtQI80dCE8/kX7QAY0PZU//raQ+/3UB3y0g7AegQx6dW6D6zs+uSn1kJ+qB9OjE+1S4=
X-Received: by 2002:adf:a501:: with SMTP id i1mr7357295wrb.119.1612569373819;
 Fri, 05 Feb 2021 15:56:13 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fUPZiSJinVQ940cqHGDZDZamrcYUXG0NFpjEGg=6sngxQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUPZiSJinVQ940cqHGDZDZamrcYUXG0NFpjEGg=6sngxQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 Feb 2021 15:56:02 -0800
Message-ID: <CAP-5=fVp7hK2YUF9rJVRyq2XVz_Wj9=345ycWiw29gKRLd2HSw@mail.gmail.com>
Subject: Re: GSoC 2021 - Volunteer to be a mentor
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Till Kamppeter <till@linux.com>, Aveek Basu <basu.aveek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

(Resending fixing Aveek's email address)

On Fri, Feb 5, 2021 at 3:53 PM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> Google Summer-of-Code is looking for organizations to mentor students
> with a deadline of February 19th:
> https://summerofcode.withgoogle.com/how-it-works/
> If accepted the deadline for students to apply for projects will be April 13th.
>
> Till Kamppeter and Aveek Basu for the Linux Foundation are making an
> application:
> https://wiki.linuxfoundation.org/gsoc/google-summer-code-2021
>
> and I've proposed mentoring some perf related projects:
> https://wiki.linuxfoundation.org/gsoc/2021-gsoc-perf
>
> It'd be nice to have more project proposals and potential mentors. If
> possible, please help with project ideas and volunteer to be added as
> a mentor!
>
> Thanks,
> Ian
