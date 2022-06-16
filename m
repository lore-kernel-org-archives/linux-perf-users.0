Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FAC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Jun 2022 13:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376623AbiFPNvI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPNvH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Jun 2022 09:51:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FF41328
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jun 2022 06:51:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso907107wmc.4
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jun 2022 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Pyl38ceVjrIW1c30TawCoejYx227J9bIxfwp7o3daC4=;
        b=qMUebGplo+1xtHmPOh8EEYngObKSIHgSuISTJ6LqJf62ksELZLeupsYB2+B60GbaoF
         FPmZ7mjY91juku/s1CHFy+fIS31KBf+KSJsMm3XmR1a8yzof1TaOq5Ef3GYWjl9YbEUu
         jnG4+UYOPmGBnD3EVVd8LKyVIsQFOOtyl3q30zsViIeBgVGsYWEFBe9pnybO1+LFLApC
         iXf0yuZtz41Hc3srGBGUmjj2h/O16t+LFmcPaG/t6g/oMsGJj2Z/2TN+hTFQyfoFKKFX
         2ya2sAD/wIHwFV76ST6CSt6ftLTqHqmbaAFMIOIyL5SIPEFJv9GmrC+JVqxvmRbQXiYB
         h1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Pyl38ceVjrIW1c30TawCoejYx227J9bIxfwp7o3daC4=;
        b=50FrJYuQ3wCuANo9qbBLzHSvVZ0pf0HWSi3wnX4VfYuOjI2/l/jN2ZWCZ12uMRISsi
         FQuOSYcmp5uflmb/AzaheI1B6UV6wNR6/m8rqHkydDrueEOH7o4ehUcvZFyNZde+vv5C
         3ooTvtOpZgvcuHr1MNaR72ASeRhBC+bIU/AqmHDHD78fjaShVI2vlxqdRGAxm3ayiXrl
         6xZ3zZqbcTU9AwQ0+POSWdW7VYHOvk9/gQVa5Jq025oJiSoAZzj4HKcrb4Xws8d/9yAf
         vKldMyNiI+rcrWKNArcb2lzFIG5gVH4GNqnm5AWLQQkkI2Pe5jOfnGp/Mdqi5hlJS5yy
         WFKg==
X-Gm-Message-State: AOAM533ygLbv0w/e5rQ0ai/ayglIYz+hstrHXQarTQd1xcu/ez+56ZvU
        jj1EEOnby33X2A7MjH3FQrtcAqGug1p4PwblsXG9kDJO2yI=
X-Google-Smtp-Source: ABdhPJzuNRM5/TKGljiSmCFBTmt1QgbFNlgtwXKpZp9+9+oLIzTCo85eD8qeAGuZr7jJI5egArx5De5RKaMa/gA5Mag=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr15693066wmk.115.1655387464083; Thu, 16
 Jun 2022 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fVdLBjQa4ptJGMfSSm69d=vezqLr=ZwoCk8J1R4OPVTgQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVdLBjQa4ptJGMfSSm69d=vezqLr=ZwoCk8J1R4OPVTgQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Jun 2022 06:50:51 -0700
Message-ID: <CAP-5=fVT8OoZKOzfOrmHkE=Aod9=kadUXrGtCqTOggoudpVrcg@mail.gmail.com>
Subject: Re: June 16th - office hours
To:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A reminder that this is happening in 10 minutes.

Thanks,
Ian


On Wed, Jun 15, 2022 at 11:24 AM Ian Rogers <irogers@google.com> wrote:
>
> Hi,
>
> A reminder that there will be another office hours tomorrow at 2pm
> GMT. The around the world times I believe are:
> China: 10pm
> India: 7:30pm
> Europe: 4pm
> UK: 3pm
> US east coast: 10am
> Brazil: 11am
> US west coast: 7am
>
> If you experience problems then my email can be used for Google
> hangout messages, I'll try to be on IRC (#perf on irc.oftc.net).
>
> A reminder that the code of conduct is here:
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> More details from the first office hours are here:
> https://lore.kernel.org/linux-perf-users/CAP-5=3DfWkxtm5-Ebwkh4pzA83prvuA=
J5yy6CKQYatdkKWu3Tgeg@mail.gmail.com/
>
> The Google meet details are here:
> Linux Perf Tool - Office Hours
> Thursday, June 16 =C2=B7 7:00 =E2=80=93 8:00am
> Google Meet joining info
> Video call link: https://meet.google.com/goj-quks-ydn
> Or dial: =E2=80=AA(US) +1 301-969-4101=E2=80=AC PIN: =E2=80=AA374 496 227=
=E2=80=AC#
> More phone numbers: https://tel.meet/goj-quks-ydn?pin=3D8067739163431
> Notes (ask to be added to see):
> https://docs.google.com/document/d/1tQZvJ12czMedpmLLZWS0XILAte97zdR6H_tgC=
3Ivafs/edit?usp=3Dsharing&resourcekey=3D0-iV9_8Oc0cSOPl0-NvEYDAA
>
> Agenda:
>  - It is the first week of GSoC so we should do our first check in
> with the contributors.
>
> If other people have agenda items then please reply-all to this
> e-mail. I believe there is interest in discussing hybrid plans - I
> don't have hybrid plans but if others want to discuss this then please
> let me know.
>
> Thanks and I hope to see you tomorrow,
> Ian
