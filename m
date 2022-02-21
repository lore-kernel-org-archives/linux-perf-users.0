Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B5C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiBUUVd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:21:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBUUVd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 15:21:33 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F141A3A2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 12:21:09 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id x193so12196857oix.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=HIG/e3Dqn3Ug3Vx2bvDFOZIxFABI4UJ/iVq+fBdRsGo=;
        b=Z8HRlJ/J8UH653KPyCXp2mPXxPDqOcvji14Zn3jRGdLerQHs8bsc5JJtGgM924ppmg
         8UJbaIXJ5XAeeRvieJNbluaDn6ygolmCh815EB1IKSNYwyDXWXbW/P2trsOwD8eCoSbZ
         VbwrzSl1kPivnUrFjz63jwDsngG2b2IsavvrVfxpr1C0SY4fMOFJuXkTEJ7h+EVZi3D+
         5N3r5ePIJwfXgfITHk7Xhy7oJb60xFFAT+FbPI5VMeW42K29va/Zh9kJRNVcfXmtPnRv
         pyCxRWVO3ch224gsH5AUSoouwDVQ7KwYwi7gWqY9lXeZziFhvx6aqRA4iCN/CXBGX2uI
         B+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=HIG/e3Dqn3Ug3Vx2bvDFOZIxFABI4UJ/iVq+fBdRsGo=;
        b=UYj0dkT28QvYnowC9oJ0fMImkqMJbfyTv4B4tyPrQCHMiEPsaG5rRPlYcjvKTJ5x/T
         c0m8P6chHR4jf1YiDE8a+800t0OGWCw0Vfoh36ffbCNgH2jFqRu/Uj4QLqDyHgGmK3gm
         xZCQmLrT6sL7SYwvVfzbyyf8xpyGNG7mFLQVsv8grzA5leuE4yK97OkS68iAePIhtt9Z
         X10wJeiXNv1SIcMuuQa0QcwQ0p9UDDVKf0hxMKtGMrVdzp5TQH+skErYHB9rSTkeamuR
         BEfMXCjYhID+PrCuJbmTS+fVfJfJZMcc35Pl0tYTYFjwU7IwbVnAncoZobvvW/bPCg0r
         e4gA==
X-Gm-Message-State: AOAM53187DRaULwgNio4oZ/NjMUxeQfL0ZoB6FFmNtSkMQ5NByKJ/YEo
        4ZJuwZW4AtcEs0WP7rCy4Lo=
X-Google-Smtp-Source: ABdhPJzWRoM0527rovmOLHUerSFWBxCyrqZrROlxWKgoXsIHDale1i3RFd6oE/Ms2TsmChSm7jWUyQ==
X-Received: by 2002:a05:6808:2006:b0:2d5:11f8:d69d with SMTP id q6-20020a056808200600b002d511f8d69dmr380937oiw.218.1645474868591;
        Mon, 21 Feb 2022 12:21:08 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t27sm7362113oiw.2.2022.02.21.12.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:21:08 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:07:24 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
CC:     acme@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
User-Agent: K-9 Mail for Android
In-Reply-To: <YhPsKeK0UdjiDN1R@krava>
References: <20220221102628.43904-1-tz.stoyanov@gmail.com> <YhPsKeK0UdjiDN1R@krava>
Message-ID: <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail=2Ecom=
> wrote:
>On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wro=
te:
>> The existing API perf_thread_map__new_dummy() allocates new thread map
>> for one thread=2E I couldn't find a way to reallocate the map with more
>> threads, or to allocate a new map for more than one thread=2E Having
>> multiple threads in a thread map is essential for some use cases=2E
>> That's why a new API is proposed, which allocates a new thread map
>> for given number of threads:
>>  perf_thread_map__new_array()
>>=20
>> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz=2Estoyanov@gmail=2Ecom>
>> ---
>> v2 changes:
>>  - Changed the new API as Arnaldo suggested - get number of threads in =
the
>>    map and array with initial values (optional)=2E
>
>looks good, would you also find useful in your use case the comm support
>in thread_map? the thread_map__read_comms function? we could move it from
>perf to libperf

IOW: we're happy that you're working on libperf, so feel encouraged to mov=
e things from tools/perf/util/ to tools/lib/perf/ if you find a supporting =
use case, brownie points if you also add an entry to tools/perf/tests/, AKA=
 'perf test'=2E

Thanks!

- Arnaldo

>
>thanks,
>jirka
>
>>=20
>>  tools/lib/perf/Documentation/libperf=2Etxt |  1 +
>>  tools/lib/perf/include/perf/threadmap=2Eh  |  1 +
>>  tools/lib/perf/libperf=2Emap               |  1 +
>>  tools/lib/perf/tests/test-threadmap=2Ec    | 41 ++++++++++++++++++++++=
++
>>  tools/lib/perf/threadmap=2Ec               | 24 ++++++++++----
>>  5 files changed, 61 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/tools/lib/perf/Documentation/libperf=2Etxt b/tools/lib/per=
f/Documentation/libperf=2Etxt
>> index a21f733b95b1=2E=2Ea8f1a237931b 100644
>> --- a/tools/lib/perf/Documentation/libperf=2Etxt
>> +++ b/tools/lib/perf/Documentation/libperf=2Etxt
>> @@ -62,6 +62,7 @@ SYNOPSIS
>>    struct perf_thread_map;
>> =20
>>    struct perf_thread_map *perf_thread_map__new_dummy(void);
>> +  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, p=
id_t *array);
>> =20
>>    void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, =
pid_t pid);
>>    char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
>> diff --git a/tools/lib/perf/include/perf/threadmap=2Eh b/tools/lib/perf=
/include/perf/threadmap=2Eh
>> index 58f7fbdce446=2E=2E8b40e7777cea 100644
>> --- a/tools/lib/perf/include/perf/threadmap=2Eh
>> +++ b/tools/lib/perf/include/perf/threadmap=2Eh
>> @@ -8,6 +8,7 @@
>>  struct perf_thread_map;
>> =20
>>  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
>> +LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_=
threads, pid_t *array);
>> =20
>>  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map,=
 int idx, pid_t pid);
