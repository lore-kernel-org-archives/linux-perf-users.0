Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC81C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiGRQZm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiGRQZc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 12:25:32 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111282AC55
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:25:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso112952707b3.9
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VpWGg1Z0ItsY17Q4CdwHYBm/NTXahJiG/W0stWad/2Q=;
        b=n5EUgG9sYycF9rx9k+w17mzIJ3Pj6DrYXTIL5aEPlPpTtjjOdf1l8Igp1lz1jIDJ5u
         cA2DPALvySRgupdWKOc0onDRiwTQpFXEKgqJDhyTwzaVpWAXlAfpjVEueUBZTNKFyJy4
         6Nf1q/swRCZ7WE6Z5w3uLnq41J/Q8eviEAMCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VpWGg1Z0ItsY17Q4CdwHYBm/NTXahJiG/W0stWad/2Q=;
        b=vBqrUIH8kb5xMzQjJPdDfdXBX3lQelL9VX+gmQj9thS0/ut26SRLxbLqKDyBAyC7Dh
         UHfg+B2TmSxNZZnw3T/nEKHiNWbLPeCTkUqSZY6R5QID20gdJ3busY3D13EBS6k8JQFn
         G4Pkpu3MX6wmIN6sRsj4OhxlqZSD2KMCgOw2wYpQDT+Xevz0bAeqp2SE76khRD+2IqFI
         r5vHiQj7bplFHhlcTnz+RlUCMsv7IrDCk0/A85wez4OxiNDB9nYj2NhH6uBoPny8EqiV
         lcDHn25qNJiHzbDLeIyYR5AOv3RCUMkW2yzILt393PpxkPY4emXUxOwyQRPkV9icpB2J
         oVmg==
X-Gm-Message-State: AJIora9JsacTvMHOggQ1JM/+x8KdOlKYuwGagbbrTxNu7/SyfEEKXYlV
        ArfBiJizcNdLEgjwJjxDbBNLtkbHu9n3ahDv7hLonA==
X-Google-Smtp-Source: AGRyM1vuHM0SfTPb0F/nlCzubE/m1n8j9K1rxYega5fLB3kYc9RJ9h5UWn69E2l7QS82ZzuOj6oMP6Brl3rTdOaLqQM=
X-Received: by 2002:a81:1b15:0:b0:31d:f87f:7ab5 with SMTP id
 b21-20020a811b15000000b0031df87f7ab5mr17976514ywb.104.1658161529300; Mon, 18
 Jul 2022 09:25:29 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 18 Jul 2022 09:25:18 -0700
Message-ID: <CABWYdi2NBSv8sUdFONrYyACa60+W6O3+r5D44OXjftxPySKTXQ@mail.gmail.com>
Subject: Removal of 128MB limit for BPF JIT programs broke perf symbolication
 on aarch64
To:     Russell King <russell.king@oracle.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

We noticed that perf symbolication is broken on aarch64:

ivan@vm:~$ sudo perf_5.10 record -e cpu-clock --cpu 3 -g --call-graph
dwarf -F 11 -- sleep 0.1
ivan@vm:~$ sudo perf_5.10 script
swapper     0 [003]    75.516009:   90909090 cpu-clock:
        ffffffe7fe311808 [unknown] ([unknown])
        ffffffe7fdaf0a60 [unknown] ([unknown])
        ffffffe7fdaf0bdc [unknown] ([unknown])
        ffffffe7fda29538 [unknown] ([unknown])
        ffffffe7fe3253b8 [unknown] ([unknown])

On Linux 5.15 I was able to bisect this to 5.15.18, where this commit
was responsible (b89ddf4cca43 upstream):

* 9c82ce593626 arm64/bpf: Remove 128MB limit for BPF JIT programs

Reverting this commit in 5.15.18 resolves the issue. The issue is also
present in 5.19-rc6.

In addition to that, I noticed that on my personal kernel build this
doesn't happen on any kernel version. After many attempts at config
reconciliation, I narrowed it down to CONFIG_PROC_KCORE. When the
option is enabled and the commit b89ddf4cca43 is present, the stacks
have no kernel symbols.

This seems like a regression.
