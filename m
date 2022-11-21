Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63155C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Nov 2022 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKUHwu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 02:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKUHwt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2022 02:52:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59632186
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Nov 2022 23:52:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13587228pjs.4
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Nov 2022 23:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WjVfFYLcTfewafnon3KVt0ktJTiMVy1KnjVKkT5rpE=;
        b=b79/fyAq/YHmS0tOjEAtCmJdzJ1Ua36rMCUO8ivApIafNLtN6kTGfwicRGJWxwKqJH
         lJqTjXKFQSETXnz1A4FO28qxJns3MyYYipxX7PqKjsNMbL6scsAern/+29y+tK3yRLiz
         Y3LRr9VjVmgT1PnZ6dOgikEtWkRy25Ry0OuR/0PI2mEoOSrjuzFBXMfg1jtCepGjgbqy
         UgvpV52e2CQo+J9euy+0nkAgV5wY/EDEiHyK4PfX08gIIZEqnh4jFb5OUx/HeIQ2hpfV
         EUnU/V/yKi6jiFZsTr6ubsWvFNhGJSlwWY2QQHqL7Vi0pVoCKYzysbYlKNYGskbqywlQ
         3SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WjVfFYLcTfewafnon3KVt0ktJTiMVy1KnjVKkT5rpE=;
        b=cGQWKuVZIqU9JUrEX6u7goe3K4aWlY1cgThEEbQQNyVdYWZ2cbcZ7/NgFmyn7T9TvT
         XnnMGb8oPZ3o1icOMDulmV/UO41AqdBXxMTu+dGTATWZT47bCZrIf0sf07RYRL5KTUvb
         sLEwQUdkxYNjDJJmHCS9RAxYTLsrqr62t0N4ZVbSni7aKumZBxU8oVRmvQMfh4f988Mb
         5nDzZVc6+8AgIhnfLISf1lplHTbxxbtA7HA287KieMqoTh+UulXBllUIsWcPHgo8b9Wm
         +dieV0Z2JinfCrnJIEZ4lDTCXUAlhJkT55ql5Z2at5gBLv9LRYmGCYkRGkuXvx1PeawI
         Azjg==
X-Gm-Message-State: ANoB5pk8iE2f3Ezy+WUbuQhCmk2aUrxFTHFivOFWCb0dVJORV3IDWAeW
        FZB+xRRiWze0Ft1nSmJVr1vP2/p/xQ3KG4OC
X-Google-Smtp-Source: AA0mqf5nMvHnG2tzrfyG/pKaCg//dI3l1l5t28l8zrVad0SYYerVDasQyvTv7S7qhLyrX4NgNp1FzQ==
X-Received: by 2002:a17:902:ec8a:b0:188:640f:f400 with SMTP id x10-20020a170902ec8a00b00188640ff400mr1182661plg.143.1669017165937;
        Sun, 20 Nov 2022 23:52:45 -0800 (PST)
Received: from leoy-huangpu.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id h31-20020a63575f000000b0047696938911sm7006277pgm.74.2022.11.20.23.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:52:45 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/5] perf trace: Cleanup and remove unused bpf map
Date:   Mon, 21 Nov 2022 07:52:32 +0000
Message-Id: <20221121075237.127706-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The initial purpose of this series is to cleanup the unused bpf map
'syscalls' in the eBPF program augmented_raw_syscalls and perf trace
tool.  The relality is perf trace tool initializes system call table
based on map 'syscalls' and wrongly returns syscall pointer for
non-existed system calls based on the previous initialization.

So the patch set firstly addresses the issue for handling non-existed
system calls, then it removes unused local variable and bpf map in
augmented_raw_syscalls.c.

Patch 01 is a minor refactoring to use macro to replace number, patch 02
is to return error if a system call doesn't exist, especially when we
cannot find corresponding trace point in sysfs node, patch 03 is to fix
the issue that trace__syscall_info() returns a syscall pointer even the
system call doesn't exist, the corrected result is to always return NULL
pointer for non-existed system call.

The last two patches remove the unused local variable and bpf map
'syscalls'.

This patch set has been tested with mainline kernel on Arm64 Ampere
Altra platform.

Leo Yan (5):
  perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
  perf trace: Return error if a system call doesn't exist
  perf trace: Handle failure when trace point folder is missed
  perf augmented_raw_syscalls: Remove unused variable 'syscall'
  perf trace: Remove unused bpf map 'syscalls'

 tools/perf/builtin-trace.c                    | 131 +++---------------
 .../examples/bpf/augmented_raw_syscalls.c     |  18 ---
 2 files changed, 18 insertions(+), 131 deletions(-)

-- 
2.34.1

