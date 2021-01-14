Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30057C433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01CD239FF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jan 2021 08:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbhANI5a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbhANI5a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Jan 2021 03:57:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364CC061575
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jan 2021 00:56:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b26so6950612lff.9
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jan 2021 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1E1n9ls/Jizk4ccRGhvDXVi/5S2NPJZO9UA85OCBVM=;
        b=GWmBNhmraFw89RyOYee8i9tZL/aqVKV2SfMJHkNhV93oJzG6cuJya/CuQ7rAqoKPZ/
         qYANREzqPEmY9a6nub4MbrG3fn3QPCBGTbMu33R4Q8tKe5ZF82wpoPnqfTP6Rfn4Xv+Y
         053XHjtylbnDq4XSjclCBlVYWd0dNK/uT7Ge7imwlG1mbNWEjBtX5MADJFAASG8PvLOd
         q6b/9Xm9KmTxLMIEMw+9zVcI/R3tTersW1SpLLkwsiW68zVkesbTFhs+QvP5H4BLdYxo
         Qemv3P8SsUEN7yMtVyZss18qUwAf0CLheh1UskrGQG80V3edGq3p/epItqPO58SdMGi4
         41XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1E1n9ls/Jizk4ccRGhvDXVi/5S2NPJZO9UA85OCBVM=;
        b=ewaJbmEUPYcpV9K2FskKwHDEQZt1bMLYVdBfrqUyxW7Pi8OCc9gRhvOJG5ha1dymmZ
         WhQdzdD1Hnz3Zk6mOJr5Vq9f6SkGCbOLP5Gf3Gmw21lICgRcybSBje/34s79lGT3Pvhy
         ObaKI06brJbL21zVTJmCC5w10I9Yd8t6ywbYPUaqzqdq2nXkEveIzBv/Z0BgUFMLDxkh
         /o7EL+Pt6n4LR2oCD0T+eczSGi2+zr0mgfFaN846afGfotTVY+GFFFAUok6UmeG87yxO
         4s+YKLTphkn8tNCoBMr2iJ4qB8mNS7YjZOj67jiHhT+a8kq7JGtWKX6z9kq5j75jLMRD
         mvIg==
X-Gm-Message-State: AOAM531Ea3aX9YoO9qfZbQfuxXMJRaKGO1quwxuVwW8MxG3mC88EDenK
        AEW1fCeUovRwGYoPacd08AVNBoZVnrptyAGMwCw=
X-Google-Smtp-Source: ABdhPJyQxkpfhSdusGCN3UmfgyprBL4+OIOwcrko2z0ddJdjxqlVxOseDJ/m1ucJzv6xR3lOvKbfjfUaUbJyFx3zeVU=
X-Received: by 2002:ac2:50d0:: with SMTP id h16mr2811702lfm.300.1610614607866;
 Thu, 14 Jan 2021 00:56:47 -0800 (PST)
MIME-Version: 1.0
References: <8218693.uYs0DeGetE@milian-workstation> <3012158.k929uczAvT@milian-workstation>
 <20210113184554.GB1358609@krava> <4450842.bcbERlpMrJ@milian-workstation>
