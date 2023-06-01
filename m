Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FAC7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 13:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjFANvc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFANvb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 09:51:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B94180
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 06:51:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-651e298be3fso177080b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685627489; x=1688219489;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=coxbV7P2GzCNBRaVW6+2JdmaHILz4+kN/zkbCOLqpuo=;
        b=Yd9SGVj66VlM90+c6INx9+Xtqcz7zSi0zGGnn8tSnB4a/1ieYzQPYZIkeXEydZ5eYp
         My/osqYHgrjS0a27NyVFz0FDtiVTGn9BJkasT6DzfW3BF+Eqoqg+V5wbuq1nktCc31r3
         yabgnNZwC4K32odDrAbMLOPmxwY9eDIHW4j2RSyNltZHljtLvWYZ709UvbV9GEirgoHg
         136NjHTrQNACnXim1huk7wKT8yFtAcG+MimqOMvXV2LXqYNNXjGqKAZ9uTuXjqN541aI
         6ZeRz4qxsZO7r0LY0Q2wdBSPsby82/SC5gVGsGqyWkkEUmqKBWmwZ3W6p51dN5pfbTbu
         ybzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685627489; x=1688219489;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=coxbV7P2GzCNBRaVW6+2JdmaHILz4+kN/zkbCOLqpuo=;
        b=UyE/ftR8pYUxyXV1Egq46qFmWFCcDcDAm38lU2jcxLCHXc1H3JlXWlJOzZ+ratuvcu
         d9Wh1tzN1Lg5iNGsyyVd1XAOh79LlD1GjB3NMqdxa3imyc9NmG+cd/ehQN7wy+rgnHBT
         JERF8cENeIsHBLhGty/EZv/gocwJL9bP2v1pxGL0os/SLaTSJ8RSow4WuvRsV66NmHgZ
         SBTHKFQhqOg81Tb4glcWycjdhNg3MyIUrQjyBQjmvMoqLkdhZ6DBTFopDlNHYNbybQ3q
         TDN01wrUL0BnGXDGOphstiCj9rdA8AHwXxPtoCWxQ9RdJ+AZ54LzquH0+bwBiEBIagvw
         hjWA==
X-Gm-Message-State: AC+VfDyjyvfd0Mye6extSKzZEiouYXtWhGO1RnFYF5X1mQnEG3pvJUdq
        nZZP9toRWGDwEDoi6W47B+MyTE/Kw9k6eZZSIhvmZOQESV4=
X-Google-Smtp-Source: ACHHUZ4NCJKPC8AW5wjrTvlrQZOym6SmGHpm1P197dC4o9jgEheZasjvyq4xwy0L6o9houLcoH7Pt9eqoHJtEHJHauY=
X-Received: by 2002:a05:6a20:938a:b0:10b:e88f:598f with SMTP id
 x10-20020a056a20938a00b0010be88f598fmr12105994pzh.51.1685627489321; Thu, 01
 Jun 2023 06:51:29 -0700 (PDT)
MIME-Version: 1.0
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Thu, 1 Jun 2023 16:51:18 +0300
Message-ID: <CAPXMrf9mRG_uyEdkppJOjJxCREXjZsXGo2A_QEtwHM4G+nJoEA@mail.gmail.com>
Subject: Reg: Perf report consuming too high memory
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi ,

I am noticing high memory usage, oom killer is invoked and restarting
our node while running perf report command.

 perf record -a  -g   sleep 120
[ perf record: Woken up 2472 times to write data ]
[ perf record: Captured and wrote 623.050 MB (3830374 samples) ]

perf report

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 119877 root      20   0 7335760   7.0g 670244 S   0.0  59.7   0:22.23 perf

perf report command is consuming more memory, oom killer is invoked.
System details : kernel 5.4.242 + glibc 2.26 + gcc12
I tried with perf 6.x versions but I still see more memory consumption.

I tried the same experiment on a different system under the same load
, this system has ( kernel 5.4.242 + glibc 2.24 + gcc 11)

perf record -a  -g  sleep 120
[ perf record: Woken up 1868 times to write data ]
[ perf record: Captured and wrote 470.203 MB
/tmp/rcpprofiling/data_cg.data (3828394 samples) ]

perf report

PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
840045 root      20   0 1459520   1.4g 493380 R  98.1  11.8   0:31.21
perf report


I see that the more the perf.data file size, the more  memory it
consumes, but in this case i only see 200MB difference between the
perf.data file and also only 2k sample difference, but memory
consumption is too high in the first system.

What could be the reason, is this expected behaviour or how to debug
why perf is consuming more memory here  . Please help me with this
query .

Thanks,
Rajesh Dasari.
