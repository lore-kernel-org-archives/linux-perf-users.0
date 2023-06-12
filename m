Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2DCC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 04:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjFLEFk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 00:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLEFi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 00:05:38 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC19C
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 21:05:37 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9d619103dso222601cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jun 2023 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686542737; x=1689134737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM54KhV0dctdibcTGgXSwjT/DWQOmqN/AxxhDCQ1d5w=;
        b=chuWSErRYIatBSP26aWRaNllwo/2Wnxfm+Cav1Jg3+hOq+i9R/A2UjHonU7d/QU8Sp
         Jqi8iqFIRZTZ896AtW3cX/ob/Orhby9ytQKLfFAkvcEU0lrErIZjYMtjzrj2iFGduUBo
         MTi+iO/5SnMzuYM31H2W3Sxg+WY7uLTUHI1xnkj5F00NYH4FPu1aFdH6/Albs4zDH7Bb
         Vpnv5A/HnS4ejMTErPn0a1CeotXXcbntz+MVpFHwpwEg2yzSuFvLJPCjCeeJQE9lxo3f
         RfFa8T0j3l/4Fwcx16or8QqDMB9+Bhm+RRV2yDSxrngYkZ1E+8+NXcVOAYU4qUubNIah
         dHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686542737; x=1689134737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM54KhV0dctdibcTGgXSwjT/DWQOmqN/AxxhDCQ1d5w=;
        b=bcYEn1CCFdPgMnRrdOmjUYgoYy4lA/UOwoTW+2506mYa8fqR7lnbocmnRPxh8niVBk
         WrGcHFzbNOgvXU1sSyq8SsJ5+jOeVxI/Z0ejzT70kVMzte3PSChdMYEVBLnPqJ2MIsOk
         hu33LhV0JJSb2WgPm9OFTfc+7uTVuXpSLhxcFx5yzaLW2osWfa2s+oNfZMuEdlyOztNb
         I8d3Z7I/N2m78qQEks32fBQAwlDweqEGV7YXVbPYcE0O+mBEdTymymf845PxDxCYPNVI
         NhJoKedCRdh4zg3NvuP8VSaQPwo26+1PDrS4a8asWV7qzoUWoPSx8OmQREGBNP8qkaWk
         yknw==
X-Gm-Message-State: AC+VfDw1D4TUEwKBVPesoZl8s8mmf3Gf6qNXL5+LiLtraebwqWaUGMJd
        QAelLigLTKedejW2PqNNO1dWlQE10MbvVva86r3hw6I0R51BkhYE9XG7Nw==
X-Google-Smtp-Source: ACHHUZ7VsOixb7v+eTKQXkFfDHG/tLxPMwZR6ZHdsHpIUUOl6rNptPZ4YbMzZAAEs6UeRIMqEmzdzM0Vi0Os15n/vKU=
X-Received: by 2002:a05:622a:54:b0:3ed:86f6:6eab with SMTP id
 y20-20020a05622a005400b003ed86f66eabmr266714qtw.14.1686542736657; Sun, 11 Jun
 2023 21:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t> <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com> <20230612021405.kcaccxchmb5juep4@M910t>
In-Reply-To: <20230612021405.kcaccxchmb5juep4@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 11 Jun 2023 21:05:24 -0700
Message-ID: <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
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

On Sun, Jun 11, 2023 at 7:14=E2=80=AFPM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> >On Fri, Jun 09, 2023 at 04:58:24PM -0700, Ian Rogers wrote:
> > On Thu, Jun 8, 2023 at 10:13=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >
> [snip]
> > Hi Changbin,
> >
> > I think I found a way around the problem by enabling address dumping
> > from addr2line. I've sent the patches here:
> > https://lore.kernel.org/lkml/20230609235419.204624-1-irogers@google.com=
/
> > but only lightly tested them. Could you please take a look and send a
> > Tested-by ?
> >
> > It is probably too late to get this into 6.4.0, but we can add a Fixes
> > tag so that it gets picked into 6.4.1. The patches here are on the
> > perf-tools-next tree targeting Linux 6.5.
> >
> > Thanks,
> > Ian
> >
> Hi Ian,
> I applied your patches on mainline, the configuration error is gone, but =
still
> get stuck finally. Here is the back trace.
>
> #0  0x00001522c92bc392 in __libc_read (fd=3D..., buf=3D..., nbytes=3D...)=
 at ../sysdeps/unix/sysv/linux/read.c:26
