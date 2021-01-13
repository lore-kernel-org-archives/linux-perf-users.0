Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB0C433DB
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 19:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCD422DFA
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jan 2021 19:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbhAMTVf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:21:35 -0500
Received: from dd17628.kasserver.com ([85.13.138.83]:41226 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbhAMTVf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jan 2021 14:21:35 -0500
Received: from milian-workstation.localnet (p4fd6c50d.dip0.t-ipconnect.de [79.214.197.13])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id A8A8E62801B7;
        Wed, 13 Jan 2021 20:20:52 +0100 (CET)
From:   Milian Wolff <mail@milianw.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date:   Wed, 13 Jan 2021 20:18:38 +0100
Message-ID: <4450842.bcbERlpMrJ@milian-workstation>
In-Reply-To: <20210113184554.GB1358609@krava>
References: <8218693.uYs0DeGetE@milian-workstation> <3012158.k929uczAvT@milian-workstation> <20210113184554.GB1358609@krava>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1750479.uiOYB00gJU"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--nextPart1750479.uiOYB00gJU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Milian Wolff <mail@milianw.de>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
Date: Wed, 13 Jan 2021 20:18:38 +0100
Message-ID: <4450842.bcbERlpMrJ@milian-workstation>
In-Reply-To: <20210113184554.GB1358609@krava>
References: <8218693.uYs0DeGetE@milian-workstation> <3012158.k929uczAvT@milian-workstation> <20210113184554.GB1358609@krava>

On Mittwoch, 13. Januar 2021 19:45:54 CET Jiri Olsa wrote:
> On Wed, Jan 13, 2021 at 06:47:22PM +0100, Milian Wolff wrote:
> > On Mittwoch, 13. Januar 2021 11:30:31 CET Jiri Olsa wrote:
> > > On Mon, Jan 11, 2021 at 05:56:52PM +0100, Milian Wolff wrote:
> > > > Hey there,
> > > > 
> > > > in hotspot I noticed a symbolization bug for perf.data files that are
> > > > recorded without `--call-graph dwarf`, i.e. something like this:
> > > > 
> > > > ```
> > > > $ cat test.c
> > > > int main()
> > > > {
> > > > 
> > > >     int sum = 0;
> > > >     for (int i = 0; i < 100000; ++i) sum += i;
> > > >     return sum > 0;
> > > > 
> > > > }
> > > > $ gcc -O0 -g test.c
> > > > $ perf record ./a.out
> > > > $ perf script --show-mmap-events | grep /a.out
> > > > 
> > > >            a.out 149719 18106.394277: PERF_RECORD_MMAP2 149719/149719:
> > > > [0x55e0b3b5e000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > > > 
> > > >            a.out 149719 18106.394748:     275254 cycles:u:
> > > >            55e0b3b5e72e
> > > > 
> > > > main+0x25 (/tmp/a.out)
> > > > 
> > > >            a.out 149719 18106.395011:     486078 cycles:u:
> > > >            55e0b3b5e72e
> > > > 
> > > > main+0x25 (/tmp/a.out)
> > > > ```
> > > 
> > > for some reason I can't reproduce this and also I'm not getting
> > > randomized VA for your example, while I see it in other processes,
> > > which is strange.. I'll check on it deeper
> > 
> > Out of interest: what exactly are you not reproducing? And what do you
> > mean by "randomized VA"?
> 
> that address 55e0b3b5e72e is randomized by kernel,
> but I had to compile your example with -pie to get it,
> otherwise I was seeing the standard 0x0400000 something
> 
> 
> I'm now seeing:
> 
>               ex 1381597 1084961.360877: PERF_RECORD_MMAP2 1381597/1381597:
> [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp
> /home/jolsa/trash/ex ex 1381597 1084961.360889: PERF_RECORD_MMAP2
> 1381597/1381597: [0x7f283cc80000(0x21000) @ 0x2000 fd:01 274841
> 3265102552]: r-xp /usr/lib64/ld-2.31.so ex 1381597 1084961.360898:
> PERF_RECORD_MMAP2 1381597/1381597: [0x7ffc2cd9c000(0x2000) @ 0 00:00 0 0]:
> r-xp [vdso] ex 1381597 1084961.360917:          1 cycles:u: 
> ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360920:         
> 1 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> 1084961.360922:          9 cycles:u:  ffffffffabc01007 [unknown]
> ([unknown]) ex 1381597 1084961.360924:        180 cycles:u: 
> ffffffffabc01007 [unknown] ([unknown]) ex 1381597 1084961.360929:      
> 3839 cycles:u:  ffffffffabc01007 [unknown] ([unknown]) ex 1381597
> 1084961.361010: PERF_RECORD_MMAP2 1381597/1381597:
> [0x7f283caa4000(0x150000) @ 0x25000 fd:01 313184 1927740165]: r-xp
> /usr/lib64/libc-2.31.so ex 1381597 1084961.361695:      22432 cycles:u:    
>  558f08599140 main+0x17 (/home/jolsa/trash/ex) ex 1381597 1084961.361702:  
>    20545 cycles:u:      558f08599140 main+0x17 (/home/jolsa/trash/ex) ex
> 1381597 1084961.361709:      99474 cycles:u:      558f08599140 main+0x17
> (/home/jolsa/trash/ex)
> 
> and it seems to work because there's 0x1000 pgoffset (number behind @)
> which for your test seems to be 0

Yes, that seems to be the issue here... Can anyone explain why that is the 
case for me? When I let my little test app print /proc/self/maps (strace and 
perf trace don't see mmap syscalls for these events btw - interesting), then I 
see this:

```
55ac3bae5000-55ac3bae6000 r--p 00000000 00:31 11568                      /tmp/
a.out
55ac3bae6000-55ac3bae7000 r-xp 00000000 00:31 11568                      /tmp/
a.out
55ac3bae7000-55ac3bae9000 r--p 00000000 00:31 11568                      /tmp/
a.out
55ac3bae9000-55ac3baea000 rw-p 00001000 00:31 11568                      /tmp/
a.out
```

That matches what I'm getting from the perf events, i.e. pgoff = 0 for the 
second (executable) mapping... Here's the output of `readelf -l a.out` - can 
anyone explain what I'm seeing based on that maybe? My personal knowlege in 
that area is not sufficient.

```
$ readelf -l a.out 
Elf file type is DYN (Shared object file)
Entry point 0x1b10
There are 11 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                 0x0000000000000268 0x0000000000000268  R      0x8
  INTERP         0x00000000000002a8 0x00000000000002a8 0x00000000000002a8
                 0x000000000000001c 0x000000000000001c  R      0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000b0c 0x0000000000000b0c  R      0x1000
  LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
                 0x0000000000000370 0x0000000000000370  R E    0x1000
  LOAD           0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
                 0x0000000000000218 0x0000000000000218  RW     0x1000
  LOAD           0x0000000000001098 0x0000000000004098 0x0000000000004098
                 0x0000000000000070 0x00000000000001f8  RW     0x1000
  DYNAMIC        0x0000000000000e98 0x0000000000002e98 0x0000000000002e98
                 0x00000000000001d0 0x00000000000001d0  RW     0x8
  GNU_RELRO      0x0000000000000e80 0x0000000000002e80 0x0000000000002e80
                 0x0000000000000218 0x0000000000001180  R      0x1
  GNU_EH_FRAME   0x0000000000000988 0x0000000000000988 0x0000000000000988
                 0x0000000000000044 0x0000000000000044  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x0
  NOTE           0x00000000000002c4 0x00000000000002c4 0x00000000000002c4
                 0x0000000000000038 0x0000000000000038  R      0x4

 Section to Segment mapping:
  Segment Sections...
   00     
   01     .interp 
   02     .interp .note.ABI-tag .note.gnu.build-id .dynsym .gnu.version 
.gnu.version_r .gnu.hash .dynstr .rela.dyn .rela.plt .rodata .gcc_except_table 
.eh_frame_hdr .eh_frame 
   03     .text .init .fini .plt 
   04     .fini_array .init_array .dynamic .got 
   05     .data .tm_clone_table .got.plt .bss 
   06     .dynamic 
   07     .fini_array .init_array .dynamic .got 
   08     .eh_frame_hdr 
   09     
   10     .note.ABI-tag .note.gnu.build-id
```

I note that the following seems to correspond to my mapping event:

```
  LOAD           0x0000000000000b10 0x0000000000001b10 0x0000000000001b10
                 0x0000000000000370 0x0000000000000370  R E    0x1000
```

This is interesting - note how there's a difference of 0x100 between the 
offset 0xb10 and the virt/phys addr at 0x1b10...

So to me it looks like it's correct that pgoff is 0, as the file offset is 
0xb10. But it's not enough to just look at the mapping information to deduce 
the offset <-> virt/phys addr discrepancy.

Which makes it just the more surprising to me that perf script/report 
seemingly copes with this situation despite these problems...

> I'm having sample with:
>   558f08599140 main+0x17
> 
> that falls into:
>               ex 1381597 1084961.360877: PERF_RECORD_MMAP2 1381597/1381597:
> [0x558f08599000(0x1000) @ 0x1000 fd:03 155428 2806170740]: r-xp
> /home/jolsa/trash/ex
> 
> 0x558f08599140 - 0x558f08599000 + 0x1000 = 0x1140
> 
> with main symbol:
> 
> 	$ nm ex | grep main
> 			 U __libc_start_main@@GLIBC_2.2.5
> 	0000000000001129 T main
> 
> 0x1140 - 0x1129 = 0x17 which is correct

Yes, that's perfectly fine. Thanks for looking into that.

> > > > How does perf resolve the address 0x55e0b3b5e72e to main+0x25 here? If
> > > > we
> > > > look at this purely from the singular mmap event, this shouldn't be
> > > > the
> > > > case:
> > > > 
> > > > 1) The mmap event starts at 0x55e0b3b5e000, has size 0x1000, so its
> > > > end is
> > > > at 0x55e0b3b5f000.
> > > > 
> > > > 2) Address 55e0b3b5e72e is thus contained in this map, and at offset
> > > > 0x72e.
> > > > 
> > > > 3) But main is not at this offset, it starts at 0x1709:
> > > > 
> > > > ```
> > > > $ nm ./a.out | grep main
> > > > 
> > > >                  U __libc_start_main
> > > > 
> > > > 0000000000001709 T main
> > > > ```
> > > > 
> > > > How does perf report/script still get the right answer here and knows
> > > > that
> > > > there's an offset of 0x1000?
> > > > 
> > > > Note that in reality, multiple mmap events occur. And the first one
> > > > maps
> > > > the file at an address with the 0x1000 offset. This can be seen by:
> > > > 
> > > > ```
> > > > $ perf record --call-graph dwarf ./a.out
> > > > $ perf script --show-mmap-events | grep /a.out
> > > > a.out 149953 18488.265340: PERF_RECORD_MMAP2 149953/149953:
> > > > [0x55b2f29d2000(0x4000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > > > a.out 149953 18488.265346: PERF_RECORD_MMAP2 149953/149953:
> > > > [0x55b2f29d3000(0x1000) @ 0 00:31 22086 3699042272]: r-xp /tmp/a.out
> > > > a.out 149953 18488.265348: PERF_RECORD_MMAP2 149953/149953:
> > > > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > > > a.out 149953 18488.265350: PERF_RECORD_MMAP2 149953/149953:
> > > > [0x55b2f29d5000(0x1000) @ 0 00:31 22086 3699042272]: rw-p /tmp/a.out
> > > > a.out 149953 18488.265706: PERF_RECORD_MMAP2 149953/149953:
> > > > [0x55b2f29d4000(0x1000) @ 0 00:31 22086 3699042272]: r--p /tmp/a.out
> > > > 
> > > >             55b2f29d372e main+0x25 (/tmp/a.out)
> > > >             55b2f29d372e main+0x25 (/tmp/a.out)
> > > 
> > > when you use '--call-graph dwarf' you also enable data mmaps,
> > > so the extra mmap events are non-X mmaps
> > 
> > I see, is this an optimization to reduce the overhead when doing this
> > "shallow" sampling? Can one opt-in to the data mmaps without going the
> > full
> > `--call-graph dwarf` way?
> 
> 5c0cf22477ea perf record: Store data mmaps for dwarf unwind
> 
> says:
>     But we've seen cases (softice) where DWARF unwinder went through non
>     executable mmaps, which we need to lookup in MAP__VARIABLE tree.
> 
> it's hardcoded

OK, thanks.

Cheers

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart1750479.uiOYB00gJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAl//R48ACgkQ8zYW/HGd
OX9k2A//YBAopEiIpw5bazLlhfT4y5X1GYePoFJNvB/TNELEUySOiVmz1NWAYpzT
S8zeIQHBnUWDFsq9IhOb2kaUPr+bCkIpZLBexgQBWXG/DtfauyFFqjt31GuVoC6R
UlYQw+12qDkyXFBz6c1UAtxZ//IqDcxKjf9KrwPHLx7+YLZrK0ZAwk/g1djgrrft
2ONElSt4CwMc9ILAy+xa4iUQHDWeK5g7Kg4WA0RD6X+BXpBt+ncmxuFB9C02AqgO
eU6zl41bOLwlcL3j10EF2KJtblEZsjzbpLN6xR1OFKC6KDfjCBCPfMzgcgE+4lu4
P4iqcFIpnZQBFOm5JpoI52Gi0qSt7NgG6kdmfqV1y+L8MMxKsp858M914ryF42xi
Ul39ivoiizwm/5pu/CR+ZS3dcyLtnSRQ7hhNNde1ArEe6pagj1ZbToTdM5macL43
/JKB9JD/DQs+K4ehtOL7C5zNGVvG/p9wTTXcpDeaEBKmBR3/veVuTE5FBwV3dRX0
bPyk9+HVj7KdkGoBSydDvM8eab2rgtIwdeQDf+XfAcxz23r0p1ShH+WJZQklhWlv
e97ctJxFjpwpQsN7yagSiPw62oEjVm4qEqObTgM2wk3EK+RPhFcPjKKCnN2A3TgX
VgGa6TCpXEU1t8t5zeuQXqZtNkAUquCYNKciHEshb4jv4ch/gus=
=gah3
-----END PGP SIGNATURE-----

--nextPart1750479.uiOYB00gJU--