In-Reply-To: <4450842.bcbERlpMrJ@milian-workstation>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 14 Jan 2021 17:56:36 +0900
Message-ID: <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
To:     Milian Wolff <mail@milianw.de>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, Jan 14, 2021 at 4:24 AM Milian Wolff <mail@milianw.de> wrote:
>
> On Mittwoch, 13. Januar 2021 19:45:54 CET Jiri Olsa wrote:
> > On Wed, Jan 13, 2021 at 06:47:22PM +0100, Milian Wolff wrote:
> > > On Mittwoch, 13. Januar 2021 11:30:31 CET Jiri Olsa wrote:
> > > > On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> > > > > Hey there,
> > > > >
> > > > > in hotspot I noticed a symbolization bug for perf.data files that are
> > > > > recorded without `--call-graph dwarf`, i.e. something like this:
> > > > >
> > > > > ```
> > > > > $ cat test.c
> > > > > int main()
> > > > > {
> > > > >
> > > > >     int sum = 0;
> > > > >     for (int i = 0; i < 100000; ++i) sum += i;
> > > > >     return sum > 0;
> > > > >
> > > > > }
> > > > > $ gcc -O0 -g test.c
> > > > > $ perf record ./a.out
> > > > > $ perf script --show-mmap-events | grep /a.out
> > > > >
> > > > >            a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719:
> > > > > [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > > > >
> > > > >            a.out 149719 18106.394748:     275254 cycles:u:
> > > > >            55e0b3b5e72e
> > > > >
> > > > > main+0x25 (/tmp/a.out)
> > > > >
> > > > >            a.out 149719 18106.395011:     486078 cycles:u:
> > > > >            55e0b3b5e72e
> > > > >
> > > > > main+0x25 (/tmp/a.out)
> > > > > ```
> > > >
> > > > for some reason I can't reproduce this and also I'm not getting
> > > > randomized VA for your example, while I see it in other processes,
> > > > which is strange.. I'll check on it deeper
> > >
> > > Out of interest: what exactly are you not reproducing? And what do you
> > > mean by "randomized VA"?
> >
> > that address 55e0b3b5e72e is randomized by kernel,
> > but I had to compile your example with -pie to get it,
> > otherwise I was seeing the standard 0x0400000 something
> >
> >
> > I'm now seeing:
> >
> >               ex 1381597 1084961.360877: PERF_RECORD_MMAP2 1381597/1381597:
> > [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp
> > /home/jolsa/trash/ex ex 1381597 1084961.360889: PERF_RECORD_MMAP2
> > 1381597/1381597: [0x7f283cc80000(0x21000) @ 0x2000 fd:01 274841
> > 3265102552]: r-xp /usr/lib64/ld-2.31.so ex 1381597 1084961.360898:
> > PERF_RECORD_MMAP2 1381597/1381597: [0x7ffc2cd9c000(0x2000) @ 0 00:00 0 0]:
> > r-xp [vdso] ex 1381597 1084961.360917:          1 cycles:u:
> > ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360920:
> > 1 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> > 1084961.360922:          9 cycles:u:  ffffffffabc01007 [unknown]
> > ([unknown]) ex 1381597 1084961.360924:        180 cycles:u:
> > ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360929:
> > 3839 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> > 1084961.361010: PERF_RECORD_MMAP2 1381597/1381597:
> > [0x7f283caa4000(0x150000) @ 0x25000 fd:01 313184 1927740165]: r-xp
> > /usr/lib64/libc-2.31.so ex 1381597 1084961.361695:      22432 cycles:u:
> >  558f08599140 main+0x17 (/home/jolsa/trash/ex) ex 1381597 1084961.361702:
> >    20545 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex) ex
> > 1381597 1084961.361709:      99474 cycles:u:      558f08599140 main+0x17
> > (/home/jolsa/trash/ex)
> >
> > and it seems to work because there's 0x1000 pgoffset (number behind @)
> > which for your test seems to be 0
>
> Yes, that seems to be the issue here... Can anyone explain why that is the
> case for me? When I let my little test app print /proc/self/maps (strace and
> perf trace don't see mmap syscalls for these events btw - interesting), then I
> see this:
>
> ```
> 55ac3bae5000-55ac3bae6000 r--p 00000000 00:31 11568                      /tmp/
> a.out
> 55ac3bae6000-55ac3bae7000 r-xp 00000000 00:31 11568                      /tmp/
> a.out
> 55ac3bae7000-55ac3bae9000 r--p 00000000 00:31 11568                      /tmp/
> a.out
> 55ac3bae9000-55ac3baea000 rw-p 00001000 00:31 11568                      /tmp/
> a.out
> ```
>
> That matches what I'm getting from the perf events, i.e. pgoff = 0 for the
> second (executable) mapping... Here's the output of `readelf -l a.out` - can
> anyone explain what I'm seeing based on that maybe? My personal knowlege in
> that area is not sufficient.
>
> ```
> $ readelf -l a.out
> Elf file type is DYN (Shared object file)
> Entry point 0x1b10
> There are 11 program headers, starting at offset 64
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
>                  0x0000000000000268 0x0000000000000268  R      0x8
>   INTERP         0x00000000000002a8 0x00000000000002a8 0x00000000000002a8
>                  0x000000000000001c 0x000000000000001c  R      0x1
>       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
>   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000b0c 0x0000000000000b0c  R      0x1000
>   LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
>                  0x0000000000000370 0x0000000000000370  R E    0x1000
>   LOAD           0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
>                  0x0000000000000218 0x0000000000000218  RW     0x1000
>   LOAD           0x0000000000001098 0x0000000000004098 0x0000000000004098
>                  0x0000000000000070 0x00000000000001f8  RW     0x1000
>   DYNAMIC        0x0000000000000e98 0x0000000000002e98 0x0000000000002e98
>                  0x00000000000001d0 0x00000000000001d0  RW     0x8
>   GNU_RELRO      0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
>                  0x0000000000000218 0x0000000000001180  R      0x1
>   GNU_EH_FRAME   0x0000000000000988 0x0000000000000988 0x0000000000000988
>                  0x0000000000000044 0x0000000000000044  R      0x4
>   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000  RW     0x0
>   NOTE           0x00000000000002c4 0x00000000000002c4 0x00000000000002c4
>                  0x0000000000000038 0x0000000000000038  R      0x4
>
>  Section to Segment mapping:
>   Segment Sections...
>    00
>    01     .interp
>    02     .interp .note.ABI-tag .note.gnu.build-id .dynsym .gnu.version
> .gnu.version_r .gnu.hash .dynstr .rela.dyn .rela.plt .rodata .gcc_except_table
> .eh_frame_hdr .eh_frame
>    03     .text .init .fini .plt
>    04     .fini_array .init_array .dynamic .got
>    05     .data .tm_clone_table .got.plt .bss
>    06     .dynamic
>    07     .fini_array .init_array .dynamic .got
>    08     .eh_frame_hdr
>    09
>    10     .note.ABI-tag .note.gnu.build-id
> ```
>
> I note that the following seems to correspond to my mapping event:
>
> ```
>   LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
>                  0x0000000000000370 0x0000000000000370  R E    0x1000
> ```
>
> This is interesting - note how there's a difference of 0x100 between the
> offset 0xb10 and the virt/phys addr at 0x1b10...
>
> So to me it looks like it's correct that pgoff is 0, as the file offset is
> 0xb10. But it's not enough to just look at the mapping information to deduce
> the offset <-> virt/phys addr discrepancy.
>
> Which makes it just the more surprising to me that perf script/report
> seemingly copes with this situation despite these problems...

What I noticed is ss->adjust_symbols which is set for user DSOs.  It does

  sym.st_value -= shdr.sh_addr - shdr.sh_offset

Maybe your program's section header has different values?

Thanks,
Namhyung
