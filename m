Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69D165F17
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Nov 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258799; cv=none; b=rjn75XEbA23GvCV60RgTKJLFTdvRUuqwrwq+MP+SNU7Slk1rteAP20CiH8D8ooGt3zhbOPUva660QnsUf3YYi2MxFpcSGTStPbI/8c2xlh4jg61BaIB9vk2ojyrk19EI9ZOBZ77Og/YpdNGJnGZLPiJoBlBW19QidVWaeoOQ2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258799; c=relaxed/simple;
	bh=WkpwOMRy/XgsMV9wQ7PG8nx+9yo8XnDPBxdg7rRQrU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCxrYnKCxC9O8abr+0DYWMAvBKKZBVNpiUm/eaLB2CfrvMmI3RuGURqJIAZNe9ZyRGB5Goptv86vQuSJqxgJC3OLSpcth3MaZShzkldoAbW+1kW45GUyMjF9ezdQT2HeTMjym6eA93Qxgm541/Zy4aW2RbyB8F0r3jgs0Y1P0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sZ+fdNo; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sZ+fdNo"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a781e908a7so115525ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Nov 2024 22:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732258797; x=1732863597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=248h8jTi5EiAlVYfxE9YjppYaI7J9lpk6fDXU7wm0KY=;
        b=3sZ+fdNoYhKchVBj7+2ZtTAWLLU6+sbLn40AbbQkNGUTMxbNf4OUAuaruGyoqwIrfJ
         7ZTRjtAytybz9fFnKjXMyLZI8VwMTVzbnMFhdMoldpPHxVdLxNbxPj2DQlCghBMc/jCs
         xQvBhVyhwB2zQ8fz98RZOwFrUc7opsz9Gt+Bv8uRVIPLz836ZbIiDt15SGCc25YznGlJ
         O9xNNYTXci4NYADC19zV7Jv3LxJjHAeOzOiu5yyVJgG4qYD6ovVFXUq+8rZ1C9SWwxbl
         M6pZu4gRHyigj8i9Gh+NQezedqmSr7vaC+pol40hrvRCpldnC0w36voRzEgv8zR0ytSN
         oudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732258797; x=1732863597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=248h8jTi5EiAlVYfxE9YjppYaI7J9lpk6fDXU7wm0KY=;
        b=juKxEsJGJEK/LzCAMnWYkdEI5P5sNO2kF1dbn8kZy+0GfWVmfnnzI/weLTnadCn/+d
         ymI1kT174z9I41CdstrJKUDETGoZiXb6mGtsa4oJO39PKpCYHq/LtGRtR6OvdUBDoKQr
         GEOFF7noCgb1j0RhH3/TDLDQ5qjXK/vwrYz3FF7jeE2qWPq/b9w5ljKF5gDF327ViraY
         KKctRn5twguYodHizqpNGPHMvUWf8KDkr6vGv1dQ8IHKuA4RtGgZ7gZBPfXjiRdeE0C0
         PuB2Uzx2JZWZjwOLkSf3u09ZREOAmYVCSwcIuQzqRXUNeEK6R2j9R+Lil9z6xqI8uhA9
         kRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVaFv9Uad69kCWYSWOzz0jijWAqPo1DjAiF7gm9fBeT14S7QZGqnl8JSDxYyB2JNa5q6b14TEiEsdtHsDikQLgE@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoK2b/hUyoIXFrEIR5UHaOU3qReAk4aQKuC647GBAzD9+ZbHZ
	XE+1twHJ41VSVyq5VJ0X48nJ82gnJlpBcx/V4G4jULlcsRqSqeT9auhO9WaS0VArL41PhvUK3cv
	JUPYSb+fbO+h3qCX8rcYbcGWPUC2d+NN3zxd0
X-Gm-Gg: ASbGncuwTM3as8PZDrhnb2UNFxyit0V0n6S6o2qGnZNqY3KuzI51Flv28NeQHtOd8tf
	chcMKSctLsbtWXwmG8KYa4T3TERDfNU4Z
