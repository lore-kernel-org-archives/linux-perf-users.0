Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAC79DA6
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Mar 2024 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244471; cv=none; b=rFTfzZnjd/BTTEmNOjJFM/+/qAbIkBoyFZQcvbslFOZlas4zQG0vD1M5VX1AlOOdKYSPsZh1YDtl0HFQZ7ZOpKuozN/JFBOhKXnZ5mMbUp9Jgd1tEI1xIX/+WnbpDoRLWKdCRzTYZ7LLVvTxjdxFlR8L6W05pJUz5YYYAm8qZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244471; c=relaxed/simple;
	bh=7QkCGft8B2o2xCJx9N2GwQjiIUV7fTEs2imD/3PseKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jItMbR9kpWdNzPe/a2pf/lReGt07yAJZCR9XKrhSBQYY0k5Raqb45ubtzG5cgiuzpcAWgIMFrLETYN42xRO2tvMBVeiCQXw5VGEvIFgQTuFqviqqMxFv6uCxVDKTwVic08kwAKakZ6g8ach7FcKVsFKZPKH2n+OS/o/olHC9nhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=AyGRqGmW; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="AyGRqGmW"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8BB1C240028
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Mar 2024 12:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710244467; bh=7QkCGft8B2o2xCJx9N2GwQjiIUV7fTEs2imD/3PseKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=AyGRqGmWl/shMyTL+iXwTnpYxYDe+c6qe3aqJpQL4c2F9SG3mY1IAMI6p2kenQ3HV
	 vtUQ3zEHifwGtjpymAbqpaDqVtjJ8av4k5tM47ogEcXORwDYXBPXYT9zU6puUHesgB
	 nQDMv7BGIqnXMAjR5Cn8zMi01Y+eSm5a54QMpVFqtf3rUgcjqG9b5Mzte+5nrBjtAg
	 IZ9H3h6pPx3UqA9o4idHQr5n3rUUC5gcqMHbeqvPnZYpTfZD4tYs9oy9KOrJZy5JnY
	 gkhUMJZ8HSqiKRrhH4u9tMG0VDxDQ4kkyD+XcE2XUGoQSrYN8/m5Bc6/8IcObLPz0g
	 ww1O+vQTZjdUQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TvBrY4JpMz6tm4;
	Tue, 12 Mar 2024 12:54:21 +0100 (CET)
From: Anne Macedo <retpolanne@posteo.net>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Mark Rutland
 <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: skip traceiter functions
