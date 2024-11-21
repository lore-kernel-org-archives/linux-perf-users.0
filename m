Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8810A3E;
	Thu, 21 Nov 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208685; cv=none; b=Mb9bmOwnlVgjxY4mGOs0tunNy1qckR3Ygp3DzXm/GG9trpYTbCdjzoD4+fN5DRMhqxoNdQ/xYoj/tu7El1hwXhsULsFkZO/x9PQjxN9ZuLS9EeWjAy9r3qA3cMg+oiqNSwF6MN8g+mphYgikirKiQADM1vNQzBs0jlaVKZRnIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208685; c=relaxed/simple;
	bh=aZGpUzKzmNNoZNO+kAOuEPARwds35ZIR3tETVKuSnKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4s4C5d7EkhjX07mlRCpZ61/URUb0K+D5rdl1+yytYo87W1dYMp7DPVxVpaHOOIUh56KG18wW/Z0Itax8D02heYbkXTyWL+78xcFl1RZeg+hHfihN9XsHiXgPlYlVqe0S5mPQxnHA291FA7qLsDaJ+2te4LznNMPlf3zvse5kRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuWh3fr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuWh3fr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368FBC4CECC;
	Thu, 21 Nov 2024 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732208684;
	bh=aZGpUzKzmNNoZNO+kAOuEPARwds35ZIR3tETVKuSnKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuWh3fr9p904cw9e1mc8O2m6lKvKAi2Q4W7mb0LRf/sRvlgauQfqFPaed6rwfJ8YK
	 qM+Czf8d2QD0FwOJjRc9zbZAsowK4TO0GlPR0kTj9yr+pQrkczIzB5YMLOWu5yV62X
	 zrbvsglrFK+K6oWhUpyAUQvr7h35onXHuD1ji6yShqfYV+iOrV/Q1VhGH17Kqh02yD
	 mPukHVH9AZim+1EQrqg3Ey6X0URZGtS4CLwZdyUOATXbHhidPW9pPiD0VFwmZyEdnQ
	 YowMbfYElZn5sMsKxNSTzdKWt/IVLV+O9GTHKupSLLrTnq81ICP1SdxN4CV49VDkms
	 3/VBQZ5QuoMTA==
Date: Thu, 21 Nov 2024 14:04:41 -0300
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
Message-ID: <Zz9oKR3goFPP9_a9@x1>
References: <20241121000955.536930-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121000955.536930-1-irogers@google.com>

On Wed, Nov 20, 2024 at 04:09:55PM -0800, Ian Rogers wrote:
> Incorrectly the hwmon with PMU name test didn't pass "true". Fix and
> address issue with hwmon_pmu__config_terms needing to load events - a
> load bearing assert fired. Also fix missing list deletion when putting
> the hwmon test PMU and lower some debug warnings to make the hwmon PMU
> less spammy in verbose mode.

After applying this, with this series of patches on a Fedora 40 system,
I get output from -v where before I needed, IIRC, to use -vv:

f8244bb9bfa66f79 (HEAD -> perf-tools-next, x1/perf-tools-next) perf tests: Fix hwmon parsing with PMU name test
9ae6c7a4bd02acbd perf hwmon_pmu: Ensure hwmon key union is zeroed before use
3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete()
0565017a0ac824c2 perf test: Correct hwmon test PMU detection
85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-next/perf-tools-next) perf: Remove unused del_perf_probe_events()
⬢ [acme@toolbox perf-tools-next]$

root@number:~# perf -vv
perf version 6.12.rc6.gf8244bb9bfa6
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
              libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
root@number:~# 

root@number:~# perf test -v 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
--- start ---
test child forked, pid 1823259
Testing 'temp_test_hwmon_event1'
Using CPUID GenuineIntel-6-B7-1
FAILED tests/hwmon_pmu.c:159 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
---- end(-1) ----
 11.2: Parsing without PMU name                                      : FAILED!
--- start ---
test child forked, pid 1823260
Testing 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
Using CPUID GenuineIntel-6-B7-1
FAILED tests/hwmon_pmu.c:159 failed to parse event 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/', err 1
event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
---- end(-1) ----
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~#

⬢ [acme@toolbox perf-tools-next]$ ls -la /sys/class/hwmon/
total 0
drwxr-xr-x.  2 nobody nobody 0 Nov 21 14:03 .
drwxr-xr-x. 80 nobody nobody 0 Nov 15 11:43 ..
lrwxrwxrwx.  1 nobody nobody 0 Nov 15 11:43 hwmon0 -> ../../devices/virtual/thermal/thermal_zone0/hwmon0
lrwxrwxrwx.  1 nobody nobody 0 Nov 15 11:43 hwmon1 -> ../../devices/pci0000:00/0000:00:06.0/0000:02:00.0/nvme/nvme0/hwmon1
lrwxrwxrwx.  1 nobody nobody 0 Nov 20 16:36 hwmon2 -> ../../devices/platform/PNP0C14:02/wmi_bus/wmi_bus-PNP0C14:02/DEADBEEF-2001-0000-00A0-C90629100000/hwmon/hwmon2
lrwxrwxrwx.  1 nobody nobody 0 Nov 20 16:36 hwmon3 -> ../../devices/pci0000:00/0000:00:1f.4/i2c-16/16-0053/hwmon/hwmon3
lrwxrwxrwx.  1 nobody nobody 0 Nov 20 16:36 hwmon4 -> ../../devices/platform/coretemp.0/hwmon/hwmon4
⬢ [acme@toolbox perf-tools-next]$
⬢ [acme@toolbox perf-tools-next]$ uname -a
Linux toolbox 6.11.7-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Nov  8 19:21:57 UTC 2024 x86_64 GNU/Linux
⬢ [acme@toolbox perf-tools-next]$ 

- Arnaldo
