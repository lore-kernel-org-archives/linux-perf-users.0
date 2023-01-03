Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF9C3DA7D
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 11:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjACLSt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbjACLSr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 06:18:47 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89026FAC4
        for <linux-perf-users@vger.kernel.org>; Tue,  3 Jan 2023 03:18:46 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so3961506ooa.6
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jan 2023 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oRW+qnZqo8xLJZmKMDcpomg1dIY+xQ+eUrRegPR4twU=;
        b=MZug2mtY9UjN21j6Uqw6EHzBkwpv01IIfTnTxW3LcBiXiGc6UNGVOiRVRfAiL1tMFR
         SucZlMop/N1q0AloljAYuqwFbo1zeGTGolI0uA3VXNSIhizc1Kp9DaVwtmWGdRmdIBm4
         6y6PzpLETkgws9y9hxwYFuDOlYj+TtEuhzbuX2tP6bYTDCPkS3iUhyAZXtSgJGL8b7sx
         GEf4ST+WdeWzFi/WfVoKrBXk6wc1lr0OHfGpkAoFuI8xV7YVQTXyvQ3o3LQTgJbnjQxN
         EDEQGmt3RH3P+CSX+jEYHbo1FGa5Y/ur1P6Me//hq/GPtuoPGbV9KlPDmp5BpwPttZWP
         EcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRW+qnZqo8xLJZmKMDcpomg1dIY+xQ+eUrRegPR4twU=;
        b=UJuoYB6Lf5tsbYl9oHGNxcBpKTbM4URa1FxmshZ7iRjrrzUXHCxL45tG+C9XA795Bu
         4L4WpB/kQBRpzIS4c1Hwd20KBKM6rEp2WJAhPBz6tRZgBb9P92MuaZghZIfmaTRyPVkH
         Mtsz4g8fuhFC/lpAEUlSBbl5OqY63ULOzQ6/v1N2Y58rT5d08jZyuTpi3lOFCiqQ76Al
         tNyDRcS5pyW5nL6n0ipSvcmVUi9D0GYeeyRvTkRITzajUupxQJOV4cAP5C9uX0xUdAFX
         17e9Kd401WKq9TvsGfmPYa4pXSljQhS6ubOsmNlAXJiqMp3vSh2yXAfcF55tDTL3Vyu/
         nLPQ==
X-Gm-Message-State: AFqh2krPViYXpzeREYyiBUL89h5IbzsrozGCtO36iYAibcvJ0HA+iqjd
        UiR1Zmv0Jwi5pLzI5LRq4nCxkCB11E6HSg==
X-Google-Smtp-Source: AMrXdXtGSCGvh76ORutHaf8lEbHpKWU3F6K1Tp7sDH+QWuqoaXffeB1XUIswjpdrwJ/Q/Q2+v0UO+Q==
X-Received: by 2002:a4a:4f89:0:b0:4a0:9768:ee8a with SMTP id c131-20020a4a4f89000000b004a09768ee8amr17987425oob.1.1672744725790;
        Tue, 03 Jan 2023 03:18:45 -0800 (PST)
