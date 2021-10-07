Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E44C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50D761163
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhJGJV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbhJGJV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 05:21:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C17C061746
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 02:19:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 138so5280474qko.10
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ndbKtJThnmt0tUTdK9BsjDNlMEJIwXwr9mfhV0eUBnE=;
        b=gbTYsjqjSo6aRMigl+7y/ADpzeOeq0Q1Xr/tvqpcmxGuymgKlhmUmsSkp/HDR7ZZJI
         4io9YG8iLZPjCKzMTrIBf9KvvCoUdsRWFnYo9yJUNKqkhGz8UKvjBPBVMWr5dfFNIe7n
         ftVuW7pH32pmD6VvAXbboi+ltfqob6AkYWVt+AMRnrXpFkxrjy3/tCFIRpPiGQRfT8N2
         GEuz+0B7dnCCQ8VogUlzoVgfae1TZt+/maeaiWGM4Zqhh735oGrsdrB34bNgD04Uklb0
         8pK3w9mArCcLaEgCy1p53kCIZ0dk5SNCkfPvwS9uN5ubEQKP8ZHmvyB+eWqFdDvH+95q
         7RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=ndbKtJThnmt0tUTdK9BsjDNlMEJIwXwr9mfhV0eUBnE=;
        b=RPweUenBYTNaFSSu3HB6vV2xp2+OCgUgm8YZKcarOjjC6eA5XCNZ70yGQu3MaiNKoR
         S7GLkO64gYfx0CWw53xLAejYdy2Q9rGH60PSnOYazszXJyQsjI0KinbLQfrWRZh6YOKi
         gyS4LKLGpyRFOaAGkUFqdMvOQtvVEoM+PQPnwdF/P942yy1rHLdjBl4yZ17+22EJk+Wn
         egiX/SCXLydWaQYSTcrTESldi2bHWH7K8u0w/tIR6iNfmz+PvkZuDPhzu+Q1RH6W/y22
         hd+Xbj2mh+C5AvqDzcj6cscD2dkFJ/9oDLGGWwTCv5+AmCWmEv1LLbK3CBIJM+GbOhPt
         EMCw==
X-Gm-Message-State: AOAM530LzWr4mT/g1uZfJ1IfgScNzSZyl4vYzWuFtiXAy1xbdiUv6x5Q
        ud3bpwbAzaozoOKemxU+E4I=
X-Google-Smtp-Source: ABdhPJw61/Iiw9A68a0UCYEWvZEoAw84L16ix7qqzagPGTEoqbl6cJFIZRkP1FrHrvA7pcC8BQRDFA==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr2363108qkh.17.1633598371746;
        Thu, 07 Oct 2021 02:19:31 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 9sm4588915qkn.84.2021.10.07.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:19:31 -0700 (PDT)
Date:   Thu, 07 Oct 2021 06:17:29 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Renjith Ponnappan <renjithponnapps@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Perf: Question about continuous background data collection
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPNhM=YRUMw2VuHg3e5RH33UTCDG0guiqvCrfwb_kW_PkLvipw@mail.gmail.com>
References: <CAPNhM=aGeiKAVFDHWuP=GcAbgUz=JgWwtKfoRgmuxoG0gNfciQ@mail.gmail.com> <DA2A1D0F-1877-41D1-BC87-C0AE70D3E18C@gmail.com> <YVv4B4syx36Co/0+@krava> <CAPNhM=YRUMw2VuHg3e5RH33UTCDG0guiqvCrfwb_kW_PkLvipw@mail.gmail.com>
Message-ID: <383B1714-E2A5-4678-8348-5B2AA5BE0833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On October 6, 2021 6:25:57 PM GMT-03:00, Renjith Ponnappan <renjithponnapp=
s@gmail=2Ecom> wrote:
>Hello Arnaldo & Jiri,
>
>Thank you for your response=2E
>
>The perf daemon is the closest implementation for what I was looking for=
=2E
>Here we run perf in the back-ground, keep overwriting the samples being
>collected and use the SIGUSR2 to signal to the perf daemon to collect the
>perf data to a file=2E This fulfills the following requirements:
>
>   1=2E Run perf in the background to collect data
>   2=2E A method to signal perf to collect the samples for the current cy=
cle=2E
>
>The last part of the requirement which  was:
>
>   1=2E The data-collection in step 2 above, rather than writing the data=
 to
