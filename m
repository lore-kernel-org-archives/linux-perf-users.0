Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B8C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98DB60ED7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 22:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGWVrp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhGWVrp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 17:47:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A7C061575;
        Fri, 23 Jul 2021 15:28:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e21so221487pla.5;
        Fri, 23 Jul 2021 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Sk6j9y98rQEk0nftaA7SWqmAdhrxmLBfOzmiEbrijuo=;
        b=jG83Y/HaZ/LJxRsubsz0mZFIj9x2j2FC+fRWpdD1uNl8cb0XS1vyuI2LHzI0MdZuld
         W05x68qwhHyF0WlKWf1oifIa4EpRyn+cldGkf6Yh8OfRsKvtT1dbXXqD3HZbCVYaQa/g
         PG+9euDAEbsITvM4olAQdA2oB0q+0jLfenm9aXz9NPxmtZb9ENtMzKKE1i3hTw4jY6L8
         UXbkIRfv8wsZAecxGsj9oe+US57IbQqKaOI+32nNHkS/TrfIt5U6OnAjxFmjW578Invi
         oWbNHIeSQLoolL8ey0gKWbtRa7m8Tp79VaHnvCsTShfqXe/4sqS+Dl3J8YWUFfSmBs2P
         VoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Sk6j9y98rQEk0nftaA7SWqmAdhrxmLBfOzmiEbrijuo=;
        b=TnDmXB3zk8R26kDoaHr0U6H+m82TVHCtpi96VsbbC67L7tk1sDsmyerUnDTVvgmAgF
         taEEB5/24PlHs9Na91+AfCyvyWhjhF/93nO/U9AkOKeVdMkjdsppfGO73pRtlvEiTv8x
         8hlq55Idgk86ki4oeFRTJl7me1SgIIAjkm4R5zq/97AE77mw+WEgNjUO+Ya2YTHNjxXG
         OwK5iYUE3xcFVvYhP1C+9SfeIrPEmLrq3yiklUP71LYkaHYlPJckHGvcEyg9NyZkVvB6
         zzUdvUGB+K9k18vUQVUtUWZQCMrCehLePRtS4Xa7cqOdTMONbNfaQwxJc5ups84vLENt
         akZQ==
X-Gm-Message-State: AOAM533yzPFY5wKnM1QnNiUOv43zGA5z5ehsbOEoM7qSLURoHNPLzYRX
        RLpnDkte4AaIbx4t7m30UhM=
X-Google-Smtp-Source: ABdhPJyQvzo0zeoha+GMDlRcT/Bdx4QJD4b/A4QpnHsnU7NbxU+KvzSxBItdk+RzjJTTM9iFOyQu8Q==
X-Received: by 2002:a05:6a00:7d7:b029:32c:b12a:d65d with SMTP id n23-20020a056a0007d7b029032cb12ad65dmr6394597pfu.44.1627079297876;
        Fri, 23 Jul 2021 15:28:17 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i13sm26387885pfr.79.2021.07.23.15.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 15:28:17 -0700 (PDT)
Date:   Fri, 23 Jul 2021 19:28:12 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fWUr91jLgD-BDYK08v0ELQtypFHDop7QW4uFOPscncCQw@mail.gmail.com>
References: <20210715013343.2286699-1-irogers@google.com> <20210715013343.2286699-5-irogers@google.com> <YPsKLa0Qe5/as4Jh@kernel.org> <YPsQGZOXqoy7Tfe6@kernel.org> <YPsQ5En9N7xG1Cya@kernel.org> <CAP-5=fWUr91jLgD-BDYK08v0ELQtypFHDop7QW4uFOPscncCQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <956E2E1D-4F91-4C92-B06B-21FC8DE376C0@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On July 23, 2021 6:03:16 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>On Fri, Jul 23, 2021 at 11:56 AM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> Em Fri, Jul 23, 2021 at 03:53:14PM -0300, Arnaldo Carvalho de Melo
>escreveu:
>> > Em Fri, Jul 23, 2021 at 03:27:57PM -0300, Arnaldo Carvalho de Melo
>escreveu:
>> > > Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
>> > > > Enabled to ensure that info pages build=2E
>> > >
>> > > How did you test this? I tried installing texinfo, that is where
>> > > makeinfo belongs:
>> > >
>> > > =E2=AC=A2[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
>> > > texinfo-6=2E7-10=2Efc34=2Ex86_64
>> > > =E2=AC=A2[acme@toolbox perf]$ rpm -q texinfo
>> > > texinfo-6=2E7-10=2Efc34=2Ex86_64
>> > > =E2=AC=A2[acme@toolbox perf]$
>> > >
>> > > And then:
>> > >
>> > > =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf O=3D/tmp/build/per=
f
>install-doc
>> > > make: Entering directory '/var/home/acme/git/perf/tools/perf'
>> > >   BUILD:   Doing 'make -j24' parallel build
>> > >   INSTALL Documentation-man
>> > > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>> > > =E2=AC=A2[acme@toolbox perf]$
>> >
>> > Also:
>>
>> We get closer if we do:
>>
>> =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf/Documentation/ install=
-info
>> make: Entering directory
>'/var/home/acme/git/perf/tools/perf/Documentation'
>>   ASCIIDOC perf=2Exml
>>   DB2TEXI  perf=2Etexi
>> /bin/sh: line 2: docbook2x-texi: command not found
>> make: *** [Makefile:289: perf=2Etexi] Error 127
>> make: Leaving directory
>'/var/home/acme/git/perf/tools/perf/Documentation'
>> =E2=AC=A2[acme@toolbox perf]$
>
>Do you need to install docbook2x?

Sure, but it seems the name of the binaries in the version in fedora are d=
ifferent=2E

>
>$ dpkg -S /usr/bin/docbook2x-texi
>docbook2x: /usr/bin/docbook2x-texi
>
>Thanks,
>Ian
>
>> - Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
