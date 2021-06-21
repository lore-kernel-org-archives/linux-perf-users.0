Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA971C4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C8361261
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 14:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFUOSL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUOSK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 10:18:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0DC061574
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 07:15:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n7so19876002wri.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QyXtD2u58RNS0eSJle/+rhCce0FgHM2UXgXTkxkGkFQ=;
        b=pXSQdYxTheMsI6M+Sp/xpN/Ap+oEj1t2HBlzu1K9w4AoFHXHdRZYj59naXejWJ0hSX
         dr4yGui0Dnli4R4/2qeMf38E2rW9q2JYiwAMYitZyrhCVU8WPzxcwr4nPfVyf/jzqrRz
         391xc+Elz489kb8OAr+lMUryPr5JbCivubOlqe9/cH4Bo9zn27tObPPZON2F4yMnATyk
         M7cWQDICeamqLloYFs64MSXbx6vsQtMXh5kDcEcqeBdIVbJdlE4feYgNhsk4wq4D78eK
         prUdEUuvGFqWyGXQ9tGW2pDkNS23fQBSJXiQLzAkXrVd/Vnapla309TUoM9FZxDAJZa3
         CPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QyXtD2u58RNS0eSJle/+rhCce0FgHM2UXgXTkxkGkFQ=;
        b=FwMzWfqWZKVnbCJoXr/kU0+VUyZBRu3pszW/ocT+5TQV/hX6aC87tKvubw4UnP1XIS
         aKuva8zfARq2nQspItv33XdeugU2vacBiYfePXjnz/RecozS8TXeIzqiK+KKytCR+SNj
         CquEVeleN3UoxM55WQMGDBtgur9R5B4oaNMipCqUm3kF3GkystbWk/c1RhT64Av1wlFP
         7+x5rAuBYDws0gNaMyQFoqLBNLH6TRTOZdKHjrwKVBcKjpD4eWOEsTKSArv1p5HgWTPs
         9OdSnpXQKasFCMMcGybwFCyGiuy+lTiEtNXdkyltSVh/EzcC+UngqGjEbTTi+0t/cxes
         uhfQ==
X-Gm-Message-State: AOAM532XnDVh/SKauI76PJ1AM2LAVRHEtXDFEeZESuj5vvW1ewFayAcC
        Sl5SZqdKY7eCm8ylfYIwPQo=
X-Google-Smtp-Source: ABdhPJxEr7ZCdUoY126kXlc8oYFxW3R7u8dK0xX9sI3rn98sjVr7qZaAdFqJzeGTAnMKEU+H5LXPhA==
X-Received: by 2002:adf:e449:: with SMTP id t9mr1881328wrm.40.1624284954847;
        Mon, 21 Jun 2021 07:15:54 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.45.200])
        by smtp.gmail.com with ESMTPSA id v18sm8841888wrv.24.2021.06.21.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:15:54 -0700 (PDT)
Message-ID: <b681eea69220684069b7c618c621e404d1946991.camel@gmail.com>
Subject: Re: perf-top: heap-buffer-overflow in elf_sec__is_text reported
 from ASan
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        acme@kernel.org
Date:   Mon, 21 Jun 2021 16:15:53 +0200
In-Reply-To: <c0f82ef2-e87b-8ede-3525-429fcb9f645c@kernel.org>
References: <e883163b0c0295bfb8a56dcc82f6cae4cbbdc84a.camel@gmail.com>
         <c0f82ef2-e87b-8ede-3525-429fcb9f645c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

thank you very much for your reply!

On Mon, 2021-06-21 at 08:54 +0200, Jiri Slaby wrote:
> Hi,
> 
> On 18. 06. 21, 11:17, Riccardo Mancini wrote:
> > ASan reports a heap-buffer-overflow in elf_sec__is_text when using perf-top.
> > The bug is introduced by commit 6833e0b: "perf symbols: Resolve symbols
> > against
> > debug file first" from Jiri Slaby.
> ...
> > pwndbg> p syms_ss->name
> > $4 = 0x607000018f90 "/usr/lib/debug/usr/lib64/libglib-2.0.so.0.6800.2-2.68.2-
> > 1.fc34.x86_64.debug"
> > pwndbg> p runtime_ss->name
> > $5 = 0x6070000190e0 "/root/.debug/.build-
> > id/37/475e3b392fb3971c8ad0d9ac0a4d7e1b93c521/elf"
> 
> Out of curiosity, could you post output of 'readelf -S' on both of them?

Sure, I'll post it to the bottom of this email since it's quite long.

