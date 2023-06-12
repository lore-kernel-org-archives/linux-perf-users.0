Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F3C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 15:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFLPzo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjFLPz2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 11:55:28 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9ECA
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 08:55:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9b7de94e7so425311cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686585326; x=1689177326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXHCgxZQ1zqngM1AlfpHPZmvdgYNnUANg7XIuSRhnSI=;
        b=gPspn1vwADse0AezaKgtpD5ISI9xeUlg/ic2KEj/1ZZ8lQiygpw3ktpQK1Fn5/7ahy
         8TBkauCdEDh86xP8VswHdWMGo7/N1S+xo7YAhj4Jm4YQVsS9/pDhQX7NoOZyxF9QgIF7
         MWOCr6M4vq2UsYqSYerPoZxLCuoajpKGqACamr4Dbm7zN2d+woR2UOq73amvwzQkgMFI
         TXBEgijbQaXhUgKY8IVolCfntg3Kjh5KB5qNZDUO8DDNxC2KHmsC2x+W1R0aXaKb/8o3
         EHimswKKidbV6D00tjBvlC1seUeUHCs/tb8BAzql5hNJ9ptM14TzFiKQ1D3GJMS6kEzA
         gWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585326; x=1689177326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXHCgxZQ1zqngM1AlfpHPZmvdgYNnUANg7XIuSRhnSI=;
        b=XR2sjepp8mdPMT1Sk+Q3Tu21yGkoZIR3iOM/Xx36IVQLCEv3o5MYBIFfTsvXNBHKUS
         Wm26CaB4tQncb5FxOLoF78W2rLFWIT7sjET5cDzIQ06toXIGs/XBBEEAk8WZRZX2lWpH
         CXGfIpnZ4UlNjK8QSj6Wkee3m6b0mR5qDtz7qDlYsaYI8MXNlbr/cU29m+0q2NPUFY2W
         y+rb4Z6fV8rDu2gcaoMM7LvGsijZmGhLubcFufyWI0DGd6B2QALcSX1U5a94J80SM8RO
         i30zoltWI3ToIxeTBOfpPky/auCoeH9nm7p6YfS9ascOQCAEKNBWW5KNbTMxs6mK2e6q
         CTOg==
X-Gm-Message-State: AC+VfDx5MMjKurApZuyu9uhviuywkHuUnwq/9kn+bidr411QoQbUVaNx
        i52bXcFENEdQg1N638sGIu7za8W33he3p7wZcVOtTNvDXSxK1pBx6LOMSw==
X-Google-Smtp-Source: ACHHUZ5QwN2OhyCEdpMQv9t4TmrelVqxuchjFU5fvPCdAj5h4lfGtWiV9op1CoBjyHZgOICmYdgSrSwth670nLqE3/I=
X-Received: by 2002:a05:622a:189b:b0:3f8:5b2:aef0 with SMTP id
 v27-20020a05622a189b00b003f805b2aef0mr377038qtc.24.1686585326092; Mon, 12 Jun
 2023 08:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t> <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
 <20230612021405.kcaccxchmb5juep4@M910t> <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
 <20230612131042.vkwoaucccwdrhl5a@M910t> <20230612131750.yisfy7zan64beg7y@M910t>