X-Google-Smtp-Source: AGHT+IFoL6sO8RkBSx3tj9bnAuVMZ+2/WNdHfooynGlQqT5wLOvDeSC88aSPZxscC8i+J6SjdUYzf2sEU5Q9wW8agyQ=
X-Received: by 2002:a05:6e02:3708:b0:3a7:75b2:1f9e with SMTP id
 e9e14a558f8ab-3a79b20ca02mr2668165ab.8.1732258796748; Thu, 21 Nov 2024
 22:59:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121000955.536930-1-irogers@google.com> <Zz9oKR3goFPP9_a9@x1>
 <Zz9sbNAuRsYjclAi@x1> <CAP-5=fXAitSZuRPppAjH=38Ua6BFyhou0sSj7xmfNakqPUQqPw@mail.gmail.com>
 <Zz-e4fMLIJmufgyl@x1>
In-Reply-To: <Zz-e4fMLIJmufgyl@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 Nov 2024 22:59:45 -0800
Message-ID: <CAP-5=fWE7VhNWm4Vo2EngQ3is7arfMq-m4MJEJZBGjd1p3m5Qg@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:58=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 10:55:00AM -0800, Ian Rogers wrote:
> > On Thu, Nov 21, 2024 at 9:22=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Nov 21, 2024 at 02:04:45PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> > > > > Incorrectly the hwmon with PMU name test didn't pass "true". Fix =
and
> > > > > address issue with hwmon_pmu__config_terms needing to load events=
 - a
> > > > > load bearing assert fired. Also fix missing list deletion when pu=
tting
> > > > > the hwmon test PMU and lower some debug warnings to make the hwmo=
n PMU
> > > > > less spammy in verbose mode.
> > >
> > > > After applying this, with this series of patches on a Fedora 40 sys=
tem,
> > > > I get output from -v where before I needed, IIRC, to use -vv:
> > > >
> > > > f8244bb9bfa66f79 (HEAD -> perf-tools-next, x1/perf-tools-next) perf=
 tests: Fix hwmon parsing with PMU name test
> > > > 9ae6c7a4bd02acbd perf hwmon_pmu: Ensure hwmon key union is zeroed b=
efore use
> > > > 3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete=
()
> > > > 0565017a0ac824c2 perf test: Correct hwmon test PMU detection
> > > > 85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-n=
ext/perf-tools-next) perf: Remove unused del_perf_probe_events()
> > > > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> > >
> > > <SNIP>
> > >
> > > > root@number:~# perf test -v 11
> > > >  11: Hwmon PMU                                                     =
  :
> > > >  11.1: Basic parsing test                                          =
  : Ok
