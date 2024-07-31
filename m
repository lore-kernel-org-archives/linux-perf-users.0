Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA02286A3;
	Wed, 31 Jul 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449857; cv=none; b=AcIhS6ds7ZAKzpDd6uKd/g4BJBt9estxpe6k3atL7AvYI7Dv572XmNat5z0wCuo+6oFjRE8rQUCticFmDXxXlkf5Q6DoDRm7OJ6/vCTr+Z8zD4A5jw7JlOcp4U8UvzhF+9oScHd87VbJmlr0+eQOlBlWlse0zkZdfRNstq2gh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449857; c=relaxed/simple;
	bh=SaDb+qT+BItO/9cjino2V6AD/Jq1OmOQe6ERuyU5noI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb62iWcTjodw9ihQDEO2oWR22j9rLjVn8q5aipPkzbkwS5ViqcVNwBV+sRRynk4qE78WDGR0D2yG3kymi3bKc/XrMc/Ff0llYXXAejEHQJWVxtEjSxy14kOed3iONH9a3bIFw0Hzk9bax+V9zQ9/sPXHxIMuWUEMUDUld8XmKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9n7mEEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9n7mEEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41244C116B1;
	Wed, 31 Jul 2024 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722449856;
	bh=SaDb+qT+BItO/9cjino2V6AD/Jq1OmOQe6ERuyU5noI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9n7mEEaDj/5Z978Wsmr3sMQLSHps5Qs0ovcLjjdhPkB6U9fPJmHmj837bLSx1YLb
	 gz2e7oldEXv+foJdfbKzKtm6WwdcdeyAEOl4rd6DzOctV4q5NAUpJclcDoDuWWPEdJ
	 +gYu+ZBNqFR8L/zue4YFzmUhHAaOi9SFYqH/nQUHBKCgzAP+Yj5MbehekckebDA+2u
	 Hp7b4QglSfOP86m0kCPUlQgFTex13hyDnTo5dJxiwRF1P9Ttljr8WGVjLSj7UPWC8M
	 RAN2IlnubUmC7qMPAhAAaVQmsIoDDjSg/t6G0cXDYRbmL46DjiOSZAp0SmXts5xSyU
	 wI+le+wc1XEbQ==
Date: Wed, 31 Jul 2024 11:17:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when
 opening events
Message-ID: <Zqp_vqCn0FEfGFwX@google.com>
References: <20240730084417.7693-1-ben.gainey@arm.com>
 <20240730084417.7693-5-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730084417.7693-5-ben.gainey@arm.com>

Hello,

On Tue, Jul 30, 2024 at 09:44:17AM +0100, Ben Gainey wrote:
> The "perf record" tool will now default to this new mode if the user
> specifies a sampling group when not in system-wide mode, and when
> "--no-inherit" is not specified.
> 
> This change updates evsel to allow the combination of inherit
> and PERF_SAMPLE_READ.
> 
> A fallback is implemented for kernel versions where this feature is not
> supported.
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> ---
>  tools/perf/tests/attr/README                  |  2 +
>  .../tests/attr/test-record-group-sampling     |  3 +-
>  .../tests/attr/test-record-group-sampling1    | 51 ++++++++++++++++
>  .../tests/attr/test-record-group-sampling2    | 61 +++++++++++++++++++
>  tools/perf/tests/attr/test-record-group2      |  1 +
>  ...{test-record-group2 => test-record-group3} | 10 +--
>  tools/perf/util/evsel.c                       | 19 +++++-
>  tools/perf/util/evsel.h                       |  1 +
>  8 files changed, 141 insertions(+), 7 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
>  copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)
> 
> diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
> index 4066fec7180a..67c4ca76b85d 100644
> --- a/tools/perf/tests/attr/README
> +++ b/tools/perf/tests/attr/README
> @@ -51,6 +51,8 @@ Following tests are defined (with perf commands):
>    perf record --call-graph fp kill              (test-record-graph-fp-aarch64)
>    perf record -e '{cycles,instructions}' kill   (test-record-group1)
>    perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
> +  perf record -e '{cycles,cache-misses}:S' kill (test-record-group-sampling1)
> +  perf record -c 10000 -e '{cycles,cache-misses}:S' kill (test-record-group-sampling2)
>    perf record -D kill                           (test-record-no-delay)
>    perf record -i kill                           (test-record-no-inherit)
>    perf record -n kill                           (test-record-no-samples)
> diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
> index 97e7e64a38f0..da7a5d10785f 100644
> --- a/tools/perf/tests/attr/test-record-group-sampling
> +++ b/tools/perf/tests/attr/test-record-group-sampling
> @@ -2,6 +2,7 @@
>  command = record
>  args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
>  ret     = 1
> +kernel_until = 6.11

I guess it's v6.12. :)

