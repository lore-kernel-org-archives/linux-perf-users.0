Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C3C74A5B
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCQOZx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQOZw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 10:25:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ECBCBAB
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 07:25:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l9so2837989iln.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679063149; x=1681655149;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p2CUhIvsIV018a8ZSlFgQ3zlVEcQ2/v9OhzU3Atnhs=;
        b=PCf+H4Nqqd52N4v//r7DysAg/Vcpsa22ZGsVjWanidwqLUnW26KPl1lC4EEa723Q5Q
         1nr+dDLFEYC66wboYQ6QSe8XzZ5NVnjtaxMvfbavlQGLA2/ES6RK1PXU5S+vGdxb8k+F
         H5IKgHmnM34hzjgBPjSQNTWrker2VxSkbCGFfmQrVa4YLkUnLeOhG2U3CrDw8klvRleO
         X3C77RSN2PqedLH0uVlGfGGnKJaXxuZJ/HG6zhjN8ZhDplgHsi3TfYKpJErZYvQaVmyG
         ew1oER4K1lWnaF1Qllu6lbCea1CH0xNlRWFVmbMW2q12C75StvlX1Oftn9nVH22wUu7j
         i+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063149; x=1681655149;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2p2CUhIvsIV018a8ZSlFgQ3zlVEcQ2/v9OhzU3Atnhs=;
        b=2mXokpiMpszs4CKvmidWrIK4VD02WQsMfCXviv3/ynw5ZfoIuper88JEXPI227lpdt
         seRlR2rE7TWS2kq1zA8N2xpV7AY5416mXZVBENQVk9wV7Ujexg3b2WoqHx7tSqIu2wC4
         j2882Np5+cG1XXfyQnUlWDXrb/aUc998WW7GxiJDqdATHsLhulZgPNFHcyH9PWKTmzE/
         ffs7BwqST2nFu6jyaRyccl0n/N5f8pOsR6PdxfmRSvefizUabLb4fiONxgFW1w9zzlPI
         4w5OSmgXFDRJxD48hGJiW2iB+eO0rVemCZXk83tEZZAyx8s+dxj1AG+Cbfy0Ye6H2qI3
         /YOw==
X-Gm-Message-State: AO0yUKUeqVcj+pZxY0O6DLP7oUHDSCQWUFRPvBeX/QKU69WCN/En6SxY
        NFNao9N0FfqdI044t1wLEZ/dXA==
X-Google-Smtp-Source: AK7set/i6lNRTCFj0GTvMl4IudVQiLW4GHLxlBPyxY/ouyWzURSvJ+jggFHPi3pYbnY/u1nwYyuuLw==
X-Received: by 2002:a92:c266:0:b0:317:36d8:cfc6 with SMTP id h6-20020a92c266000000b0031736d8cfc6mr4372418ild.3.1679063149130;
        Fri, 17 Mar 2023 07:25:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r23-20020a02b117000000b00406328003a4sm724854jah.65.2023.03.17.07.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:25:48 -0700 (PDT)
Message-ID: <25fccb43-8338-a690-0009-384dc0640169@kernel.dk>
Date:   Fri, 17 Mar 2023 08:25:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: NMI reason 2d when running perf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

When running perf on my Dell R7525 on a running process, I get a ton of:

[  504.234782] Dazed and confused, but trying to continue
[  504.267843] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.267846] Dazed and confused, but trying to continue
[  504.335975] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.335977] Dazed and confused, but trying to continue
[  504.368031] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.368033] Dazed and confused, but trying to continue
[  504.371037] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.371038] Dazed and confused, but trying to continue
[  504.439165] Uhhuh. NMI received for unknown reason 2d on CPU 48.
[  504.439167] Dazed and confused, but trying to continue

spew in dmesg. The box has 2x7763 CPUS. This seems to be a recent
regression, been using this box for a while and haven't seen this
before. The test being traced is pinned to CPU 48. The box is currently
running:

commit 6015b1aca1a233379625385feb01dd014aca60b5 (origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Mar 14 19:32:38 2023 -0700

    sched_getaffinity: don't assume 'cpumask_size()' is fully initialized

with the pending block/io_uring branches merged in for testing.

-- 
Jens Axboe

