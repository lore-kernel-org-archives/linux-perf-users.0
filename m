Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C031DFDB1;
	Fri, 15 Nov 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685779; cv=none; b=ExUnv/Q88vE2KsqvTXhAzoRxi8Eul8r68IacMML4ebl/LhAmNKoq3jsUf9Js2AkHkTjY1L/eCfFvgIZohpPlu3rSlk4l2ZtRHiTUZ9rOI90CUFjdz8UErcfNPFxtR24FhGTVim8HJZgQypT9nXh1UAz7UI12QpQBn7QWOZaQ/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685779; c=relaxed/simple;
	bh=tU1xmk3+Nnc7sUGOBXAWq/oVW6HP8BYPHD2LHmlMFlg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AewLu0nes2CDKauGRH6FhvCJP4uVUnLmq7IMoBKKBk7g8bdcKpHaTDCrAdhxl5BEZ65ex27LAsxpr+CLcTWXfg301pPPvdQ0eTNtStgxovz4yrau24ZnqBYHSa5AOnu7Y/zCtOlU1xN3C0ipOCZ3JH4087akfoI7MWGhjcP9qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/PmF3X+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/PmF3X+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A6FC4CECF;
	Fri, 15 Nov 2024 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685778;
	bh=tU1xmk3+Nnc7sUGOBXAWq/oVW6HP8BYPHD2LHmlMFlg=;
	h=Date:From:To:Cc:Subject:From;
	b=n/PmF3X+8OaXb/wUpoKWolBP3m9/tbsXE4I/bbeMUiwxgMmepJ4/VuEDuKUfpaL01
	 zcC3GWDpzU2OjV6r1TcFAofKZntJ3axaE/2O/lj/kQltKsY12HPcmkg+LBEIT6sB/3
	 OSuE5O4rSk2BDgj8a3MH+jYwy6TYmkvoTgkRMvS6Ph2x47vo3Zh9hmghADRJoyCudm
	 bAS7+0KrqGLbWhG/fjkqKOY7D7YXeV7akn3H9x86aX5e8Wsp7qGBIK0Pea5bgGonoK
	 YFNtndsIfxhaOXSS+KSb5pG/d5x9JvDa0xozC+f8zhZmkFLbYu4UtbI8kbb7zJep6e
	 oIs3q2G0lK+Kg==
Date: Fri, 15 Nov 2024 12:49:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: perf test failures with tmp.perf-tools-next
Message-ID: <Zzdtj0PEWEX3ATwL@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With what is in tmp.perf-tools-next I'm getting:

 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
 84: perftool-testsuite_probe                                        : FAILED!
 86: probe libc's inet_pton & backtrace it with ping                 : FAILED!
 96: perf stat tests                                                 : FAILED!
 97: perf all metricgroups test                                      : FAILED!
 98: perf all metrics test                                           : FAILED!
117: perftool-testsuite_report                                       : FAILED!
118: Add vfs_getname probe to get syscall args filenames             : FAILED!
119: Use vfs_getname probe to get syscall args filenames             : FAILED!
120: perf record tests                                               : FAILED!
121: perf record LBR tests                                           : FAILED!
128: Test data symbol                                                : FAILED!

root@x1:~# perf test -vv 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test:
--- start ---
test child forked, pid 391389
hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
---- end(0) ----
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name:
--- start ---
test child forked, pid 391390
Testing 'temp_test_hwmon_event1'
Using CPUID GenuineIntel-6-BA-3
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'pwm1'
Not a hwmon file 'pwm1'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'pwm1' that has no input file
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
free(): invalid pointer

---- unexpected signal (6) ----
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name:
--- start ---
test child forked, pid 391391
Testing 'temp_test_hwmon_event1'
Using CPUID GenuineIntel-6-BA-3
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'pwm1'
Not a hwmon file 'pwm1'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: removing event 'pwm1' that has no input file
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
hwmon_pmu: not a hwmon file 'uevent'
Not a hwmon file 'uevent'
hwmon_pmu: not a hwmon file 'name'
Not a hwmon file 'name'
FAILED tests/hwmon_pmu.c:160 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'

---- unexpected signal (11) ----
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~# 



I'm working on removing the vfs_getname code from 'perf trace' so those
will go away, probably there are patches fixing some of the other ones,
I'll try and look after those, but probably later today I'll push what I
have so that it gets exposure on linux-next.

- Arnaldo
