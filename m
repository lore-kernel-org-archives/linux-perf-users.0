Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F5C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 08:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F1B2311C
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbhASIND (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:13:03 -0500
Received: from dd17628.kasserver.com ([85.13.138.83]:49528 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbhASIMb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 03:12:31 -0500
Received: from milian-workstation.localnet (p4fd6c50d.dip0.t-ipconnect.de [79.214.197.13])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id 5413E628046D;
        Tue, 19 Jan 2021 09:11:41 +0100 (CET)
From:   Milian Wolff <mail@milianw.de>
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date:   Tue, 19 Jan 2021 09:09:19 +0100
Message-ID: <7161646.QLfhZlOSzD@milian-workstation>
In-Reply-To: <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com>
References: <8218693.uYs0DeGetE@milian-workstation> <4450842.bcbERlpMrJ@milian-workstation> <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2356779.EW4P4RBxm5"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart2356779.EW4P4RBxm5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Milian Wolff <mail@milianw.de>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date: Tue, 19 Jan 2021 09:09:19 +0100
Message-ID: <7161646.QLfhZlOSzD@milian-workstation>
In-Reply-To: <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com>
References: <8218693.uYs0DeGetE@milian-workstation> <4450842.bcbERlpMrJ@milian-workstation> <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com>

On Donnerstag, 14. Januar 2021 09:56:36 CET Namhyung Kim wrote:
> Hi,
> 
> On Thu, Jan 14, 2021 at 4:24 AM Milian Wolff <mail@milianw.de> wrote:
> > On Mittwoch, 13. Januar 2021 19:45:54 CET Jiri Olsa wrote:
> > > On Wed, Jan 13, 2021 at 06:47:22PM +0100, Milian Wolff wrote:
> > > > On Mittwoch, 13. Januar 2021 11:30:31 CET Jiri Olsa wrote:
> > > > > On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> > > > > > Hey there,
> > > > > > 
> > > > > > in hotspot I noticed a symbolization bug for perf.data files that
> > > > > > are
> > > > > > recorded without `--call-graph dwarf`, i.e. something like this:
> > > > > > 
> > > > > > ```
> > > > > > $ cat test.c
> > > > > > int main()
> > > > > > {
> > > > > > 
> > > > > >     int sum = 0;
> > > > > >     for (int i = 0; i < 100000; ++i) sum += i;
> > > > > >     return sum > 0;
> > > > > > 
> > > > > > }
> > > > > > $ gcc -O0 -g test.c
> > > > > > $ perf record ./a.out
> > > > > > $ perf script --show-mmap-events | grep /a.out
> > > > > > 
> > > > > >            a.out 149719 18106.394277: PERF_RECORD_MMAP2 
149719/149719:
> > > > > > [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp
> > > > > > /tmp/a.out
> > > > > > 
> > > > > >            a.out 149719 18106.394748:     275254 cycles:u:
> > > > > >            55e0b3b5e72e
> > > > > > 
> > > > > > main+0x25 (/tmp/a.out)
> > > > > > 
> > > > > >            a.out 149719 18106.395011:     486078 cycles:u:
> > > > > >            55e0b3b5e72e
> > > > > > 
> > > > > > main+0x25 (/tmp/a.out)
> > > > > > ```
> > > > > 
> > > > > for some reason I can't reproduce this and also I'm not getting
> > > > > randomized VA for your example, while I see it in other processes,
> > > > > which is strange.. I'll check on it deeper
> > > > 
> > > > Out of interest: what exactly are you not reproducing? And what do you
> > > > mean by "randomized VA"?
> > > 
> > > that address 55e0b3b5e72e is randomized by kernel,
> > > but I had to compile your example with -pie to get it,
> > > otherwise I was seeing the standard 0x0400000 something
> > > 
> > > I'm now seeing:
> > >               ex 1381597 1084961.360877: PERF_RECORD_MMAP2 
1381597/1381597:
> > > [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp
> > > /home/jolsa/trash/ex ex 1381597 1084961.360889: PERF_RECORD_MMAP2
> > > 1381597/1381597: [0x7f283cc80000(0x21000) @ 0x2000 fd:01 274841
> > > 3265102552]: r-xp /usr/lib64/ld-2.31.so ex 1381597 1084961.360898:
> > > PERF_RECORD_MMAP2 1381597/1381597: [0x7ffc2cd9c000(0x2000) @ 0 00:00 0
> > > 0]:
> > > r-xp [vdso] ex 1381597 1084961.360917:          1 cycles:u:
> > > ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360920:
> > > 1 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> > > 1084961.360922:          9 cycles:u:  ffffffffabc01007 [unknown]
> > > ([unknown]) ex 1381597 1084961.360924:        180 cycles:u:
> > > ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360929:
> > > 3839 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> > > 1084961.361010: PERF_RECORD_MMAP2 1381597/1381597:
> > > [0x7f283caa4000(0x150000) @ 0x25000 fd:01 313184 1927740165]: r-xp
> > > 
> > > /usr/lib64/libc-2.31.so ex 1381597 1084961.361695:      22432 cycles:u:
> > >  558f08599140 main+0x17 (/home/jolsa/trash/ex) ex 1381597 
1084961.361702:
> > >    20545 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex) ex
> > > 
> > > 1381597 1084961.361709:      99474 cycles:u:      558f08599140 main+0x17
> > > (/home/jolsa/trash/ex)
> > > 
> > > and it seems to work because there's 0x1000 pgoffset (number behind @)
> > > which for your test seems to be 0
> > 
> > Yes, that seems to be the issue here... Can anyone explain why that is the
> > case for me? When I let my little test app print /proc/self/maps (strace
> > and perf trace don't see mmap syscalls for these events btw -
> > interesting), then I see this:
> > 
> > ```
> > 55ac3bae5000-55ac3bae6000 r--p 00000000 00:31 11568                     
> > /tmp/ a.out
> > 55ac3bae6000-55ac3bae7000 r-xp 00000000 00:31 11568                     
> > /tmp/ a.out
> > 55ac3bae7000-55ac3bae9000 r--p 00000000 00:31 11568                     
> > /tmp/ a.out
> > 55ac3bae9000-55ac3baea000 rw-p 00001000 00:31 11568                     
> > /tmp/ a.out
> > ```
> > 
> > That matches what I'm getting from the perf events, i.e. pgoff = 0 for the
> > second (executable) mapping... Here's the output of `readelf -l a.out` -
> > can anyone explain what I'm seeing based on that maybe? My personal
> > knowlege in that area is not sufficient.
> > 
> > ```
> > $ readelf -l a.out
> > Elf file type is DYN (Shared object file)
> > Entry point 0x1b10
> > There are 11 program headers, starting at offset 64
> > 
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >   
> >                  FileSiz            MemSiz              Flags  Align
> >   
> >   PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
> >   
> >                  0x0000000000000268 0x0000000000000268  R      0x8
> >   
> >   INTERP         0x00000000000002a8 0x00000000000002a8 0x00000000000002a8
> >   
> >                  0x000000000000001c 0x000000000000001c  R      0x1
> >       
> >       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
> >   
> >   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
> >   
> >                  0x0000000000000b0c 0x0000000000000b0c  R      0x1000
> >   
> >   LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
> >   
> >                  0x0000000000000370 0x0000000000000370  R E    0x1000
> >   
> >   LOAD           0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
> >   
> >                  0x0000000000000218 0x0000000000000218  RW     0x1000
> >   
> >   LOAD           0x0000000000001098 0x0000000000004098 0x0000000000004098
> >   
> >                  0x0000000000000070 0x00000000000001f8  RW     0x1000
> >   
> >   DYNAMIC        0x0000000000000e98 0x0000000000002e98 0x0000000000002e98
> >   
> >                  0x00000000000001d0 0x00000000000001d0  RW     0x8
> >   
> >   GNU_RELRO      0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
> >   
> >                  0x0000000000000218 0x0000000000001180  R      0x1
> >   
> >   GNU_EH_FRAME   0x0000000000000988 0x0000000000000988 0x0000000000000988
> >   
> >                  0x0000000000000044 0x0000000000000044  R      0x4
> >   
> >   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> >   
> >                  0x0000000000000000 0x0000000000000000  RW     0x0
> >   
> >   NOTE           0x00000000000002c4 0x00000000000002c4 0x00000000000002c4
> >   
> >                  0x0000000000000038 0x0000000000000038  R      0x4
> >  
> >  Section to Segment mapping:
> >   Segment Sections...
> >   
> >    00
> >    01     .interp
> >    02     .interp .note.ABI-tag .note.gnu.build-id .dynsym .gnu.version
> > 
> > .gnu.version_r .gnu.hash .dynstr .rela.dyn .rela.plt .rodata
> > .gcc_except_table .eh_frame_hdr .eh_frame
> > 
> >    03     .text .init .fini .plt
> >    04     .fini_array .init_array .dynamic .got
> >    05     .data .tm_clone_table .got.plt .bss
> >    06     .dynamic
> >    07     .fini_array .init_array .dynamic .got
> >    08     .eh_frame_hdr
> >    09
> >    10     .note.ABI-tag .note.gnu.build-id
> > 
> > ```
> > 
> > I note that the following seems to correspond to my mapping event:
> > 
> > ```
> > 
> >   LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
> >   
> >                  0x0000000000000370 0x0000000000000370  R E    0x1000
> > 
> > ```
> > 
> > This is interesting - note how there's a difference of 0x100 between the
> > offset 0xb10 and the virt/phys addr at 0x1b10...
> > 
> > So to me it looks like it's correct that pgoff is 0, as the file offset is
> > 0xb10. But it's not enough to just look at the mapping information to
> > deduce the offset <-> virt/phys addr discrepancy.
> > 
> > Which makes it just the more surprising to me that perf script/report
> > seemingly copes with this situation despite these problems...
> 
> What I noticed is ss->adjust_symbols which is set for user DSOs.  It does
> 
>   sym.st_value -= shdr.sh_addr - shdr.sh_offset
> 
> Maybe your program's section header has different values?

Hey Namhyung,

how would I figure that one out? Isn't that data shown in the readelf output 
above? Put differently: Could someone else maybe show his readelf output so we 
can compare?

@ jirka: did you have a chance to figure out why/how perf stat/report is 
figuring out the right mapping address from the singular mapping event?

Thanks

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart2356779.EW4P4RBxm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAmAGk68ACgkQ8zYW/HGd
OX9q3g/8D67bQSUvRW8qt/jSL0DCY/q0yHzJ6oY8YOCRJU7pIq8RBpgb/cbirUxl
4HrC/opI0JAVAmMJWTHZlznyz+vxD2RYtEYjVyZ1wQO4XcCFMaBRO0zHTHJQLOto
SNeflyXyLRdawtgLBnYlTBBnooxZmPEdXrET6jJnjHh2Wy+MTQCfwRcHljtDWgzU
U2DK3rzVyPNwfv8I/6iG4PVbuBcBzNh8NqxQS9RVCndhfaLPuCAqFcgddyb46A3n
4Szdi5tdL4Oy9LNS/+C4KFH9fJ41F0D11kV/3gkMbv8AhyJ4uv7nzobsQWxA8Vnk
1b2MubzcGAvRymKs208aio3OuekKipFkTphJHEeZnVG+FhPMBXDDl4R5zzA56dtI
Vtx400fGnWWBqbjBxJlX/W9Zb9A723FlPqvsypXLV3J40FCUV+EkpksHtGQGSXMv
ke3FjjQsbbSqcZBrT+nx5X62poKPeuYG3JNt3Fpdgvw2qvWw5UFgMtmbxUUh4tcZ
k76WPAqjoVeDVymAtsyVSg0FMIHip1TCNjQNyFXv11OOwN4LmYgBwu8McH2yrSy+
7VzPB669TA8+sKaHkVdL6UMvyXex+TONKIR+jGD4k1YZ3ibYrKWEpyo8WER2GW/V
hgqBaR8QyVLtq72S3ELpWYARY2A4gVbRCHDF4PvAfj6B4ynSxHA=
=xsrI
-----END PGP SIGNATURE-----

--nextPart2356779.EW4P4RBxm5--



