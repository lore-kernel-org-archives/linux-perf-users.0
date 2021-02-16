Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F6FC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Feb 2021 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D91B64DFF
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Feb 2021 07:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPHvh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBPHvc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Feb 2021 02:51:32 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E6C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Feb 2021 23:50:51 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g11so10671233ljj.7
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Feb 2021 23:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=880oX04tISf6P0btK8lKR95ADDSRc57TWRBocP5h01k=;
        b=Xu0D0bLAwkNTRkdwxcFt0UXJDHETKu9prTUuKiGyT+Ih5cXI5Ug2m0U+5PyncxK1Xm
         kpfDt0yQPEr4IVG2xI0crpT6Rx0pNf1f/RpEk3wolkgxlyT/aD0aPEKaJGqLrUHE2kbH
         r8b6MGfY7tIuerNny8tmvAxKf8dbJe8zg44QzRPmFCiBBnjh/Ny6Cp+5O7QODHZ/EUhJ
         lvzLyiZgEpPmgZE9t8pgBUTm5JXf4jWBaz30ZfLVzukxkxMxLQPzwUAf/Ab2kvuDHUMR
         lXLBbJeqiFvxHPos8QQlRTGTdXbzvVz+g2910PFLRtnz6sxjbVIs6NaQwwQmhrz2CA2t
         Tb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=880oX04tISf6P0btK8lKR95ADDSRc57TWRBocP5h01k=;
        b=S9GyVKr+yzShxWp6fLUkvjV9ALWV1Lpq+EUCdrm9Tr1BK6OWdBmwQbtIsvZq7hMEUY
         Fp/i1MiPRyd9ivrOrU34QI9s3yZURNTYzNM8HfZnKb4cwq0E7g6UklFeADhuQIFzBbvV
         NR6IfGt8RWP6Tq1EWOm7CeCM1mIGEywSC0jAHrzkyPIbPsuXjEfn9BHuWnq58fqxDpV9
         6OHz7vQLhP+Ssihw86WQLJyYExxKDY73PTIDZMbry0D5djuPml8WdtqgEyxv/JhKvFBa
         ZTRbfxngBg1RNzSGjvx7gAopguAp9iCp1EsHetqfmcenkbZ0BK2bqpwqKXFs6FoSVA31
         e3rA==
X-Gm-Message-State: AOAM53207PyJm1uGEbH/QLZHws3bnuIOtQJassX9rrg4Y44qlJP4UkED
        5UjTXFYOlvegq2HyYr639QMvc0nZYPdHZefQhSQ=
X-Google-Smtp-Source: ABdhPJywqH6rlUYFy3436JMGEFH562zL+5XgWViwU1KrZdGz+YUhZXZfz3TqBz3FL2ssQOezKQI0+IDa9lmr8Lxtrtk=
X-Received: by 2002:a2e:b8c6:: with SMTP id s6mr11181200ljp.275.1613461850323;
 Mon, 15 Feb 2021 23:50:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
In-Reply-To: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 16 Feb 2021 16:50:39 +0900
Message-ID: <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com>
Subject: Re: [Question] How to sample PERF_TYPE_HARDWARE
To:     rainkin <rainkin1993@gmail.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Mon, Feb 8, 2021 at 12:50 PM rainkin <rainkin1993@gmail.com> wrote:
>
> Hello~
>
> My goal is to record the number of occurring PERF_TYPE_HARDWARE events
> (e.g., branches) every N events.
>
> In my understanding, the "perf stat -e branches -I N " command is not
> sampling, it is actually count model which records branches every N
> millisecond. Thus perf stat does not meet my goal.
>
> For the "perf record -e cycles -b" command, it does sampling, which
> records a LBR sample every N cycles events. However, it seems that
> "perf record" does not support sampling PERF_TYPE_HARDWARE.

The 'cycles' is a PERF_TYPE_HARDWARE event.

>
> I also look at the syscall perf_event_open, but still cannot find any
> documentation about how to sample PERF_TYPE_HARDWARE.
>
> Does anyone know how to do that=EF=BC=9FAny suggestions is helpful for me=
 :)

  perf record -e branches -c N

?

Thanks,
Namhyung
