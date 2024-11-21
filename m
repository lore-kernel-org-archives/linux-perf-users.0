Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CF1C8FC6
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215314; cv=none; b=Ppn6dvqKB57cQ+lQcMfxCSKSEOtsEGp3O+xfbTJ95HTQwBWyWeV8XKV8PYgvZPUHphuJWVhN1mj0n7KsYn6Fw7hRSdiwOmAKZ3rF544HFQqbH7B34bbSKLEnX7fq1bUW6MtlRsa2tcJ8dGpTYuSzGPSpHEmcbGWZ9ShoDbnEgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215314; c=relaxed/simple;
	bh=Awu/JAsNi2Sp1BH9u7fyKcUm5SqZWUbcHzAYfDXjpo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9YytE/tRHbHKbxh3fm7MA440SeYhnGZtzEx7ZtyIgk8eMgotreOEuEZeAanudt9GOCevutarLxkl4HC9OmFNggLe8W0EApr42EiCLRgOceAnxNWdNdBZvRlxRupxMVa13rvCbAPnVvUcbJhb8HIsOBWMCW0rapGcIHqVNzMfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl42QzI2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl42QzI2"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so13165ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 10:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732215312; x=1732820112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5Yq0kMD1KNk0ruihWIMR0JAGRCSlFWCvSyeBxV/s80=;
        b=kl42QzI25Ul2BESYsj0iy5AgmYowfvNR2ZqZl5rHSkHFCcQ7Etqno0fYugOW6J9TaC
         jHpbXhPx6BsUYrbDIAonzKjf+qjka9MinF/E6IGMA9VTmcN1OUP8yV1JhiUz5sYUvAhV
         INSQp7WWVtk3Yi9IbuQ3dm+v8YMtgS/hu6lWv0PpWGrBpeBjlpO6SJ1JDpoA90HLfQTY
         WH54U+huMMdr3YCmWm9epWStaGNvGM6/ONwK+A6XDQGgj6u60npZY/EJ0srHbnoG0Rpa
         IlNCfKxYIInezfEZoiiR0pT4YU8jdzYAdIT5T+wp0RrAIxMhuqFTAQfHKeVtmL3sBO9h
         itgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215312; x=1732820112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5Yq0kMD1KNk0ruihWIMR0JAGRCSlFWCvSyeBxV/s80=;
        b=CAT7V3wTCTdfz2XgV3Z8Hri3mKN23gYAjCNxdorhILrNcykPG5L+u4c7WOzGerm0XP
         UCiWf8oeEaRj8O/tCYfrgoUUCUCGe3p6JpjyM/mr4L1zEeA0srzoMjY0uPaY5lwjzuBO
         Zid+08kcE/fL9jNSTIMI2AqW42ReruHIuGg5H3VPEePi0LfDnM+zdA2iKuQQhgoeTahv
         2MaWck3PS91e/2x6Ki3c1q1Qf6ON1GIPjwkA40epPiKRVKyeUHbLVtBpQiQNlh7mZ7/p
         lO/7H6iTi1PqTdb7+b8bFG9Zo3kXC62wMs6MGe4CSTPoj9J6CKSZINPuFhQ64IDwUqxR
         BL4w==
X-Forwarded-Encrypted: i=1; AJvYcCWRYn7sveHDD0qbePsoW3xFPFRGz+mosjIqFBeZJLnO5zq0IE4oDZ5tM5PPXWr2hJNMhsrhAM9MLExm9/fOVqf2@vger.kernel.org
X-Gm-Message-State: AOJu0YyYW+H7RpAAm6qK0pgaKcLLP7a6Hm2g/Sd0Z4La9C0yI9lDIMps
	/u0yNvLcCoMvt1lW52jYgv2cQQptM7ISzVi3IdBtTXTmGysJEEcmvChaCZXLnzwyCRwq595WbSS
	9BwA1bRzFdY+xhwFxOaT1ysMAB1JyYvCnHSKW
X-Gm-Gg: ASbGncuNqApGVi95KV5ZTXWswdcK6o8SK2j/7ZrE510MOPO76qRWTrL0UzeU9rxfZV8
	thYDhxbllv6NEZfVLfePeu6XVq4tCkK9bIZPmd+AMdZ4IRuR2rT6zbk+ddf6tPQ==
