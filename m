Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C90C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Apr 2022 12:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbiDTMsg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353371AbiDTMsf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Apr 2022 08:48:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880AE3C4B1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2022 05:45:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b21so2781829lfb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2022 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=061YbEYPg3PBd6zIxLnZg9sBpmTPW8CcwDQ4YDI/ctg=;
        b=FioQSUCI9l06ytDto881ZCTb5LNDJeb92BVnz9jd35QK2N+Zkv0f4JFDFPoLd5YI3N
         OsfmTtLwVGGHOkL528KBtm2I+wOlLEngCqyKla0HxeKiIatgay7tIktWs1NDPdQ0fffG
         qVa5E2FUmrGzDg5DzmGiKC2j04e9gd7hs3kdwX5LRJGyK7U9unRuKIJRWcL30CkaM3jM
         uPzDr/OF7eA5RFgqh/9P/RRyYjRXL6Zm8hA1t7qH9KKL4AOave4qC38R6hJZjFFw3ef0
         EYbHaW919vvYeC/ckIKrDyZrrAULJ1wzf/Qfl2ce9F16vmKmehcHAJ7cS0u+3Di6mO9A
         gDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=061YbEYPg3PBd6zIxLnZg9sBpmTPW8CcwDQ4YDI/ctg=;
        b=mQL4L0SmOd5zF2lpE6PY2y4+myFkvnydtc83Zc1ve7x4lZ1F9JMbNSdtoQcRzvAwb3
         PYONz87KrBeKcEN/5QnoRwlFyzaNLuLC0RT005sKivt12b3qyI3q9Xdkgob3WIra5OjN
         wKY2yUDU50ziSpQJkqOTNiqkGvrb0FIhO7t+6wISsP1cyPKab/5ACv4SFpOu9EuYT168
         dSr2WT0G3FB2FXV9Oe6k8Rb/60wnJeHV8SIWT7C27LtpxxOQXf5rThJKLHKhgnRAd8hG
         kDbxCsMSSMAzyUcXGJPXWb9d5IY9UaHW96g3QPDgSTWe5CMf7CO/olGFcTkbV7IrVy2q
         /UKw==
X-Gm-Message-State: AOAM530tq03TvATk+/fohLiz+GFBQn7GgrqmXKpEP8te27uIlBB/sVyd
        pXuoi6TMrUcX5KZ2vG9kc3i6M4Ra06rQBz/MIT8Za/pziwg=
X-Google-Smtp-Source: ABdhPJy6JbxcDi2e0n1HtolFAOAPNZzje6kdXw6FEGBpOycy9I6p9hGeJq4QViiO7s7a0eB0+BUhQIv1y3RPcFl+LMM=
X-Received: by 2002:a05:6512:3995:b0:471:c1cb:512d with SMTP id
 j21-20020a056512399500b00471c1cb512dmr926458lfu.567.1650458747494; Wed, 20
 Apr 2022 05:45:47 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Musa_=C3=9Cnal?= <umusasadik@gmail.com>
Date:   Wed, 20 Apr 2022 15:45:35 +0300
Message-ID: <CAMjwK+dqZE3Nbij3-e_-G9n9BXkOao5Y2yXc-_RPay0Z0iG3ww@mail.gmail.com>
Subject: Read perf counters of a specific userspace process from the kernel
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello all,
I'm using perf to measure tlb misses of an userspace process. For my
research,  i have a syscall handler at the kernel and when a system
call comes I want to read specific userspace processes misses from
it's pid. (I don't want to use strace). I examined the task_struct and
saw a variable named perf_event_ctxp. I wonder if it would be possible
for me to read the miss numbers from here. Or do you have any idea
where I can read the counter values specific to a process on the
kernel side (started with perf).
Thanks
