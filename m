Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BF2E762C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924491; cv=none; b=gOLglNhrjJUYo3wFZA2gZsEmmP6/rG1iPfOiMTf4bxcwG1ITTZ8lljzG5csOGfyLP9SD26O6zLwCe4Qy6joi/LbQy18zoSNBCm1JKfB6NpyEw5d+qNjbl294fSBTizdN6IvpBSgIiCX1oxNevuJTiNYsek30Rc8K2O10ZrflD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924491; c=relaxed/simple;
	bh=+RQfb7nlFluqFZudDUHqAH1tgo5rgkQhhHh1uwpukbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V0MOspFXPKecLRPIE3rFVzNx2zaY6xoDSdwjyRWV3mSwEBnOvfZXawFJhVyLEJDBr+WokZl9bF5ma8ekd2P7QBV6fDrc4BDxbczX/tPVFBGPhxGSMWljvbX+82AX65krKTTQU3LbU/AwGANzZGAUsEKXEcf2VAWeIVfjc0619U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI21EA/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI21EA/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBDA1F00893;
	Mon,  8 Jun 2026 13:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924489;
	bh=5BUVPHkdtciOo82vt89uhotE1FQNkhJ3Q6PR6DEiOOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MI21EA/zVktiDbSuAW2+JtjNx4UPnsA7b/hmddEJurmVeX9YtxCJ2KnIaOEtJ55jB
	 4skNjjLavsKfXW8FeQdXf/QVbimm8+Wedo/n5PPwxvx5DWFZFX2FrakqfMRx2iJxF3
	 t8xwdiwhD6hQtNXIZB0eSMPQPBTj5iFjs4RuIRUZyuDWcPcSVefvRtONcV83rXtAhB
	 oV2b4tucWzcBGALRNWGE7tDyRtrfqla0eVyYwMSZNlkP/QFnaYEDO9CSBznml9vffC
	 vYqVQKczaAA7O7E2/4PkCrNIGWNRd/0t7IKNq5vvTy0u1DwVS0yd+0Y9ECq5qqaYwf
	 XkZxYWIBeMkGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] perf data-convert: Add perf.data to trace.dat
 conversion backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608125951.90425-5-tshah@linux.ibm.com>
References: <20260608125951.90425-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:14:49 +0000
Message-Id: <20260608131449.9DBDA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Out-of-bounds heap write when tracepoint event data size excee=
ds the remaining space in a trace.dat page.
- [Medium] The conversion tool fails to register required callbacks for pip=
e mode (such as `.attr`, `.feature`, and `.tracing_data`), silently droppin=
g events.
- [Medium] The output file is overwritten unconditionally, ignoring the `op=
ts->force` flag.
- [Medium] A `realloc` failure in `trace_dat__collect_cpu_event` causes a m=
emory leak and subsequent segmentation fault.
--

commit da74698d88efeca5fa33802144416838acb15d2a
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data-convert: Add perf.data to trace.dat conversion backend

Add data-convert-trace.c implementing trace_convert__perf2dat() to
convert perf.data tracepoint events to trace.dat format.

process_sample_event() is invoked for each PERF_TYPE_TRACEPOINT sample
during perf_session__process_events(), storing raw event bytes per-cpu
via trace_dat__collect_cpu_event().

Once all samples are collected:
- trace_dat__write_options_section1() writes the OPTIONS section with
  CPUCOUNT, TRACECLOCK, HEADER_INFO, FTRACE_EVENTS, EVENT_FORMATS,
  KALLSYMS, CMDLINES and DONE options.
- trace_dat__write__options_section2() writes the OPTIONS section with
  BUFFER option holding per-cpu data offset placeholders and the DONE
  option.
- trace_dat__write_flyrecord_section() builds ring buffer pages
  per-cpu and patches BUFFER option with final offsets and sizes

Per-cpu buffers are sized to tep_get_page_size() from the session
tep handle and released on all exit paths.

> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-=
convert-trace.c
> new file mode 100644
> index 0000000000000..e4f8b817be36d
> --- /dev/null
> +++ b/tools/perf/util/data-convert-trace.c
[ ... ]
> +/* Store raw tracepoint event data in per-cpu buffer for trace.dat flyre=
cord */
> +static int process_sample_event(const struct perf_tool *tool,
> +				union perf_event *event __maybe_unused,
> +				struct perf_sample *sample,
> +				struct evsel *evsel,
> +				struct machine *machine __maybe_unused)
> +{
> +	struct trace_convert *tc =3D container_of(tool, struct trace_convert, t=
ool);
> +
> +	/* Collect raw tracepoint data per-cpu */
> +	if (trace_dat_fp && sample->raw_size > 0 &&
> +	    evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		if (trace_dat__collect_cpu_event(sample->cpu, sample->time,
> +					sample->raw_data, sample->raw_size) < 0) {

[Severity: Medium]
Is it possible for a memory allocation failure here to cause a crash
during cleanup?

If trace_dat__collect_cpu_event() fails during a realloc(), it might return
-ENOMEM while leaving the events array pointer as NULL but keeping the count
intact.

When trace_dat__free_cpu_buffers() is called on the error path, it could
dereference that NULL pointer:

tools/perf/util/trace-dat.c:trace_dat__free_cpu_buffers() {
	...
	for (i =3D 0; i < trace_cpu_data[cpu].count; i++)
		free(trace_cpu_data[cpu].events[i].raw);
	...
}

> +			pr_err("Failed to collect CPU event\n");
> +			return -ENOMEM;
> +		}
> +		tc->events_count++;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +/* Convert perf.data tracepoint events to trace.dat format */
> +int trace_convert__perf2dat(const char *input, const char *to_trace,
> +			   struct perf_data_convert_opts *opts)
> +{
> +	struct perf_session *session;
> +	struct trace_convert tc =3D {
> +		.events_count =3D 0,
> +	};
> +	struct perf_data data =3D {
> +		.path =3D input,
> +		.mode =3D PERF_DATA_MODE_READ,
> +		.force =3D opts->force,
> +	};
> +	int ret =3D -EINVAL;
> +	bool cpu_buffers_initialized =3D false;
> +
> +	/* Initialize tool with all required callbacks */
> +	perf_tool__init(&tc.tool, /*ordered_events=3D*/true);
> +	tc.tool.sample =3D process_sample_event;

[Severity: Medium]
Does this initialization omit the required callbacks for pipe mode?

By only overriding .sample, the .attr, .feature, and .tracing_data
callbacks remain as default stubs from perf_tool__init().

In pipe mode, without these callbacks, the tool might silently fail to
populate trace metadata and generate an empty trace.dat file.

> +
> +	/* Open output trace.dat file */
> +	trace_dat_fp =3D fopen(to_trace, "wb");
> +	if (!trace_dat_fp) {

[Severity: Medium]
Can this unconditionally overwrite an existing file?

The fopen() call uses the "wb" mode which truncates the file, but it
doesn't appear to check the opts->force flag.

This regression could lead to accidental data loss.

> +		pr_err("Failed to open output file: %s\n", to_trace);
> +		return -EINVAL;
> +	}
[ ... ]
> +	/* Write trace.dat options and flyrecord sections */
> +	if (trace_dat__write_options_section1() < 0) {
> +		pr_err("Failed to write options section1\n");
> +		ret =3D -EIO;
> +		goto out_delete;
> +	}
> +	if (trace_dat__write_options_section2() < 0) {
> +		pr_err("Failed to write options section2\n");
> +		ret =3D -EIO;
> +		goto out_delete;
> +	}
> +	if (trace_dat__write_flyrecord_section() < 0) {

[Severity: Critical]
Could an unusually large tracepoint event cause an out-of-bounds memory
access when writing the flyrecord section?

When trace_dat__write_cpu_dat() processes records, it queues them to a new
page without checking if the rec_size fits within trace_dat_page_size.

If an event size exceeds the page size, trace_dat__write_page() allocates a
fixed-size buffer and copies the data into it:

tools/perf/util/trace-dat.c:trace_dat__write_page() {
	page =3D calloc(1, trace_dat_page_size);
	...
	for (i =3D 0; i < nr_recs; i++) {
		memcpy(page + offset, records[i], rec_sizes[i]);
	...
}

This regression could result in a heap buffer overflow.

> +		pr_err("Failed to write flyrecord section\n");
> +		ret =3D -EIO;
> +		goto out_delete;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125951.9042=
5-2-tshah@linux.ibm.com?part=3D3
