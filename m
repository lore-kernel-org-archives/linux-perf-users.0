Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1886CC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Dec 2022 08:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiLTInb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 03:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLTIn1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2022 03:43:27 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015916589
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 00:43:26 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h9-20020a92c269000000b00303494c4f3eso7984019ild.15
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 00:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77qvNoQqle0MfKLDQMi01YZLkngrkg9aZffzgWoC0vY=;
        b=PNJSo+4q2z/5NGTh8Yc+HhLoMRMRrT77xFYGTZ4PAI8rRrp+W56lMG3OLrxmAjAyU9
         M1lMDhFAXL5R/Bmbs8bBGDsM31dG85w8x42vd8wmF51ds9JY6qLlpfBuFdgnHolCokE2
         C5yvzGQsk2A0yyqZszTh7Ca/gWTbAGMNi1kZfb6kNNqK7/tFWdohnkzwp8fqgA0gVSRb
         EdzOneN2ND0+UsAlYE53f0ZkvVeEjSqZq3oBTqkrMIDs/Dxqzoc64fOYAJEwZaomVeqH
         aGDM8dmJ1KTjFsfb7GHnqheBq+6iaZCh/7n4uJPJgYVUOxocQgyLFRtVkjtf+z8v3L5y
         LQyg==
X-Gm-Message-State: ANoB5pk3IJhIuF1cc4wa7eaQwmUgbitPJk7xrJ24kTgKsuy1juLWYrZm
        KlCqhPr/NfvvEGnHX0HjaI8vUxpsv/1xTl/fF5ljQup4//nx
X-Google-Smtp-Source: AA0mqf4KHT2PjH0rudr1knR4xY3Cueu+ZSBoGTVC3IgyDsnWzkduYtWlNbZNuj+1lcG9wQRkygZ76sBT0PKeMjXcG8DlWn7Oafxq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:303:129a:8157 with SMTP id
 s10-20020a056e02216a00b00303129a8157mr28409262ilv.38.1671525805458; Tue, 20
 Dec 2022 00:43:25 -0800 (PST)
Date:   Tue, 20 Dec 2022 00:43:25 -0800
In-Reply-To: <Y6Fxfw5fhHhQYaSd@hirez.programming.kicks-ass.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de0f0b05f03e6d9b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5791 } 2673 jiffies s: 2805 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121ea2e8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d4ad4f880000

