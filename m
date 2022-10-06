Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FDC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJFUdN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiJFUdL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 16:33:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E858BEFA5
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 13:33:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso3498243wma.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0z0FmLDGVJmFP1eG0Or9KNKWQKi1PS0YZ0eW02ErW0g=;
        b=rrhoJJG2xGnk8C+uGS+drteumclirqA6/njpzCmSrhWoC23u0TmXGwWE1B2f3XkXdV
         boJELV69wmNR3VYt11tROQqKvdxzNDNag5UIVrEpuWSGzRXE3Ek4Tjn9QBCfIFtg3ZK4
         b9MxM3xzfWFJKu8Rf9GB6lXAkvrsdJgbYgKd/9MJqaaHueDSS5w5jmb24qag/2oCmv93
         bTlvZogMag2bybKYUvvWDKoEZRRzDKAAeAas4f7t8Gc9VlRykoubD54avnlwGzV5ILIu
         gVm+zg0ZGHfYYYdxPUlxNjflHoSBrEguslAtH77qJfnQTMe+TyLDRlU7LscgBEk7LqOh
         x6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z0FmLDGVJmFP1eG0Or9KNKWQKi1PS0YZ0eW02ErW0g=;
        b=BcYfjBk5dHAB/t4tQPVDNnu1yuu+NQZDqO8JXOrS44QvrrfHZWLu39OR0wGBP8EUmf
         zaUyMI0qbx+4Ik/qfUJaaKjCbxkIUPH0CJMKHhl3z0qIlQQQdXFJXKKYaxLboWdH2Pes
         uLV5h3/lxX0KHiNauHpV6yReiPzWNyeqf4sdKv8QQhG2BMzJg+3BTW9DT7HFZf8vbGYA
         pLoCGmkLKmZYdhtXiMHN3bbjqQnIZqlG7FK+nYIHJmDQVT3mW2fZy0Elds+roTaBuzLN
         52fYHggncsxQi/z8c7Y0ZDxKIiZPmp7L33HlUckqSIbxrFMwQZ0QDRIkH1JpomE1B3FH
         Bx5A==
X-Gm-Message-State: ACrzQf2fbxZbVFkXKpL43rlYzMPEUfuntJwapNxXlIvJkH1/RQRbZepB
        Z6dGrW6CtVcHjhp1whP++Za0SgGl2uPQdemRTk/KyQ==
X-Google-Smtp-Source: AMsMyM6qbtEjWGvL3qBt+7dqLCuhPT8hx4mmZzVv16Dp0ehpR4MXnzxFlGe4g6KD4e59UtuTiC2K7EoNFBKLU4QKdoQ=
X-Received: by 2002:a05:600c:4b88:b0:3bf:98ea:ba92 with SMTP id
 e8-20020a05600c4b8800b003bf98eaba92mr1023019wmp.174.1665088387686; Thu, 06
 Oct 2022 13:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221006142852.mhrgi3r4fvtkircw@altlinux.org> <20221006151622.i45co6lioxgheval@altlinux.org>
 <CAP-5=fXqQpcVk+mzPpM9vC=RHTcZvm4Ng14dJ0Uax4kCQ5Qa7Q@mail.gmail.com> <Yz8uJ9gdYOUIuhIL@kernel.org>
In-Reply-To: <Yz8uJ9gdYOUIuhIL@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Oct 2022 13:32:55 -0700
Message-ID: <CAP-5=fUyii52yHDmRvrkHBkNqbmhGH5KLFSV=KrQTeYht6MO3w@mail.gmail.com>
Subject: Re: /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No
 such file or directory
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 6, 2022 at 12:36 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Oct 06, 2022 at 10:20:34AM -0700, Ian Rogers escreveu:
> > On Thu, Oct 6, 2022 at 8:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
> > >
> > > On Thu, Oct 06, 2022 at 05:28:53PM +0300, Vitaly Chikunov wrote:
> > > > I noticed that perf examples do not compile anymore with v6.0 (first on ALT,
> > > > but on Fedora is the same). Fedora example for convenience:
> > > >
> > > >   # dnf install kernel libperf-devel gcc
> > > >   # cc /usr/share/doc/libperf/examples/counting.c -lperf
> > > >   In file included from /usr/share/doc/libperf/examples/counting.c:8:
> > > >   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
> > > >       9 | #include <linux/compiler.h>
> > > >       |          ^~~~~~~~~~~~~~~~~~
> > > >   compilation terminated.
> > >
> > > This is introduced in b2f10cd4e805 ("perf cpumap: Fix alignment for
> > > masks in event encoding") just (it seems) for `__packed'.
> > > I am told that all uapi is using  __attribute__ ((__packed__)) for that.
> > >
> > > Thanks,
> >
> > Thanks for reporting the issue and sorry for the breakage. I'm not a
> > dependency/packaging expert. Arnaldo, what should be the next steps
> > here?
>
> I guess we should just use '__attribute__ ((__packed__))', as its what
> we see when grepping for attribute on /usr/include/linux/
>
> But t his patch seems to simple remove the packed, no? I.e. is that
> packed really needed?

The packed came from undefined behavior in the disk representation of
the cpu map (perf_record_cpu_map_data). Unfortunately there are
unaligned __u32 and __64 values in perf_record_cpu_map_data take for
example the case where bitmap entries are 32-bit (long_size == 4):

perf_record_cpu_map_data {
   __u16 type
  perf_record_mask_cpu_map32 {
        __u16                    nr;
       __u16                    long_size;
       __u32                    mask[];
  }
}

when mask is accessed it is necessary that the compiler know it is
unaligned (2 rather than 4 byte aligned). Removing the packed would
mean that the alignment on mask would change and so would the disk
representation. This would break reading old perf.data files. The
previous code would pass __u32 pointers to mask even though it was
unaligned, triggering undefined behavior errors. The code now passes
around a pointer to perf_record_cpu_map_data as the compiler knows
from the packed attribute that the mask is going to be unaligned when
accessed.

Thanks,
Ian

> - Arnaldo
