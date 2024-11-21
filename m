Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADA1C304F;
	Thu, 21 Nov 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732222693; cv=none; b=QtRERn6NnGmPqbnZjPBSBZHopM6c8gAT/EcpNSSfNvoBAXnFlF+O8IlqaUEzTKYXDeoRhotXgrS4QQqpHLNNO8EmMQbYIujFRkxhm5quwPWzsdqSo3JuqYggA6sTDwX7FBIjOewofVB7x4bdJ1qoLCspH7kzMCMOW3prUcIIxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732222693; c=relaxed/simple;
	bh=xDvniAIlhnzBwNgXiEvN/CISL127vuPJKCIxQxi8PPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyy2CgBz7UEFZzg//LKKFvDSQqgPuRGfy0BtdQDVkQRX5uidHMhiBhQ0LJa4rlEUAxfkBZmQQ02GyshNFneRuHKAFqcblaX2hs4ES1GG4j2KVlTYZuJLneM+AwZFvBTPMbrEHp0ay+uGtVdvyo0Ob9ABP4qXzffrqWvCbK4o1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyuylrn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyuylrn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493D0C4CECC;
	Thu, 21 Nov 2024 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732222692;
	bh=xDvniAIlhnzBwNgXiEvN/CISL127vuPJKCIxQxi8PPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyuylrn3NycYPbHMY2OmeRp7UkFMPMaXpGKdAY5EsiIsqJlf264GdJxiUmy+yVrMv
	 n8oasfXYrUVFpn8fncESI4xq9JpJNgX0LaCvWk8TSSBYZ0HKkgudHvmrunzWwI9+9z
	 zgv46ab8ZqA/NQrTmLCSA1d6+ajK4tM2lBk1gSkM7AjITi9Qi5XnlzxpsTz1sN8I27
	 1APOfAJn6rIwPaFnGQhOueBfAlStQhEl/ke5XnRXyqMS0bQD/QYImpb8DbgWHiD6Je
	 XaHk1NHXMeTsfSVsgJF18YKSIHvffHyxCJIUNjq2kF9vYvwC67su2v1Mg1TAYfONcP
	 Ppmy19UpFhOsQ==
Date: Thu, 21 Nov 2024 17:58:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
Message-ID: <Zz-e4fMLIJmufgyl@x1>
References: <20241121000955.536930-1-irogers@google.com>
 <Zz9oKR3goFPP9_a9@x1>
 <Zz9sbNAuRsYjclAi@x1>
 <CAP-5=fXAitSZuRPppAjH=38Ua6BFyhou0sSj7xmfNakqPUQqPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXAitSZuRPppAjH=38Ua6BFyhou0sSj7xmfNakqPUQqPw@mail.gmail.com>

