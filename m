Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C60C001B2
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 22:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiLSWYT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiLSWYS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 17:24:18 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593029FEE
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso4697132iow.15
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 14:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76mJq/l4HZlpTiL5oLX0kKwVOqHktPVtqBnvtIS30Wc=;
        b=pYanMy7ypIhswXQMbA7gdCVM2n3KEq7mzcUYalFhX0yvJv3vCqE3GwIRe80ohzDxNg
         Eb+TS1+8wWMQOOYPnt07c0hsJZlsFBOHvIg4lJ9bXjXX/RlqTlDddTHaUv6GhteM0Cex
         /ZArzv1mEqhaK0IrTeCyLFAWTL4WOwyCoAfjb9HmY4i1PWkm7rGRSIEsueC68IxhlqXE
         ArNw0uE/YpUo+/2MF8wm5gAPAZZCpr7PqNSaGeYHsmAipFMMuxoafem7L6WNJJX3QVWn
         dFWAtLdIekD41Muroa/1VFrmGP3HBxniLiHHS61st7gmBG7Boo6pqzz5mfPwXoYDgza+
         O+Ig==
X-Gm-Message-State: ANoB5pnmzkgrbmjrUOVLVg7hhVCJwF9pe5M4daVtCv7PBYPjIBr+4pFD
        CLvpkeo8lYLCPjDLN/S+MYQVP0620j8PF3+WhZ9p12h/DVDw
X-Google-Smtp-Source: AA0mqf5koWrdgDmYUjh4xKAo1ta9oaVFjF3Be9Dw1NrhXCgSKhjJG/4FuFiOWekR09ThaBrobDJVV94M5L5993+HxdV02lC9kQwo
MIME-Version: 1.0
X-Received: by 2002:a05:6602:42c2:b0:6e0:117f:f0a7 with SMTP id
 ce2-20020a05660242c200b006e0117ff0a7mr9222393iob.127.1671488656681; Mon, 19
 Dec 2022 14:24:16 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:24:16 -0800
In-Reply-To: <Y6DYsN+G3mdKP/Bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0afac05f035c7a0@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1451cef0480000

