Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1369FC7EE25
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjFLNSO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjFLNSN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 09:18:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFCBBB
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 06:18:09 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qfsg55rJszTl1r;
        Mon, 12 Jun 2023 21:17:37 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 21:18:05 +0800
Date:   Mon, 12 Jun 2023 21:17:50 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Changbin Du <changbin.du@huawei.com>
CC:     Ian Rogers <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <hw.huiwang@huawei.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
Message-ID: <20230612131750.yisfy7zan64beg7y@M910t>
References: <20230609033128.ujodex56vkha2ifr@M910t>
 <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
 <20230612021405.kcaccxchmb5juep4@M910t>
 <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
 <20230612131042.vkwoaucccwdrhl5a@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612131042.vkwoaucccwdrhl5a@M910t>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Attach the debug patch:

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index d5e8cf0dada0..0793c03e7933 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -123,6 +123,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
        size_t line_len = 0;
        int ch = 0;

+       printf("io__getline: start\n");
        /* TODO: reuse previously allocated memory. */
        free(*line_out);
        while (ch != '\n') {
@@ -151,6 +152,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
        line_len += buf_pos;
        *line_out = line;
        *line_len_out = line_len;
+       printf("io__getline: %s\n", line);
        return line_len;
 err_out:
        free(line);
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 638527c8be58..1b1d9b6605e9 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -416,6 +416,8 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
                return NULL;
        }

+       printf("subprocess: addr2line -e %s -a -i -f\n", binary_path);
+
        a2l->pid = -1;
        a2l->in = -1;
        a2l->out = -1;
