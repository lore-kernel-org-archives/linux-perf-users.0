Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E61C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 19:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiLST40 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiLST4R (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 14:56:17 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4B11C2E
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 11:56:17 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f23-20020a5d8157000000b006dfb209094fso4543026ioo.18
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 11:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj5G7w7wrnXTjWG4Lf9C2ODteMMiP5v7wAraEGH3U0k=;
        b=JF5808TaP2SOTusizkMvhi3SPDX+WnAEfYUP/dm8QW4dULtrdXrBxRelvTK1saSyoQ
         SQWEHRO2Bw0VxIGTX1YOPhV+Qe6cstmn/xlt31wn+o2GT+xGInCgCGeouD0YKjxliHcj
         NA7iGvA1nILqQY9j4wSaPsNyx2ZK4VgL92jW9HDNvmz47NY4qLC14zO5iOAQzQsknoTQ
         T6Yiy3xZ2Ykdzk5oFMyA6fOTzn5rSGU3QGH5w5xloeRpmV9CiifDVEoWEXJwPC7MfaBm
         aDe8UZKYlB6f0QSclUcDJyjgd9+qaljIvuMpP7QJ2f9ZKgNRL2Lid8LB71xklcPfYdVg
         cEjQ==
X-Gm-Message-State: ANoB5pkQ4XVLY4+5zctzeP8DtRgBiBlFUWKNvRl3aW8a6Cy0R/nIkGhd
        I96OkIJzF0ZCfVXfdgWXTXD4nbZfNsfDPCqXn2wgd3LOx+r2
X-Google-Smtp-Source: AA0mqf7eE0GC/Cb+W5QzJIxt46Tbcb3KvugY9SCOhpmm/M5g7dQmZkOk8OKjjh9bxyYHJeuaULjQLcDPviCk4OX2G41hWkxQ25I2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c1:b0:303:7f25:72c with SMTP id
 v1-20020a056e0213c100b003037f25072cmr7289815ilj.221.1671479776357; Mon, 19
 Dec 2022 11:56:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 11:56:16 -0800
In-Reply-To: <Y6C8iQGENUk/XY/A@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051b79a05f033b6e5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sdf@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/events/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15861a9f880000

