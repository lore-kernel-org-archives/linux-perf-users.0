Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124EDC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Mar 2022 18:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiCWSEd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiCWSEc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Mar 2022 14:04:32 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E0130E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2022 11:03:01 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id a127so2342437vsa.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2022 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxMCeIULouJWFlbLIQ6Xsyx6h4OQz2uZBzxppk94Ikc=;
        b=QbQtUz6DXuztYjte6SDRrc4538jFfpZC0rdtF6513StXRQRfWLgGnYdyT4UXkiMSbd
         ynIRXgiMljiWRZd76t5BcfRTGvjKOsBrypbnSVtDV557XbuVOaMqd0IS1P2yOIJwJ7o6
         BFqOGFvtmimg+exBjGlG0wuWLxzth4DhWUn5HtzCDJaPScxDTjJuqYsk7uiVSm57tf0y
         p+GruvrMF/lsgMJ4nzPXA6KF2auVMKjCoXA+oXTteM04pDzlxbPVqc+pzRuRDqRuYJ/f
         ziDGV+V1kprtzjXudUmxExspYukRZY0sLSsElS8epeQn7z4g2C1wIiFt3Et+yE2XXcG0
         xy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxMCeIULouJWFlbLIQ6Xsyx6h4OQz2uZBzxppk94Ikc=;
        b=7vkDmg7WVzQ14nbWQsj+sVFUVGzmGTd2eL6Oxfu+z8YCYxcz/CCoEEmzDEIXbMNXjK
         2VkSW8CPdw1LU1oJSngK9JdQo33Uo7fAWYMbofwO1ccyJMIx00W2PL/hXz6rxblMSXA3
         VecZe5zxZlf58Y7z5mps81CUweHHrcHi3EUyglnreSg1z+uAcinAuG3xPAaSrKMSf3hU
         9bxUgi1jagy4vj4Tpf/cpqGne9ODpNnW83hVCk9LhUl8KhDpzkEgDUVsxbyZ4OrrgNqP
         NvWvj+F7xiQs2/tdDsJr0s3BKGLgKDFROylsLFhrNFxkFAD9BBfRhnYYUFRtkFEeQKSl
         3zNQ==
X-Gm-Message-State: AOAM533MZiuemqIsF1Ncdp7i7jwozokECCfG0b6jnQQoCIzz1E6O+JR8
        ia8aL6bwRaMmgNyAKgKH9UyKyUcDzqixyLdnnxkUUA==
X-Google-Smtp-Source: ABdhPJzvlqgJVzCXyVx+Ntg85bJFPjty/OajMNVpc4KNHpEnCrgYCZaQkHW720tCHTfmcEJXo2BOsksezs3a1rWs98Y=
X-Received: by 2002:a05:6102:3576:b0:325:46eb:fdde with SMTP id
 bh22-20020a056102357600b0032546ebfddemr595430vsb.11.1648058580840; Wed, 23
 Mar 2022 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBSKMU-r+AbYvZ9e17nZ70idCyxBQ4sUhKzhkTn-1JaTDA@mail.gmail.com>
 <CA+JHD90unShQ2pvEFRyr2FKD2+tDchrtBQHtZq+LEJxKQjLJ_Q@mail.gmail.com> <2febdfab-2b83-515a-ef73-0415c72a6fad@intel.com>
In-Reply-To: <2febdfab-2b83-515a-ef73-0415c72a6fad@intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 23 Mar 2022 11:02:49 -0700
Message-ID: <CABPqkBTK632bTz5hR_yHnYYCzEt=sdf-u_OxR80cjovwD=6Jgg@mail.gmail.com>
Subject: Re: perf record crash with Intel PT
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 23, 2022 at 8:31 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 23.3.2022 15.58, Arnaldo Carvalho de Melo wrote:
> >> On Wed, Mar 23, 2022, 2:06 AM Stephane Eranian <eranian@google.com <mailto:eranian@google.com>> wrote:
> >>
> >>     Hi,
> >>
> >>     I was trying some simple command lines with perf record from tip.git tree
> >>     and Intel PT and to my surprised I got an immediate crash with cmdline such as :
> >>
> >>     $ perf record -e intel_pt// -a -C 1 sleep 5
> >>
> >>     As soon as you specify -C you get a crash in:
> >>
> >
> >
> > I'll check that, but can you please try removing -a?
>
> Happens as far back as v5.9, also without -a
>
> Most likely the addition of "text poke" support because it is
> always system-wide, and probably breaks the indexing by cpu.
>
> There is another issue though.  Even for a single CPU, side-band
> should really be collected on all CPUs (like it is for text poke).

In an effort to limit volume of data, it makes sense to only monitor a
subset of the CPUs, i.e., where
workload of interest is running. So I think this is a valid use case
and there should be a way to
configure it on the perf record cmdline.
Thanks.
