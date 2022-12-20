Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D839C41535
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Dec 2022 19:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLTThW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiLTThV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2022 14:37:21 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1D65CE
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 11:37:18 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g3-20020a056e021a2300b00305e3da9585so8894328ile.16
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 11:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtf3kK/4JkO5DVd4qOuGUgyJBsIREUJl3kcqk4Bwjr4=;
        b=lklMCEwv7O0h7UtfOHP6aL5qLXAkG6NIx8EghFsanSZb2Bah9HiQAeEvtIRB5RgvtL
         o6ch5Vl0rf5RcVDkYEpRQPrc2HiEsT/RhTrkiwOWfxs9W0yzIR5QSC4jaQOISlYFqGbG
         IoMjlkv4ZVC87dmSLU9qaNEjZRaQZR6zqBTGPM0aTYPrSM51YpFZvy4puaIj5frVxJGQ
         PqBPsp/4f91B4V39EwIpRsFYoJCZS15CiDeLh88jcHiOHXDBssbkWTbzFitEiahfGVG3
         ljKxjOFbpB7PmJEaWB1fYBavl5BL0qeDCFVD2Eq/JCQ/NimMFEmvymOlUdS+GtwE9iK4
         A8tg==
X-Gm-Message-State: ANoB5plQZYjGQ12vnqE0T6GLq9TQqjxn5Gon+oa8LTCbZXDghtNycX5G
        xeTyga+RMOe+DIpfbTKLC2CChcVc7Y3k2M1FouZk24aF1gHp
X-Google-Smtp-Source: AA0mqf79LM6cuQfmZgkg9I2E8BaJp2XadINP9woNrMjfuuHwCStlay7Ncmm1QjAAXXiaNN1Z3ZOaFyHazaxPHao1vnryZURMltfR
MIME-Version: 1.0
X-Received: by 2002:a92:d8ca:0:b0:303:6b79:14bb with SMTP id
 l10-20020a92d8ca000000b003036b7914bbmr11203430ilo.9.1671565038025; Tue, 20
 Dec 2022 11:37:18 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:37:18 -0800
In-Reply-To: <CAKH8qBs1UiikX=_CBzRC_2rg3sp8CU5hhB7sOkNkNBqm8OqFEw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f881505f047903b@google.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5778 } 2673 jiffies s: 2773 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb0e5d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e91ad4b5f69c47
dashboard link: https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12df6a9b880000