> 
> > Furthermore, the branch in line symbol-elf.c:1241 (the one added in the
> > referred
> > patch) is not taken.
> > 
> > As you can see, sh_name is out-of-range (342 > 332).
> > I can also provide a coredump, if it can be useful.
> > 
> > I have no idea of how the ELF stuff works, but I thought this may be caused by
> > the fact that secstrs is built from runtime_ss, while shdr is built from
> > syms_ss
> > (since it is the change of the commit). I tried to test this theory with the
> > following change:
> > 
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index a73345730ba9..8d2b692f11a2 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1146,7 +1146,7 @@ int dso__load_sym(struct dso *dso, struct map *map,
> > struct symsrc *syms_ss,
> >         if (symstrs == NULL)
> >                 goto out_elf_end;
> >   
> > -       sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
> > +       sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
> >         if (sec_strndx == NULL)
> >                 goto out_elf_end;
> >   
> > @@ -1244,6 +1244,14 @@ int dso__load_sym(struct dso *dso, struct map *map,
> > struct symsrc *syms_ss,
> >                  * values for syms (invalid) and runtime (valid).
> >                  */
> >                 if (shdr.sh_type == SHT_NOBITS) {
> > +                       sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss-
> > >ehdr.e_shstrndx);
> > +                       if (sec_strndx == NULL)
> > +                               goto out_elf_end;
> > +
> > +                       secstrs = elf_getdata(sec_strndx, NULL);
> > +                       if (secstrs == NULL)
> > +                               goto out_elf_end;
> > +
> >                         sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
> >                         if (!sec)
> >                                 goto out_elf_end;
> > 
> > However, it still overflows, but oddly the branch is not taken before the
> > overflow. Is there some kind of state that gets changed in the ELF structs?
> 
> Something like that should work. But you should reset sec_strndx also in 
> the else branch, IMO. 

Oops, that was embarassing. I completely forgot that it was inside a loop.

> So what about this?
> 
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1081,7 +1081,7 @@ int dso__load_sym(struct dso *dso, struct map 
> *map, struct symsrc *syms_ss,
>          struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
>          struct map *curr_map = map;
>          struct dso *curr_dso = dso;
> -       Elf_Data *symstrs, *secstrs;
> +       Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
>          uint32_t nr_syms;
>          int err = -1;
>          uint32_t idx;
> @@ -1150,8 +1150,16 @@ int dso__load_sym(struct dso *dso, struct map 
> *map, struct symsrc *syms_ss,
>          if (sec_strndx == NULL)
>                  goto out_elf_end;
> 
> -       secstrs = elf_getdata(sec_strndx, NULL);
> -       if (secstrs == NULL)
> +       secstrs_run = elf_getdata(sec_strndx, NULL);
> +       if (secstrs_run == NULL)
> +               goto out_elf_end;
> +
> +       sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
> +       if (sec_strndx == NULL)
> +               goto out_elf_end;
> +
> +       secstrs_sym = elf_getdata(sec_strndx, NULL);
> +       if (secstrs_sym == NULL)
>                  goto out_elf_end;
> 
>          nr_syms = shdr.sh_size / shdr.sh_entsize;
> @@ -1237,6 +1245,8 @@ int dso__load_sym(struct dso *dso, struct map 
> *map, struct symsrc *syms_ss,
> 
>                  gelf_getshdr(sec, &shdr);
> 
> +               secstrs = secstrs_sym;
> +
>                  /*
>                   * We have to fallback to runtime when syms' section 
> header has
>                   * NOBITS set. NOBITS results in file offset 
> (sh_offset) not
> @@ -1249,6 +1259,7 @@ int dso__load_sym(struct dso *dso, struct map 
> *map, struct symsrc *syms_ss,
>                                  goto out_elf_end;
> 
>                          gelf_getshdr(sec, &shdr);
> +                       secstrs = secstrs_run;
>                  }
> 
>                  if (is_label && !elf_sec__filter(&shdr, secstrs))

It works, thanks!

> 
> thanks,
> -- 
> js
> 

Here are the ELF sections of the two files causing the bug:

# readelf -S /usr/lib/debug/usr/lib64/libglib-2.0.so.0.6800.2-2.68.2-1.fc34.x86_64.debug
There are 43 section headers, starting at offset 0x386ed0:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.pr[...] NOTE             00000000000002a8  000002a8
       0000000000000020  0000000000000000   A       0     0     8
  [ 2] .note.gnu.bu[...] NOTE             00000000000002c8  000002c8
       0000000000000024  0000000000000000   A       0     0     4
  [ 3] .gnu.hash         NOBITS           00000000000002f0  000002f0
       000000000000341c  0000000000000000   A       4     0     8
  [ 4] .dynsym           NOBITS           0000000000003710  000002f0
       000000000000bdd8  0000000000000018   A       5     1     8
  [ 5] .dynstr           NOBITS           000000000000f4e8  000002f0
       0000000000009a40  0000000000000000   A       0     0     1
  [ 6] .gnu.version      NOBITS           0000000000018f28  000002f0
       0000000000000fd2  0000000000000002   A       4     0     2
  [ 7] .gnu.version_r    NOBITS           0000000000019f00  000002f0
       0000000000000150  0000000000000000   A       5     2     8
  [ 8] .rela.dyn         NOBITS           000000000001a050  000002f0
       0000000000000e88  0000000000000018   A       4     0     8
  [ 9] .rela.plt         NOBITS           000000000001aed8  000002f0
       0000000000001548  0000000000000018  AI       4    23     8
  [10] .init             NOBITS           000000000001d000  000002f0
       000000000000001b  0000000000000000  AX       0     0     4
  [11] .plt              NOBITS           000000000001d020  000002f0
       0000000000000e40  0000000000000010  AX       0     0     16
  [12] .plt.sec          NOBITS           000000000001de60  000002f0
       0000000000000e30  0000000000000010  AX       0     0     16
  [13] .text             NOBITS           000000000001ec90  000002f0
       000000000008d842  0000000000000000  AX       0     0     16
  [14] .fini             NOBITS           00000000000ac4d4  000002f0
       000000000000000d  0000000000000000  AX       0     0     4
  [15] .rodata           NOBITS           00000000000ad000  00000300
       000000000006878c  0000000000000000   A       0     0     32
  [16] .stapsdt.base     NOBITS           000000000011578c  00000300
       0000000000000001  0000000000000000   A       0     0     1
  [17] .eh_frame_hdr     NOBITS           0000000000115790  00000300
       000000000000470c  0000000000000000   A       0     0     4
  [18] .eh_frame         NOBITS           0000000000119ea0  00000300
       000000000001ba00  0000000000000000   A       0     0     8
  [19] .init_array       NOBITS           00000000001373a8  00000300
       0000000000000010  0000000000000008  WA       0     0     8
  [20] .fini_array       NOBITS           00000000001373b8  00000300
       0000000000000008  0000000000000008  WA       0     0     8
  [21] .data.rel.ro      NOBITS           00000000001373c0  00000300
       0000000000000240  0000000000000000  WA       0     0     32
  [22] .dynamic          NOBITS           0000000000137600  00000300
       0000000000000210  0000000000000010  WA       5     0     8
  [23] .got              NOBITS           0000000000137810  00000300
       00000000000007e0  0000000000000008  WA       0     0     8
  [24] .data             NOBITS           0000000000138000  00000300
       00000000000005f8  0000000000000000  WA       0     0     32
  [25] .probes           NOBITS           00000000001385f8  00000300
       0000000000000060  0000000000000000  WA       0     0     2
  [26] .bss              NOBITS           0000000000138660  00000300
       0000000000000d10  0000000000000000  WA       0     0     32
  [27] .comment          PROGBITS         0000000000000000  00000300
       000000000000005c  0000000000000001  MS       0     0     1
  [28] .note.stapsdt     NOTE             0000000000000000  0000035c
       0000000000001554  0000000000000000           0     0     4
  [29] .gnu.build.a[...] NOTE             000000000013b370  000018b0
       00000000000005c8  0000000000000000           0     0     4
  [30] .debug_aranges    PROGBITS         0000000000000000  00001e78
       00000000000002a0  0000000000000000           0     0     1
  [31] .debug_info       PROGBITS         0000000000000000  00002118
       00000000001166d4  0000000000000000           0     0     1
  [32] .debug_abbrev     PROGBITS         0000000000000000  001187ec
       000000000000dad6  0000000000000000           0     0     1
  [33] .debug_line       PROGBITS         0000000000000000  001262c2
       000000000006cff4  0000000000000000           0     0     1
  [34] .debug_str        PROGBITS         0000000000000000  001932b6
       000000000000d853  0000000000000001  MS       0     0     1
  [35] .debug_line_str   PROGBITS         0000000000000000  001a0b09
       0000000000001037  0000000000000001  MS       0     0     1
  [36] .debug_loclists   PROGBITS         0000000000000000  001a1b40
       00000000000c5cfc  0000000000000000           0     0     1
  [37] .debug_rnglists   PROGBITS         0000000000000000  0026783c
       0000000000016ff6  0000000000000000           0     0     1
  [38] .gdb_index        PROGBITS         0000000000000000  0027e832
       0000000000028f3a  0000000000000000           0     0     1
  [39] .gnu_debugaltlink PROGBITS         0000000000000000  002a776c
       000000000000003a  0000000000000000           0     0     1
  [40] .symtab           SYMTAB           0000000000000000  002a77a8
       00000000000a3b18  0000000000000018          41   25913     8
  [41] .strtab           STRTAB           0000000000000000  0034b2c0
       000000000003ba35  0000000000000000           0     0     1
  [42] .shstrtab         STRTAB           0000000000000000  00386cf5
       00000000000001d4  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  l (large), p (processor specific)

# sudo readelf -S /root/.debug/.build-id/37/475e3b392fb3971c8ad0d9ac0a4d7e1b93c521/elf
There are 32 section headers, starting at offset 0x13d088:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.pr[...] NOTE             00000000000002a8  000002a8
       0000000000000020  0000000000000000   A       0     0     8
  [ 2] .note.gnu.bu[...] NOTE             00000000000002c8  000002c8
       0000000000000024  0000000000000000   A       0     0     4
  [ 3] .gnu.hash         GNU_HASH         00000000000002f0  000002f0
       000000000000341c  0000000000000000   A       4     0     8
  [ 4] .dynsym           DYNSYM           0000000000003710  00003710
       000000000000bdd8  0000000000000018   A       5     1     8
  [ 5] .dynstr           STRTAB           000000000000f4e8  0000f4e8
       0000000000009a40  0000000000000000   A       0     0     1
  [ 6] .gnu.version      VERSYM           0000000000018f28  00018f28
       0000000000000fd2  0000000000000002   A       4     0     2
  [ 7] .gnu.version_r    VERNEED          0000000000019f00  00019f00
       0000000000000150  0000000000000000   A       5     2     8
  [ 8] .rela.dyn         RELA             000000000001a050  0001a050
       0000000000000e88  0000000000000018   A       4     0     8
  [ 9] .rela.plt         RELA             000000000001aed8  0001aed8
       0000000000001548  0000000000000018  AI       4    23     8
  [10] .init             PROGBITS         000000000001d000  0001d000
       000000000000001b  0000000000000000  AX       0     0     4
  [11] .plt              PROGBITS         000000000001d020  0001d020
       0000000000000e40  0000000000000010  AX       0     0     16
  [12] .plt.sec          PROGBITS         000000000001de60  0001de60
       0000000000000e30  0000000000000010  AX       0     0     16
  [13] .text             PROGBITS         000000000001ec90  0001ec90
       000000000008d842  0000000000000000  AX       0     0     16
  [14] .fini             PROGBITS         00000000000ac4d4  000ac4d4
       000000000000000d  0000000000000000  AX       0     0     4
  [15] .rodata           PROGBITS         00000000000ad000  000ad000
       000000000006878c  0000000000000000   A       0     0     32
  [16] .stapsdt.base     PROGBITS         000000000011578c  0011578c
       0000000000000001  0000000000000000   A       0     0     1
  [17] .eh_frame_hdr     PROGBITS         0000000000115790  00115790
       000000000000470c  0000000000000000   A       0     0     4
  [18] .eh_frame         PROGBITS         0000000000119ea0  00119ea0
       000000000001ba00  0000000000000000   A       0     0     8
  [19] .init_array       INIT_ARRAY       00000000001373a8  001363a8
       0000000000000010  0000000000000008  WA       0     0     8
  [20] .fini_array       FINI_ARRAY       00000000001373b8  001363b8
       0000000000000008  0000000000000008  WA       0     0     8
  [21] .data.rel.ro      PROGBITS         00000000001373c0  001363c0
       0000000000000240  0000000000000000  WA       0     0     32
  [22] .dynamic          DYNAMIC          0000000000137600  00136600
       0000000000000210  0000000000000010  WA       5     0     8
  [23] .got              PROGBITS         0000000000137810  00136810
       00000000000007e0  0000000000000008  WA       0     0     8
  [24] .data             PROGBITS         0000000000138000  00137000
       00000000000005f8  0000000000000000  WA       0     0     32
  [25] .probes           PROGBITS         00000000001385f8  001375f8
       0000000000000060  0000000000000000  WA       0     0     2
  [26] .bss              NOBITS           0000000000138660  00137658
       0000000000000d10  0000000000000000  WA       0     0     32
  [27] .note.stapsdt     NOTE             0000000000000000  00137658
       0000000000001554  0000000000000000           0     0     4
  [28] .gnu.build.a[...] NOTE             000000000013b370  00138bac
       00000000000005c8  0000000000000000           0     0     4
  [29] .gnu_debuglink    PROGBITS         0000000000000000  00139174
       0000000000000038  0000000000000000           0     0     4
  [30] .gnu_debugdata    PROGBITS         0000000000000000  001391ac
       0000000000003d90  0000000000000000           0     0     1
  [31] .shstrtab         STRTAB           0000000000000000  0013cf3c
       000000000000014c  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  l (large), p (processor specific)

Thanks,
Riccardo


