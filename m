Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13D3C2B92
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352700; cv=none; b=LfTTlmDIVQe66iduTsIW0zA6rFLdk0syHrP68Mv2VGI5fqXdHj/L6Znc8BJPAe3JU7SKfA1fo4OAcJUlRusFhyLYkBXfCwPV9ASbVw3fbKuiMjNnVXBn9y4bz+k0GyfDryXhRTxlOiDsj1/wDZ6MPTudOFcG40zVkCygn5DeRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352700; c=relaxed/simple;
	bh=Gt7TERJi1K3SB9YhF4GeO9loSl23F5cbQ2rmS20vgow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jldG6MknR82OLhTjBOvncf/izh4qFjMyKR2HFNdBN0uej7nG7xD0eg333GurchtvH/q1RFCKjK3ar5WPdBqOQ3yuG61F9ZA8eBDCLBnOjwoOlVwXQ/UbtifWgVTi4SqlMKVZJZC78cQFMaAeZPPlW0G2SmdyBK8IkdK07Mu0PIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjYwni5k; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjYwni5k"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1118287f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791352697; x=1791957497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qlY3t16suadoXEY1qXDhukOrB9L0aD9CIyaQ8QOX98Y=;
        b=LjYwni5kxCW3lXa6obQNER8bQ66dBNcw+oFC+5fzCZds9vyYmbd89hLjuvLK16/Tlq
         FMguJlvaMyBejiuOfEOCGaZGetRmhL/nqigcQ/eukbp67SaNGV/ZbE3WeHjI82r5hL1T
         8fujOOzRJeUU6zOJurtW/tguxyaM21THHHMe9GrFRV4CT+wSswrjDQVoPX8rZDgzicEY
         tg04ATtrw0Ks3L9Y91GQ+PIzy36M8Sda99dY4GBY440D1V6k99srndANDnvaoN/tj3A5
         6mIHr4OZZ9uqpMUp5J1r19bv3Glph0h7qraS8bHj+mAM/NavYzgJFxagYL+djFtpZZno
         fFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791352697; x=1791957497;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qlY3t16suadoXEY1qXDhukOrB9L0aD9CIyaQ8QOX98Y=;
        b=tkU+iJHJlIFVPyZQa4LcTBzoNylqE9gV/1UnOMhmdSp8s3VGfzBbNwanEif2Jyhw07
         f6hKzrNZ6ntWtHbD42UI4fuY+m7yeCUzo1MX6Pq+khkuUYoUh8FPnIvDXpL6ldjli33M
         96yQK7i+EolohvwGHom6D4tbwge4bHupG5Uqk2TNushujLe+jSBM/ZELoMOykl+6F9DA
         ayGy2D180wo2BF/Y8ibbn+17BymNeo+RcmAugCf/4hr2hHnN2mkAdiSMQE8Ty88rvWCW
         npWfR7ih1PvPp55231KS5xHNNsT7GaBOwPwLhI58Jbk2ceJOxu1BKrcgwwCGYpkHbNJK
         Pa+w==
X-Forwarded-Encrypted: i=1; AKwUvBzDxPBFnGNxueYcqi8hLNml77QXAYrr16kzhVodrCreRWlZMpBgW5jH13gzbUBG02hPBzDt3DtTpwkhu9sp2k7o@vger.kernel.org
X-Gm-Message-State: AFq9FYIlkmYFxhITdk5XfZdns93OWWv9EWTBu2YmBHhRRBsTmK0djjHd
	Q9bGOQJrmfMzo2z7y2c6JKpnCWhTbHE5jw2x7RXtzfBcPGLfnnCAEFnS
X-Gm-Gg: AYBFou0QS2fSrlMbOtSSnBfja9G1Jc5K2Pc8nibUXEgm3hhuQZB1b1g3eO2Kk0nEX9X
	WGPapE/OyF209uQOvSCNM/z168psn7afvnuOVkm/UWUuba+Y4xPCbuOeHBH4mzL37xltL1u5A4v
	a6p5cNXzkc37D21SKWT+pUeQLuYPMX5KdMPPc28zpQUNEpgmXC+c1VrkNkM3Eb6S1tIg9weu5Go
	YKs2jAPbsU/um7+KSDYUussjFDBfgHQT/yAqMYfJ9x3qkdQmLs55g1uK5v6Fo8rNlcSYxEy6FwL
	VjhVeph9VXnxbb5zoakUeqCQNyBxuJhEDJnIp0NUqdBcDW++143L5kREo/T8esgI0mURw3UPoPp
	1666OeeDutAt4J4w6V3yzxUiUAvauhKJ6Dss9zlh4G8CNd0SKuphO99oauMFD96ojcVrX8HiO21
	KbSDxL01rL0P1iMcN/4VVffMR7lGa5TKXEToswuzEmIVQobLBnzZimYIWPKNbf0b2wyX9Vg/dVl
	8dhj3i0VQ==
X-Received: by 2002:a05:6000:46cc:b0:488:89ad:56b8 with SMTP id ffacd0b85a97d-48c72574ff3mr1486829f8f.0.1791352696964;
        Tue, 06 Oct 2026 22:58:16 -0700 (PDT)
