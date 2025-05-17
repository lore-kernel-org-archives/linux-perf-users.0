Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA227453;
	Sat, 17 May 2025 02:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447325; cv=none; b=H4RM8oM8DsxSc5o2PgH4FSVqHWRnfByZJtTDaRBQls2E4+pTvgDfCNq9FGm3B4OjVjrHZ5v9rhRDLZubKLNzbVo0Ix56gHlQdgfTeVmWrOYkK/onNA0W/pF3a1YHssTKC57s046nJr7mbhHVq1DdlduEIljlDtixjQYA/6i1G+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447325; c=relaxed/simple;
	bh=WWhZDNBDfelgXZRN6PpcDN567olv/AKOtgrJMC70tmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufk/r/p83+zmcrFDYHWwkAELaKlTySRNQgrchvXgUrUs0ZBlk1uxI77zYGgAFN+hzjIAGvhCwDaK/7weCIH6rDl6J0kuwQazKUDo0+xm+XfT9ZAN3e8QvAYYIGkTnYt9900Fea8tDinY/vEn4R2+81OBISGiOwj8g9E3WRJsZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9npX4HO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9npX4HO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F6AC4CEE4;
	Sat, 17 May 2025 02:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747447324;
	bh=WWhZDNBDfelgXZRN6PpcDN567olv/AKOtgrJMC70tmg=;
	h=Date:From:To:Cc:Subject:From;
	b=u9npX4HOc3ELlhcw10BnOLhYhZbHEycxwlO/8fdMJDYM67/vuKdVMqRC51AJ/hPoF
	 YKkAz08dl+wjmzvY/ke6XSfleXudNNdN7lju42fy6m5beCdqJcB2inu67VV+7TREO9
	 bgSO4pjF8dBn9ojUFLWzb/0mTgWBxtEjTKyjr5WCdw2C2uCoDXFtER2em/M0gF1wt7
	 681aGJTLrqWxqkMQTRU9u2RCk0L5ue6h/hVcW9r8vaSDy0HAv7++YJYjRwXzGp5Gq8
	 qiYV75Ka1DOadgwtdEdDfcnNJhwXd+S5f/gCdckDvqvfwnsv94rh7Wl5J867ttCtCV
	 xnjbPUkZLvxNg==
Date: Fri, 16 May 2025 23:02:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: IBS perf test failures on 9950x3d
Message-ID: <aCfuGXUnNIbnYo_r@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Ravi,

	Does this look familiar?

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -10
8cdf00b843ea3ca0 (HEAD -> perf-tools-next) perf record: Fix a asan runtime error in util/maps.c
208c0e16834472bb perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
bcfab08db7fb38bf perf intel-tpebs: Filter non-workload samples
1c5721ca89a1c8ae (x1/perf-tools-next, x1/HEAD, five/perf-tools-next, five/HEAD) perf test: Allow tolerance for leader sampling test
cb422594d62066a5 perf test: Add stat uniquifying test
137359b7895f61cd perf parse-events: Use wildcard processing to set an event to merge into
7d45f402d3117e0b perf evlist: Make uniquifying counter names consistent
ef60b8f5724da364 perf trace: Support --summary-mode=cgroup
39922dc53c268429 perf report: Add 'tgid' sort key
b922881712743035 perf test: Update sysfs path for core PMU caps
⬢ [acme@toolbx perf-tools-next]$

I'll push my local branch soon, but I think this predates it.

If it needs a specific kernel, then the test needs to cope with that,
etc.

- Arnaldo


root@number:~# perf test -vvvvv 115
115: AMD IBS sample period:
--- start ---
test child forked, pid 1949350
Using CPUID AuthenticAMD-26-44-0

IBS config tests:
-----------------
Fetch PMU tests:
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xffff            : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x1000            : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xff              : Ok   (nr samples: 5)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x1               : Ok   (nr samples: 101)
0x0               : Ok  
0x10000           : Ok  
Op PMU tests:
0x0               : Ok  
0x1               : Fail
0x8               : Fail
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x9               : Ok   (nr samples: 101)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xf               : Ok   (nr samples: 101)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x1000            : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xffff            : Fail (nr samples: 0)
0x10000           : Ok  
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x100000          : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xf00000          : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0xf0ffff          : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x1f0ffff         : Fail (nr samples: 0)
mprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission deniedmprotect() failed. Permission denied0x7f0ffff         : Fail (nr samples: 0)
0x8f0ffff         : Ok  
0x17f0ffff        : Ok  

