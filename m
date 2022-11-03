Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D8FC43217
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 05:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKCF0Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKCF0T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 01:26:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680E18B02
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 22:26:18 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id q17-20020a5d87d1000000b006d21a9cca67so471318ios.2
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Nov 2022 22:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hubE5cXRc9JuQCcqWhxOGTFZ206SuvXNuCleiqfj7l0=;
        b=UCU0l05bX8WSLXaS2zCdoyqr2xBhPqyqioYOGkIFDL01YX9mIA/5fZpd29Pa6NHuFj
         LcWEbEg34etWKeYvE48jGwj3I+VJQzicdiAZ7QXo2DSvgipjKAayd6OEnjPAXrlIMcLh
         iuT/Ny0Gj5muk9A7SWGJOHf0h7/vRepjWGZL/4BM+Lhr8v6L23D72qj1V7LiEjYq3QWW
         TK86SDQgL7hIfDtfG0C9TDAx8zVef1nhgWQu4glOUyrgHeBuoZH3o8i2ylt8mxI7elPe
         /DyquvzkJHm1PktsBcRFwfkbXCH9Nvx9Izs1bn/JSxmC8q+OtHLDzEy/d+AbSYTrouVD
         mXxw==
X-Gm-Message-State: ACrzQf26Y121PU11fWOivh/4Lr1gjUVYGi/sFo73XMJiIL1UaEN+dQ8d
        u30yBGaIgQi42wGggfdyj/395QlD36td84GOXwvgCxnie6rQ
X-Google-Smtp-Source: AMsMyM7M+gbJ9p2WjkZ9tsLPHEN9g++/Bo3XU4yPT5uBfhfhLwrxINRWSCpGkuwwLFqDERYuy5PPDkBauLfSwc6aEbOSjHRRHa64
MIME-Version: 1.0
X-Received: by 2002:a92:cc49:0:b0:300:d9d7:fe36 with SMTP id
 t9-20020a92cc49000000b00300d9d7fe36mr860359ilq.225.1667453177891; Wed, 02 Nov
 2022 22:26:17 -0700 (PDT)
Date:   Wed, 02 Nov 2022 22:26:17 -0700
In-Reply-To: <000000000000e9df4305ec7a3fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005912d405ec8a329c@google.com>
Subject: Re: [syzbot] WARNING in __perf_event_overflow
From:   syzbot <syzbot+589d998651a580e6135d@syzkaller.appspotmail.com>
To:     acme@kernel.org, alex.williamson@redhat.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        cohuck@redhat.com, dvyukov@google.com, elver@google.com,
        jgg@ziepe.ca, jolsa@kernel.org, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, shameerali.kolothum.thodi@huawei.com,
        syzkaller-bugs@googlegroups.com, yishaih@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

syzbot has bisected this issue to:

commit c1d050b0d169fd60c8acef157db53bd4e3141799
Author: Yishai Hadas <yishaih@nvidia.com>
Date:   Thu Sep 8 18:34:45 2022 +0000

    vfio/mlx5: Create and destroy page tracker object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136eb2da880000
start commit:   88619e77b33d net: stmmac: rk3588: Allow multiple gmac cont..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10eeb2da880000
console output: https://syzkaller.appspot.com/x/log.txt?x=176eb2da880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=589d998651a580e6135d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eabcea880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f7e632880000

Reported-by: syzbot+589d998651a580e6135d@syzkaller.appspotmail.com
Fixes: c1d050b0d169 ("vfio/mlx5: Create and destroy page tracker object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
