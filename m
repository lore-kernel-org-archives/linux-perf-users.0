Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D6C6FD1F
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCWAcn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCWAcm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2023 20:32:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151E1E9E6
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 17:32:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ddbf70d790so158651cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2023 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679531559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu5Ppfnx6VYzPNfHOJ/hTuJbgt+v9oOxiqjAV0/VXEo=;
        b=oQyWh7TMz0j+h1kSZ9MtD0miQOOG3pvt2rV45soCOagJOwPVWGOcagAdUbRFOe+r8X
         auLP0OLKRn0JERMooxeDJj5xPWOIuaPsukhHR+iirxgh25rTIopdd4FQLpwVt4+l1Y5z
         XwBM7KMa0h2pvCb1obd9pV0fhGGhvMln+h5EBOn9Z/nKbJZ8+XkX2+673wLEmNqL5Pv3
         mVcsnqWtQKkC317kWzgQEYtNUHMXm5SGI2Vzlx3j31cdCQnFLYhU6TLaDOJ+RuWCVL6Q
         cskS0m4OlgytatTtsJbi2xlBn5UOTq66FTYCd5vVENgp/VzPExdPjZew/FoGw82SvBYD
         c3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679531559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu5Ppfnx6VYzPNfHOJ/hTuJbgt+v9oOxiqjAV0/VXEo=;
        b=KTnvQDHv33YhEk9d/kS7eo2IVdHYnTdxHWQV1wRiNHf6XJ2WYnvMlEkD5+6PYrjTim
         KQpDm++b2dTxQMRKytleveDrKjJJAXOgQ8N2/wvKnNWzkEgxEpqNNGA+MFG6g1S/sAH0
         2EGnf4ajSO40RJ+LLCsUH2cTjf7QURlde8tIS7L/BAXBniac1zziHs/MFDnQCcS2OCk/
         yfmElj/F8SENI3T8o4M4/3xA35FRQOJZGDQF9fcxxcNJc/ngeMedWIlc83gBNM68V2AV
         QRSUTJ49c1OnKYhkAoJDGOW3coHy+HoapDSJsvoJWz79BF/DMkM73z0aZLGtEbxfZids
         qiYg==
X-Gm-Message-State: AO0yUKXmxyqHoPoAwXLrfq7ZXXs6WTFIlkC7V/zkgCnyERRwANjx8Tz+
        pWCtW6PTlElCk5lVIpgPwzCx8SWkIU2HL0tXzpWKxhOtpb+A88RWyHUPxw==
X-Google-Smtp-Source: AK7set/8GCh3LMa0iFnY+bD3AxH0fIJRYMsDYgpwzhnRYZ2p7pkBmJ0cyz9dtf+KSfBFJNzGdgcsh6Pu3bi6ioPm5w4=
X-Received: by 2002:a05:622a:1496:b0:3bf:d313:77dd with SMTP id
 t22-20020a05622a149600b003bfd31377ddmr165774qtx.14.1679531559474; Wed, 22 Mar
 2023 17:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOBGo4z=LObbQ-KRRuH__pFsC=1r1jQ2r0e3TbCTeweA9YsDxA@mail.gmail.com>
 <01A1CCF5-C9C0-484B-A1B7-08514CE5453F@gmail.com> <CAOBGo4zGRSYrq1qCPneEdH8FcOO=4C8DXb49Rk0aaiOE2rk5ZA@mail.gmail.com>
In-Reply-To: <CAOBGo4zGRSYrq1qCPneEdH8FcOO=4C8DXb49Rk0aaiOE2rk5ZA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Mar 2023 17:32:25 -0700
Message-ID: <CAP-5=fVf8YPJGHDBa=LTHyGTbMGsX4XiSWyTo6Y77AMy7TfHrw@mail.gmail.com>
Subject: Re: Cross-arch analysis
To:     Travis Downs <travis.downs@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Mar 22, 2023 at 12:47=E2=80=AFPM Travis Downs <travis.downs@gmail.c=
om> wrote:
>
> Thanks for the quick reply Arnaldo!
>
> As luck would have it, perf-achive.sh is apparently not
> packaged by Debian or Ubunutu (and the bugs have gone unanaswered) but
> it's straightforward
> to grab the script from elsewhere.

Fwiw, I see it on Debian:

```
$ dpkg -s linux-perf|grep Version
Version: 5.19.11-1rodete1
$ dpkg -L linux-perf|grep perf-archive
/usr/lib/perf-core/perf-archive
/usr/share/man/man1/perf-archive.1.gz
```

Thanks,
Ian

> On Fri, Mar 17, 2023 at 10:28=E2=80=AFAM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On March 17, 2023 10:02:37 AM GMT-03:00, Travis Downs <travis.downs@gma=
il.com> wrote:
> > >Can I run perf record against a binary running on say Arm64, then pull
> > >back the perf.data file
> > >to an x86 machine and run perf report there?
> >
> > Yes, and to gather DSOs with samples, use 'perf archive' or point 'perf=
 report' to a directory with the arm64 OS image using --symfs.
> >
> > - Arnaldo
