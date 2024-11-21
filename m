Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562055C29;
	Thu, 21 Nov 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209775; cv=none; b=iJsZzwCQ8tH68QWEEilTVS2LuvFa8x2pldsk4s4fILz6AkoH17PvlNYCL9E8BIaLT+rVDQSaaqgowFaSv7GOVM0BoaEQlcmfSZncHnrX1r3K3376ZUfun5Y/izwS1qnPOBvwEuHheEtW72yVZS3cAZQgLyZVhw1nCYnhQ0X2wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209775; c=relaxed/simple;
	bh=vrLtc+wqTM3wm53I5eqfMyii4DXjb/vnZwhmFtWYOT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUiuTgkhBox2wxQ5D0bbXxrKJP1xY2Jmq96MNS7QmXSch6I+AxHotnZ2xcrgzHtc1x76lAPCCIc0D7rdRmkqxFGHENH7AkKOkTS6r+2jgy30ecjiAA3KSzxiJmon2BSYISmqLWuD/YxMpUf9WafqYnto4ttYdfn7zBIaGmR5OlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WubPOd1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WubPOd1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEFBC4CECC;
	Thu, 21 Nov 2024 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732209775;
	bh=vrLtc+wqTM3wm53I5eqfMyii4DXjb/vnZwhmFtWYOT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WubPOd1Bf8Jsekq7KXCQSjLDwlcWXnnwtH3EL8QkB+xEZ4/3kiY38djMdNOQQBH2M
	 9Bg55BXdLpYo+I3nQhFal2yG+BWW7Anuqor8yJcWlbjDcxQ23dVgbJGXKxgJ7dI9SO
	 Lk+UKiphlpcE8fD/Q1virarRxZiq3GZi4ePuFW/wMvSJTG7pgBg0iXdVmTWk1yfBBB
	 qygE8oBAYqJfd5eU+RTs+iXzh+Nyr0QCgkXQv34QutgrVEfNFcQn88WxwE2sP/99NV
	 sNdjY4vp4Id4lXnL8OVT+KojOm0XrjlhvlivC2Lz7OusQ1sJGPQXZBlW6cElkyrBlq
	 mSXQ++N42oiDg==
Date: Thu, 21 Nov 2024 14:22:52 -0300
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
Message-ID: <Zz9sbNAuRsYjclAi@x1>
References: <20241121000955.536930-1-irogers@google.com>
 <Zz9oKR3goFPP9_a9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz9oKR3goFPP9_a9@x1>

On Thu, Nov 21, 2024 at 02:04:45PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> > Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> > address issue with hwmon_pmu__config_terms needing to load events - a
> > load bearing assert fired. Also fix missing list deletion when putting
> > the hwmon test PMU and lower some debug warnings to make the hwmon PMU
> > less spammy in verbose mode.
 
> After applying this, with this series of patches on a Fedora 40 system,
> I get output from -v where before I needed, IIRC, to use -vv:
> 
> f8244bb9bfa66f79 (HEAD -> perf-tools-next, x1/perf-tools-next) perf tests: Fix hwmon parsing with PMU name test
> 9ae6c7a4bd02acbd perf hwmon_pmu: Ensure hwmon key union is zeroed before use
> 3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete()
> 0565017a0ac824c2 perf test: Correct hwmon test PMU detection
> 85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-next/perf-tools-next) perf: Remove unused del_perf_probe_events()
> ⬢ [acme@toolbox perf-tools-next]$

<SNIP>

> root@number:~# perf test -v 11
>  11: Hwmon PMU                                                       :
>  11.1: Basic parsing test                                            : Ok
> --- start ---
> test child forked, pid 1823259
> Testing 'temp_test_hwmon_event1'
> Using CPUID GenuineIntel-6-B7-1
> FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon_event1', err 1
> event syntax error: 'temp_test_hwmon_event1'
>                      \___ Bad event name
> 
> Unable to find event on a PMU of 'temp_test_hwmon_event1'

In gdb it fails on the first call to do_test() from the first test__hwmon_pmu()

Starting program: /root/bin/perf test -F -vv 11
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
--- start ---
---- end ----
 11.1: Basic parsing test                                            : Ok
--- start ---

Breakpoint 1, test__hwmon_pmu (with_pmu=false) at tests/hwmon_pmu.c:203
203	{
(gdb) n
205		struct perf_pmu *pmu = test_pmu_get(dir, sizeof(dir));
(gdb) n
206		int ret = TEST_OK;
(gdb) p pmu
$2 = (struct perf_pmu *) 0xf50450
(gdb) p *pmu
$3 = {name = 0xf50ac0 "hwmon_a_test_hwmon_pmu", alias_name = 0xf50aa0 "hwmon1234", id = 0x0, type = 4294902994, selectable = false, is_core = false, is_uncore = false, auxtrace = false, 
  formats_checked = false, config_masks_present = false, config_masks_computed = false, max_precise = 0, perf_event_attr_init_default = 0x0, cpus = 0xf4fbf0, format = {next = 0xf50488, 
    prev = 0xf50488}, aliases = {next = 0xf50498, prev = 0xf50498}, events_table = 0x0, sysfs_aliases = 0, cpu_json_aliases = 0, sys_json_aliases = 0, sysfs_aliases_loaded = false, 
  cpu_aliases_added = false, caps_initialized = false, nr_caps = 0, caps = {next = 0xf504c8, prev = 0xf504c8}, list = {next = 0xedc090 <other_pmus>, prev = 0xedc090 <other_pmus>}, 
  config_masks = {0, 0, 0, 0}, missing_features = {exclude_guest = false, checked = false}, mem_events = 0x0}
(gdb) s
208		if (!pmu)
(gdb) s
211		for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
(gdb) s
212			ret = do_test(i, with_pmu, /*with_alias=*/false);
(gdb) s
do_test (i=0, with_pmu=false, with_alias=false) at tests/hwmon_pmu.c:136
136	{
(gdb) n
137		const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
(gdb) n
138		struct evlist *evlist = evlist__new();
(gdb) n
143		bool found = false;
(gdb) n
145		if (!evlist) {
(gdb) n
150		if (with_pmu)
(gdb) n
153			strlcpy(str, test_event, sizeof(str));
(gdb) n
155		pr_debug("Testing '%s'\n", str);
(gdb) p str
$4 = "temp_test_hwmon_event1\000\000\004\000\000\000\000\000\000\000\274\204z\000\000\000\000\000΄z\000\000\000\000\000\021\000\000\000\000\000\000\000 \305\377\377\377\177\000\000߄z\000\000\000\000\000\353\204z\000\000\000\000\000\376\204z\000\000\000\000\000\n\205z\000\000\000\000\000\021\205z\000\000\000\000\000\035\205z\000\000\000\000\0000\205z\000\000\000\000\000<\205z\000\000\000\000"
(gdb) n
Testing 'temp_test_hwmon_event1'
156		parse_events_error__init(&err);
(gdb) n
157		ret = parse_events(evlist, str, &err);
(gdb) n
Using CPUID GenuineIntel-6-B7-1
158		if (ret) {
(gdb) p ret
$5 = 1
(gdb) n
159			pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
(gdb) 