In-Reply-To: <20230612131750.yisfy7zan64beg7y@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 08:55:14 -0700
Message-ID: <CAP-5=fWdvMVOiZDhqiz1R9hucz+6+ho_L3jBixqP3YLcJD7Lew@mail.gmail.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
To:     Changbin Du <changbin.du@huawei.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        hw.huiwang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 6:18=E2=80=AFAM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> Attach the debug patch:
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index d5e8cf0dada0..0793c03e7933 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -123,6 +123,7 @@ static inline ssize_t io__getline(struct io *io, char=
 **line_out, size_t *line_l
>         size_t line_len =3D 0;
>         int ch =3D 0;
>
> +       printf("io__getline: start\n");
>         /* TODO: reuse previously allocated memory. */
>         free(*line_out);
>         while (ch !=3D '\n') {
> @@ -151,6 +152,7 @@ static inline ssize_t io__getline(struct io *io, char=
 **line_out, size_t *line_l
>         line_len +=3D buf_pos;
>         *line_out =3D line;
>         *line_len_out =3D line_len;
> +       printf("io__getline: %s\n", line);
>         return line_len;
>  err_out:
>         free(line);
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 638527c8be58..1b1d9b6605e9 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -416,6 +416,8 @@ static struct child_process *addr2line_subprocess_ini=
t(const char *addr2line_pat
>                 return NULL;
>         }
>
> +       printf("subprocess: addr2line -e %s -a -i -f\n", binary_path);
> +
>         a2l->pid =3D -1;
>         a2l->in =3D -1;
>         a2l->out =3D -1;
> @@ -467,7 +469,7 @@ static enum a2l_style addr2line_configure(struct chil=
d_process *a2l, const char
>                         lines =3D 3;
>                 } else {
>                         if (!symbol_conf.disable_add2line_warn) {
> -                               char *output;
> +                               char *output =3D NULL;
>                                 size_t output_len;
>
>                                 io__getline(&io, &output, &output_len);
> @@ -516,6 +518,7 @@ static int read_addr2line_record(struct io *io,
>         if (line_nr !=3D NULL)
>                 *line_nr =3D 0;
>
> +       printf("read_addr2line_record\n");
>         /*
>          * Read the first line. Without an error this will be either an a=
ddress
>          * like 0x1234 or for llvm-addr2line the sentinal ',' character.
> @@ -632,6 +635,8 @@ static int addr2line(const char *dso_name, u64 addr,
>         struct io io;
>         enum a2l_style a2l_style;
>
> +       printf("addr2line: %s, addr %lx\n", dso_name, addr);
> +
>         if (!a2l) {
>                 if (!filename__has_section(dso_name, ".debug_line"))
>                         goto out;
>
>
> On Mon, Jun 12, 2023 at 09:10:42PM +0800, Changbin Du wrote:
> > On Sun, Jun 11, 2023 at 09:05:24PM -0700, Ian Rogers wrote:
> > > On Sun, Jun 11, 2023 at 7:14=E2=80=AFPM Changbin Du <changbin.du@huaw=
ei.com> wrote:
> > > >
> > > > >On Fri, Jun 09, 2023 at 04:58:24PM -0700, Ian Rogers wrote:
> > > > > On Thu, Jun 8, 2023 at 10:13=E2=80=AFPM Ian Rogers <irogers@googl=
e.com> wrote:
> > > > >
> > > > [snip]
> > > > > Hi Changbin,
> > > > >
> > > > > I think I found a way around the problem by enabling address dump=
ing
> > > > > from addr2line. I've sent the patches here:
> > > > > https://lore.kernel.org/lkml/20230609235419.204624-1-irogers@goog=
le.com/
> > > > > but only lightly tested them. Could you please take a look and se=
nd a
> > > > > Tested-by ?
> > > > >
> > > > > It is probably too late to get this into 6.4.0, but we can add a =
Fixes
> > > > > tag so that it gets picked into 6.4.1. The patches here are on th=
e
> > > > > perf-tools-next tree targeting Linux 6.5.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > Hi Ian,
> > > > I applied your patches on mainline, the configuration error is gone=
, but still
> > > > get stuck finally. Here is the back trace.
> > > >
> > > > #0  0x00001522c92bc392 in __libc_read (fd=3D..., buf=3D..., nbytes=
=3D...) at ../sysdeps/unix/sysv/linux/read.c:26
> > > > #1  0x0000559e6bd0fdfb in read (__nbytes=3D..., __buf=3D..., __fd=
=3D...) at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> > > > #2  io__get_char (io=3D...) at /work/linux/tools/perf/libapi/includ=
e/api/io.h:50
> > > > #3  io__getline (line_len_out=3D..., line_out=3D..., io=3D...) at /=
work/linux/tools/perf/libapi/include/api/io.h:129
> > > > #4  read_addr2line_record (io=3D..., style=3D..., function=3D..., f=
ilename=3D..., line_nr=3D...) at util/srcline.c:523
> > > > #5  0x0000559e6bd111b4 in addr2line (dso_name=3D..., addr=3D..., fi=
le=3D..., line_nr=3D..., dso=3D..., unwind_inlines=3D..., node=3D..., sym=
=3D...) at util/srcline.c:722
> > > > #6  0x0000559e6bd11e77 in addr2inlines (sym=3D..., dso=3D..., addr=
=3D..., dso_name=3D...) at util/srcline.c:773
> > > > #7  dso__parse_addr_inlines (dso=3D..., addr=3D..., sym=3D...) at u=
til/srcline.c:950
> > > > #8  0x0000559e6bcc1de7 in append_inlines (cursor=3D..., ms=3D..., i=
p=3D...) at util/machine.c:3085
> > > > #9  0x0000559e6bcc24e6 in add_callchain_ip (thread=3D..., cursor=3D=
..., parent=3D..., root_al=3D..., cpumode=3D..., ip=3D..., branch=3D..., fl=
ags=3D..., iter=3D..., branch_from=3D...) at util/machine.c:2375
> > > > #10 0x0000559e6bcc3c1a in thread__resolve_callchain_sample (thread=
=3D..., cursor=3D..., evsel=3D..., sample=3D..., parent=3D..., root_al=3D..=
., max_stack=3D...) at util/machine.c:3055
> > > > #11 0x0000559e6bcbe817 in sample__resolve_callchain (sample=3D..., =
cursor=3D..., parent=3D..., evsel=3D..., al=3D..., max_stack=3D...) at util=
/callchain.c:1098
> > > > #12 0x0000559e6bcfb8c0 in hist_entry_iter__add (iter=3D..., al=3D..=
., max_stack_depth=3D..., arg=3D...) at util/hist.c:1222
> > > > #13 0x0000559e6bbc9951 in process_sample_event (tool=3D..., event=
=3D..., sample=3D..., evsel=3D..., machine=3D...) at builtin-report.c:330
> > > > #14 0x0000559e6bcd0193 in perf_session__deliver_event (session=3D..=
., event=3D..., tool=3D..., file_offset=3D..., file_path=3D...) at util/ses=
sion.c:1645
> > > > #15 0x0000559e6bcd5226 in do_flush (show_progress=3D..., oe=3D...) =
at util/ordered-events.c:245
> > > > #16 __ordered_events__flush (oe=3D..., how=3D..., timestamp=3D...) =
at util/ordered-events.c:324
> > > > #17 0x0000559e6bcd5a19 in __ordered_events__flush (timestamp=3D...,=
 how=3D..., oe=3D...) at util/ordered-events.c:340
> > > > #18 ordered_events__flush (how=3D..., oe=3D...) at util/ordered-eve=
nts.c:342
> > > > #19 ordered_events__flush (oe=3D..., how=3D...) at util/ordered-eve=
nts.c:340
> > > > #20 0x0000005b0000006e in ?? ()
> > > > #21 0x68f3206410bcae00 in ?? ()
> > > > #22 0x0000000000000000 in ?? ()
> > >
> > > Thanks Changbin, the backtrace shows that perf thinks addr2line is
> > > going to write more output. These patches will cause an eventual
> > > timeout:
> > > https://lore.kernel.org/lkml/20230608061812.3715566-2-irogers@google.=
com/
> > > I'm not sure how this situation can arise. Presumably you are using
> > > binutils addr2line. Can you use gdb to work out what dso is causing
> > > addr2line to stop like this? My guess would be vmlinux. If you can
> > > find the dso and the address that was requested from addr2line, shoul=
d
> > > be in frame 5 in your backtrace, you can repeat the query on the
> > > command line to see what addr2line is doing. Hopefully then we can
> > > figure out why this caused the sentinel to be broken - the sentinel
> > > needs to have address 0 or ',' if LLVM addr2line, or have a filename
> > > line number of "??:0".
> > >
> > I am using binutils addr2line. It's vmlinux causes addr2line stuck. I a=
dded some
> > logs in perf as below.
> >
> > $ ./perf --no-pager report --stdio
> > # To display the perf.data header info, please use --header/--header-on=
ly options.
> > #
> > addr2line: /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d=
6fa3776974b54/elf, addr ffffffff81e000aa
> > subprocess: addr2line -e /home/changbin/.debug/.build-id/5e/2fa721660d6=
63f38b6e1aa98d6fa3776974b54/elf -a -i -f
> > read_addr2line_record
> > io__getline: start
> > io__getline: 0xffffffff81e000aa
> >
> > io__getline: start
> > io__getline: entry_SYSCALL_64_after_hwframe
> >
> > io__getline: start
> > io__getline: ??:?
> >
> > read_addr2line_record
> > io__getline: start
> > io__getline: 0x0000000000000000
> >
> > io__getline: start
> > io__getline: __per_cpu_start
> >
> > io__getline: start
> > io__getline: ??:?
> >
> > read_addr2line_record
> > io__getline: start
> > [stuck]

Thanks Changbin, this should have hit the 0x0...0 sentinel match:

https://lore.kernel.org/lkml/20230609235419.204624-2-irogers@google.com/
+ } else {
+ int zero_count =3D 0, non_zero_count =3D 0;
+
+ /* The address should always start 0x. */
+ if (line_len < 2 || line[0] !=3D '0' || line[1] !=3D 'x')
+ goto error;
+
+ for (size_t i =3D 2; i < line_len; i++) {
+ if (line[i] =3D=3D '0')
+ zero_count++;
+ else
+ non_zero_count++;
+ }
+ if (!non_zero_count) {
+ int ch;
+
+ if (!zero_count) {
+ /* Line was erroneous just '0x'. */
+ goto error;
+ }
+ /*
+ * Line was 0x0..0, the sentinel for binutils. Remove
+ * the function and filename lines.
+ */
+ zfree(&line);
+ do {
+ ch =3D io__get_char(io);
+ } while (ch > 0 && ch !=3D '\n');
+ do {
+ ch =3D io__get_char(io);
+ } while (ch > 0 && ch !=3D '\n');
+ return 0;
+ }
  }

That doesn't use io__getline - so we've not matched the 0x0...0 case
to terminate the records. Could you add some logging/debug?

Thanks,
Ian

> > > Thanks,
> > > Ian
> > >
> > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > > --
> > > > > > > Cheers,
> > > > > > > Changbin Du
> > > >
> > > > --
> > > > Cheers,
> > > > Changbin Du
> >
> > --
> > Cheers,
> > Changbin Du
>
> --
> Cheers,
> Changbin Du
