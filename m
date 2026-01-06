Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3F19D081;
	Tue,  6 Jan 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738825; cv=none; b=OQf3parA9wskfdKL1vxckEPs2pzygNm/4xBsa8XWZGWVztRkbRtCuH9/xaPZkhNb8HdaV8Axl99M7EuLbtIh97oZT0a/F/xKZlwlcROUtBA3I+LN23EXuaIjxTpXebYEOj6rvzDBVfUwCRmceipsR5dA7INYZAZlI7Bj+fTvRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738825; c=relaxed/simple;
	bh=dMAxAAwjSZumkinbr6BGha5e8bTWzvenn3HYSxBBVYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1J48GmOjdtaqaKC5V9oc1iApqrTeMqYDCrm7pekgP5JCceIoXcLf9FCldJSohEkXnclFYeOLaMybisZRIiHet0hYB8t3QE+/NOEtdfRihFN0SB/E6zmGugRelijKodtQmFWSU1yAEh0TDSMd33nLakMspAHZSFRYNe6Hw6X6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn1rgtgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn1rgtgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A7C116C6;
	Tue,  6 Jan 2026 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767738825;
	bh=dMAxAAwjSZumkinbr6BGha5e8bTWzvenn3HYSxBBVYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nn1rgtgw4EWPika95i09OHRNYibPPcKPG2hw660GQeJrpHBZHF/xq4tqKantJPZmJ
	 VgDzgR+Xor4z7kA5qivQjpE4uV9HCM9D1geTpxmULZWuJ2B3THaYCJtNLmEXtlA0W4
	 aXRa+qgCbKrnsmoPeImWhKxKc71DEaDUNHDfNxgw1jYya3iOMxJxRxvWxk/qIqLFOs
	 bcmL8z6M1CQbtZnOjAzJEATfH/G7yMjGtB8MUvL12tLbFr+C7Day6iRbiFReSZyHia
	 C1yiZrBxK1PFhflq8ZNB2Bt8Zmtj7TcB6w9v9ulg2oULPjU1qIlT3kM1Q+Ncryi6HP
	 1mTPKBaBd0zNQ==
Date: Tue, 6 Jan 2026 19:33:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Derek Foreman <derek.foreman@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, kernel@collabora.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf data: Allow filtering conversion by time
 range
Message-ID: <aV2NxTYrcZwlw0_8@x1>
References: <20251128215020.184466-1-derek.foreman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128215020.184466-1-derek.foreman@collabora.com>

On Fri, Nov 28, 2025 at 03:50:17PM -0600, Derek Foreman wrote:
> This adds a feature to allow restricting the range of converted samples
> with a range string like perf-script and perf-report --time.
> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>

Thanks, tested and applied to perf-tools-next, see:

Committer testing:

Put a probe on the ICMP receive path handling broadcast packets:

  # perf probe icmp_rcv:64
  Added new event:
    probe:icmp_rcv_L64   (on icmp_rcv:64)
  
  You can now use it in all perf tools, such as:
  
  	perf record -e probe:icmp_rcv_L64 -aR sleep 1
  
  # perf record -e probe:icmp_rcv_L64 ping -c 10 -b 127.255.255.255
  WARNING: pinging broadcast address
  PING 127.255.255.255 (127.255.255.255) 56(84) bytes of data.
  ^C
  --- 127.255.255.255 ping statistics ---
  10 packets transmitted, 0 received, 100% packet loss, time 9217ms
  
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.034 MB perf.data (10 samples) ]
  
  # perf script
              ping   52785 [009]  5847.300394: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5848.325018: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5849.349007: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5850.372979: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5851.396988: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5852.420954: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5853.444934: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5854.468926: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5855.492914: probe:icmp_rcv_L64: (ffffffffaadb337e)
              ping   52785 [009]  5856.516883: probe:icmp_rcv_L64: (ffffffffaadb337e)
  # 

Now get some slices using perf script:

  # perf script --time 40%
            ping   52785 [009]  5847.300394: probe:icmp_rcv_L64: (ffffffffaadb337e)
            ping   52785 [009]  5848.325018: probe:icmp_rcv_L64: (ffffffffaadb337e)
            ping   52785 [009]  5849.349007: probe:icmp_rcv_L64: (ffffffffaadb337e)
            ping   52785 [009]  5850.372979: probe:icmp_rcv_L64: (ffffffffaadb337e)
  # perf script --time 40%-60%
            ping   52785 [009]  5851.396988: probe:icmp_rcv_L64: (ffffffffaadb337e)
            ping   52785 [009]  5852.420954: probe:icmp_rcv_L64: (ffffffffaadb337e)
  #