>>  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, i=
nt idx);
>> diff --git a/tools/lib/perf/libperf=2Emap b/tools/lib/perf/libperf=2Ema=
p
>> index 6fa0d651576b=2E=2E190b56ae923a 100644
>> --- a/tools/lib/perf/libperf=2Emap
>> +++ b/tools/lib/perf/libperf=2Emap
>> @@ -12,6 +12,7 @@ LIBPERF_0=2E0=2E1 {
>>  		perf_cpu_map__empty;
>>  		perf_cpu_map__max;
>>  		perf_cpu_map__has;
>> +		perf_thread_map__new_array;
>>  		perf_thread_map__new_dummy;
>>  		perf_thread_map__set_pid;
>>  		perf_thread_map__comm;
>> diff --git a/tools/lib/perf/tests/test-threadmap=2Ec b/tools/lib/perf/t=
ests/test-threadmap=2Ec
>> index 5e2a0291e94c=2E=2Ef728ad7002bb 100644
>> --- a/tools/lib/perf/tests/test-threadmap=2Ec
>> +++ b/tools/lib/perf/tests/test-threadmap=2Ec
>> @@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level le=
vel,
>>  	return vfprintf(stderr, fmt, ap);
>>  }
>> =20
>> +static int test_threadmap_array(int nr, pid_t *array)
>> +{
>> +	struct perf_thread_map *threads;
>> +	int i;
>> +
>> +	threads =3D perf_thread_map__new_array(nr, array);
>> +	__T("Failed to allocate new thread map", threads);
>> +
>> +	__T("Unexpected number of threads", perf_thread_map__nr(threads) =3D=
=3D nr);
>> +
>> +	for (i =3D 0; i < nr; i++) {
>> +		__T("Unexpected initial value of thread",
>> +		    perf_thread_map__pid(threads, i) =3D=3D (array ? array[i] : -1))=
;
>> +	}
>> +
>> +	for (i =3D 1; i < nr; i++)
>> +		perf_thread_map__set_pid(threads, i, i * 100);
>> +
>> +	__T("Unexpected value of thread 0",
>> +	    perf_thread_map__pid(threads, 0) =3D=3D (array ? array[0] : -1));
>> +
>> +	for (i =3D 1; i < nr; i++) {
>> +		__T("Unexpected thread value",
>> +		    perf_thread_map__pid(threads, i) =3D=3D i * 100);
>> +	}
>> +
>> +	perf_thread_map__put(threads);
>> +
>> +	return 0;
>> +}
>> +
>> +#define THREADS_NR	10
>>  int test_threadmap(int argc, char **argv)
>>  {
>>  	struct perf_thread_map *threads;
>> +	pid_t thr_array[THREADS_NR];
>> +	int i;
>> =20
>>  	__T_START;
>> =20
>> @@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
>>  	perf_thread_map__put(threads);
>>  	perf_thread_map__put(threads);
>> =20
>> +	test_threadmap_array(THREADS_NR, NULL);
>> +
>> +	for (i =3D 0; i < THREADS_NR; i++)
>> +		thr_array[i] =3D i + 100;
>> +
>> +	test_threadmap_array(THREADS_NR, thr_array);
>> +
>>  	__T_END;
>>  	return tests_failed =3D=3D 0 ? 0 : -1;
>>  }
>> diff --git a/tools/lib/perf/threadmap=2Ec b/tools/lib/perf/threadmap=2E=
c
>> index 84fa07c79d00=2E=2E07968f3ea093 100644
>> --- a/tools/lib/perf/threadmap=2Ec
>> +++ b/tools/lib/perf/threadmap=2Ec
>> @@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map =
*map, int idx)
>>  	return map->map[idx]=2Ecomm;
>>  }
>> =20
>> -struct perf_thread_map *perf_thread_map__new_dummy(void)
>> +struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid=
_t *array)
>>  {
>> -	struct perf_thread_map *threads =3D thread_map__alloc(1);
>> +	struct perf_thread_map *threads =3D thread_map__alloc(nr_threads);
>> +	int i;
>> +
>> +	if (!threads)
>> +		return NULL;
>> +
>> +	for (i =3D 0; i < nr_threads; i++)
>> +		perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
>> +
>> +	threads->nr =3D nr_threads;
>> +	refcount_set(&threads->refcnt, 1);
>> =20
>> -	if (threads !=3D NULL) {
>> -		perf_thread_map__set_pid(threads, 0, -1);
>> -		threads->nr =3D 1;
>> -		refcount_set(&threads->refcnt, 1);
>> -	}
>>  	return threads;
>>  }
>> =20
>> +struct perf_thread_map *perf_thread_map__new_dummy(void)
>> +{
>> +	return perf_thread_map__new_array(1, NULL);
>> +}
>> +
>>  static void perf_thread_map__delete(struct perf_thread_map *threads)
>>  {
>>  	if (threads) {
>> --=20
>> 2=2E34=2E1
>>=20