@@ -467,7 +469,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
                        lines = 3;
                } else {
                        if (!symbol_conf.disable_add2line_warn) {
-                               char *output;
+                               char *output = NULL;
                                size_t output_len;

                                io__getline(&io, &output, &output_len);
@@ -516,6 +518,7 @@ static int read_addr2line_record(struct io *io,
        if (line_nr != NULL)
                *line_nr = 0;

+       printf("read_addr2line_record\n");
        /*
         * Read the first line. Without an error this will be either an address
         * like 0x1234 or for llvm-addr2line the sentinal ',' character.
@@ -632,6 +635,8 @@ static int addr2line(const char *dso_name, u64 addr,
        struct io io;
        enum a2l_style a2l_style;

+       printf("addr2line: %s, addr %lx\n", dso_name, addr);
+
        if (!a2l) {
                if (!filename__has_section(dso_name, ".debug_line"))
                        goto out;


On Mon, Jun 12, 2023 at 09:10:42PM +0800, Changbin Du wrote:
> On Sun, Jun 11, 2023 at 09:05:24PM -0700, Ian Rogers wrote:
> > On Sun, Jun 11, 2023 at 7:14 PM Changbin Du <changbin.du@huawei.com> wrote:
> > >
> > > >On Fri, Jun 09, 2023 at 04:58:24PM -0700, Ian Rogers wrote:
> > > > On Thu, Jun 8, 2023 at 10:13 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > [snip]
> > > > Hi Changbin,
> > > >
> > > > I think I found a way around the problem by enabling address dumping
> > > > from addr2line. I've sent the patches here:
> > > > https://lore.kernel.org/lkml/20230609235419.204624-1-irogers@google.com/
> > > > but only lightly tested them. Could you please take a look and send a
> > > > Tested-by ?
> > > >
> > > > It is probably too late to get this into 6.4.0, but we can add a Fixes
> > > > tag so that it gets picked into 6.4.1. The patches here are on the
> > > > perf-tools-next tree targeting Linux 6.5.
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > Hi Ian,
> > > I applied your patches on mainline, the configuration error is gone, but still
> > > get stuck finally. Here is the back trace.
> > >
> > > #0  0x00001522c92bc392 in __libc_read (fd=..., buf=..., nbytes=...) at ../sysdeps/unix/sysv/linux/read.c:26
> > > #1  0x0000559e6bd0fdfb in read (__nbytes=..., __buf=..., __fd=...) at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> > > #2  io__get_char (io=...) at /work/linux/tools/perf/libapi/include/api/io.h:50
> > > #3  io__getline (line_len_out=..., line_out=..., io=...) at /work/linux/tools/perf/libapi/include/api/io.h:129
> > > #4  read_addr2line_record (io=..., style=..., function=..., filename=..., line_nr=...) at util/srcline.c:523
> > > #5  0x0000559e6bd111b4 in addr2line (dso_name=..., addr=..., file=..., line_nr=..., dso=..., unwind_inlines=..., node=..., sym=...) at util/srcline.c:722
> > > #6  0x0000559e6bd11e77 in addr2inlines (sym=..., dso=..., addr=..., dso_name=...) at util/srcline.c:773
> > > #7  dso__parse_addr_inlines (dso=..., addr=..., sym=...) at util/srcline.c:950
> > > #8  0x0000559e6bcc1de7 in append_inlines (cursor=..., ms=..., ip=...) at util/machine.c:3085
> > > #9  0x0000559e6bcc24e6 in add_callchain_ip (thread=..., cursor=..., parent=..., root_al=..., cpumode=..., ip=..., branch=..., flags=..., iter=..., branch_from=...) at util/machine.c:2375
> > > #10 0x0000559e6bcc3c1a in thread__resolve_callchain_sample (thread=..., cursor=..., evsel=..., sample=..., parent=..., root_al=..., max_stack=...) at util/machine.c:3055
> > > #11 0x0000559e6bcbe817 in sample__resolve_callchain (sample=..., cursor=..., parent=..., evsel=..., al=..., max_stack=...) at util/callchain.c:1098
> > > #12 0x0000559e6bcfb8c0 in hist_entry_iter__add (iter=..., al=..., max_stack_depth=..., arg=...) at util/hist.c:1222
> > > #13 0x0000559e6bbc9951 in process_sample_event (tool=..., event=..., sample=..., evsel=..., machine=...) at builtin-report.c:330
> > > #14 0x0000559e6bcd0193 in perf_session__deliver_event (session=..., event=..., tool=..., file_offset=..., file_path=...) at util/session.c:1645
> > > #15 0x0000559e6bcd5226 in do_flush (show_progress=..., oe=...) at util/ordered-events.c:245
> > > #16 __ordered_events__flush (oe=..., how=..., timestamp=...) at util/ordered-events.c:324
> > > #17 0x0000559e6bcd5a19 in __ordered_events__flush (timestamp=..., how=..., oe=...) at util/ordered-events.c:340
> > > #18 ordered_events__flush (how=..., oe=...) at util/ordered-events.c:342
> > > #19 ordered_events__flush (oe=..., how=...) at util/ordered-events.c:340
> > > #20 0x0000005b0000006e in ?? ()
> > > #21 0x68f3206410bcae00 in ?? ()
> > > #22 0x0000000000000000 in ?? ()
> > 
> > Thanks Changbin, the backtrace shows that perf thinks addr2line is
> > going to write more output. These patches will cause an eventual
> > timeout:
> > https://lore.kernel.org/lkml/20230608061812.3715566-2-irogers@google.com/
> > I'm not sure how this situation can arise. Presumably you are using
> > binutils addr2line. Can you use gdb to work out what dso is causing
> > addr2line to stop like this? My guess would be vmlinux. If you can
> > find the dso and the address that was requested from addr2line, should
> > be in frame 5 in your backtrace, you can repeat the query on the
> > command line to see what addr2line is doing. Hopefully then we can
> > figure out why this caused the sentinel to be broken - the sentinel
> > needs to have address 0 or ',' if LLVM addr2line, or have a filename
> > line number of "??:0".
> >
> I am using binutils addr2line. It's vmlinux causes addr2line stuck. I added some
> logs in perf as below.
> 
> $ ./perf --no-pager report --stdio
> # To display the perf.data header info, please use --header/--header-only options.
> #
> addr2line: /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf, addr ffffffff81e000aa
> subprocess: addr2line -e /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf -a -i -f
> read_addr2line_record
> io__getline: start
> io__getline: 0xffffffff81e000aa
> 
> io__getline: start
> io__getline: entry_SYSCALL_64_after_hwframe
> 
> io__getline: start
> io__getline: ??:?
> 
> read_addr2line_record
> io__getline: start
> io__getline: 0x0000000000000000
> 
> io__getline: start
> io__getline: __per_cpu_start
> 
> io__getline: start
> io__getline: ??:?
> 
> read_addr2line_record
> io__getline: start
> [stuck]
> 
> > Thanks,
> > Ian
> > 
> > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > --
> > > > > > Cheers,
> > > > > > Changbin Du
> > >
> > > --
> > > Cheers,
> > > Changbin Du
> 
> -- 
> Cheers,
> Changbin Du

-- 
Cheers,
Changbin Du
