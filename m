Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41773016F2
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787381083; cv=none; b=JA1bAldvxf545FMNfhCY026CA1o4nnxM/ydCdI0fqnxwW0mv3CPakmramk/MpO0fKpE+IVEnoNBHG0Qy/xUD58Fqiy7gN4WfwoVdNqTPjndQ/jlXR3IbUGMpHAVGgnIHpFdY1UHRSJLa+34BQXAnymqhmbcSblFcgkU1JAssRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787381083; c=relaxed/simple;
	bh=JiHqOZ0JFhS4jSjXLaZ1pP/Xw0uApDjvk7i0ZdIodUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzeEVGAqjBgvjoqNTu1OUSZbih1OUEsgW8S+1qva8ieMV5h/hQNd29FNuzafoDiPvYI/IETakOX9sHEWuyhzcVSfPmx4xBRvo8D58sLRjJpXK3f/tjEKjxCZ6l57/gTPPMnjOqZ43ENe/0lsKst2o0cX9SoFApHk+Z1b3HqSQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Ob86ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Ob86ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CBB1F000E9;
	Sat, 22 Aug 2026 06:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787381081;
	bh=wA4fPxx84vvjuZL5uEqwiUAuRFKC513akg6b31IdJ24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3Ob86ikgzo8MTonEHL4Iu5o7mfvxXo+Xs89ThYLPEuFxIk4JKminHqA4LBGjaSmV
	 KeABT45PP7TOIKzJAaz2vPYR3RlDdLIhNaWErIisTFK0AKeGu0rCehDzHw7JE2FF3w
	 R3FlvosX/2hd8j2uHNnd0W2Q6nWDWk9c7dlSZjpEfraI3MUfx+DQgiQ+DgdRfTva0P
	 leZscocBLm57TBXEy8BBb/I3iB7XLVUn8NzlPW9OoKmXjgTB/kOvCl9Rdrnn4+O4/s
	 gsX/nQEvpjNd4p1wPFnKsUMz/8259oMC8Kp2z8CLYPSMOfdcP8BDFDxjwRSe7JEz9E
	 4qu1E16ADKxjQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/5] perf data: Add --to-trace-dat option for
 converting perf.data tracepoint events into trace.dat format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822062729.882005-5-tshah@linux.ibm.com>
References: <20260822062729.882005-1-tshah@linux.ibm.com>
 <20260822062729.882005-5-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 06:44:40 +0000
Message-Id: <20260822064441.40CBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Trace parser desynchronization: Large event array lengths must be =
encoded as the fully padded size minus the length word.
- [High] Out of bounds rejection: CPU array limits must be scoped to `nr_cp=
us_avail` rather than `nr_cpus_online`.
- [High] Silent I/O truncation: Stream checks must explicitly assert identi=
cal element counts instead of binary negation.
- [High] Architecture violation: Page header offsets must dynamically query=
 the ftrace event format to accommodate 32-bit `local_t` structures.
- [Low] Build architecture violation: The `data-convert.h` header must incl=
ude a dummy inline fallback stub for `trace_convert__perf2dat`.
- [Low] Dead code elimination: The `skipped` sample counter is incremented =
but structurally isolated and unread.
--

--- Patch [4]: [RFC PATCH v4 4/5] perf data: Add --to-trace-dat option for =
converting perf.data tracepoint events into trace.dat format ---
commit 9a258038767861211db47cd6d942b553034516f1
Author: Tanushree Shah <tshah@linux.ibm.com>

perf data: Add --to-trace-dat option for converting perf.data tracepoint ev=
ents into trace.dat format

Add new command-line option to perf data convert for generating
trace.dat output files.

> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 1dd73ed6bdcb8..c9c863197d02c 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
[ ... ]
> @@ -63,10 +72,44 @@ static int cmd_data_convert(int argc, const char **ar=
gv)
[ ... ]
> +#ifdef HAVE_LIBTRACEEVENT
> +	if (trace_dat_output)
> +		return trace_convert__perf2dat(input_name ? input_name : "perf.data",
> +					       trace_dat_output, &opts);
> +#endif

[Severity: Low]
Does the data-convert.h header need a dummy inline fallback stub for
trace_convert__perf2dat()?

Without an #else block providing an inline dummy stub, could this cause a
build failure when compiling without HAVE_LIBTRACEEVENT?

> diff --git a/tools/perf/util/data-convert-trace.c b/tools/perf/util/data-=
convert-trace.c
> index 445479fae8884..425b3aaa3f026 100644
> --- a/tools/perf/util/data-convert-trace.c
> +++ b/tools/perf/util/data-convert-trace.c
> @@ -31,6 +32,10 @@
>  struct trace_convert {
>  	struct perf_tool tool;
>  	u64 events_count;
> +	struct perf_time_interval *ptime_range;
> +	int range_size;
> +	int range_num;
> +	u64 skipped;
>  };

