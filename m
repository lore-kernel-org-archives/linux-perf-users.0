Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E051C01
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340193; cv=none; b=Qi5MXSRkP8Qrj706bmDiG45DA1poUhmPB/Ad3VbOsCxHCTgUe9Dna4niu7YxOEXE788vx3dSa9c7wWEGmlZ4FdcjdNMz6thDAySR5jlVKIcx79NIkHRohBOzYgHCjHIUf/X84vnfDM1ECYOHIp9lmJtYeod0sT1hPX7fiTgBvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340193; c=relaxed/simple;
	bh=MZuDi8YiFcvSQY2GhW+yLY67xviqlcVS6wLgx7J3BBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZVVKtx7d/JE5yfNdKkMzlulqfvEaN8o95iqrxE0VXB5Xq8XSDelyzjunbaVdw92x5T1RRn47L8HrxlCtCqJ3ipVzVbm+HI8yXJWz8UfgSpDdOiAIWzl5qGtexk0a8OSHtsX04lZUuqih0eTCLh2ueemVUzhuIV4LCgXhGsbsP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zc8RP/56; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zc8RP/56"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so37631385e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731340189; x=1731944989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZiuG6vO285AeoXa2+/Nuxw8bBquuL6RNvtIRl6EjA8=;
        b=zc8RP/56Y076lvGsUqUsubptJI4v4LekD9kjBJAZYSuTnWrdiNOQ5pnGK+vyoiY/UF
         cqcf3m1I4dgiOwKTrZ/bU+0jI+HIPu4D0ftrkqLrumviqafUizrhpg8s3dfAS1yRTd4i
         3X5ITEqoplu9Wtn4GYn0yjAc9gBKrzft5Oh0ZIqSyggMda6jgatxqQI6MFJJCVrshe/M
         NBV7rZtvXi4akd8L/1R7R0o+BMOnrzjLt6ie++skXHnENM7Bsod4bgYzvFgyA4/yjxdr
         5pymQ+4pYk+8H/I+CSp8Nqmj6MaTmncD0iAb36aTMhdVV+qaq/14luwUsyu/QnQ7W56C
         wTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340189; x=1731944989;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZiuG6vO285AeoXa2+/Nuxw8bBquuL6RNvtIRl6EjA8=;
        b=Q4DZE49nJl+lgjBtx2GOpGlOvgkxJgVLOhlUio0CjNZ8+6dtdfzwTLS2MXtjI9s5Zn
         6Zyc5jJ+4hXJSMBp8aygzGzWVle+FGNIAZe4zN/nDqVPKoDnPTCh/7Hm1aCkyzXDcUtf
         3qbYZF64VmCt4Imu4dxc/YQqSW6cYnqg1ddg87LjjH0H/6/g9ywgHFMoJS2C8mLQTpDV
         UzqXSeJBP7HFA9tolBq5+bCs6g/BhUXzs/7F91lDkXTuca+paehgMPZabeNE6mXYoBoW
         PPc/O28TvIBkVfTpb+80Ei88x3oOpFmgmMcsx17uWUSycaC37h55n/6o03AOKpgnXdOJ
         JAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdJ1BpuiJlXVu9jGxgtNga/7OaZxXIcVVYh4dvQSSZoczYTqhmE8k94vRWfG0wxHVYkQzzc+rthl0uuii0m50@vger.kernel.org
X-Gm-Message-State: AOJu0YycCZk1vuXV7/vsaeZh9lGXWzIvvuVXZjZfLp5iHEbgxdS9HCce
	yOiUBGTVrM911mnnIsD3S9Ibd4iMKpjpK6x876DQqSHwSp/5m8CLMnoBFzYGPQg=
X-Google-Smtp-Source: AGHT+IEf8ZLfYGz4Ep81ktvQnSsWEJgpx9GkGgRDp+Sp5/zXGXroLdE9Ahp4goxrI71QaW6Qs6uJlA==
X-Received: by 2002:a05:600c:4ecc:b0:431:5a93:4e3c with SMTP id 5b1f17b1804b1-432b7507c0bmr113526115e9.16.1731340189222;
        Mon, 11 Nov 2024 07:49:49 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fc9sm214217075e9.3.2024.11.11.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:49:48 -0800 (PST)
Message-ID: <7c1a0bbf-12fd-46ef-9db2-183dfa70a334@linaro.org>
Date: Mon, 11 Nov 2024 15:49:47 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] perf record: Skip don't fail for events that don't
 open
To: Ian Rogers <irogers@google.com>, Atish Patra <atishp@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20241026121758.143259-1-irogers@google.com>
 <20241026121758.143259-4-irogers@google.com>
Content-Language: en-US
Cc: linux-riscv@lists.infradead.org, beeman@rivosinc.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Junhao He
 <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241026121758.143259-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2024 1:17 pm, Ian Rogers wrote:
