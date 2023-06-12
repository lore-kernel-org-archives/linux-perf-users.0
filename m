Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0910EC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 02:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjFLCO0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jun 2023 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjFLCOZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jun 2023 22:14:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B31BB
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 19:14:23 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QfZvj1mfBzLmjC;
        Mon, 12 Jun 2023 10:12:33 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 10:14:20 +0800
Date:   Mon, 12 Jun 2023 10:14:05 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Ian Rogers <irogers@google.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <hw.huiwang@huawei.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
Message-ID: <20230612021405.kcaccxchmb5juep4@M910t>
References: <20230609033128.ujodex56vkha2ifr@M910t>
 <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>On Fri, Jun 09, 2023 at 04:58:24PM -0700, Ian Rogers wrote:
> On Thu, Jun 8, 2023 at 10:13 PM Ian Rogers <irogers@google.com> wrote:
>
[snip]
> Hi Changbin,
> 
> I think I found a way around the problem by enabling address dumping
> from addr2line. I've sent the patches here:
> https://lore.kernel.org/lkml/20230609235419.204624-1-irogers@google.com/
> but only lightly tested them. Could you please take a look and send a
> Tested-by ?
> 
> It is probably too late to get this into 6.4.0, but we can add a Fixes
> tag so that it gets picked into 6.4.1. The patches here are on the
> perf-tools-next tree targeting Linux 6.5.
> 
> Thanks,
> Ian
>
Hi Ian,
I applied your patches on mainline, the configuration error is gone, but still
get stuck finally. Here is the back trace.

#0  0x00001522c92bc392 in __libc_read (fd=..., buf=..., nbytes=...) at ../sysdeps/unix/sysv/linux/read.c:26
#1  0x0000559e6bd0fdfb in read (__nbytes=..., __buf=..., __fd=...) at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
#2  io__get_char (io=...) at /work/linux/tools/perf/libapi/include/api/io.h:50
#3  io__getline (line_len_out=..., line_out=..., io=...) at /work/linux/tools/perf/libapi/include/api/io.h:129
#4  read_addr2line_record (io=..., style=..., function=..., filename=..., line_nr=...) at util/srcline.c:523
#5  0x0000559e6bd111b4 in addr2line (dso_name=..., addr=..., file=..., line_nr=..., dso=..., unwind_inlines=..., node=..., sym=...) at util/srcline.c:722
#6  0x0000559e6bd11e77 in addr2inlines (sym=..., dso=..., addr=..., dso_name=...) at util/srcline.c:773
#7  dso__parse_addr_inlines (dso=..., addr=..., sym=...) at util/srcline.c:950
#8  0x0000559e6bcc1de7 in append_inlines (cursor=..., ms=..., ip=...) at util/machine.c:3085
#9  0x0000559e6bcc24e6 in add_callchain_ip (thread=..., cursor=..., parent=..., root_al=..., cpumode=..., ip=..., branch=..., flags=..., iter=..., branch_from=...) at util/machine.c:2375
#10 0x0000559e6bcc3c1a in thread__resolve_callchain_sample (thread=..., cursor=..., evsel=..., sample=..., parent=..., root_al=..., max_stack=...) at util/machine.c:3055
#11 0x0000559e6bcbe817 in sample__resolve_callchain (sample=..., cursor=..., parent=..., evsel=..., al=..., max_stack=...) at util/callchain.c:1098
#12 0x0000559e6bcfb8c0 in hist_entry_iter__add (iter=..., al=..., max_stack_depth=..., arg=...) at util/hist.c:1222
#13 0x0000559e6bbc9951 in process_sample_event (tool=..., event=..., sample=..., evsel=..., machine=...) at builtin-report.c:330
#14 0x0000559e6bcd0193 in perf_session__deliver_event (session=..., event=..., tool=..., file_offset=..., file_path=...) at util/session.c:1645
#15 0x0000559e6bcd5226 in do_flush (show_progress=..., oe=...) at util/ordered-events.c:245
#16 __ordered_events__flush (oe=..., how=..., timestamp=...) at util/ordered-events.c:324
#17 0x0000559e6bcd5a19 in __ordered_events__flush (timestamp=..., how=..., oe=...) at util/ordered-events.c:340
#18 ordered_events__flush (how=..., oe=...) at util/ordered-events.c:342
#19 ordered_events__flush (oe=..., how=...) at util/ordered-events.c:340
#20 0x0000005b0000006e in ?? ()
#21 0x68f3206410bcae00 in ?? ()
#22 0x0000000000000000 in ?? ()

> 
> > Thanks,
> > Ian
> >
> > > --
> > > Cheers,
> > > Changbin Du

-- 
Cheers,
Changbin Du