[Severity: Low]
Is this skipped counter ever read?

It is incremented when events are outside the specified time range, but
appears to be structurally isolated and never emitted in the final
conversion summary.

> @@ -86,6 +91,11 @@ static int process_sample_event(const struct perf_tool=
 *tool,
>  		cpu_buffers_initialized =3D true;
>  	}
> =20
> +	if (perf_time__ranges_skip_sample(tc->ptime_range, tc->range_num, sampl=
e->time)) {
> +		tc->skipped++;
> +		return 0;
> +	}
> +

[Severity: High]
Are valid samples from sparse CPU topologies rejected here?

In process_sample_event(), the CPU buffers are initialized using
nr_cpus_online:
    int nr_cpus =3D trace_dat_session->header.env.nr_cpus_online;

But trace_dat__collect_cpu_event() rejects samples if the CPU index is >=3D
trace_dat_nr_cpus:
    if (!trace_cpu_data || cpu < 0 || cpu >=3D trace_dat_nr_cpus)
        return -EINVAL;

If a system has hotplugged CPUs (e.g. CPUs 0 and 127 are online, making
nr_cpus_online 2), a valid sample from CPU 127 will be evaluated against
cpu >=3D 2. This causes trace_dat__collect_cpu_event() to return -EINVAL,
aborting the conversion.

Should this use nr_cpus_avail instead of nr_cpus_online?

> diff --git a/tools/perf/util/trace-dat.c b/tools/perf/util/trace-dat.c
> index f71e03716e27e..1b236745bcacc 100644
> --- a/tools/perf/util/trace-dat.c
> +++ b/tools/perf/util/trace-dat.c
[ ... ]
> @@ -288,7 +292,7 @@ static int trace_dat__write_cpu_dat(FILE *fp, struct =
tep_handle *pevent,
>  		/* Check page fit BEFORE allocating data record */
>  		if (page_size_used + needed_size >
>  			trace_dat_page_size - TRACE_DAT_RECORD_HEADER_SIZE) {
> -			ret =3D trace_dat__write_page(fp, pevent, base_ts,
> +			ret =3D trace_dat__write_page(fp, pevent, page_base_ts,
>  					page_records, page_rec_sizes,
>  					nr_page_recs);

[Severity: High]
Could the length word for large trace events be miscalculated?

Later in trace_dat__write_cpu_dat(), the array length is encoded:

    /* Large events: write actual byte length after header */
    if (type_len =3D=3D 0) {
        unsigned int data_len_out =3D to_file_u32(pevent, data_len);
        memcpy(data_rec + TRACE_DAT_WORD_SIZE, &data_len_out, TRACE_DAT_WOR=
D_SIZE);
    }

For large events (>=3D29 words), the ftrace ring buffer format dictates that
the first word of the payload contains the length of the data plus the
length word itself (data_len + 4).

By writing just data_len, might this cause downstream tools like trace-cmd
to compute the event size incorrectly and lose parser synchronization?

[Severity: High]
Can a short write silently corrupt the trace.dat file?

In trace_dat__write_page(), the file write checks for a boolean false:

    if (!fwrite(page, 1, trace_dat_page_size, fp)) {
        free(page);
        return -EIO;
    }

Since fwrite() returns the number of elements written, a short write (e.g.
512 out of 4096 bytes) evaluates to true.

Will this silently drop data without reporting an error to the user if the
disk runs out of space? Should the stream check explicitly assert
fwrite(...) =3D=3D trace_dat_page_size?

[Severity: High]
Will this hardcoded page header size break parsing for trace data recorded
on 32-bit architectures?

In trace_dat__write_page(), the page header offsets are hardcoded:

    /* Byte-swap page header for cross-arch compatibility */
    ts_out =3D to_file_u64(pevent, base_ts);
    commit_out =3D to_file_u64(pevent, commit);
    memcpy(page, &ts_out, sizeof(ts_out));
    memcpy(page + sizeof(ts_out), &commit_out, sizeof(commit_out));

The ftrace page header includes a local_t commit field, which is 8 bytes on
64-bit systems but 4 bytes on 32-bit systems (making the header 12 bytes).
Because this unconditionally assumes a 16-byte header and writes 8 bytes for
commit_out, trace-cmd reading 32-bit metadata will likely parse the remaini=
ng
4 bytes as the first trace event.

Should the page header offsets and sizing be dynamically queried from the
ftrace event format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822062729.8820=
05-1-tshah@linux.ibm.com?part=3D4
