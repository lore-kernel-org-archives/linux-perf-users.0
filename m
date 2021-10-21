Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EDC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 14:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFE460F50
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 14:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUOib (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOib (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 10:38:31 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129DC0613B9;
        Thu, 21 Oct 2021 07:36:15 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id f3so1607734uap.6;
        Thu, 21 Oct 2021 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ajoqDPP656VX5YEBu8I1q77ACKKc8Lf1fY/olzortAE=;
        b=Ksty8m03gG131TGw1j2LHYW3Zz1euVw4MAxFJlvy2qBz+f6yYAdDVVmRgxYravk+7c
         +bK7+cfHA6ic35LCl99nvibR/LuX7wugyZuxWFclwiWwyWOP1m1QpO9HEsWuU3BAYY1L
         mUrPZtGfWWOPbGofXxF/CJ6zrBMz2nPIHfBeaoTSKmKLK4Dzsz3phMHTaqAWlDWEVOUz
         lmgTBZ6QxXQ7/iiqo9k/aWp+Stc3HgGD0FgPAupGnH6CO8equjMzhr06ExcNCHtEY7yr
         Iy5yhmXUFAh4rpgCpwsYn1+LA7HMil6t6bpvND0J4OzdCGvT4Yus3tMeBiavu7g2mR9B
         SSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=ajoqDPP656VX5YEBu8I1q77ACKKc8Lf1fY/olzortAE=;
        b=ny5eVMy3uIpLCOI+6lNFsAbt3Byxnd0dRNrsbZ2dkw6e9OUWGoBxL7jJGxPppxb1Ln
         urrV8pyItf3oAAFpk7LGBok31ho6uKX2en1qntew01/nwb0YqWFRsj6CdVOrZdGWLFB1
         KAwIz3TyuW//J05jKxNWjNDtK09mEFF+SLfNaaO9brgoVEUW9UV+lVKcJWpvEGt5um5G
         shmAMWEZ7PBj3IsOZgEnwstBwhaE0VQq8U7bQg/tjxhkRIuxhDVMCukAR4rxIuZSoLEa
         e5GpG8k+oZIZeq2gURDHgEAYTXUfdoaW4cGHY8kLH1x9xmuub8l9CFmmg8Thed14g9yQ
         8ucQ==
X-Gm-Message-State: AOAM532RluNbYv/OsJUD0kQmwpGYyaDQlbzJZVHSaV4IdqSS25CfXvVR
        ABqeYx/buarfY/UBUREeWUw=
X-Google-Smtp-Source: ABdhPJzs3fIDRsfWoXgUCGIUOec9z2VIIpcFKSpSfazaeuxbj6y7WC1joJGMkog/7P0aRTBHrdrSTw==
X-Received: by 2002:a67:e1d2:: with SMTP id p18mr6418032vsl.30.1634826974436;
        Thu, 21 Oct 2021 07:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([187.68.192.38])
        by smtp.gmail.com with ESMTPSA id s8sm2986617vsk.18.2021.10.21.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:36:13 -0700 (PDT)
Date:   Thu, 21 Oct 2021 11:36:03 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 0/2] perf jevents: Enable build warnings
User-Agent: K-9 Mail for Android
In-Reply-To: <9075dc5c-25a2-c977-a1c2-675e972115e7@huawei.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com> <YXFjSR6ZRQbMjiG3@kernel.org> <9075dc5c-25a2-c977-a1c2-675e972115e7@huawei.com>
Message-ID: <0B2C61AB-3F0D-4618-B0AD-7143C44B4A3A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 21, 2021 10:02:41 AM GMT-03:00, John Garry <john=2Egarry@huawei=
=2Ecom> wrote:
>On 21/10/2021 13:55, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Oct 21, 2021 at 05:16:43PM +0800, John Garry escreveu:
>>> Currently jevents builds without any complier warning flags enabled=2E=
 So
>>> use newly-defined HOSTCFLAGS, which comes from EXTRA_WARNINGS=2E
>>>
>>> Changes for v2:
>>> - Add Werror, Wall, and Wextra (James Clark suggestion)
>>=20
>> Thanks, applied=2E
>>=20
>
>Hi Arnaldo,
>
>Can you please wait until I check the review response from jirka?

Sure, it's not published, and will not be until some fixes are made=2E Hav=
ing it in my local tree gets it tested together with the whole shebang in l=
ots of containers=2E

I collect reviewed-by, etc as they appear=2E

- Arnaldo

>>=20
>>  =20
>>> Baseline is acme perf/core + mainline commit b94729919db2 ("perf jeven=
ts:
>>> Free the sys_event_tables list after processing entries"):
>>>
>>> 680453e63302 perf jevents: Free the sys_event_tables list after proces=
sing entries
>>> be8ecc57f180 (origin/perf/core) perf srcline: Use long-running addr2li=
ne per DSO
>>> 2b775152bbe8 perf tests vmlinux-kallsyms: Ignore hidden symbols
>>>
>>> John Garry (2):
>>>    perf jevents: Fix some would-be warnings
>>>    perf jevents: Enable warnings through HOSTCFLAGS
>>>
>>>   tools/perf/Makefile=2Econfig      |  5 +++++
>>>   tools/perf/Makefile=2Eperf        |  2 +-
>>>   tools/perf/pmu-events/Build     |  2 +-
>>>   tools/perf/pmu-events/jevents=2Ec | 10 ++++------
>>>   4 files changed, 11 insertions(+), 8 deletions(-)
>>>
>>> --=20
>>> 2=2E17=2E1
>>=20
>
