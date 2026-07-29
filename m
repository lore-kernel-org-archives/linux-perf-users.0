Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09097485CEB
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329816; cv=none; b=dsCYuaGS/B2X0CM8+KATgolnfuSQjvjjlu2JlRL9XHmfd6315hd/zhxgexq3jQLpnr7PwWBeYpa9uP0mJdV8aSF0hgZtWGn8qd/+KXqTtmFWGVjraFwzyo0iEdG4EVO4dFIsC+bcak4fe7/QX8VURkhkaPuQkHG01Izw3OWTvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329816; c=relaxed/simple;
	bh=9m/gh3cHddn47eiCqW2Dhzo9cGot3e6ugGpb3ugGi7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tj6n6P4e1Z/zfaklWN3vtLr1qhOLPTCnIpOG+oYeolnexxKa2zEDwSvPyzSxo9EEdndcV0VEXbL07YiJvhfj+/XfVRUT/jvAUiHRHD4x8WUXUDx20QasargEqxMZHo+xqVmTgFvJVaFBVprgbdZ4gxC1U6KdzL3g8PrcQaYpDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIc7BxFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIc7BxFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBA81F00A3D;
	Wed, 29 Jul 2026 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329807;
	bh=YlSERjOgRMeXswJSsUbU1dvx4ItP0YvrYxs3cTwez2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIc7BxFTYVhLNDZKe2E0lSlRQxzXo0e+rjMogZ5idqp5NYpZMLS35+hjWmyOhLO3s
	 k4gI8dIzkZF9kzSWPBAg+PItUYiQ1Q4wudBCcHZGjqEzhB4Sdi6KWCXLLIiyS5tbjN
	 kZKgPzBGiMp0PU0n+CehWB11zHODP2/O6mwMC3ujd6H+RNOjo7PAnewHqoKn07w6Gn
	 EN1IiSlZZ+FIKTm1ybvrNMjIdLMctBb1z8bb+1Lf4aNMsjRvfuEIH6fdZ7eCAopjW1
	 lCC1GKfRJKzzdlXmhg7gmiItsYQnF6aw+7nTVMEvO7znzhKEIkZZJBrZ5TSeq4y1JE
	 CZTgiDCc1k7XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/6] tools/perf: Add arch hook to drain remaining
 data before event close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729124400.65009-4-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
 <20260729124400.65009-4-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:56:46 +0000
Message-Id: <20260729125647.1CBA81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The main thread accesses worker thread mmaps via `record__final_da=
ta()` while worker threads are still actively polling, leading to severe da=
ta races and memory corruption.
--

--- Patch [3]: [PATCH V4 3/6] tools/perf: Add arch hook to drain remaining =
data before event close ---
commit 1746069e521d6537fd752aeade6ae6e917cfb5f9
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add arch hook to drain remaining data before event close

This commit adds a weak architecture hook, arch_perf_record__need_read(), to
indicate if more data needs to be collected before events are disabled and
closed. It introduces record__final_data() to perform an additional read pa=
ss
when the hook reports pending data. This allows architectures like powerpc
HTM to drain trace data and associated metadata.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e915390556752..e8ece174ba86e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[ ... ]
> @@ -2425,6 +2428,68 @@ static unsigned long record__waking(struct record =
*rec)
[ ... ]
> +static void record__final_data(struct record *rec)
> +{
> +	u64 last_bytes_written =3D 0;
> +	int retries =3D 0;
> +	int t;
> +#define FINAL_DATA_MAX_RETRIES 20  /* 20 * 1 ms =3D 20 ms max wait */
[ ... ]
> +	while (arch_perf_record__need_read(rec->evlist)) {
> +		if (drain_interrupted)
> +			break;
> +
> +		last_bytes_written =3D record__bytes_written(rec);
> +
> +		for (t =3D 0; t < rec->nr_threads; t++) {
> +			thread =3D &rec->thread_data[t];
> +			if (record__mmap_read_all(rec, true) < 0) {
> +				thread =3D &rec->thread_data[0];
> +				return;
> +			}
> +		}
> +		thread =3D &rec->thread_data[0];
[ ... ]
> @@ -2852,11 +2917,23 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
[ ... ]
>  		/*
>  		 * When perf is starting the traced process, at the end events
>  		 * die with the process and we wait for that. Thus no need to
>  		 * disable events in this case.
>  		 */
>  		if (done && !disabled && !target__none(&opts->target)) {
>  			trigger_off(&auxtrace_snapshot_trigger);
> +			record__final_data(rec);

[Severity: High]
Is it safe for the main thread to iterate over worker thread mmaps and call
record__mmap_read_all() here?

When --threads is enabled, worker threads are concurrently running
record__thread() and reading from their own mmaps:

tools/perf/builtin-record.c:record__thread() {
    ...
    if (record__mmap_read_all(thread->rec, false) < 0 || terminate)
        break;
    ...
}

Because record__final_data() is called here before record__stop_threads() is
called at the end of __cmd_record(), the main thread temporarily redirects =
its
TLS `thread` pointer to each worker thread's data and reads their mmaps.

Since the underlying mmap reads lack locking, this concurrent access to the
ring buffer boundaries (md->start, md->end, md->prev) could lead to data
races and corrupted perf.data events.

Could this concurrent access corrupt the ring buffer state, or is there some
other synchronization mechanism preventing the worker threads from reading
while record__final_data() runs?

>  			evlist__disable(rec->evlist);
>  			disabled =3D true;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729124400.6500=
9-1-atrajeev@linux.ibm.com?part=3D3