On Thu, Nov 21, 2024 at 10:55:00AM -0800, Ian Rogers wrote:
> On Thu, Nov 21, 2024 at 9:22 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Nov 21, 2024 at 02:04:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> > > > Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> > > > address issue with hwmon_pmu__config_terms needing to load events - a
> > > > load bearing assert fired. Also fix missing list deletion when putting
> > > > the hwmon test PMU and lower some debug warnings to make the hwmon PMU
> > > > less spammy in verbose mode.
> >
> > > After applying this, with this series of patches on a Fedora 40 system,
> > > I get output from -v where before I needed, IIRC, to use -vv:
> > >
> > > f8244bb9bfa66f79 (HEAD -> perf-tools-next, x1/perf-tools-next) perf tests: Fix hwmon parsing with PMU name test
> > > 9ae6c7a4bd02acbd perf hwmon_pmu: Ensure hwmon key union is zeroed before use
> > > 3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete()
> > > 0565017a0ac824c2 perf test: Correct hwmon test PMU detection
> > > 85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-next/perf-tools-next) perf: Remove unused del_perf_probe_events()
> > > ⬢ [acme@toolbox perf-tools-next]$
> >
> > <SNIP>
> >
> > > root@number:~# perf test -v 11
> > >  11: Hwmon PMU                                                       :
> > >  11.1: Basic parsing test                                            : Ok
> > > --- start ---
> > > test child forked, pid 1823259
> > > Testing 'temp_test_hwmon_event1'
> > > Using CPUID GenuineIntel-6-B7-1
> > > FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon_event1', err 1
> > > event syntax error: 'temp_test_hwmon_event1'
> > >                      \___ Bad event name
> > >
> > > Unable to find event on a PMU of 'temp_test_hwmon_event1'
> >
> > In gdb it fails on the first call to do_test() from the first test__hwmon_pmu()
> >
> > Starting program: /root/bin/perf test -F -vv 11
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib64/libthread_db.so.1".
> > --- start ---
> > ---- end ----
> >  11.1: Basic parsing test                                            : Ok
> > --- start ---
> >
> > Breakpoint 1, test__hwmon_pmu (with_pmu=false) at tests/hwmon_pmu.c:203
> > 203     {
> > (gdb) n
> > 205             struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
> > (gdb) n
> > 206             int ret = TEST_OK;
> > (gdb) p pmu
> > $2 = (struct perf_pmu *) 0xf50450
> > (gdb) p *pmu
> > $3 = {name = 0xf50ac0 "hwmon_a_test_hwmon_pmu", alias_name = 0xf50aa0 "hwmon1234", id = 0x0, type = 4294902994, selectable = false, is_core = false, is_uncore = false, auxtrace = false,
> >   formats_checked = false, config_masks_present = false, config_masks_computed = false, max_precise = 0, perf_event_attr_init_default = 0x0, cpus = 0xf4fbf0, format = {next = 0xf50488,
> >     prev = 0xf50488}, aliases = {next = 0xf50498, prev = 0xf50498}, events_table = 0x0, sysfs_aliases = 0, cpu_json_aliases = 0, sys_json_aliases = 0, sysfs_aliases_loaded = false,
> >   cpu_aliases_added = false, caps_initialized = false, nr_caps = 0, caps = {next = 0xf504c8, prev = 0xf504c8}, list = {next = 0xedc090 <other_pmus>, prev = 0xedc090 <other_pmus>},
> >   config_masks = {0, 0, 0, 0}, missing_features = {exclude_guest = false, checked = false}, mem_events = 0x0}
> 
> Thanks for helping, I'm not able to repro this, so extra debugging
> would be useful for me. Here sysfs_aliases_loaded is false as we'll
> load the PMU aliases when there is a request to pmu__have_event. This
> looks pretty ordinary.
> 
> > (gdb) s
> > 208             if (!pmu)
> > (gdb) s
> > 211             for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
> > (gdb) s
> > 212                     ret = do_test(i, with_pmu, /*with_alias=*/false);
> > (gdb) s
> > do_test (i=0, with_pmu=false, with_alias=false) at tests/hwmon_pmu.c:136
> > 136     {
> > (gdb) n
> > 137             const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
> > (gdb) n
> > 138             struct evlist *evlist = evlist__new();
> > (gdb) n
> > 143             bool found = false;
> > (gdb) n
> > 145             if (!evlist) {
> > (gdb) n
> > 150             if (with_pmu)
> > (gdb) n
> > 153                     strlcpy(str, test_event, sizeof(str));
> > (gdb) n
> > 155             pr_debug("Testing '%s'\n", str);
> > (gdb) p str
> > $4 = "temp_test_hwmon_event1\000\000\004\000\000\000\000\000\000\000\274\204z\000\000\000\000\000΄z\000\000\000\000\000\021\000\000\000\000\000\000\000 \305\377\377\377\177\000\000߄z\000\000\000\000\000\353\204z\000\000\000\000\000\376\204z\000\000\000\000\000\n\205z\000\000\000\000\000\021\205z\000\000\000\000\000\035\205z\000\000\000\000\0000\205z\000\000\000\000\000<\205z\000\000\000\000"
> > (gdb) n
> > Testing 'temp_test_hwmon_event1'
> > 156             parse_events_error__init(&err);
> 
> So there was no parse event output like the expected:
> ```
> Attempt to add: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> ..after resolving event: hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/
> ```
> The wildcard PMU lookup will call perf_pmu__have_event trying to find
> a PMU with the event:
> ```
> Breakpoint 1, perf_pmu__have_event (pmu=0x555556157f90,
>    name=0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> 1816    {
> (gdb) bt
> #0  perf_pmu__have_event (pmu=0x555556157f90, name=0x5555560ce470
> "temp_test_hwmon_event1")
>    at util/pmu.c:1816
> #1  0x00005555557ab143 in parse_events_multi_pmu_add
> (parse_state=0x7fffffffbf00,
>    event_name=0x5555560ce470 "temp_test_hwmon_event1", hw_config=10,
> const_parsed_terms=0x0,
>    listp=0x7fffffffa270, loc_=0x7fffffffb120) at util/parse-events.c:1592
> #2  0x00005555558108cc in parse_events_parse
> (_parse_state=0x7fffffffbf00, scanner=0x555556138aa0)
>    at util/parse-events.y:293
> #3  0x00005555557abdc2 in parse_events__scanner (str=0x7fffffffc000
> "temp_test_hwmon_event1",
>    input=0x0, parse_state=0x7fffffffbf00) at util/parse-events.c:1870
> #4  0x00005555557ac735 in __parse_events (evlist=0x55555613ca40,
>    str=0x7fffffffc000 "temp_test_hwmon_event1", pmu_filter=0x0,
> err=0x7fffffffbff0,
>    fake_pmu=false, warn_if_reordered=true, fake_tp=false) at
> util/parse-events.c:2139
> #5  0x00005555557448ca in parse_events (evlist=0x55555613ca40,
>    str=0x7fffffffc000 "temp_test_hwmon_event1", err=0x7fffffffbff0)
>    at /home/irogers/kernel.org2/tools/perf/util/parse-events.h:41
> #6  0x0000555555744f6e in do_test (i=0, with_pmu=false,
> with_alias=false) at tests/hwmon_pmu.c:156
> #7  0x00005555557452dd in test__hwmon_pmu (with_pmu=false) at
> tests/hwmon_pmu.c:212
> #8  0x000055555574538d in test__hwmon_pmu_without_pmu
> (test=0x5555560a3740 <suite.hwmon_pmu>,
>    subtest=1) at tests/hwmon_pmu.c:229
> #9  0x00005555556fc935 in start_test (test=0x5555560a3740
> <suite.hwmon_pmu>, i=10, subi=1,
>    child=0x55555613c528, width=64, pass=1) at tests/builtin-test.c:424
> #10 0x00005555556fd014 in __cmd_test (suites=0x55555613c0f0, argc=1,
> argv=0x7fffffffd9c0,
>    skiplist=0x0) at tests/builtin-test.c:571
> #11 0x00005555556fdb29 in cmd_test (argc=1, argv=0x7fffffffd9c0) at
> tests/builtin-test.c:773
> #12 0x000055555568043a in run_builtin (p=0x55555608f950 <commands+624>, argc=4,
>    argv=0x7fffffffd9c0) at perf.c:351
> #13 0x00005555556806e1 in handle_internal_command (argc=4,
> argv=0x7fffffffd9c0) at perf.c:404
> #14 0x000055555568083a in run_argv (argcp=0x7fffffffd7bc,
> argv=0x7fffffffd7b0) at perf.c:448
> #15 0x0000555555680b83 in main (argc=4, argv=0x7fffffffd9c0) at perf.c:560
> (gdb) p pmu->name
> $1 = 0x5555560ce940 "cpu"
> ```
> Repeating this the test hwmon_a_test_hwmon_pmu test PMU should be tested:
> ```
> (gdb) c
> Continuing.
> 
> (gdb) p pmu->name
> $2 = 0x5555560d6b20 "breakpoint"
> (gdb) c
> Continuing.
> 
> Breakpoint 1, perf_pmu__have_event (pmu=0x555556158060,
>    name=0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> 1816    {
> (gdb) p pmu->name
> $3 = 0x5555560d7ec0 "cstate_core"
> (gdb) c
> Continuing.
> 
> Breakpoint 1, perf_pmu__have_event (pmu=0x555556158610,
>    name=0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> 1816    {
> (gdb) p pmu->name
> $4 = 0x5555560c84b0 "cstate_pkg"
> (gdb) c
> Continuing.
> 
> Breakpoint 1, perf_pmu__have_event (pmu=0x5555561360b0,
>    name=0x5555560ce470 "temp_test_hwmon_event1") at util/pmu.c:1816
> 1816    {
> (gdb) p pmu->name
> $5 = 0x5555560d46a0 "hwmon_a_test_hwmon_pmu"
> ```
> which should then go into the hwmon_pmu__have_event:
> ```
> (gdb) n
> 1817            if (!name)
> (gdb)
> 1819            if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
> (gdb)
> 1821            if (perf_pmu__is_hwmon(pmu))
> (gdb) n
> 1822                    return hwmon_pmu__have_event(pmu, name);
> (gdb) s
> hwmon_pmu__have_event (pmu=0x5555561360b0, name=0x5555560ce470
> "temp_test_hwmon_event1")
>    at util/hwmon_pmu.c:559
> ```
> hwmon_pmu__have_event should return true but it is either not getting
> called in your case or it is returning false. Not getting called I
> find hard to understand as your output shows the test PMU was created.
> It seems more likely reading the "events" and then doing the hashmap
> lookup in hwmon_pmu__have_event fails. This was failing for me with
> undefined behavior sanitizer because of the under initialized unions.
> But that should be fixed by: "perf hwmon_pmu: Ensure hwmon key union
> is zeroed before use". The particular event "temp_test_hwmon_event1"
> is going to search all events as it uses the "label" name, so that
> makes me think the bug is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/hwmon_pmu.c?h=perf-tools-next#n584
> but I can't eye ball an issue and the test works for me even when
> trying to be aggressive with sanitizers. If you could help me look I'd
> appreciate it.

Where is that "temp_test_hwmon_event1" added?

I see it at:

⬢ [acme@toolbox perf-tools-next]$ git grep -B6 -A10 temp_test_hwmon_event1 tools/ 
tools/perf/tests/hwmon_pmu.c-static const struct test_event {
tools/perf/tests/hwmon_pmu.c-   const char *name;
tools/perf/tests/hwmon_pmu.c-   const char *alias;
tools/perf/tests/hwmon_pmu.c-   long config;
tools/perf/tests/hwmon_pmu.c-} test_events[] = {
tools/perf/tests/hwmon_pmu.c-   {
tools/perf/tests/hwmon_pmu.c:           "temp_test_hwmon_event1",
tools/perf/tests/hwmon_pmu.c-           "temp1",
tools/perf/tests/hwmon_pmu.c-           0xA0001,
tools/perf/tests/hwmon_pmu.c-   },
tools/perf/tests/hwmon_pmu.c-   {
tools/perf/tests/hwmon_pmu.c-           "temp_test_hwmon_event2",
tools/perf/tests/hwmon_pmu.c-           "temp2",
tools/perf/tests/hwmon_pmu.c-           0xA0002,
tools/perf/tests/hwmon_pmu.c-   },
tools/perf/tests/hwmon_pmu.c-};
tools/perf/tests/hwmon_pmu.c-
⬢ [acme@toolbox perf-tools-next]$

And then it is used in do_test() for looking it up in the hwmon that
should have been added via:

	test_pmu_get()
		perf_pmus__add_test_hwmon_pmu()

And we have:

root@number:~# ls -la /tmp/perf-hwmon-pmu-test-YPH4sb/
total 16
drwx------.  3 root root  140 Nov 21 16:15 .
drwxrwxrwt. 41 root root 1180 Nov 21 17:33 ..
drwxr-xr-x.  2 root root   60 Nov 21 16:15 hwmon1234
-rw-------.  1 root root    6 Nov 21 16:15 temp1_input
-rw-------.  1 root root   18 Nov 21 16:15 temp1_label
-rw-------.  1 root root    6 Nov 21 16:15 temp2_input
-rw-------.  1 root root   18 Nov 21 16:15 temp2_label
root@number:~# 

So it should parse that dir, and then associate the alias that is the
prefix for the files, etc. Ok, then we have:

root@number:~# perf probe -x ~/bin/perf -L hwmon_pmu__have_event
<hwmon_pmu__have_event@/home/acme/git/perf-tools-next/tools/perf/util/hwmon_pmu.c:0>
      0  bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
      1  {
      2         struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
                enum hwmon_type type;
                int number;
      5         union hwmon_pmu_event_key key = { .type_and_num = 0 };
                struct hashmap_entry *cur;
                size_t bkt;
         
      9         if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
     10                 return false;
         
     12         if (hwmon_pmu__read_events(hwm))
     13                 return false;
         
     15         key.type = type;
     16         key.num = number;
     17         if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
     18                 return true;
     19         if (key.num != -1)
     20                 return false;
                /* Item is of form <type>_ which means we should match <type>_<label>. */
     22         hashmap__for_each_entry((&hwm->events), cur, bkt) {
     23                 struct hwmon_pmu_event_value *value = cur->pvalue;
         
     25                 key.type_and_num = cur->key;
     26                 if (key.type == type && value->name && !strcasecmp(name, value->name))
     27                         return true;
                }
     29         return false;
     30  }
         
         static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
                                          struct perf_event_attr *attr,

root@number:~# 

Probing at the start and end, it gets called, and it returns false.

root@number:~# perf probe -l;
  probe_perf:hwmon_pmu__have_event (on hwmon_pmu__have_event:1@util/hwmon_pmu.c in /home/acme/bin/perf with name_string)
  probe_perf:hwmon_pmu__have_event__return (on hwmon_pmu__have_event%return@util/hwmon_pmu.c in /home/acme/bin/perf with arg1)
root@number:~# perf trace --libtrace -e probe_perf:* perf test -F 11
 11.1: Basic parsing test                                            : Ok
     0.000 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.017 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     0.021 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.031 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     0.034 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.189 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     0.192 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.203 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     0.205 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.221 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     0.224 :146016/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.234 :146016/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
 11.2: Parsing without PMU name                                      : FAILED!
     3.701 perf/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     3.705 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     3.707 perf/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     3.710 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     3.712 perf/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     3.713 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     3.714 perf/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     3.716 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     3.717 perf/146016 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     3.718 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
     3.870 perf/146016 probe_perf:hwmon_pmu__have_event(event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
                     \___ Bad event or PMU
(6611f1) name_string="hwmon_a_test_hwmon_pmu"
Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
)
     3.871 perf/146016 probe_perf:hwmon_pmu__have_event__return((6611e1 <- 6570de) arg1=0x0)
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~# 


So lets see what is the return false we're getting:

root@number:~# perf probe -d probe_perf:hwmon_pmu__have_event__return
Removed event: probe_perf:hwmon_pmu__have_event__return
root@number:~# perf probe -l
  probe_perf:hwmon_pmu__have_event (on hwmon_pmu__have_event:1@util/hwmon_pmu.c in /home/acme/bin/perf with name_string)
root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:10
Added new event:
  probe_perf:hwmon_pmu__have_event_L10 (on hwmon_pmu__have_event:10 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L10 -aR sleep 1

root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:13
Added new event:
  probe_perf:hwmon_pmu__have_event_L13 (on hwmon_pmu__have_event:13 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L13 -aR sleep 1

root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:20
Added new event:
  probe_perf:hwmon_pmu__have_event_L20 (on hwmon_pmu__have_event:20 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L20 -aR sleep 1

root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:29
Added new event:
  probe_perf:hwmon_pmu__have_event_L29 (on hwmon_pmu__have_event:29 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L29 -aR sleep 1

root@number:~# perf probe -l
  probe_perf:hwmon_pmu__have_event (on hwmon_pmu__have_event:1@util/hwmon_pmu.c in /home/acme/bin/perf with name_string)
  probe_perf:hwmon_pmu__have_event_L10 (on hwmon_pmu__have_event:10@util/hwmon_pmu.c in /home/acme/bin/perf)
  probe_perf:hwmon_pmu__have_event_L13 (on hwmon_pmu__have_event:13@util/hwmon_pmu.c in /home/acme/bin/perf)
  probe_perf:hwmon_pmu__have_event_L20 (on hwmon_pmu__have_event:20@util/hwmon_pmu.c in /home/acme/bin/perf)
  probe_perf:hwmon_pmu__have_event_L29 (on hwmon_pmu__have_event:29@util/hwmon_pmu.c in /home/acme/bin/perf)
root@number:~# 


root@number:~# perf trace --libtrace -e probe_perf:* perf test -F 11
 11.1: Basic parsing test                                            : Ok
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
     0.000 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.029 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
     0.032 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.040 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
     0.042 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.194 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
     0.196 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.206 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
     0.207 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.221 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
     0.223 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     0.232 perf/146265 probe_perf:hwmon_pmu__have_event_L29((66135d))
 11.2: Parsing without PMU name                                      : FAILED!
     4.068 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.076 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
     4.078 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.080 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
     4.081 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.083 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
     4.084 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.086 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
     4.088 perf/146265 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.089 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
     4.272 event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
perf/                     \___ Bad event or PMU
146265 
Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     4.274 perf/146265 probe_perf:hwmon_pmu__have_event_L10((66123e))
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~# 



So for the "Unable to find event on a PMU of 'temp_test_hwmon_event1'"
case its the last 'return false', while for the "Parsing without PMU
name" case its all in line 10, i.e. 

      9         if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
     10                 return false;

root@number:~# perf probe -x ~/bin/perf parse_hwmon_filename filename:string

Unable to find event on a PMU of 'temp_test_hwmon_event1'
 11.2: Parsing without PMU name                                      : FAILED!
     6.436 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.446 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.452 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.454 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.488 perf/146683 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.490 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.492 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.494 perf/146683 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.495 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.497 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.499 perf/146683 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.500 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.502 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.504 perf/146683 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.505 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.507 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.508 perf/146683 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.510 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.512 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.655 perf/146683 event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
probe_perf:hwmon_pmu__have_event(                     \___ Bad event or PMU
(6611f1) name_string="hwmon_a_test_hwmon_pmu"
Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
)
     6.658 perf/146683 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.660 perf/146683 probe_perf:hwmon_pmu__have_event_L10((66123e))
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~#

Hope this helps,

- Arnaldo