In-Reply-To: <CAM9d7civcSVL92SYhssCjYzaomyJNfn0CHWz7ErGwKY-H8_Kfw@mail.gmail.com>
	(Namhyung Kim's message of "Mon, 11 Mar 2024 22:44:12 -0700")
References: <20240311225617.179184-1-retpolanne@posteo.net>
	<CAM9d7civcSVL92SYhssCjYzaomyJNfn0CHWz7ErGwKY-H8_Kfw@mail.gmail.com>
Date: Tue, 12 Mar 2024 11:54:18 +0000
Message-ID: <m2v85racnp.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Namhyung Kim <namhyung@kernel.org> writes:

> On Mon, Mar 11, 2024 at 3:57=E2=80=AFPM Anne Macedo <retpolanne@posteo.ne=
t> wrote:
>>
>> The perf lock contention program currently shows the caller of the locks
>> as __traceiter_contention_begin+0x??. This caller can be ignored, as it =
is
>> from the traceiter itself. Instead, it should show the real callers for
>> the locks.
>>
>> When fiddling with the --stack-skip parameter, the actual callers for
>> the locks start to show up. However, just ignore the
>> __traceiter_contention_begin and the __traceiter_contention_end symbols
>> so the actual callers will show up.
>>
>> Before this patch is applied:
>>
>> sudo perf lock con -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_c=
ontention_begin+0x84
>>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __trace=
iter_contention_begin+0x44
>>          1     13.54 us     13.54 us     13.54 us        mutex   trace_c=
ontention_begin+0x84
>>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __trace=
iter_contention_begin+0x44
>>
>> Before this patch is applied - using --stack-skip 5
>>
>> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epol=
l_wait+0x5a0
>>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit=
+0x338
>>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_sig=
nal+0x108
>>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release=
_task+0x68
>>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_=
kn_lock_live+0x58
>>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exit=
+0x44
>>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm=
_and_find_vma+0xb0
>>
>> After this patch is applied:
>>
>> sudo ./perf lock con -a -b -- sleep 3
>>  contended   total wait     max wait     avg wait         type   caller
>>
>>          4      4.13 s       2.07 s       1.03 s      rwlock:W   release=
_task+0x68
>>          2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_upda=
te_next_owner+0x50
>>          2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exit=
+0x338
>>          1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup_=
kn_lock_live+0x58
>>          2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exit=
+0x338
>>
>> changes since v1:
>>
>> - consider trace_contention and __traceiter_contention functions as
>> optional (i.e. check if sym is null to avoid segfault)
>>
>> changes since v0:
>>
>> - skip trace_contention functions
>> - use sym->end instead of __traceiter_contention_end for text_end
>>
>> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
>> ---
>>  tools/perf/util/machine.c | 21 +++++++++++++++++++++
>>  tools/perf/util/machine.h |  2 +-
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>> index 527517db3182..968f69364f9a 100644
>> --- a/tools/perf/util/machine.c
>> +++ b/tools/perf/util/machine.c
>> @@ -3266,6 +3266,18 @@ bool machine__is_lock_function(struct machine *ma=
chine, u64 addr)
>>
>>                 sym =3D machine__find_kernel_symbol_by_name(machine, "__=
lock_text_end", &kmap);
>>                 machine->lock.text_end =3D map__unmap_ip(kmap, sym->star=
t);
>> +
>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "__=
traceiter_contention_begin", &kmap);
>> +               if (sym) {
>> +                       machine->traceiter.text_start =3D map__unmap_ip(=
kmap, sym->start);
>> +                       machine->traceiter.text_end =3D map__unmap_ip(km=
ap, sym->end);
>> +               }
>> +
>> +               sym =3D machine__find_kernel_symbol_by_name(machine, "tr=
ace_contention_begin", &kmap);
>> +               if (sym) {
>> +                       machine->trace.text_start =3D map__unmap_ip(kmap=
, sym->start);
>> +                       machine->trace.text_end =3D map__unmap_ip(kmap, =
sym->end);
>> +               }
>>         }
>>
>>         /* failed to get kernel symbols */
>> @@ -3280,5 +3292,14 @@ bool machine__is_lock_function(struct machine *ma=
chine, u64 addr)
>>         if (machine->lock.text_start <=3D addr && addr < machine->lock.t=
ext_end)
>>                 return true;
>>
>> +       /* traceiter functions currently don't have their own section
>> +        * but we consider them lock functions
>> +        */
>> +       if (machine->traceiter.text_start <=3D addr && addr < machine->t=
raceiter.text_end)
>> +               return true;
>> +
>> +       if (machine->trace.text_start <=3D addr && addr < machine->trace=
.text_end)
>> +               return true;
>
> You cannot simply check these as they are set optionally.
>
Should I move them to the same if block where I check for the sym?
>
> Thanks,
> Namhyung
>
>
>> +
>>         return false;
>>  }
>> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
>> index e28c787616fe..4312f6db6de0 100644
>> --- a/tools/perf/util/machine.h
>> +++ b/tools/perf/util/machine.h
>> @@ -49,7 +49,7 @@ struct machine {
>>         struct {
>>                 u64       text_start;
>>                 u64       text_end;
>> -       } sched, lock;
>> +       } sched, lock, traceiter, trace;
>>         pid_t             *current_tid;
>>         size_t            current_tid_sz;
>>         union { /* Tool specific area */
>> --
>> 2.39.2
>>
Thanks, Anne