IBS sample period constraint tests:
-----------------------------------
Fetch PMU test:
freq 0, sample_freq         0: Ok  
freq 0, sample_freq         1: Fail
freq 0, sample_freq        15: Fail
mprotect() failed. Permission deniedfreq 0, sample_freq        16: Ok   (nr samples: 202)
mprotect() failed. Permission deniedfreq 0, sample_freq        17: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq       143: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq       144: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq       145: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq      1234: Ok   (nr samples: 4)
mprotect() failed. Permission deniedfreq 0, sample_freq      4103: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq     65520: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq     65535: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq     65552: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq   8388607: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq 268435455: Fail (nr samples: 0)
freq 1, sample_freq         0: Ok  
mprotect() failed. Permission deniedfreq 1, sample_freq         1: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        15: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        16: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        17: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq       143: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq       144: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq       145: Ok   (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq      1234: Ok   (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq      4103: Ok   (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq     65520: Ok   (nr samples: 8)
mprotect() failed. Permission deniedfreq 1, sample_freq     65535: Ok   (nr samples: 8)
mprotect() failed. Permission deniedfreq 1, sample_freq     65552: Ok   (nr samples: 8)
freq 1, sample_freq   8388607: Ok  
Op PMU test:
freq 0, sample_freq         0: Ok  
freq 0, sample_freq         1: Fail
freq 0, sample_freq        15: Fail
freq 0, sample_freq        16: Fail
freq 0, sample_freq        17: Fail
freq 0, sample_freq       143: Fail
mprotect() failed. Permission deniedfreq 0, sample_freq       144: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq       145: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq      1234: Ok   (nr samples: 101)
mprotect() failed. Permission deniedfreq 0, sample_freq      4103: Ok   (nr samples: 6)
mprotect() failed. Permission deniedfreq 0, sample_freq     65520: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq     65535: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq     65552: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq   8388607: Fail (nr samples: 0)
mprotect() failed. Permission deniedfreq 0, sample_freq 268435455: Fail (nr samples: 0)
freq 1, sample_freq         0: Ok  
mprotect() failed. Permission deniedfreq 1, sample_freq         1: Fail (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        15: Fail (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        16: Fail (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq        17: Fail (nr samples: 3)
mprotect() failed. Permission deniedfreq 1, sample_freq       143: Fail (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq       144: Fail (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq       145: Fail (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq      1234: Fail (nr samples: 4)
mprotect() failed. Permission deniedfreq 1, sample_freq      4103: Fail (nr samples: 5)
mprotect() failed. Permission deniedfreq 1, sample_freq     65520: Fail (nr samples: 9)
mprotect() failed. Permission deniedfreq 1, sample_freq     65535: Fail (nr samples: 9)
mprotect() failed. Permission deniedfreq 1, sample_freq     65552: Fail (nr samples: 9)
freq 1, sample_freq   8388607: Ok  

IBS ioctl() tests:
------------------
Fetch PMU tests
ioctl(period = 0x0      ): Ok
ioctl(period = 0x1      ): Fail
ioctl(period = 0xf      ): Fail
ioctl(period = 0x10     ): Ok
ioctl(period = 0x11     ): Fail
ioctl(period = 0x1f     ): Fail
ioctl(period = 0x20     ): Ok
ioctl(period = 0x80     ): Ok
ioctl(period = 0x8f     ): Fail
ioctl(period = 0x90     ): Ok
ioctl(period = 0x91     ): Fail
ioctl(period = 0x100    ): Ok
ioctl(period = 0xfff0   ): Ok
ioctl(period = 0xffff   ): Fail
ioctl(period = 0x10000  ): Ok
ioctl(period = 0x1fff0  ): Ok
ioctl(period = 0x1fff5  ): Fail
ioctl(freq   = 0x0      ): Ok
ioctl(freq   = 0x1      ): Ok
ioctl(freq   = 0xf      ): Ok
ioctl(freq   = 0x10     ): Ok
ioctl(freq   = 0x11     ): Ok
ioctl(freq   = 0x1f     ): Ok
ioctl(freq   = 0x20     ): Ok
ioctl(freq   = 0x80     ): Ok
ioctl(freq   = 0x8f     ): Ok
ioctl(freq   = 0x90     ): Ok
ioctl(freq   = 0x91     ): Ok
ioctl(freq   = 0x100    ): Ok
Op PMU tests
ioctl(period = 0x0      ): Ok
ioctl(period = 0x1      ): Fail
ioctl(period = 0xf      ): Fail
ioctl(period = 0x10     ): Fail
ioctl(period = 0x11     ): Fail
ioctl(period = 0x1f     ): Fail
ioctl(period = 0x20     ): Fail
ioctl(period = 0x80     ): Fail
ioctl(period = 0x8f     ): Fail
ioctl(period = 0x90     ): Ok
ioctl(period = 0x91     ): Fail
ioctl(period = 0x100    ): Ok
ioctl(period = 0xfff0   ): Ok
ioctl(period = 0xffff   ): Fail
ioctl(period = 0x10000  ): Ok
ioctl(period = 0x1fff0  ): Ok
ioctl(period = 0x1fff5  ): Fail
ioctl(freq   = 0x0      ): Ok
ioctl(freq   = 0x1      ): Ok
ioctl(freq   = 0xf      ): Ok
ioctl(freq   = 0x10     ): Ok
ioctl(freq   = 0x11     ): Ok
ioctl(freq   = 0x1f     ): Ok
ioctl(freq   = 0x20     ): Ok
ioctl(freq   = 0x80     ): Ok
ioctl(freq   = 0x8f     ): Ok
ioctl(freq   = 0x90     ): Ok
ioctl(freq   = 0x91     ): Ok
ioctl(freq   = 0x100    ): Ok

IBS freq (negative) tests:
--------------------------
freq 1, sample_freq 200000: Fail

IBS L3MissOnly test: (takes a while)
--------------------
Fetch L3MissOnly: Fail (nr_samples: 299)
Op L3MissOnly:    Ok   (nr_samples: 444)
---- end(-1) ----
115: AMD IBS sample period                                           : FAILED!
root@number:~# 
root@number:~# 
root@number:~# 
root@number:~# uname -r
6.14.5-300.fc42.x86_64
root@number:~# grep -m1 "model name" /proc/cpuinfo 
model name	: AMD Ryzen 9 9950X3D 16-Core Processor
root@number:~# 



