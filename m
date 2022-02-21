Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D676C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 20:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiBUUEc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:04:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBUUEb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 15:04:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34122BDA
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 12:04:07 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id z7so9080193oid.4
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=zIdZkkLCxofWEY1mI82HfuSpr1YvWn9JqhY8pyQKFgw=;
        b=SPL5k0zBXEgx36fh+Q0TTaZE4pFuK4WBt1ZvZA1dEevYBgmO0syUXrv0QOdG0Mkr2Z
         P0Ymvewe7/IR4NZB5QM75bGEKa/Cah6QKRZQgFPoJAOJGj+NDTQa/T+Rl/jnc2ZIYHW9
         6w/gWc8wxLn49HYTjZuuGkaSiXLUVX/hicIed7jEUinCWtUYEsxKu5MP8cgxAbLRwZzl
         uEfnTDyyt2RjVkjPS8rvqpmNzJ6w+yXMW3NFcxUY4pTZZh64Wcx5t1CpH5jKVRqZ9Lf2
         Vu0LQ8nw7T2bDVY3tfDZcbIM8nu/SbqLNNWPf9zTTu6757UV/A0kxg2Al+qCqT/f+6vM
         /tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=zIdZkkLCxofWEY1mI82HfuSpr1YvWn9JqhY8pyQKFgw=;
        b=TaQRj12hCUpnJM77KCrZFCrX3DxcrJQj7Toaysr89DsPPugal8cx8mQKwISwe330Ef
         4X1B5vaLckRpSyOlWVROTYqIu5y0xYzSkV8q0lgvC4i8FGT5S7OvTCrJAkktyvBidc++
         nuzX6RjlcYoQzx8+JnCLvxoFp4gtlNcSEoLH2/jn+VeeKnckz222LLrDtxy9R2bvjObt
         Dj7OadHsmV7AXcDBsVobBZcElCZXXbwVeWTMTLikhPhWoX2icTZmI4tc+oA1Rbx845As
         pVfA1gwaEtXUoGDlW0DqDhE+vfGhoJs3M7cFplyb4/ExS0kt0X0MlQmwKVifujUoPG1o
         iSuA==
X-Gm-Message-State: AOAM5328EcvFwVE4oHNl4aO0nbUNXUEsRK41SkCeojt3UAn6HkDnvVVs
        dWeFq0P2kK80Lsm27FQ0+m4=
X-Google-Smtp-Source: ABdhPJxDuCJwJ16rrUPYihsIt9FzMcje0h9RnOkncMhElGqKRFHj/VeJHg1MXR5ECAPobnJuIxbqkQ==
X-Received: by 2002:a05:6808:211e:b0:2d5:38f5:6e70 with SMTP id r30-20020a056808211e00b002d538f56e70mr329377oiw.306.1645473846388;
        Mon, 21 Feb 2022 12:04:06 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t5sm5945574otp.67.2022.02.21.12.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:04:05 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:02:32 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
CC:     acme@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf: Rename arguments of perf_thread_map APIs
User-Agent: K-9 Mail for Android
In-Reply-To: <YhPsIJBdsN9AiE0O@krava>
References: <20220221102612.43879-1-tz.stoyanov@gmail.com> <YhPsIJBdsN9AiE0O@krava>
Message-ID: <FCD24EF8-737C-4E9B-A1C1-6B992AD6B466@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On February 21, 2022 4:46:40 PM GMT-03:00, Jiri Olsa <olsajiri@gmail=2Ecom=
> wrote:
>On Mon, Feb 21, 2022 at 12:26:12PM +0200, Tzvetomir Stoyanov (VMware) wro=
te:
>> The "int thread" input arguments of some perf_thead_map APIs are index
>> of the thread in the thread map=2E In order to avoid confusion and to
>> make the APIs consistent with perf_cpu_map APIs, those arguments are
>> renamed to "int idx"=2E
>>=20
>> Suggested-by: Arnaldo Carvalho de Melo <arnaldo=2Emelo@gmail=2Ecom>
>> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz=2Estoyanov@gmail=2Ecom>
>> ---
>>  tools/lib/perf/Documentation/libperf=2Etxt |  6 +++---
>>  tools/lib/perf/include/perf/threadmap=2Eh  |  6 +++---
>>  tools/lib/perf/threadmap=2Ec               | 12 ++++++------
>>  3 files changed, 12 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/tools/lib/perf/Documentation/libperf=2Etxt b/tools/lib/per=
f/Documentation/libperf=2Etxt
>> index 32c5051c24eb=2E=2Ea21f733b95b1 100644
>> --- a/tools/lib/perf/Documentation/libperf=2Etxt
>> +++ b/tools/lib/perf/Documentation/libperf=2Etxt
>> @@ -63,10 +63,10 @@ SYNOPSIS
>> =20
>>    struct perf_thread_map *perf_thread_map__new_dummy(void);
>> =20
>> -  void perf_thread_map__set_pid(struct perf_thread_map *map, int threa=
d, pid_t pid);
>> -  char *perf_thread_map__comm(struct perf_thread_map *map, int thread)=
;
>> +  void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, =
pid_t pid);
>> +  char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
>>    int perf_thread_map__nr(struct perf_thread_map *threads);
>> -  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
>> +  pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
>> =20
>>    struct perf_thread_map *perf_thread_map__get(struct perf_thread_map =
*map);
>>    void perf_thread_map__put(struct perf_thread_map *map);
>> diff --git a/tools/lib/perf/include/perf/threadmap=2Eh b/tools/lib/perf=
/include/perf/threadmap=2Eh
>> index a7c50de8d010=2E=2E58f7fbdce446 100644
>> --- a/tools/lib/perf/include/perf/threadmap=2Eh
>> +++ b/tools/lib/perf/include/perf/threadmap=2Eh
>> @@ -9,10 +9,10 @@ struct perf_thread_map;
>> =20
>>  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
>> =20
>> -LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map,=
 int thread, pid_t pid);
>> -LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, i=
nt thread);
>> +LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map,=
 int idx, pid_t pid);
>> +LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, i=
nt idx);
>>  LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
>> -LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, in=
t thread);
>> +LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, in=
t idx);
>
>does this argument name change break abi?

I don't think so, this is just a clarification, it's not even a semantic c=
hange, those are indices from the get go=2E

 > do we care at this point? ;-)

Of course we care, this isn't even a deprecation! 8-)

>not sure if we already started to treat libperf properly in this regard

We better, it's in tools/lib/=2E

- Arnaldo
>
>jirka