And finally use this new feature:

  # perf data convert --to-json out.json --time 0%-10%
  [ perf data convert: Converted 'perf.data' into JSON data 'out.json' ]
  [ perf data convert: Converted and wrote 0.001 MB (1 samples) ]
  [ perf data convert: Skipped 9 samples ]
  # cat out.json
  {
  	"linux-perf-json-version": 1,
  	"headers": {
  		"header-version": 1,
  		"captured-on": "2026-01-06T22:26:40Z",
  		"data-offset": 520,
  		"data-size": 34648,
  		"feat-offset": 35168,
  		"hostname": "number",
  		"os-release": "6.17.12-300.fc43.x86_64",
  		"arch": "x86_64",
  		"cpu-desc": "AMD Ryzen 9 9950X3D 16-Core Processor",
  		"cpuid": "AuthenticAMD,26,68,0",
  		"nrcpus-online": 32,
  		"nrcpus-avail": 32,
  		"perf-version": "6.19.rc4.gf4c270685d3d",
  		"cmdline": [
  			"/home/acme/bin/perf"
  		]
  	},
  	"samples": [
  		{
  			"timestamp": 5847300394661,
  			"pid": 52785,
  			"tid": 52785,
  			"cpu": 9,
  			"comm": "ping",
  			"callchain": [
  				{
  					"ip": "0xffffffffaadb337f",
  					"symbol": "icmp_rcv",
  					"dso": "[kernel.kallsyms]"
  				}
  			],
  			"__probe_ip": "ffffffffaadb337e"
  		}
  	]
  }
  #