> > > > --- start ---
> > > > test child forked, pid 1823259
> > > > Testing 'temp_test_hwmon_event1'
> > > > Using CPUID GenuineIntel-6-B7-1
> > > > FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon=
_event1', err 1
> > > > event syntax error: 'temp_test_hwmon_event1'
> > > >                      \___ Bad event name
> > > >
> > > > Unable to find event on a PMU of 'temp_test_hwmon_event1'
> > >
> > > In gdb it fails on the first call to do_test() from the first test__h=
wmon_pmu()
> > >
> > > Starting program: /root/bin/perf test -F -vv 11
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > --- start ---
> > > ---- end ----
> > >  11.1: Basic parsing test                                            =
: Ok
> > > --- start ---
> > >
> > > Breakpoint 1, test__hwmon_pmu (with_pmu=3Dfalse) at tests/hwmon_pmu.c=
:203
> > > 203     {
> > > (gdb) n
> > > 205             struct perf_pmu *pmu =3D test_pmu_get(dir, sizeof(dir=
));
> > > (gdb) n
> > > 206             int ret =3D TEST_OK;
> > > (gdb) p pmu
> > > $2 =3D (struct perf_pmu *) 0xf50450
> > > (gdb) p *pmu
> > > $3 =3D {name =3D 0xf50ac0 "hwmon_a_test_hwmon_pmu", alias_name =3D 0x=
f50aa0 "hwmon1234", id =3D 0x0, type =3D 4294902994, selectable =3D false, =
is_core =3D false, is_uncore =3D false, auxtrace =3D false,
> > >   formats_checked =3D false, config_masks_present =3D false, config_m=
asks_computed =3D false, max_precise =3D 0, perf_event_attr_init_default =
=3D 0x0, cpus =3D 0xf4fbf0, format =3D {next =3D 0xf50488,
> > >     prev =3D 0xf50488}, aliases =3D {next =3D 0xf50498, prev =3D 0xf5=
0498}, events_table =3D 0x0, sysfs_aliases =3D 0, cpu_json_aliases =3D 0, s=
ys_json_aliases =3D 0, sysfs_aliases_loaded =3D false,
> > >   cpu_aliases_added =3D false, caps_initialized =3D false, nr_caps =
=3D 0, caps =3D {next =3D 0xf504c8, prev =3D 0xf504c8}, list =3D {next =3D =
0xedc090 <other_pmus>, prev =3D 0xedc090 <other_pmus>},
> > >   config_masks =3D {0, 0, 0, 0}, missing_features =3D {exclude_guest =
=3D false, checked =3D false}, mem_events =3D 0x0}
> >
> > Thanks for helping, I'm not able to repro this, so extra debugging
> > would be useful for me. Here sysfs_aliases_loaded is false as we'll
> > load the PMU aliases when there is a request to pmu__have_event. This
> > looks pretty ordinary.
> >
> > > (gdb) s
> > > 208             if (!pmu)
> > > (gdb) s
> > > 211             for (size_t i =3D 0; i < ARRAY_SIZE(test_events); i++=
) {
> > > (gdb) s
> > > 212                     ret =3D do_test(i, with_pmu, /*with_alias=3D*=
/false);
> > > (gdb) s
> > > do_test (i=3D0, with_pmu=3Dfalse, with_alias=3Dfalse) at tests/hwmon_=
pmu.c:136
> > > 136     {
> > > (gdb) n
> > > 137             const char *test_event =3D with_alias ? test_events[i=
].alias : test_events[i].name;
> > > (gdb) n
> > > 138             struct evlist *evlist =3D evlist__new();
> > > (gdb) n
> > > 143             bool found =3D false;
> > > (gdb) n
> > > 145             if (!evlist) {
> > > (gdb) n
> > > 150             if (with_pmu)
> > > (gdb) n
> > > 153                     strlcpy(str, test_event, sizeof(str));
> > > (gdb) n
> > > 155             pr_debug("Testing '%s'\n", str);
> > > (gdb) p str
> > > $4 =3D "temp_test_hwmon_event1\000\000\004\000\000\000\000\000\000\00=
0\274\204z\000\000\000\000\000=CE=84z\000\000\000\000\000\021\000\000\000\0=
00\000\000\000 \305\377\377\377\177\000\000=DF=84z\000\000\000\000\000\353\=
204z\000\000\000\000\000\376\204z\000\000\000\000\000\n\205z\000\000\000\00=
0\000\021\205z\000\000\000\000\000\035\205z\000\000\000\000\0000\205z\000\0=
00\000\000\000<\205z\000\000\000\000"
> > > (gdb) n
> > > Testing 'temp_test_hwmon_event1'
> > > 156             parse_events_error__init(&err);
> >
> > So there was no parse event output like the expected:
> > ```
> > Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> > ..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> > ```
> > The wildcard PMU lookup will call perf_pmu__have_event trying to find
> > a PMU with the event:
> > ```
> > Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556157f90,
> >    name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> > 1816    {
> > (gdb) bt
> > #0  perf_pmu__have_event (pmu=3D0x555556157f90, name=3D0x5555560ce470
> > "temp_test_hwmon_event1")
> >    at util/pmu.c:1816
> > #1  0x00005555557ab143 in parse_events_multi_pmu_add
> > (parse_state=3D0x7fffffffbf00,
> >    event_name=3D0x5555560ce470 "temp_test_hwmon_event1", hw_config=3D10=
,
> > const_parsed_terms=3D0x0,
> >    listp=3D0x7fffffffa270, loc_=3D0x7fffffffb120) at util/parse-events.=
c:1592
> > #2  0x00005555558108cc in parse_events_parse
> > (_parse_state=3D0x7fffffffbf00, scanner=3D0x555556138aa0)
> >    at util/parse-events.y:293
> > #3  0x00005555557abdc2 in parse_events__scanner (str=3D0x7fffffffc000
> > "temp_test_hwmon_event1",
> >    input=3D0x0, parse_state=3D0x7fffffffbf00) at util/parse-events.c:18=
70
> > #4  0x00005555557ac735 in __parse_events (evlist=3D0x55555613ca40,
> >    str=3D0x7fffffffc000 "temp_test_hwmon_event1", pmu_filter=3D0x0,
> > err=3D0x7fffffffbff0,
> >    fake_pmu=3Dfalse, warn_if_reordered=3Dtrue, fake_tp=3Dfalse) at
> > util/parse-events.c:2139
> > #5  0x00005555557448ca in parse_events (evlist=3D0x55555613ca40,
> >    str=3D0x7fffffffc000 "temp_test_hwmon_event1", err=3D0x7fffffffbff0)
> >    at /home/irogers/kernel.org2/tools/perf/util/parse-events.h:41
> > #6  0x0000555555744f6e in do_test (i=3D0, with_pmu=3Dfalse,
> > with_alias=3Dfalse) at tests/hwmon_pmu.c:156
> > #7  0x00005555557452dd in test__hwmon_pmu (with_pmu=3Dfalse) at
> > tests/hwmon_pmu.c:212
> > #8  0x000055555574538d in test__hwmon_pmu_without_pmu
> > (test=3D0x5555560a3740 <suite.hwmon_pmu>,
> >    subtest=3D1) at tests/hwmon_pmu.c:229
> > #9  0x00005555556fc935 in start_test (test=3D0x5555560a3740
> > <suite.hwmon_pmu>, i=3D10, subi=3D1,
> >    child=3D0x55555613c528, width=3D64, pass=3D1) at tests/builtin-test.=
c:424
> > #10 0x00005555556fd014 in __cmd_test (suites=3D0x55555613c0f0, argc=3D1=
,
> > argv=3D0x7fffffffd9c0,
> >    skiplist=3D0x0) at tests/builtin-test.c:571
> > #11 0x00005555556fdb29 in cmd_test (argc=3D1, argv=3D0x7fffffffd9c0) at
> > tests/builtin-test.c:773
> > #12 0x000055555568043a in run_builtin (p=3D0x55555608f950 <commands+624=
>, argc=3D4,
> >    argv=3D0x7fffffffd9c0) at perf.c:351
> > #13 0x00005555556806e1 in handle_internal_command (argc=3D4,
> > argv=3D0x7fffffffd9c0) at perf.c:404
> > #14 0x000055555568083a in run_argv (argcp=3D0x7fffffffd7bc,
> > argv=3D0x7fffffffd7b0) at perf.c:448
> > #15 0x0000555555680b83 in main (argc=3D4, argv=3D0x7fffffffd9c0) at per=
f.c:560
> > (gdb) p pmu->name
> > $1 =3D 0x5555560ce940 "cpu"
> > ```
> > Repeating this the test hwmon_a_test_hwmon_pmu test PMU should be teste=
d:
> > ```
> > (gdb) c
> > Continuing.
> >
> > (gdb) p pmu->name
> > $2 =3D 0x5555560d6b20 "breakpoint"
> > (gdb) c
> > Continuing.
> >
> > Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556158060,
> >    name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> > 1816    {
> > (gdb) p pmu->name
> > $3 =3D 0x5555560d7ec0 "cstate_core"
> > (gdb) c
> > Continuing.
> >
> > Breakpoint 1, perf_pmu__have_event (pmu=3D0x555556158610,
> >    name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> > 1816    {
> > (gdb) p pmu->name
> > $4 =3D 0x5555560c84b0 "cstate_pkg"
> > (gdb) c
> > Continuing.
> >
> > Breakpoint 1, perf_pmu__have_event (pmu=3D0x5555561360b0,
> >    name=3D0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> > 1816    {
> > (gdb) p pmu->name
> > $5 =3D 0x5555560d46a0 "hwmon_a_test_hwmon_pmu"
> > ```
> > which should then go into the hwmon_pmu__have_event:
> > ```
> > (gdb) n
> > 1817            if (!name)
> > (gdb)
> > 1819            if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name=
))
> > (gdb)
> > 1821            if (perf_pmu__is_hwmon(pmu))
> > (gdb) n
> > 1822                    return hwmon_pmu__have_event(pmu, name);
> > (gdb) s
> > hwmon_pmu__have_event (pmu=3D0x5555561360b0, name=3D0x5555560ce470
> > "temp_test_hwmon_event1")
> >    at util/hwmon_pmu.c:559
> > ```
> > hwmon_pmu__have_event should return true but it is either not getting
> > called in your case or it is returning false. Not getting called I
> > find hard to understand as your output shows the test PMU was created.
> > It seems more likely reading the "events" and then doing the hashmap
> > lookup in hwmon_pmu__have_event fails. This was failing for me with
> > undefined behavior sanitizer because of the under initialized unions.
> > But that should be fixed by: "perf hwmon_pmu: Ensure hwmon key union
> > is zeroed before use". The particular event "temp_test_hwmon_event1"
> > is going to search all events as it uses the "label" name, so that
> > makes me think the bug is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n584
> > but I can't eye ball an issue and the test works for me even when
> > trying to be aggressive with sanitizers. If you could help me look I'd
> > appreciate it.
>
> Where is that "temp_test_hwmon_event1" added?

test_pmu_get creates the directory for the test PMU. The file
temp1_label will be created with the contents "test hwmon event1",
there is also a fake "input" file:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/hwmon_pmu.c?h=3Dperf-tools-next#n62
```
{ "temp1_label", "test hwmon event1\n", },
{ "temp1_input", "40000\n", },
```
So we will have an event called temp1 based on the type and number.
Because we have a label there will be an alias of
"temp_test_hwmon_event1" where temp is the type from the filename,
"test_hwmon_event1" is the contents of the file "fixed" by removing
escapes, spaces, etc. and making them underscores:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n234

These files are read and stored in a hashmap where the key is the
type, so temp, and the number, so 1:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n287
The value associated with the key is just a bitmap saying what kinds
of hwmon items (files) there are for this type+number as well as a
cache of reading the file event's label file and of its "fixed" name
to aid searching:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n125
The key is numeric but the failing event is a string and requires the
whole map searching to check for presence by matching what is the name
computed from the label file:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/hwmon_pmu.c?h=3Dperf-tools-next#n579

```
Breakpoint 1, hwmon_pmu__have_event (pmu=3D0x555556147f40,
   name=3D0x5555560d8470 "temp_test_hwmon_event1") at util/hwmon_pmu.c:559
559     {
(gdb) n
560             struct hwmon_pmu *hwm =3D container_of(pmu, struct
hwmon_pmu, pmu);
(gdb)
563             union hwmon_pmu_event_key key =3D {};
(gdb)
567             if (!parse_hwmon_filename(name, &type, &number,
/*item=3D*/NULL, /*is_alarm=3D*/NULL))
(gdb)
570             if (hwmon_pmu__read_events(hwm))
(gdb)
573             key.type =3D type;
(gdb)
574             key.num =3D number;
(gdb)
575             if (hashmap_find(&hwm->events, key.type_and_num,
/*value=3D*/NULL))
(gdb)
577             if (key.num !=3D -1)
(gdb)
580             hashmap__for_each_entry((&hwm->events), cur, bkt) {
(gdb) n
581                     struct hwmon_pmu_event_value *value =3D cur->pvalue=
;
(gdb)
583                     key.type_and_num =3D cur->key;
(gdb)
584                     if (key.type =3D=3D type && value->name &&
!strcasecmp(name, value->name))
(gdb) p value->name
$1 =3D 0x5555560d0680 "temp_test_hwmon_event1"
(gdb) n
585                             return true;
```
The if here must be failing for you, but I fail to see why. I don't
see the strcasecmp in your output and what we care about is why either
the type is wrong or value->name is wrong, if you could help to log
these it would be great.

Thanks,
Ian