> Whilst for many tools it is an expected behavior that failure to open
> a perf event is a failure, ARM decided to name PMU events the same as
> legacy events and then failed to rename such events on a server uncore
> SLC PMU. As perf's default behavior when no PMU is specified is to
> open the event on all PMUs that advertise/"have" the event, this
> yielded failures when trying to make the priority of legacy and
> sysfs/json events uniform - something requested by RISC-V and ARM. A
> legacy event user on ARM hardware may find their event opened on an
> uncore PMU which for perf record will fail. Arnaldo suggested skipping
> such events which this patch implements. Rather than have the skipping
> conditional on running on ARM, the skipping is done on all
> architectures as such a fundamental behavioral difference could lead
> to problems with tools built/depending on perf.
> 
> An example of perf record failing to open events on x86 is:
> ```
> $ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 
> Error:
> Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
> "dmesg | grep -i perf" may provide additional information.
> 

This makes me wonder if this message was overly wordy to begin with. 
This line is fine:

  Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0'
  which will be removed.

The next bit about the syscall just repeats. The exit code could be 
included on the previous line. And the dmesg bit is general advice that 
could possibly be printed once at the end.

> Error:
> Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
> The LLC-prefetch-read event is not supported.
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]
> 
> $ perf report --stats
> Aggregated stats:
>                 TOTAL events:      17255
>                  MMAP events:        284  ( 1.6%)
>                  COMM events:       1961  (11.4%)
>                  EXIT events:          1  ( 0.0%)
>                  FORK events:       1960  (11.4%)
>                SAMPLE events:         87  ( 0.5%)
>                 MMAP2 events:      12836  (74.4%)
>               KSYMBOL events:         83  ( 0.5%)
>             BPF_EVENT events:         36  ( 0.2%)
>        FINISHED_ROUND events:          2  ( 0.0%)
>              ID_INDEX events:          1  ( 0.0%)
>            THREAD_MAP events:          1  ( 0.0%)
>               CPU_MAP events:          1  ( 0.0%)
>             TIME_CONV events:          1  ( 0.0%)
>         FINISHED_INIT events:          1  ( 0.0%)
> cycles stats:
>                SAMPLE events:         87
> ```
> 
> Note, if all events fail to open then the data file will contain no
> samples. This is deliberate as at the point the events are opened
> there are other events, such as the dummy event for sideband data, and
> these events will succeed in opening even if the user specified ones

Is a file with only sideband events useful? Is it possible to fail the 
record command if the event doesn't open anywhere?

I noticed this leads to some different behavior and a libperf warning 
when you have paranoid=3:

   $ perf record -e cycles -C 0 -- true

   Error:
   Failure to open event 'cpu_atom/cycles/u' on PMU 'cpu_atom' which will
   be removed.
   ...
   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting
   ...
   libperf: Miscounted nr_mmaps 0 vs 28
   WARNING: No sample_id_all support, falling back to unordered
   processing
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.021 MB perf.data ]


> don't. Having a mix of open and broken events leads to a problem of
> identifying different sources of events.
 >

In my basic test I saw that the opened event was identified correctly in 
perf report, unless you have an example that you encountered that we 
should fix?

One place I saw an issue was with auxtrace events. If there's an event 
name clash then you're likely to not be able to open the file afterwards 
because the auxtrace code can't handle an event that didn't open. But I 
don't know of any name clashes there (I just faked one for testing), and 
maybe that could be fixed up later in the auxtrace code if there is ever 
a real one.

Other than the above it does seem to work ok.

> The issue with legacy events is that on RISC-V they want the driver to
> not have mappings from legacy to non-legacy config encodings for each
> vendor/model due to size, complexity and difficulty to update. It was
> reported that on ARM Apple-M? CPUs the legacy mapping in the driver
> was broken and the sysfs/json events should always take precedent,
> however, it isn't clear this is still the case. It is the case that
> without working around this issue a legacy event like cycles without a
> PMU can encode differently than when specified with a PMU - the
> non-PMU version favoring legacy encodings, the PMU one avoiding legacy
> encodings.
> 
> The patch removes events and then adjusts the idx value for each
> evsel. This is done so that the dense xyarrays used for file
> descriptors, etc. don't contain broken entries. As event opening
> happens relatively late in the record process, use of the idx value
> before the open will have become corrupted, so it is expected there
> are latent bugs hidden behind this change - the change is best
> effort. As the only vendor that has broken event names is ARM, this
> will principally effect ARM users. They will also experience warning
> messages like those above because of the uncore PMU advertising legacy
> event names.



> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-record.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f83252472921..7e99743f7e42 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
>   	struct perf_session *session = rec->session;
>   	struct record_opts *opts = &rec->opts;
>   	int rc = 0;
> +	bool skipped = false;
>   
>   	evlist__for_each_entry(evlist, pos) {
>   try_again:
> @@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
>   			        pos = evlist__reset_weak_group(evlist, pos, true);
>   				goto try_again;
>   			}
> -			rc = -errno;
>   			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
> -			ui__error("%s\n", msg);
> -			goto out;
> +			ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
> +				  evsel__name(pos), evsel__pmu_name(pos), msg);
> +			pos->skippable = true;
> +			skipped = true;
> +		} else {
> +			pos->supported = true;
>   		}
> -
> -		pos->supported = true;
>   	}
>   
> +	if (skipped) {
> +		struct evsel *tmp;
> +		int idx = 0;
> +
> +		evlist__for_each_entry_safe(evlist, tmp, pos) {
> +			if (pos->skippable)
> +				evlist__remove(evlist, pos);
> +			pos->core.idx = idx++;
> +		}
> +	}
>   	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
>   		pr_warning(
>   "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"

