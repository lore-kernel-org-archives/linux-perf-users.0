Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A9C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5036113B
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhKFBCJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Nov 2021 21:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhKFBCJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Nov 2021 21:02:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52650C061570;
        Fri,  5 Nov 2021 17:59:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v20so12072665plo.7;
        Fri, 05 Nov 2021 17:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6MtQiK0S3jEjVIoI0yvzlZnXKtUnQBiKLDp70ATlbuQ=;
        b=fQuZRtlmS8kdQulOEfsq+Hm6UoSh8P0PrHAH7HupdnbQ7gJY3sqDaB7q7zsdpUlkAd
         CgZyT8SnMI+ZTdVFvSL7L45AO/T2nkqO2HxRnh3LwtsZp4OBYGoOSmPBbrBdQsQYwpRy
         FMX/zegttPwcWeW/W8wjjgo2/bBHYKjXHATijHwAFKKTvEy4Dj/8ZsQDeXYohqbLtCct
         NqCHaisaV7ZClFFZkDMam8YXZtHYchy/MXh4le+3YdYIJNI5B2tR5yCE/GZ339OZ7qSd
         p941S6QV2ilMv2C80IOnVGs5eEf+3s65qw/JnidQ/gFW8CZzbV0cUfk7+JhmQEeMYrhm
         0Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6MtQiK0S3jEjVIoI0yvzlZnXKtUnQBiKLDp70ATlbuQ=;
        b=uFHVQYBy6hjxP13M2rbRVQJ4D0ny0p84hDOCVGWOCXaS/yV045JuPb9PJG9ePsYw3q
         +glKaQ2NamjqgfoCj1r4l7vK4fdLzNmNrqV1bmMy0j/K9xELevi62w9i5P0XU24EE4xM
         w7XM8+Yyp7oN0JFW5JGekjW0qwwabcPS0wzEzN12bnPeh7r9G27MXejDTzuPpyM2IG9O
         F4ijqT5XpuFRVbfL8KgfXn+xDi0mLRCllnfuu0ZnWHPlcrOQNXllyKufK7Q8c9b3L+Fk
         Vll/ElLZYpMU5m/exnRmmoAEEu9x3toj7dhVdKX1WVSoAnsK3eOywTBhIsske4/PAaQj
         eipA==
X-Gm-Message-State: AOAM5338rdkmNofzdlbLPxX04ZkNHcTSVcgSaMylyFHxpePsTu2DKiVc
        831cL07qlI1LC7wmFNfUj8dAGM4u85M=
X-Google-Smtp-Source: ABdhPJzaP3t3P/mo2m2s/kgf65HugB1NDhWliP3aL09rWkIackdenE0svdaW6qo87Kgmr4uIAzrTMA==
X-Received: by 2002:a17:90b:4ace:: with SMTP id mh14mr9096647pjb.164.1636160368455;
        Fri, 05 Nov 2021 17:59:28 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w185sm8263341pfb.38.2021.11.05.17.59.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 17:59:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Using perf_event_open() to sample multiple events of a process
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
Date:   Fri, 5 Nov 2021 17:59:26 -0700
Cc:     kan.liang@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB6138F5-29A4-40AE-8307-6C3ED07A0649@gmail.com>
References: <92645262-D319-4068-9C44-2409EF44888E@gmail.com>
 <YYXQRYbRO193U4re@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On Nov 5, 2021, at 5:45 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Nov 04, 2021 at 10:57:50PM -0700, Nadav Amit wrote:
>> Hello Ken, Peter,
>>=20
>> I would appreciate some help regarding the use of perf_event_open()
>> to have multiple samples getting into the same mmap=E2=80=99d memory =
when they
>> are both attached to the same process.
>>=20
>> I am doing so (using both PERF_FLAG_FD_NO_GROUP and =
PERF_FLAG_FD_OUTPUT),
>> but it results in -EINVAL. Debugging the code shows that
>> perf_event_set_output() fails due to the following check:
>>=20
>>        /*
>>         * If its not a per-cpu rb, it must be the same task.
>>         */
>>        if (output_event->cpu =3D=3D -1 && output_event->ctx !=3D =
event->ctx)
>>                goto out;
>>=20
>> However, it appears that at this point, event->ctx is not initialized
>> (it is null) so the test fails and the whole perf_event_open() =
syscall
>> fails.
>>=20
>> Am I missing something? If not, I am unsure, unfortunately, what the
>> proper way to fix it is=E2=80=A6
>>=20
>> I include a small test that fails on my system. The second
>> perf_event_open fails due to the check in perf_event_set_output():
>>=20
>=20
> Works when you use the SET_OUTPUT ioctl()...
>=20
> I think something went sideways in the syscall path and things went =
out
> of order :/ I'll try and have a look.

Highly appreciated.

While at it, I would note that there is a mistake in Intel SDM =
31.4.2.27,
Table 31-47 =E2=80=9CBlock Item Packet Definition=E2=80=9D. The ID[5:0] =
takes 6 bits,
when in fact I presume it is only 5 bits (according to the table).

Perhaps you can forward it to the relevant people.

Thanks again,
Nadav=