>   file store it in in-memory datastructure via pointer manipulation=2E W=
e can
>   have a list of such samples stored in memory until the next step=2E Th=
is
>   helps free up the CPU cycles used by perf for writing to file for
>   applications=2E
>   2=2E A method to signal perf to dump all the collected samples into
>   separate files=2E This way the user can collect the stored samples whe=
n the
>   CPU is relatively free=2E
>
>Let me know whether we have support for storing samples as in-memory
>samples=2E

Have you looked at the URL I pointed to you?

https://www=2Espinics=2Enet/lists/linux-perf-users/msg11455=2Ehtml

More specifically, read about 'perf record --overwrite"

- Arnaldo
>
>Thanks in advance for your help!
>
>*cheers,*
>*Renjith*
>
>
>On Tue, Oct 5, 2021 at 12:00 AM Jiri Olsa <jolsa@redhat=2Ecom> wrote:
>
>> On Thu, Sep 30, 2021 at 10:39:21PM -0300, Arnaldo Carvalho de Melo wrot=
e:
>> >
>> >
>> > On September 30, 2021 10:28:28 PM GMT-03:00, Renjith Ponnappan <
>> renjithponnapps@gmail=2Ecom> wrote:
>> > >Hello Peter/Ingo/Arnaldo,
>> > >
>> > >First of all, apologies if I bombarded you with an irrelevant questi=
on
>> in
>> > >your busy day and ignore this if the question is irrelevant=2E
>> > >
>> > >I had a question about continuous background data-collection with pe=
rf
>> and
>> > >hope you are the right person to answer this=2E If not, it would be =
great
>> if
>> > >you can redirect me to the right person=2E
>> > >
>> > >I am trying to build a CPU profiling system (on an embedded ARM Plat=
form
>> > >with CPU/memory constraints) which has CPU Samples already collected
>> when
>> > >an application CPU starvation scenario occurs based on perf=2E The
>> > >implementation I am trying to use is:
>> > >
>> > >   1=2E Run perf in the background collecting samples for the entire
>> system
>> >
>> >
>> > This is already in perf:
>> >
>> > https://www=2Espinics=2Enet/lists/linux-perf-users/msg11455=2Ehtml
>> >
>> >
>> > Reply adding linux-perf-users@vger=2Ekernel=2Eorg=2E
>> >
>> > - Arnaldo
>> >
>> >
>> > >   with a sleep period of 60 seconds
>> > >   2=2E When an application CPU starvation scenario occurs (detected=
 and
>> > >   raised by applications) notify the collection process to store th=
e
>> last
>> > >   perf collection as data to be analyzed offline=2E
>> > >
>> > >Have you come across such a scenario and any recommendations on this=
?
>> > >
>> > >The following are the two implementations I have on the above:
>> > >
>> > >   1=2E An external process which instructs perf to record the 60 se=
conds
>> by
>> > >   providing unique filenames each time=2E This approach was taking
>> around 40%
>> > >   CPU of a CPU core, everytime the perf record was getting written
>> (once for
>> > >   each 60 seconds cycle)=2E This isn't okay as it could cause
>> aggravation of
>> > >   the CPU starvation situation=2E
>> > >   2=2E I tinkered with Perf Code to add the logic of looping and wr=
iting
>> the
>> > >   file incase of an event only=2E This did reduce the CPU to only t=
he
>> case when
>> > >   an event was detected=2E
>>
>> hi,
>> and there's also perf daemon to run perf sessions on background:
>> https://lore=2Ekernel=2Eorg/lkml/20210130234856=2E271282-19-jolsa@kerne=
l=2Eorg/
>>
>> jirka
>>
>> > >
>> > >Would like to hear your opinion on whether approach 2 is the right w=
ay
>> here
>> > >and any suggestion/guidance you may have=2E
>> > >
>> > >Thanks in advance for this help!
>> > >
>> > >*cheers,*
>> > >*Renjith*
>> >
>>
>>