> #1  0x0000559e6bd0fdfb in read (__nbytes=3D..., __buf=3D..., __fd=3D...) =
at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> #2  io__get_char (io=3D...) at /work/linux/tools/perf/libapi/include/api/=
io.h:50
> #3  io__getline (line_len_out=3D..., line_out=3D..., io=3D...) at /work/l=
inux/tools/perf/libapi/include/api/io.h:129
> #4  read_addr2line_record (io=3D..., style=3D..., function=3D..., filenam=
e=3D..., line_nr=3D...) at util/srcline.c:523
> #5  0x0000559e6bd111b4 in addr2line (dso_name=3D..., addr=3D..., file=3D.=
.., line_nr=3D..., dso=3D..., unwind_inlines=3D..., node=3D..., sym=3D...) =
at util/srcline.c:722
> #6  0x0000559e6bd11e77 in addr2inlines (sym=3D..., dso=3D..., addr=3D...,=
 dso_name=3D...) at util/srcline.c:773
> #7  dso__parse_addr_inlines (dso=3D..., addr=3D..., sym=3D...) at util/sr=
cline.c:950
> #8  0x0000559e6bcc1de7 in append_inlines (cursor=3D..., ms=3D..., ip=3D..=
.) at util/machine.c:3085
> #9  0x0000559e6bcc24e6 in add_callchain_ip (thread=3D..., cursor=3D..., p=
arent=3D..., root_al=3D..., cpumode=3D..., ip=3D..., branch=3D..., flags=3D=
..., iter=3D..., branch_from=3D...) at util/machine.c:2375
> #10 0x0000559e6bcc3c1a in thread__resolve_callchain_sample (thread=3D...,=
 cursor=3D..., evsel=3D..., sample=3D..., parent=3D..., root_al=3D..., max_=
stack=3D...) at util/machine.c:3055
> #11 0x0000559e6bcbe817 in sample__resolve_callchain (sample=3D..., cursor=
=3D..., parent=3D..., evsel=3D..., al=3D..., max_stack=3D...) at util/callc=
hain.c:1098
> #12 0x0000559e6bcfb8c0 in hist_entry_iter__add (iter=3D..., al=3D..., max=
_stack_depth=3D..., arg=3D...) at util/hist.c:1222
> #13 0x0000559e6bbc9951 in process_sample_event (tool=3D..., event=3D..., =
sample=3D..., evsel=3D..., machine=3D...) at builtin-report.c:330
> #14 0x0000559e6bcd0193 in perf_session__deliver_event (session=3D..., eve=
nt=3D..., tool=3D..., file_offset=3D..., file_path=3D...) at util/session.c=
:1645
> #15 0x0000559e6bcd5226 in do_flush (show_progress=3D..., oe=3D...) at uti=
l/ordered-events.c:245
> #16 __ordered_events__flush (oe=3D..., how=3D..., timestamp=3D...) at uti=
l/ordered-events.c:324
> #17 0x0000559e6bcd5a19 in __ordered_events__flush (timestamp=3D..., how=
=3D..., oe=3D...) at util/ordered-events.c:340
> #18 ordered_events__flush (how=3D..., oe=3D...) at util/ordered-events.c:=
342
> #19 ordered_events__flush (oe=3D..., how=3D...) at util/ordered-events.c:=
340
> #20 0x0000005b0000006e in ?? ()
> #21 0x68f3206410bcae00 in ?? ()
> #22 0x0000000000000000 in ?? ()

Thanks Changbin, the backtrace shows that perf thinks addr2line is
going to write more output. These patches will cause an eventual
timeout:
https://lore.kernel.org/lkml/20230608061812.3715566-2-irogers@google.com/
I'm not sure how this situation can arise. Presumably you are using
binutils addr2line. Can you use gdb to work out what dso is causing
addr2line to stop like this? My guess would be vmlinux. If you can
find the dso and the address that was requested from addr2line, should
be in frame 5 in your backtrace, you can repeat the query on the
command line to see what addr2line is doing. Hopefully then we can
figure out why this caused the sentinel to be broken - the sentinel
needs to have address 0 or ',' if LLVM addr2line, or have a filename
line number of "??:0".

Thanks,
Ian

> >
> > > Thanks,
> > > Ian
> > >
> > > > --
> > > > Cheers,
> > > > Changbin Du
>
> --
> Cheers,
> Changbin Du