X-Google-Smtp-Source: AGHT+IEqD4eA6qb4GJdME6SOtoCS5fShtF9kHjpMw2TgtyR0ivTKp5pNbyGU3DmrbE0O4XV4IrNZ9joyiY6qbDv4bgg=
X-Received: by 2002:a05:6e02:3190:b0:3a7:6966:5fe1 with SMTP id
 e9e14a558f8ab-3a79b40e1bbmr189805ab.20.1732215311512; Thu, 21 Nov 2024
 10:55:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121000955.536930-1-irogers@google.com> <Zz9oKR3goFPP9_a9@x1> <Zz9sbNAuRsYjclAi@x1>
In-Reply-To: <Zz9sbNAuRsYjclAi@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 Nov 2024 10:55:00 -0800
Message-ID: <CAP-5=fXAitSZuRPppAjH=38Ua6BFyhou0sSj7xmfNakqPUQqPw@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:22=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 02:04:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> > > Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> > > address issue with hwmon_pmu__config_terms needing to load events - a
> > > load bearing assert fired. Also fix missing list deletion when puttin=
g
> > > the hwmon test PMU and lower some debug warnings to make the hwmon PM=
U
> > > less spammy in verbose mode.
>
> > After applying this, with this series of patches on a Fedora 40 system,
> > I get output from -v where before I needed, IIRC, to use -vv:
> >
> > f8244bb9bfa66f79 (HEAD -> perf-tools-next, x1/perf-tools-next) perf tes=
ts: Fix hwmon parsing with PMU name test
> > 9ae6c7a4bd02acbd perf hwmon_pmu: Ensure hwmon key union is zeroed befor=
e use
> > 3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete()
> > 0565017a0ac824c2 perf test: Correct hwmon test PMU detection
> > 85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-next/=
perf-tools-next) perf: Remove unused del_perf_probe_events()
> > =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> <SNIP>
>
> > root@number:~# perf test -v 11
> >  11: Hwmon PMU                                                       :
> >  11.1: Basic parsing test                                            : =
Ok
> > --- start ---
> > test child forked, pid 1823259
> > Testing 'temp_test_hwmon_event1'
> > Using CPUID GenuineIntel-6-B7-1
> > FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon_eve=
nt1', err 1
> > event syntax error: 'temp_test_hwmon_event1'
> >                      \___ Bad event name
> >
> > Unable to find event on a PMU of 'temp_test_hwmon_event1'
>
> In gdb it fails on the first call to do_test() from the first test__hwmon=
_pmu()
>
> Starting program: /root/bin/perf test -F -vv 11
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> --- start ---
> ---- end ----
>  11.1: Basic parsing test                                            : Ok
> --- start ---
>
> Breakpoint 1, test__hwmon_pmu (with_pmu=3Dfalse) at tests/hwmon_pmu.c:203
> 203     {
> (gdb) n
> 205             struct perf_pmu *pmu =3D test_pmu_get(dir, sizeof(dir));
> (gdb) n
> 206             int ret =3D TEST_OK;
> (gdb) p pmu
> $2 =3D (struct perf_pmu *) 0xf50450
> (gdb) p *pmu
> $3 =3D {name =3D 0xf50ac0 "hwmon_a_test_hwmon_pmu", alias_name =3D 0xf50a=
a0 "hwmon1234", id =3D 0x0, type =3D 4294902994, selectable =3D false, is_c=
ore =3D false, is_uncore =3D false, auxtrace =3D false,
>   formats_checked =3D false, config_masks_present =3D false, config_masks=
_computed =3D false, max_precise =3D 0, perf_event_attr_init_default =3D 0x=
0, cpus =3D 0xf4fbf0, format =3D {next =3D 0xf50488,
>     prev =3D 0xf50488}, aliases =3D {next =3D 0xf50498, prev =3D 0xf50498=
}, events_table =3D 0x0, sysfs_aliases =3D 0, cpu_json_aliases =3D 0, sys_j=
son_aliases =3D 0, sysfs_aliases_loaded =3D false,
>   cpu_aliases_added =3D false, caps_initialized =3D false, nr_caps =3D 0,=
 caps =3D {next =3D 0xf504c8, prev =3D 0xf504c8}, list =3D {next =3D 0xedc0=
90 <other_pmus>, prev =3D 0xedc090 <other_pmus>},
>   config_masks =3D {0, 0, 0, 0}, missing_features =3D {exclude_guest =3D =
false, checked =3D false}, mem_events =3D 0x0}

Thanks for helping, I'm not able to repro this, so extra debugging
would be useful for me. Here sysfs_aliases_loaded is false as we'll
load the PMU aliases when there is a request to pmu__have_event. This
looks pretty ordinary.

> (gdb) s
> 208             if (!pmu)
> (gdb) s
> 211             for (size_t i =3D 0; i < ARRAY_SIZE(test_events); i++) {
> (gdb) s
> 212                     ret =3D do_test(i, with_pmu, /*with_alias=3D*/fal=
se);
> (gdb) s
> do_test (i=3D0, with_pmu=3Dfalse, with_alias=3Dfalse) at tests/hwmon_pmu.=
c:136
> 136     {
> (gdb) n
> 137             const char *test_event =3D with_alias ? test_events[i].al=
ias : test_events[i].name;
> (gdb) n
> 138             struct evlist *evlist =3D evlist__new();
> (gdb) n
> 143             bool found =3D false;
> (gdb) n
> 145             if (!evlist) {
> (gdb) n
> 150             if (with_pmu)
> (gdb) n
> 153                     strlcpy(str, test_event, sizeof(str));
> (gdb) n
> 155             pr_debug("Testing '%s'\n", str);
> (gdb) p str
> $4 =3D "temp_test_hwmon_event1\000\000\004\000\000\000\000\000\000\000\27=
4\204z\000\000\000\000\000=CE=84z\000\000\000\000\000\021\000\000\000\000\0=
00\000\000 \305\377\377\377\177\000\000=DF=84z\000\000\000\000\000\353\204z=
\000\000\000\000\000\376\204z\000\000\000\000\000\n\205z\000\000\000\000\00=
0\021\205z\000\000\000\000\000\035\205z\000\000\000\000\0000\205z\000\000\0=
00\000\000<\205z\000\000\000\000"
> (gdb) n
> Testing 'temp_test_hwmon_event1'
> 156             parse_events_error__init(&err);

So there was no parse event output like the expected:
```
Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
```
The wildcard PMU lookup will call perf_pmu__have_event trying to find
a PMU with the event:
```
Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556157f90,
   name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
1816    {
(gdb) bt
#0  perf_pmu__have_event (pmu=3D0x555556157f90, name=3D0x5555560ce470
"temp_test_hwmon_event1")
   at util/pmu.c:1816
#1  0x00005555557ab143 in parse_events_multi_pmu_add
(parse_state=3D0x7fffffffbf00,
   event_name=3D0x5555560ce470 "temp_test_hwmon_event1", hw_config=3D10,
const_parsed_terms=3D0x0,
   listp=3D0x7fffffffa270, loc_=3D0x7fffffffb120) at util/parse-events.c:15=
92
#2  0x00005555558108cc in parse_events_parse
(_parse_state=3D0x7fffffffbf00, scanner=3D0x555556138aa0)
   at util/parse-events.y:293
#3  0x00005555557abdc2 in parse_events__scanner (str=3D0x7fffffffc000
"temp_test_hwmon_event1",
   input=3D0x0, parse_state=3D0x7fffffffbf00) at util/parse-events.c:1870
#4  0x00005555557ac735 in __parse_events (evlist=3D0x55555613ca40,
   str=3D0x7fffffffc000 "temp_test_hwmon_event1", pmu_filter=3D0x0,
err=3D0x7fffffffbff0,
   fake_pmu=3Dfalse, warn_if_reordered=3Dtrue, fake_tp=3Dfalse) at
util/parse-events.c:2139
#5  0x00005555557448ca in parse_events (evlist=3D0x55555613ca40,
   str=3D0x7fffffffc000 "temp_test_hwmon_event1", err=3D0x7fffffffbff0)
   at /home/irogers/kernel.org2/tools/perf/util/parse-events.h:41
#6  0x0000555555744f6e in do_test (i=3D0, with_pmu=3Dfalse,
with_alias=3Dfalse) at tests/hwmon_pmu.c:156
#7  0x00005555557452dd in test__hwmon_pmu (with_pmu=3Dfalse) at
tests/hwmon_pmu.c:212
#8  0x000055555574538d in test__hwmon_pmu_without_pmu
(test=3D0x5555560a3740 <suite.hwmon_pmu>,
   subtest=3D1) at tests/hwmon_pmu.c:229
#9  0x00005555556fc935 in start_test (test=3D0x5555560a3740
<suite.hwmon_pmu>, i=3D10, subi=3D1,
   child=3D0x55555613c528, width=3D64, pass=3D1) at tests/builtin-test.c:42=
4
#10 0x00005555556fd014 in __cmd_test (suites=3D0x55555613c0f0, argc=3D1,
argv=3D0x7fffffffd9c0,
   skiplist=3D0x0) at tests/builtin-test.c:571
#11 0x00005555556fdb29 in cmd_test (argc=3D1, argv=3D0x7fffffffd9c0) at
tests/builtin-test.c:773
#12 0x000055555568043a in run_builtin (p=3D0x55555608f950 <commands+624>, a=
rgc=3D4,
   argv=3D0x7fffffffd9c0) at perf.c:351
#13 0x00005555556806e1 in handle_internal_command (argc=3D4,
argv=3D0x7fffffffd9c0) at perf.c:404
#14 0x000055555568083a in run_argv (argcp=3D0x7fffffffd7bc,
argv=3D0x7fffffffd7b0) at perf.c:448
#15 0x0000555555680b83 in main (argc=3D4, argv=3D0x7fffffffd9c0) at perf.c:=
560
(gdb) p pmu->name
$1 =3D 0x5555560ce940 "cpu"
```
Repeating this the test hwmon_a_test_hwmon_pmu test PMU should be tested:
```
(gdb) c
Continuing.

(gdb) p pmu->name
$2 =3D 0x5555560d6b20 "breakpoint"
(gdb) c
Continuing.

Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556158060,
   name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
1816    {
(gdb) p pmu->name
$3 =3D 0x5555560d7ec0 "cstate_core"
(gdb) c
Continuing.

Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556158610,
   name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
1816    {
(gdb) p pmu->name
$4 =3D 0x5555560c84b0 "cstate_pkg"
(gdb) c
Continuing.

Breakpoint 1, perf_pmu__have_event (pmu=3D0x5555561360b0,
   name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
1816    {
(gdb) p pmu->name
$5 =3D 0x5555560d46a0 "hwmon_a_test_hwmon_pmu"
```
which should then go into the hwmon_pmu__have_event:
```
(gdb) n
1817            if (!name)
(gdb)
1819            if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
(gdb)
1821            if (perf_pmu__is_hwmon(pmu))
(gdb) n
1822                    return hwmon_pmu__have_event(pmu, name);
(gdb) s
hwmon_pmu__have_event (pmu=3D0x5555561360b0, name=3D0x5555560ce470
"temp_test_hwmon_event1")
   at util/hwmon_pmu.c:559
```
hwmon_pmu__have_event should return true but it is either not getting
called in your case or it is returning false. Not getting called I
find hard to understand as your output shows the test PMU was created.
It seems more likely reading the "events" and then doing the hashmap
lookup in hwmon_pmu__have_event fails. This was failing for me with
undefined behavior sanitizer because of the under initialized unions.
But that should be fixed by: "perf hwmon_pmu: Ensure hwmon key union
is zeroed before use". The particular event "temp_test_hwmon_event1"
is going to search all events as it uses the "label" name, so that
makes me think the bug is here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n584
but I can't eye ball an issue and the test works for me even when
trying to be aggressive with sanitizers. If you could help me look I'd
appreciate it.

Thanks,
Ian


> (gdb) n
> 157             ret =3D parse_events(evlist, str, &err);
> (gdb) n
> Using CPUID GenuineIntel-6-B7-1
> 158             if (ret) {
> (gdb) p ret
> $5 =3D 1
> (gdb) n
> 159                     pr_debug("FAILED %s:%d failed to parse event '%s'=
, err %d\n",
> (gdb)
>
>
