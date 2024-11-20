Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6D155726;
	Wed, 20 Nov 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132005; cv=none; b=JCt8ZcrIdOQO2HYQaBNV7OdqdyY9NuLmZB2FQOa52rlAgfz8O8xXz8ZRpqop/u9wNINxIqQuo11z6TXL/GA7gD0cuPqnCnI9e7QAm59YTrhAae2Y1HvkRcLlxu1zUoywYQPVPfmkxHdq5I4IKtx/OizAkpcak0AP1cjINyiOe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132005; c=relaxed/simple;
	bh=jGUXEYLqw6Lz5FHAyBAxGLRTYlfPM+WXhaKtUtCjwDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+COxEpiVkKGPYhNSb+YZr+fRoVAIRUS10E9D7fQvQJb8tlBCNRRtTusk8yqB5gvK0ZFXyNG7O7JF1J5I182YRILvl+PjtDTD2SA9hdLkR7ehqdRVPqkhkwMo2ei771ItLpIXXSzVxKoKQty0zqupCvtDh8eeFBTt/e8emUyJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrGj8osm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrGj8osm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABAEC4CECD;
	Wed, 20 Nov 2024 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732132005;
	bh=jGUXEYLqw6Lz5FHAyBAxGLRTYlfPM+WXhaKtUtCjwDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LrGj8osmwjyYDEHFsjl9x8YCKCk30UE4FOuqRfUwULbBv4JFycPwihF6YApCwTO+F
	 LH7c5tDn2N1ip2J2J7f+ZrqiqHadvVR/Y0eA6e5rgcxdZrMCRROLsN2JY9Lv/GF+h9
	 iY4vu1dRvM7uA20mUU8uJ2Pzq8m2pC36UKaGgwIRI/8cvCm19ljDcJeONwXhvXMq+y
	 P3aFskqgpxqHXwhJuyagLwSCmm9666IjlL4cBkEU7d5aHnMbE8sBhOcdu2Wfnsc/Ml
	 HJ/YZL4PI5r/bbSBRYvl6JKwvc613kjZGSNgkceOLIibVIwzhmYJbbaIExs8hZ3nZG
	 oQrKFPLabD/BA==
Date: Wed, 20 Nov 2024 16:46:42 -0300
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
Subject: Re: [PATCH v1] perf hwmon_pmu: Ensure hwmon key union is zeroed
 before use
Message-ID: <Zz48orOYgt1UDe9_@x1>
References: <20241119230033.115369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119230033.115369-1-irogers@google.com>

On Tue, Nov 19, 2024 at 03:00:33PM -0800, Ian Rogers wrote:
> Non-zero values led to mismatches in testing. This was reproducible
> with -fsanitize=undefined.

Unfortunately, not yet, see below, I'll have some meetings and will try
to get back at this, to try and take advantage I went thru the code
yesterday.

- Arnaldo

⬢ [acme@toolbox perf-tools-next]$ git log --oneline -5
9ae6c7a4bd02acbd (HEAD -> perf-tools-next) perf hwmon_pmu: Ensure hwmon key union is zeroed before use
3e37de098af38179 perf tests hwmon_pmu: Remove double evlist__delete()
0565017a0ac824c2 perf test: Correct hwmon test PMU detection
85c60a01b85ee956 (perf-tools-next/tmp.perf-tools-next, perf-tools-next/perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next, perf-tools-next.korg/perf-tools-next, acme/tmp.perf-tools-next, acme/perf-tools-next, acme.korg/tmp.perf-tools-next, acme.korg/perf-tools-next) perf: Remove unused del_perf_probe_events()
8f997865ee9e7328 perf pmu: Move pmu_metrics_table__find and remove ARM override
⬢ [acme@toolbox perf-tools-next]$

⬢ [acme@toolbox perf-tools-next]$ perf test 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
⬢ [acme@toolbox perf-tools-next]$ perf -v
perf version 6.12.rc6.g9ae6c7a4bd02
⬢ [acme@toolbox perf-tools-next]$

root@x1:~# perf -vv
perf version 6.12.rc6.g9ae6c7a4bd02
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
root@x1:~# perf test 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~# perf test -vv 11
 11: Hwmon PMU                                                       :
 11.1: Basic parsing test:
--- start ---
test child forked, pid 152385
hwmon_pmu: not a hwmon type 'badtype' in file name 'badtype5_baditem'
hwmon_pmu: not a hwmon item 'baditem' in file name 'humidity6_baditem'
---- end(0) ----
 11.1: Basic parsing test                                            : Ok
 11.2: Parsing without PMU name:
--- start ---
test child forked, pid 152386
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
FAILED tests/hwmon_pmu.c:158 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
---- end(-1) ----
 11.2: Parsing without PMU name                                      : FAILED!
 11.3: Parsing with PMU name:
--- start ---
test child forked, pid 152387
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
FAILED tests/hwmon_pmu.c:158 failed to parse event 'temp_test_hwmon_event1', err 1
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
---- end(-1) ----
 11.3: Parsing with PMU name                                         : FAILED!
root@x1:~#
 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/Zzdtj0PEWEX3ATwL@x1/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/hwmon_pmu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index ac2245acdc6d..4d9d6f405434 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -274,7 +274,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
>  		int number;
>  		enum hwmon_item item;
>  		bool alarm;
> -		union hwmon_pmu_event_key key = {};
> +		union hwmon_pmu_event_key key = { .type_and_num = 0 };
>  		struct hwmon_pmu_event_value *value;
>  
>  		if (ent->d_type != DT_REG)
> @@ -560,7 +560,7 @@ bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
>  	struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
>  	enum hwmon_type type;
>  	int number;
> -	union hwmon_pmu_event_key key = {};
> +	union hwmon_pmu_event_key key = { .type_and_num = 0 };
>  	struct hashmap_entry *cur;
>  	size_t bkt;
>  
> @@ -623,10 +623,11 @@ static int hwmon_pmu__config_term(const struct hwmon_pmu *hwm,
>  					return -EINVAL;
>  			} else {
>  				union hwmon_pmu_event_key key = {
> -					.type = type,
> -					.num = number,
> +					.type_and_num = 0,
>  				};
>  
> +				key.type = type;
> +				key.num = number;
>  				attr->config = key.type_and_num;
>  			}
>  			return 0;
> -- 
> 2.47.0.371.ga323438b13-goog
> 
