Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0051C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSVdl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLSVdk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 16:33:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24BCBF72
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 13:33:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c71-20020a621c4a000000b0057e867fbaa3so5624840pfc.16
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpSyaw7IzzUwQ80GRIZq630SjWs043p2tlSn9Ge42Ig=;
        b=DhKrhwDhNxRtLQ4hD30ALjUurCc9f4RCZdls/fWZbnDkFGV2oPx4TdKcSwMlQzk3ie
         A7I9+3NMTLXU8+212DBa1vNyer4MFCX0jZTcRyy4J+tyFISFRojS0FyvlGug4OkYuC9A
         1+UZjithsMA150YT1fPGa9QahyU5h+XnRdZeLNEbw87WRYSBko7IVmUVxr/Oy2p5gWjh
         qovD/lWHY8atDnwTtnZ7FzcssbP2IOIZ9n0RpJ/lJOC6nLG80TULDg5f6WO7KUsw2fBT
         oGRQ7fxsCGKxCHrH13F1IIhB1x/ijKqOPM+WUJYfD7kTXGImxHm0vEQzdJYHUI0WPaqH
         j8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpSyaw7IzzUwQ80GRIZq630SjWs043p2tlSn9Ge42Ig=;
        b=cEyU76O8BwhC60mErPfNBASTWZEo0Pxlj0en/ts7WvrzwRckdxEg15RlfhBoBuZkO+
         tjviUj30nELbIvOD+v9AwZGPVQ8xKaPGbqFFvlMb+wlQ854Zz6hgq3WHMmUyI0s2kPMn
         jdEKpjIqYVLObL/2GXR71fJfHvbgyRL+p9mzOTdkNYQWNabTDEKn0L/acO5g4LvCNYHx
         b87OMKf1GsvLcrnBpUdHuDX6I3xAisLh3Y+66+2WgoC2U88kkj9iUaB/I8ICgtNE1mzx
         r8yz8f1gLWgdPlsw9z8xjSgxK1SJLCDl7sjQX5vrvwhjsvAMuGZ8bbmJhrN1Y5FO42FR
         FyBQ==
X-Gm-Message-State: ANoB5pnF5fNmHmoCltRYSBgLraiLAGbzplxwg1PFj2Lia6/FUc5qiMwH
        ofX4i6tz1kfY6FToeQ71eAgOJ0I=
X-Google-Smtp-Source: AA0mqf6b+8RXnM1FmTTmyMFRRumZB4F9hR7A5n1+1yLtRhrbiaNTaN+QV0AdHzB523/1wMCm59zoDpc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:85cb:0:b0:575:871f:2e7a with SMTP id
 z11-20020aa785cb000000b00575871f2e7amr5047278pfn.35.1671485618298; Mon, 19
 Dec 2022 13:33:38 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:33:36 -0800
In-Reply-To: <00000000000051b79a05f033b6e5@google.com>
Mime-Version: 1.0
References: <Y6C8iQGENUk/XY/A@google.com> <00000000000051b79a05f033b6e5@google.com>
Message-ID: <Y6DYsN+G3mdKP/Bb@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in put_pmu_ctx
From:   sdf@google.com
To:     syzbot <syzbot+b8e8c01c8ade4fe6e48f@syzkaller.appspotmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        bpf@vger.kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/19, syzbot wrote:
> Hello,

> syzbot tried to test the proposed patch but the build/boot failed:

> failed to apply patch:
> checking file kernel/events/core.c
> patch: **** unexpected end of file in patch



> Tested on:

> commit:         13e3c779 Merge tag 'for-netdev' of https://git.kernel...
> git tree:        
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> dashboard link:  
> https://syzkaller.appspot.com/bug?extid=b8e8c01c8ade4fe6e48f
> compiler:
> patch:           
> https://syzkaller.appspot.com/x/patch.diff?x=15861a9f880000


Let's try again with hopefully a better formatted patch..

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git  
13e3c7793e2f

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e47914ac8732..bbff551783e1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12689,7 +12689,8 @@ SYSCALL_DEFINE5(perf_event_open,
  	return event_fd;

  err_context:
-	/* event->pmu_ctx freed by free_event() */
+	put_pmu_ctx(event->pmu_ctx);
+	event->pmu_ctx = NULL; /* _free_event() */
  err_locked:
  	mutex_unlock(&ctx->mutex);
  	perf_unpin_context(ctx);
