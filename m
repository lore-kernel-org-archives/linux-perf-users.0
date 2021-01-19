Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D0C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024D322472
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbhASOiN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbhASJhF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 04:37:05 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F60C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jan 2021 01:36:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id p13so21190767ljg.2
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Jan 2021 01:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Smh19yU4TrWUr80CFoRge1kQ5ZuNhvIPSsXeaczgPA=;
        b=Bx0S8jFpItRdNLpXHFYLjn0PTsa9uZHhNah+uyat0lGQ6JF+2kLrUwyO2RmYKIyE35
         vxi8YTerQywVknPS1861eyISr55GctmwPDnVAV8QDo7a7RxHYWRMVH2nDtJ7WXOqEkhG
         efWDZd91zRHBl4SjHzQROFfkSnHuyfuBA3NCuKibyKGYfU22Qaqp1UiLSFXdHX9fYtw0
         dnnpRAx5nXX6oXsSnTXRvAY6DQxSCPivNNeWD/BvOCWWfj1WXo08vY4BZZ+XSuVqhVJ2
         htCDkK12E4IiNsqdpk6nKorjmr4CNDeaB4oa2OPpKcGUAi+bjHP5ggqXRuH/8xGMCfex
         j5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Smh19yU4TrWUr80CFoRge1kQ5ZuNhvIPSsXeaczgPA=;
        b=XA4sCgJELP1iYOmtDO/B7SQXnxCG5Li0oNKba0biQyuRMJ3zYJs/Eep4lxOfBQjFu+
         bc9d6chf93rdAfZ+7A96PsaZPRRUZMUgzbTl+ls5rpj8kp7Rmu86dzbLa9Wdc6GyJC/a
         gNREpkrQF8aLk8hPN7oz2bt1JjaDGQRHVxQRJEx+3M2clz2e5xJ6iJfXJaKWu8ypvAKr
         gmxJBLjvonZU8BBkYd3D/BGTvynyN4ThGvQEHWvocHx1yZC+jc+kPnB3heocqcbCkd8p
         JK69n+uxyKpr7i6fTftCC7OHKz8vSf4aGi2JoN9eT2+qe1dQKy9GgAv2B2BZSNQL8cTg
         O8lg==
X-Gm-Message-State: AOAM531+lfC85QhxW96hBhoeGib7vlV6qm7z13ZOmkc6xApME8PCZnr1
        OBdICK+Iz8diQ+X5TWlcLteIm7q3/AHnoITKE0v/xsU8OSFB9w==
X-Google-Smtp-Source: ABdhPJxUOmC7+DoT6Ef52aMcYFio4nZvL6CtGB3XS6K+omaXIweBB+BO0SHhqAJuqxEklHvLOOYtuDWhZdnbGt624j0=
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr1481432ljl.26.1611048982916;
 Tue, 19 Jan 2021 01:36:22 -0800 (PST)
MIME-Version: 1.0
References: <8218693.uYs0DeGetE@milian-workstation> <4450842.bcbERlpMrJ@milian-workstation>
 <CAM9d7cjvzO3D-vbf+-kFH1MbsiLhVxm4qAA=ySxe8FmiLKfMKQ@mail.gmail.com> <7161646.QLfhZlOSzD@milian-workstation>
In-Reply-To: <7161646.QLfhZlOSzD@milian-workstation>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 19 Jan 2021 18:36:11 +0900
Message-ID: <CAM9d7cihUNLX9wAWkNi5-J1HC4NPhD_mFW9EFc77t=SAFF10-A@mail.gmail.com>
Subject: Re: missing mmap events in perf profiles without dwarf callgraph
To:     Milian Wolff <mail@milianw.de>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kenel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Milian,

On Tue, Jan 19, 2021 at 5:11 PM Milian Wolff <mail@milianw.de> wrote:
>
> On Donnerstag, 14. Januar 2021 09:56:36 CET Namhyung Kim wrote:
> > What I noticed is ss->adjust_symbols which is set for user DSOs.  It does
> >
> >   sym.st_value -= shdr.sh_addr - shdr.sh_offset
> >
> > Maybe your program's section header has different values?
>
> Hey Namhyung,
>
> how would I figure that one out? Isn't that data shown in the readelf output
> above? Put differently: Could someone else maybe show his readelf output so we
> can compare?

I mean the below.  In my case, address and offset of the .text section are
same as 0x1080.

Thanks,
Namhyung


$ readelf -S a.out
There are 37 section headers, starting at offset 0x1df20:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .interp           PROGBITS         00000000000002a8  000002a8
       000000000000001c  0000000000000000   A       0     0     1
  [ 2] .note.gnu.bu[...] NOTE             00000000000002c4  000002c4
       0000000000000024  0000000000000000   A       0     0     4
  [ 3] .note.ABI-tag     NOTE             00000000000002e8  000002e8
       0000000000000020  0000000000000000   A       0     0     4
  [ 4] .gnu.hash         GNU_HASH         0000000000000308  00000308
       0000000000000028  0000000000000000   A       5     0     8
  [ 5] .dynsym           DYNSYM           0000000000000330  00000330
       0000000000000138  0000000000000018   A       6     1     8
  [ 6] .dynstr           STRTAB           0000000000000468  00000468
       00000000000000fb  0000000000000000   A       0     0     1
  [ 7] .gnu.version      VERSYM           0000000000000564  00000564
       000000000000001a  0000000000000002   A       5     0     2
  [ 8] .gnu.version_r    VERNEED          0000000000000580  00000580
       0000000000000040  0000000000000000   A       6     2     8
  [ 9] .rela.dyn         RELA             00000000000005c0  000005c0
       0000000000000108  0000000000000018   A       5     0     8
  [10] .rela.plt         RELA             00000000000006c8  000006c8
       0000000000000060  0000000000000018  AI       5    23     8
  [11] .init             PROGBITS         0000000000001000  00001000
       0000000000000017  0000000000000000  AX       0     0     4
  [12] .plt              PROGBITS         0000000000001020  00001020
       0000000000000050  0000000000000010  AX       0     0     16
  [13] .plt.got          PROGBITS         0000000000001070  00001070
       0000000000000008  0000000000000008  AX       0     0     8
  [14] .text             PROGBITS         0000000000001080  00001080
       000000000000201e  0000000000000000  AX       0     0     16
  ...