Received: from [127.0.0.1] ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id m2-20020a4add02000000b004a3d98b2ccdsm12159033oou.42.2023.01.03.03.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:18:45 -0800 (PST)
Date:   Tue, 03 Jan 2023 08:18:40 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Ian Rogers <irogers@google.com>
CC:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [v6.2-rc1] Regression with installing perf tool
User-Agent: K-9 Mail for Android
In-Reply-To: <9560b967-a2ec-c370-7ec3-115295929e27@leemhuis.info>
References: <fa4b3115-d555-3d7f-54d1-018002e99350@secunet.com> <d372f704-fa4a-344f-7a15-d97bfb13ac1d@leemhuis.info> <CAP-5=fXkpbfxGo8ozTJRCXVm0eS6tZ+9XSLchTfcVHmvvhBq5A@mail.gmail.com> <9560b967-a2ec-c370-7ec3-115295929e27@leemhuis.info>
Message-ID: <BA4AAC11-A1DB-4F21-B186-F9BD6220750B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On January 3, 2023 4:29:12 AM GMT-03:00, Thorsten Leemhuis <regressions@le=
emhuis=2Einfo> wrote:
>On 03=2E01=2E23 08:13, Ian Rogers wrote:
>> On Mon, Jan 2, 2023 at 7:06 AM Linux kernel regression tracking
>>> [CCing Arnaldo]
>>> On 02=2E01=2E23 14:16, Torsten Hilbrich wrote:
>>>> I recently tried a kernel build based on v6=2E2-rc2 and had some regr=
ession when trying to install the perf command=2E It seems that the commit:
>>>>
>>>> commit 746bd29e348f99b44c14cb2b2a57f1d3efb66538
>>>> Author: Ian Rogers <irogers@google=2Ecom>
>>>> Date:   Tue Nov 15 23:22:11 2022 -0800
>>>>
>>>>     perf build: Use tools/lib headers from install path
>>>>
>>>>     Switch -I from tools/lib to the install path for the tools/lib
>>>>     libraries=2E Add the include_headers build targets to prepare tar=
get, as
>>>>     well as pmu-events=2Ec compilation that dependes on libperf=2E
>>>>
>>>> Causes the the following command to fail: "make -C tools/ perf_instal=
l"
>>>>
>>>> Full logs are attached as file=2E
>>>>
>>>> The basic error is that the adding of $(LIBAPI), $(LIBSYMBOLS) and ot=
hers to the prepare target seems to has problems when the subdir variable i=
s set by the tools/Makefile=2E
>>>>
>>>> The call chains seems to include
>>>>
>>>> - "make -C tools perf_install" which calls:
>>>> - "make  subdir=3Dperf --no-print-directory -C perf install" which th=
en fails
>>>>
>>>> The beginning of tools/scripts/Makfile=2Einclude then seems to constr=
uct a name like /build/git/linux/tools/perf/libapi/perf/ (when building in =
/build/git/linux) and this directory does not exist=2E
>>>>
>>>> We only need the perf tool in this case, so we don't care much about =
the optional features which are missing=2E
>>> Thanks for the report=2E To be sure the issue doesn't fall through the
>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regressio=
n
>>> tracking bot:
>>>
>>> #regzbot ^introduced 746bd29e348f99b44c14cb2b2a57f1d3efb66538
>>> #regzbot title perf build: problems when trying to install the perf co=
mmand
>>> #regzbot ignore-activity
>>=20
>> Thanks, hopeful fix in:
>> https://lore=2Ekernel=2Eorg/lkml/20230103070916=2E2407873-1-irogers@goo=
gle=2Ecom/
>
>In case you need to respin that patch, please add a Link: tag to the
>start of this thread to make things easier for future code archaeologists=
=2E

I'll add it when processing the patch latest today=2E

- Arnaldo

>
>To explain: Linus[1] and others considered proper link tags important in
>cases like this, as they allow anyone to look into the backstory of a
>commit weeks or years later=2E That's nothing new, the documentation[2]
>for some time says to place tags in cases like this=2E I care personally
>(and made it a bit more explicit in the docs a while ago), because these
>tags make my regression tracking efforts a whole lot easier, as they
>allow my tracking bot 'regzbot' to automatically connect reports with
>patches posted or committed to fix tracked regressions=2E
>
>Apropos regzbot, let me tell regzbot to monitor that thread:
>
>#regzbot monitor
>https://lore=2Ekernel=2Eorg/lkml/20230103070916=2E2407873-1-irogers@googl=
e=2Ecom/
>
>Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
>[1] for details, see:
>https://lore=2Ekernel=2Eorg/all/CAHk-=3DwjMmSZzMJ3Xnskdg4+GGz=3D5p5p+GSYy=
FBTh0f-DgvdBWg@mail=2Egmail=2Ecom/
>https://lore=2Ekernel=2Eorg/all/CAHk-=3Dwgs38ZrfPvy=3DnOwVkVzjpM3VFU1zobP=
37Fwd_h9iAD5JQ@mail=2Egmail=2Ecom/
>https://lore=2Ekernel=2Eorg/all/CAHk-=3DwjxzafG-=3DJ8oT30s7upn4RhBs6TX-uV=
FZ5rME+L5_DoJA@mail=2Egmail=2Ecom/
>
>[2] see Documentation/process/submitting-patches=2Erst
>(http://docs=2Ekernel=2Eorg/process/submitting-patches=2Ehtml) and
>Documentation/process/5=2EPosting=2Erst
>(https://docs=2Ekernel=2Eorg/process/5=2EPosting=2Ehtml)
