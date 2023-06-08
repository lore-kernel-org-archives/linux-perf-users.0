Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D69C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 04:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjFHEO0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 00:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjFHEOZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 00:14:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267E2126
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Jun 2023 21:14:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so77615ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jun 2023 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686197663; x=1688789663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUEUsWqAnfxMExbFkdGQIB7uUxwQYCOKSOfpffmINLc=;
        b=w+nqRq3ADnAKIiEglg9JgAqNmyTKqzZmLrXsZ2gqdk5ycz8Azg518ZsoGJ9DUBuaz9
         scrVHUOk4sOHQFUmOA8vsnRPwh6ki8iHiOuxWTzXYwTomoEH/N1r+zSE/eygzRaOfXP+
         Cmj1B3kXJAbcmDpf+xWnzu31LWnFbNvBe3elQ/vs9gGPzq2BRuC6/ycSA2hPHZlWG0HY
         /2IJ72HsBYflc8mjrKVA7aKGgw0cVZwLZmbE8ieKpqVIAXV3kc6Vq/Pgzw2fuCxFoJKK
         XdZXZPsd4i7zxwLupjFjR+UTWlFTczKtiJD01EFBaScwklpkaIL0d+3IDadArtV5Idqr
         1Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686197663; x=1688789663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUEUsWqAnfxMExbFkdGQIB7uUxwQYCOKSOfpffmINLc=;
        b=l7b9uTIT1B8wk0DrRozf9UGSuXzbOVC3JAgQTywPZbpcnQQDLA2rBwTZcAoDFWrpzo
         VLm8PUYXlwDLETE0RbRKwOf+lq48cKF9YFNwj3sX6bJ97G4pJtSa2/1O1bzuaV8pSgEU
         zMoXyfm2Qjf6liZw9qTUH2DosD0YDWnWng7L/f44MGB9eiSuLTCv6jBFKewCzt1/VRCe
         iX/E3UUwN+xVY54AeAkiz2iByfLqYV9JS6gN3zVg7APQvTDSTceDLxN+dO9esHa9vOFi
         zr4bQRgMERJxTv8KWtlzXhRaHVhPCRPV9m+W/1NTu8q6Bgv+4PxoDsiUrSPOgUKH8bp5
         EWcw==
X-Gm-Message-State: AC+VfDwB9c9UI3hVAJPmqAgZfvCWzSwsgsMa/iH+PUrCFM691CFE/YpI
        3vcnISUVwY451+M/7qetG9jn6gTsdVEwoH0oStoY7ud4eic6decBkxkDiA==
X-Google-Smtp-Source: ACHHUZ467NMIqM2euwil/gFSbch99jluQasI/190TAmGmAN6+1At4aV/2iwcPDustlTg8+YS+iRiRWeFM6z+DqJ7Xbk=
X-Received: by 2002:a05:6e02:1d90:b0:335:6626:9f38 with SMTP id
 h16-20020a056e021d9000b0033566269f38mr152781ila.0.1686197663496; Wed, 07 Jun
 2023 21:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
In-Reply-To: <CAP-5=fU10YCxZfq=dOUUPR0dRusbq=vzp5CqsOuz1aLVY16KAw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Jun 2023 21:14:11 -0700
Message-ID: <CAP-5=fWOCE6+9MuiFziHz1o6Ej-FTDJa1fnkhYpifz7Rtazk8Q@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Office hours and chance for GSoC contributor sync slightly earlier at
9am PT tomorrow:

Linux Perf Tool Office Hours
Thursday, June 8 =C2=B7 9:00 =E2=80=93 9:45am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/jds-asbo-day
Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983

If you'd like to randomly drop in, feel free. An issue I'm keen to
discuss is memory usage and memory leaks.

Thanks,
Ian

On Wed, May 31, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Hi,
>
> On Monday the Google Summer-of-Code officially started and Anup is
> this summer's contributor to the Linux perf tool! We've found in the
> past [1] that having office hours is a good chance for contributors to
> sync and also for those interested in the Linux perf tool to also
> connect and share their problems and experiences. As such we plan on
> running our first office hours for this summer tomorrow, the details
> are below:
>
> Linux Perf Tool Office Hours
> Thursday, June 1 =C2=B7 9:30 =E2=80=93 10:30am
> Time zone: America/Los_Angeles
> Google Meet joining info
> Video call link: https://meet.google.com/jds-asbo-day
> Or dial: =E2=80=AA(US) +1 458-242-4309=E2=80=AC PIN: =E2=80=AA817 018 892=
=E2=80=AC#
> More phone numbers: https://tel.meet/jds-asbo-day?pin=3D6629252256983
>
> Please ask me and I'll be more than happy to add you to the calendar
> invite for this. Over the summer we can adjust the timing of the
> office hours to maximize participation, etc. so please reach out and
> share concerns.
>
> Thanks,
> Ian
>
> [1] https://lore.kernel.org/linux-perf-users/CAP-5=3DfWiQHvYZp5R=3Duw4xUw=
BiN1fBLBU8witPkYM+2r8tnYCOg@mail.gmail.com/
