Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16BC54EBE
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjAMPhw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjAMPh2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 10:37:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0492FBC368;
        Fri, 13 Jan 2023 07:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 475E2B82170;
        Fri, 13 Jan 2023 15:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A360DC433F0;
        Fri, 13 Jan 2023 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623799;
        bh=Pn5X1oiGkT2ioXSPvzox4F8ZHW3ijQ1na48kZXX6018=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LoIVDCANAV18PecHmA+Nt5UTHRJraooFDQ2iwjRH9aL2jxGB0l05J1A8YmxNj0ph/
         L26hVJQY+70da4A4wkTF2HTlZsX/l5DZY3WZ1z5rbZS2Q+ZMaJqk+ohyMoZOvpVZHc
         URcymXgdegg88ZIPl1xQqwNhHJKFxMyGoAY5zvE81yh0fWvMpjSUVFsyJ7Xg6E32zL
         S209VWE8+/XLRZerPQ4vwnWPx4vvwcegVsqU5ldTYDpeCrgO7G8AbzjgQwyGsY8DAn
         W6EMlUhxAiKc+TqiS9GilVY6qWf+Q4UdOHdrMqylj4FGKY5hm9LHpZqJQhAi9tz8Pw
         rqiNLYKCztTRg==
Date:   Sat, 14 Jan 2023 00:29:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     luolongjun@huawei.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sangyan@huawei.com,
        luanjianhai@huawei.com, zhuling8@huawei.com, lizongwu@huawei.com,
        luolongjuna@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
        oleg@redhat.com
Subject: Re: [PATCH] uprobes: list all active uprobes in the system
Message-Id: <20230114002954.199fe4c699d2ccc0591a4b66@kernel.org>
In-Reply-To: <b4109593-1aa9-bf7a-cb1b-3ccd586f31d6@amd.com>
References: <20230111104825.1945418-1-luolongjun@huawei.com>
        <b4109593-1aa9-bf7a-cb1b-3ccd586f31d6@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 13 Jan 2023 09:33:41 +0530
Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> +cc: Steven, Oleg, Masami
> 
> On 11-Jan-23 4:18 PM, luolongjun@huawei.com wrote:
> > From: Longjun Luo <luolongjun@huawei.com>
> > 
> > Since uprobes will replace instructions in the process
> > memory, it is necessary to provide one way to list
> > all active uprobes. One can access this file through
> > /sys/kernel/debug/uprobes/list.
> > 
> > Output looks like this
> > =====================
> > inode+offset/ref_ctr_offset    4160760670+0x30a10/0x0
> >     ref                        1
> >     register_rwsem             (unlocked)
> >     consumer_rwsem             (unlocked)
> >     consumers-1
> >         handler                0xffffffffc03ee02e(handler) uprobe
> >         ret_handler            0x0000000000000000( )
> >         filter                 0xffffffffc03ee010(filter) uprobe
> >     consumers-2
> >         handler                0xffffffffc03e902e(handler_1) uprobe_1
> >         ret_handler            0x0000000000000000( )
> >         filter                 0xffffffffc03e9010(filter_1) uprobe_1
> 
> You can list uprobes via /sys/kernel/tracing/uprobe_events. Any specific reason
> to introduce another way?

Note that /sys/kernel/tracing/uprobe_events is only for the uprobes defined
by ftrace, it doesn't include the uprobes registered by out-of-tree modules.

Thank you,

> 
> Thanks,
> Ravi


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