>  
>  [event-1:base-record]
>  fd=1
> @@ -18,7 +19,7 @@ group_fd=1
>  type=0
>  config=3
>  
> -# default | PERF_SAMPLE_READ
> +# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
>  sample_type=343
>  
>  # PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
> diff --git a/tools/perf/tests/attr/test-record-group-sampling1 b/tools/perf/tests/attr/test-record-group-sampling1
> new file mode 100644
> index 000000000000..b02de391718d
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-group-sampling1
> @@ -0,0 +1,51 @@
> +[config]
> +command = record
> +args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
> +ret     = 1
> +kernel_since = 6.11
> +
> +[event-1:base-record]
> +fd=1
> +group_fd=-1
> +
> +# cycles
> +type=0
> +config=0
> +
> +# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
> +sample_type=343
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=28|31
> +task=1
> +mmap=1
> +comm=1
> +enable_on_exec=1
> +disabled=1
> +
> +# inherit is enabled for group sampling
> +inherit=1
> +
> +[event-2:base-record]
> +fd=2
> +group_fd=1
> +
> +# cache-misses
> +type=0
> +config=3
> +
> +# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
> +sample_type=343
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=28|31
> +task=0
> +mmap=0
> +comm=0
> +enable_on_exec=0
> +disabled=0
> +freq=0
> +
> +# inherit is enabled for group sampling
> +inherit=1
> +
> diff --git a/tools/perf/tests/attr/test-record-group-sampling2 b/tools/perf/tests/attr/test-record-group-sampling2
> new file mode 100644
> index 000000000000..060fd1d24f63
> --- /dev/null
> +++ b/tools/perf/tests/attr/test-record-group-sampling2
> @@ -0,0 +1,61 @@
> +[config]
> +command = record
> +args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
> +ret     = 1
> +kernel_since = 6.11
> +
> +[event-1:base-record]
> +fd=1
> +group_fd=-1
> +
> +# cycles
> +type=0
> +config=0
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=87
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=28|31
> +task=1
> +mmap=1
> +comm=1
> +enable_on_exec=1
> +disabled=1
> +
> +# inherit is enabled for group sampling
> +inherit=1
> +
> +# sampling disabled
> +sample_freq=0
> +sample_period=10000
> +freq=0
> +write_backward=0
> +
> +[event-2:base-record]
> +fd=2
> +group_fd=1
> +
> +# cache-misses
> +type=0
> +config=3
> +
> +# default | PERF_SAMPLE_READ
> +sample_type=87
> +
> +# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
> +read_format=28|31
> +task=0
> +mmap=0
> +comm=0
> +enable_on_exec=0
> +disabled=0
> +
> +# inherit is enabled for group sampling
> +inherit=1
> +
> +# sampling disabled
> +sample_freq=0
> +sample_period=0
> +freq=0
> +write_backward=0
> diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
> index cebdaa8e64e4..ad97df77a506 100644
> --- a/tools/perf/tests/attr/test-record-group2
> +++ b/tools/perf/tests/attr/test-record-group2
> @@ -2,6 +2,7 @@
>  command = record
>  args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
>  ret     = 1
> +kernel_until = 6.11
>  
>  [event-1:base-record]
>  fd=1
> diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group3
> similarity index 81%
> copy from tools/perf/tests/attr/test-record-group2
> copy to tools/perf/tests/attr/test-record-group3
> index cebdaa8e64e4..311afb478b85 100644
> --- a/tools/perf/tests/attr/test-record-group2
> +++ b/tools/perf/tests/attr/test-record-group3
> @@ -2,6 +2,7 @@
>  command = record
>  args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
>  ret     = 1
> +kernel_since = 6.11
>  
>  [event-1:base-record]
>  fd=1
> @@ -9,8 +10,9 @@ group_fd=-1
>  config=0|1
>  sample_period=1234000
>  sample_type=87
> -read_format=12|28
> -inherit=0
> +read_format=28|31
> +disabled=1
> +inherit=1
>  freq=0
>  
>  [event-2:base-record]
> @@ -19,9 +21,9 @@ group_fd=1
>  config=0|1
>  sample_period=6789000
>  sample_type=87
> -read_format=12|28
> +read_format=28|31
>  disabled=0
> -inherit=0
> +inherit=1
>  mmap=0
>  comm=0
>  freq=0
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bc603193c477..ceb09b6a8c2f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1171,7 +1171,15 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  		 */
>  		if (leader->core.nr_members > 1) {
>  			attr->read_format |= PERF_FORMAT_GROUP;
> -			attr->inherit = 0;
> +		}
> +
> +		/*
> +		 * Inherit + SAMPLE_READ requires SAMPLE_TID in the read_format
> +		 */
> +		if (attr->inherit) {
> +			evsel__set_sample_bit(evsel, TID);
> +			evsel->core.attr.read_format |=
> +				PERF_FORMAT_ID;
>  		}

Also I think we should reset the inherit bit for system-wide events.

  $ perf record -a --synth=no true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.042 MB perf.data (51 samples) ]
  
  $ perf evlist -v | tr ',' '\n' | grep inherit
   inherit: 1
   inherit: 1

Maybe something like this:

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..9423cd65c3c4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1149,7 +1149,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
        bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
 
        attr->sample_id_all = perf_missing_features.sample_id_all ? 0 : 1;
-       attr->inherit       = !opts->no_inherit;
+       attr->inherit       = target__has_cpu(&opts->target) ? 0 : !opts->no_inherit;
        attr->write_backward = opts->overwrite ? 1 : 0;
        attr->read_format   = PERF_FORMAT_LOST;
 

Thanks,
Namhyung


>  	}
>  
> @@ -2020,6 +2028,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +	if (perf_missing_features.inherit_sample_read)
> +		evsel->core.attr.inherit = 0;
>  	if (perf_missing_features.branch_counters)
>  		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
>  	if (perf_missing_features.read_lost)
> @@ -2075,7 +2085,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -	if (!perf_missing_features.branch_counters &&
> +	if (!perf_missing_features.inherit_sample_read &&
> +	    evsel->core.attr.inherit && (evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {
> +		perf_missing_features.inherit_sample_read = true;
> +		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
> +		return true;
> +	} else if (!perf_missing_features.branch_counters &&
>  	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
>  		perf_missing_features.branch_counters = true;
>  		pr_debug2("switching off branch counters support\n");
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 80b5f6dd868e..bb0c91c23679 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -206,6 +206,7 @@ struct perf_missing_features {
>  	bool weight_struct;
>  	bool read_lost;
>  	bool branch_counters;
> +	bool inherit_sample_read;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.45.2
> 