Received: from ehlo.thunderbird.net ([193.86.28.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d10216sm3149921f8f.20.2026.10.06.22.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 22:58:15 -0700 (PDT)
Date: Wed, 07 Oct 2026 07:58:12 +0200
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
User-Agent: Thunderbird for Android
In-Reply-To: <asWQvXRdqp_RK85c@google.com>
References: <20261006161309.3078488-1-acme@kernel.org> <asWLmvF-3YtoKJ7j@google.com> <asWQvXRdqp_RK85c@google.com>
Message-ID: <EE4F4624-D728-4D59-A15D-70EEC29229DA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 7, 2026 2:22:21 AM GMT+02:00, Namhyung Kim <namhyung@kernel=2Eo=
rg> wrote:
>On Tue, Oct 06, 2026 at 05:00:26PM -0700, Namhyung Kim wrote:
>> On Tue, Oct 06, 2026 at 06:13:03PM +0200, Arnaldo Carvalho de Melo wrot=
e:
>> > From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> >=20
>> > Hello all,
>> >=20
>> > This series fixes the "Perf attribute expectations test" (perf test 8=
2,
>> > formerly "Setup struct perf_event_attr")=2E
>> >=20
>> > Patches 1-2 are Michael Petlan's prerequisite fixes that make the she=
ll
>> > wrapper propagate attr=2Epy's return value and correct the
>> > perf_event_attr size expectation after struct config4 was added=2E  T=
hey
>> > are included at the start of the series so that it applies cleanly on
>> > the current perf-tools-next (and for the review bots to verify the ne=
w
>> > patches); the new fixes are patches 3-6=2E
>> >=20
>> > With the test reporting failures again, several stale expectations
>> > surfaced and are addressed here:
>> >=20
>> > - test-record-graph-dwarf still expected PERF_SAMPLE_ADDR and
>> >   PERF_SAMPLE_DATA_SRC for --call-graph dwarf=2E  Those were dropped =
by
>> >   bdd051e249141c79 ("perf record: Split --data-mmap option"), which
>> >   decoupled data MMAP recording from the sample address bits=2E
>> >=20
>> > - The record and stat group tests expected cache-misses and
>> >   instructions to be the legacy PERF_TYPE_HARDWARE events, but since
>> >   b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy
>> >   hardware and cache parsing") they resolve to the core PMU sysfs/JSO=
N
>> >   events, so request the legacy encodings explicitly with the
>> >   legacy-hardware-config term=2E
>> >=20
>> > - The perf stat default metrics open their events in groups and the
>> >   raw encodings of instructions, branch-misses, cpu-cycles and
>> >   stalled-cycles-frontend/backend differ between Intel and AMD, so
>> >   base-stat now accepts the standalone and group variants and
>> >   test-stat-default/detailed-{1,2,3} gained the per-vendor raw
>> >   encodings=2E
>> >=20
>> > - attr=2Epy no longer requires a recorded event to be in a group when
>> >   the matching expectation does not declare one, allowing the stat
>> >   tests to verify event attributes without encoding the metric
>> >   grouping=2E  Expectations that declare a group are still verified i=
n
>> >   both directions=2E
>> >=20
>> > The test passes with 'perf test -vv attribute' on x86_64=2E  The AMD
>> > encodings come from the amd_pmu_event_map tables in
>> > arch/x86/events/amd/core=2Ec=2E
>>=20
>> On my machine, the current tmp=2Eperf-tools-next which contains these
>> changes fails like this=2E
>>=20
>>   $ tools/perf/perf test -v 82
>>   ---- start ----
>>   test child forked, pid 931585
>>   /home/namhyung/project/linux/tools/perf/tests/shell/attr=2Esh: line 2=
0: python: command not found
>>   ---- end(-1) ----
>>    82: Perf attribute expectations test                                =
                 : FAILED!
>>  =20
>>   =3D=3D=3D Test Summary =3D=3D=3D
>>   Passed main tests : 0
>>   Passed subtests   : 0
>>   Skipped tests     : 0
>>   Failed tests      : 1
>>   List of failed tests:
>>      82: Perf attribute expectations test
>>=20
>> The below patch fixes the problem=2E
>
>Hmm=2E=2E even with the fix, it failed like this=2E


I'll address Sashiko's reviews and test this in more machines, Intel hybri=
d, AMD and arm64=2E

Will also incorporate your fix, thanks for testing it!=20

- Arnaldo=2E


>
>Thanks,
>Namhyung
>
>
>  $ tools/perf/perf test -v 82
>  ---- start ----
>  =2E=2E=2E
>  expected mmap=3D1, got 0
>  expected comm=3D1, got 0
>  expected freq=3D1, got 0
>  expected enable_on_exec=3D1, got 0
>  expected task=3D1, got 0
>  expected sample_id_all=3D1, got 0
>  expected branch_sample_type=3D16, got 0
>  FAILED '/home/namhyung/project/linux/tools/perf/tests/shell/attr/test-r=
ecord-branch-filter-any_call' - match failure
>  ---- end(-1) ----
>   82: Perf attribute expectations test                                  =
                                    : FAILED!
> =20
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 0
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 1
>  List of failed tests:
>     82: Perf attribute expectations test
>

- Arnaldo 
