Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276714854E4;
	Thu,  6 Aug 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033014; cv=none; b=nU8Os5cEBDd7YiA1Ubxah7oysz20RYkDKXKR/1LNtjlhgktP2oDX9dqv0+qh7lGcFgRxJVGt2MQM4FbVZvhMZQfJZdMTUbOpUf8LUHRJoNYaYTTH5vgSFprjj3doJdN2UmJgOLuIx2J7k4XYlhO/i9iIxatOhEmCutrJyDphgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033014; c=relaxed/simple;
	bh=mvDPGoAEU59JiBM9EycfblBwRdWeFoZgGuUcBBo5KoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZWsVf+OG06HuakUEODmHUMAzVWs/PiuIOqYoQfRZAuDCn5YRxEvniWJUC+PeujMrvCLV02ERv1wBdIjRuz2oQosnq/84ge/uWF56VL7tzdzUffx24j6Sxx64lrLPvjWrzCeW1WZrz/JxA3DbLPm9IYmRD39cFF6ZWE8/6TF4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrzOoh+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrzOoh+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0A11F000E9;
	Thu,  6 Aug 2026 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032984;
	bh=RTlQHQ7mzhsQVIdJKJI7jztAPlRi4NyEUkjzmsq+7Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SrzOoh+RqfRthBj3EVBH08ijxb0CRFEpfMans+ob95FA3m3WgQ271ZS4Fj28LaTkj
	 XkgWnpQ9giIwN5udMZ6KCJRt3lMfZd+eMbYxSLsMIM/JDAFZXb1kTq8BGsc7pcxGiE
	 gdLzMLWmSFTEJfvrugIWqCbMpRP4qrxk0ejL6H1VCRXryZ5xEkSG5SyJUGQgvzJuXh
	 H7UeJte6l/HOVZtcTxF+mpkGCpfgBWF7U+KbxnCWaRDDlDoLgmdWqf8oeHpuUPSIZ7
	 4clet3UAbk99fiKRpB1D4Au/0I1HKg+oUFHq8BBVeUqDfbioomnDbCyua4UQe+ut5j
	 LVwZs/xKR62hw==
Date: Thu, 6 Aug 2026 09:16:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
Message-ID: <anSzVrjS14v2B3Im@google.com>
References: <20260804210659.112192-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804210659.112192-1-ctshao@google.com>

Hello,

On Tue, Aug 04, 2026 at 02:06:59PM -0700, Chun-Tse Shao wrote:
> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), `perf stat` evaluates metric expressions
> across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> `uncore_iio_1`, etc.).
> 
> However, `perf stat` previously formatted JSON output by printing only
> "cpu" : "<id>" and grouping all metric values on a single line per CPU
> without identifying which PMU instance evaluated each metric. As a
> result, when an uncore event spans multiple PMU boxes, `perf stat`
> printed repeated, ambiguous metric keys without PMU names.
> 
> Fix this by:
> 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->pmu
>    is a non-core or hybrid PMU in AGGR_NONE mode (-A).
> 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever the
>    underlying hardware PMU instance changes across PMU events.
> 3. Bypassing line initialization for tool events (e.g. -e user_time) in
>    metric-only mode so that JSON lines are opened only by hardware PMUs,
>    preventing tool events from corrupting PMU name labels or creating
>    spurious empty {"pmu": "tool"} JSON objects.
> 4. Updating perf_json_output_lint.py to recognize the new "pmu" key in
>    the JSON test suite.
> 
> Before the fix:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.001017947, "cpu" : "0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "22.5", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.2", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0", "MB/s  iio_bandwidth_read" : "0.0"}
> 
> There is no way to determine which uncore device generated the metrics.
> 
> After:
>   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.1"}
>   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}
>   ...
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "MB/s  iio_bandwidth_read" : "0.0"}
>   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "MB/s  iio_bandwidth_read" : "0.0"}

Can you please fix perf stat JSON output linter test?

  ---- start ----                                                                 
  ...                                                                             
  Checking json output: system wide no aggregation Test failed for input:         
  {"cpu" : "0", "pmu" : "software", "counter-value" : "3.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 6269136, "pcnt-running" : 100.00, "metric-value" : "478.743700", "metric-unit" : "cs/sec  cs_per_second"}
  ...                                                                             
      check_json_output(expected_items)                                           
      ~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^                                           
    File "linux/tools/perf/tests/shell/lib/perf_json_output_lint.py", line 89, in check_json_output
      raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                         f' in \'{item}\'')                                       
  RuntimeError: wrong number of fields. counted 9 expected [6, 8] in '{'cpu': '0', 'pmu': 'software', 'counter-value': '3.000000', 'unit': '', 'event': 'context-switches', 'event-runtime': 6269136, 'pcnt-running': 100.0, 'metric-value': '478.743700', 'metric-unit': 'cs/sec  cs_per_second'}'
  ---- end(-1) ----                                                               
  119: perf stat JSON output linter                                   : FAILED!

Thanks,
Namhyung