> ---
> v2) Replace bespoke filtering with --time (util/time-utils.h)
> 
>  tools/perf/Documentation/perf-data.txt | 28 ++++++++++++++++++++++
>  tools/perf/builtin-data.c              |  3 +++
>  tools/perf/util/data-convert-bt.c      | 31 ++++++++++++++++++++++++
>  tools/perf/util/data-convert-json.c    | 33 ++++++++++++++++++++++++++
>  tools/perf/util/data-convert.h         |  1 +
>  5 files changed, 96 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index 417bf17e265c..20f178d61ed7 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -40,6 +40,34 @@ OPTIONS for 'convert'
>  --force::
>  	Don't complain, do it.
>  
> +--time::
> +	Only convert samples within given time window: <start>,<stop>. Times
> +	have the format seconds.nanoseconds. If start is not given (i.e. time
> +	string is ',x.y') then analysis starts at the beginning of the file. If
> +	stop time is not given (i.e. time string is 'x.y,') then analysis goes
> +	to end of file. Multiple ranges can be separated by spaces, which
> +	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
> +
> +	Also support time percent with multiple time ranges. Time string is
> +	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
> +
> +	For example:
> +	Select the second 10% time slice:
> +
> +	  perf data convert --to-json out.json --time 10%/2
> +
> +	Select from 0% to 10% time slice:
> +
> +	  perf data convert --to-json out.json --time 0%-10%
> +
> +	Select the first and second 10% time slices:
> +
> +	  perf data convert --to-json out.json --time 10%/1,10%/2
> +
> +	Select from 0% to 10% and 30% to 40% slices:
> +
> +	  perf data convert --to-json out.json --time 0%-10%,30%-40%
> +
>  -v::
>  --verbose::
>          Be more verbose (show counter open errors, etc).
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index ce51cbf6dc97..85f59886b5cf 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -33,6 +33,7 @@ const char *to_ctf;
>  struct perf_data_convert_opts opts = {
>  	.force = false,
>  	.all = false,
> +	.time_str = NULL,
>  };
>  
>  const struct option data_options[] = {
> @@ -45,6 +46,8 @@ const struct option data_options[] = {
>  #endif
>  		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
>  		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
> +		OPT_STRING(0, "time", &opts.time_str, "str",
> +			   "Time span of interest (start,stop)"),
>  		OPT_END()
>  	};
>  
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index 3d2e437e1354..0bcbc0e309e0 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -34,6 +34,7 @@
>  #include "util.h"
>  #include "clockid.h"
>  #include "util/sample.h"
> +#include "util/time-utils.h"
>  
>  #ifdef HAVE_LIBTRACEEVENT
>  #include <event-parse.h>
> @@ -91,9 +92,14 @@ struct convert {
>  	struct perf_tool	tool;
>  	struct ctf_writer	writer;
>  
> +	struct perf_time_interval *ptime_range;
> +	int range_size;
> +	int range_num;
> +
>  	u64			events_size;
>  	u64			events_count;
>  	u64			non_sample_count;
> +	u64			skipped;
>  
>  	/* Ordered events configured queue size. */
>  	u64			queue_size;
> @@ -811,6 +817,11 @@ static int process_sample_event(const struct perf_tool *tool,
>  	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
>  		return 0;
>  
> +	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
> +		++c->skipped;
> +		return 0;
> +	}
> +
>  	event_class = priv->event_class;
>  
>  	/* update stats */
> @@ -1644,6 +1655,15 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
>  
> +	if (opts->time_str) {
> +		err = perf_time__parse_for_ranges(opts->time_str, session,
> +						  &c.ptime_range,
> +						  &c.range_size,
> +						  &c.range_num);
> +		if (err < 0)
> +			goto free_session;
> +	}
> +
>  	/* CTF writer */
>  	if (ctf_writer__init(cw, path, session, opts->tod))
>  		goto free_session;
> @@ -1687,6 +1707,14 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  	else
>  		fprintf(stderr, ", %" PRIu64 " non-samples) ]\n", c.non_sample_count);
>  
> +	if (c.skipped) {
> +		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
> +			c.skipped);
> +	}
> +
> +	if (c.ptime_range)
> +		zfree(&c.ptime_range);
> +
>  	cleanup_events(session);
>  	perf_session__delete(session);
>  	ctf_writer__cleanup(cw);
> @@ -1696,6 +1724,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
>  free_writer:
>  	ctf_writer__cleanup(cw);
>  free_session:
> +	if (c.ptime_range)
> +		zfree(&c.ptime_range);
> +
>  	perf_session__delete(session);
>  	pr_err("Error during conversion setup.\n");
>  	return err;
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 9dc1e184cf3c..787039967916 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -25,6 +25,7 @@
>  #include "util/session.h"
>  #include "util/symbol.h"
>  #include "util/thread.h"
> +#include "util/time-utils.h"
>  #include "util/tool.h"
>  
>  #ifdef HAVE_LIBTRACEEVENT
> @@ -35,7 +36,12 @@ struct convert_json {
>  	struct perf_tool tool;
>  	FILE *out;
>  	bool first;
> +	struct perf_time_interval *ptime_range;
> +	int range_size;
> +	int range_num;
> +
>  	u64 events_count;
> +	u64 skipped;
>  };
>  
>  // Outputs a JSON-encoded string surrounded by quotes with characters escaped.
> @@ -165,6 +171,11 @@ static int process_sample_event(const struct perf_tool *tool,
>  		return -1;
>  	}
>  
> +	if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, sample->time)) {
> +		++c->skipped;
> +		return 0;
> +	}
> +
>  	++c->events_count;
>  
>  	if (c->first)
> @@ -320,6 +331,10 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  	struct convert_json c = {
>  		.first = true,
>  		.events_count = 0,
> +		.ptime_range = NULL,
> +		.range_size = 0,
> +		.range_num = 0,
> +		.skipped = 0,
>  	};
>  	struct perf_data data = {
>  		.mode = PERF_DATA_MODE_READ,
> @@ -382,6 +397,15 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  		goto err_session_delete;
>  	}
>  
> +	if (opts->time_str) {
> +		ret = perf_time__parse_for_ranges(opts->time_str, session,
> +						  &c.ptime_range,
> +						  &c.range_size,
> +						  &c.range_num);
> +		if (ret < 0)
> +			goto err_session_delete;
> +	}
> +
>  	// The opening brace is printed manually because it isn't delimited from a
>  	// previous value (i.e. we don't want a leading newline)
>  	fputc('{', c.out);
> @@ -411,7 +435,16 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
>  			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
>  
> +	if (c.skipped) {
> +		fprintf(stderr,	"[ perf data convert: Skipped %" PRIu64 " samples ]\n",
> +			c.skipped);
> +	}
> +
>  	ret = 0;
> +
> +	if (c.ptime_range)
> +		zfree(&c.ptime_range);
> +
>  err_session_delete:
>  	perf_session__delete(session);
>  err_fclose:
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
> index 1b4c5f598415..ee651fa680a1 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -8,6 +8,7 @@ struct perf_data_convert_opts {
>  	bool force;
>  	bool all;
>  	bool tod;
> +	const char *time_str;
>  };
>  
>  #ifdef HAVE_LIBBABELTRACE_SUPPORT
> -- 
> 2.47.3
