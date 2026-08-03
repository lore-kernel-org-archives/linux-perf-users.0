Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99339479B
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748994; cv=none; b=sa9B8Z5sblHWNaCiTZ0LNTuMei+czrQPmTe9WSctoCCmqoSHpn9Mu9kOb7PPZRURT0Xx2KW+GQYMNxnPnfC9Ifd7pgrsW0avAoZJF2GoSbf5JgXCwvNCR8Brk9v8AsQ775p6kdEGqF6hSao6GQ0I+BqZXOmAAzRKPZQ3bMqPDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748994; c=relaxed/simple;
	bh=GkkTXhdIRx/Q4t1NqVClS0VG9Mkrpv7H9Txnp95iORM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbkS/qMmKS4aBYUcl4DOVC73kYAvqPPRmgybFrkoza7Oo+xcBHuszxmv4JYVvF0nN4b0JXOky+bmsMSIaCK2cgWKRzG7i/LnpLrtoQpd6H9J4O3a8G8NMG9bcho68QJe6PVa3aZNDPak11BEC3nvZqhg1roIL7gmTVxiJkmKYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OErqwEkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OErqwEkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5609F1F00A3A;
	Mon,  3 Aug 2026 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785748992;
	bh=/HY+FXRjmQUCMPRUxc1yNbYdq2TwQ7Bxt6jMBZtWTfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OErqwEkPRnxPEBu0/BtoeY49U+4KblmZKfeEJiN4U52J10udUsUaUU4+kHrzHSnAB
	 jvKgh8OVZPWkURqvU3B1LBMrI14njVEIYWBpOTac5qfppywrtPxOYs0GMX29rIZzqm
	 cCZoBWU34lmOAv2ZnDdj0jPnpEW8DQ3jy/5ShPxNvFb2Rs6uS751qH7jqSnvD+9Wf7
	 pOUq/pZY0PHs15TkxeV4yobNuO3kiq3CuuvFPE1KuszF2zjykjQkAHXNwPPljJMSDb
	 qkBxYoHWJVRR2nDNhRecmV2RR28uB5iUsO1OrGXwMAImxuLMiTgkbL0o2LfBmOYzcA
	 cnPxdKWOCXZ+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] perf cs-etm: Add branch history to existing samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803090640.2412336-6-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-6-aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:23:11 +0000
Message-Id: <20260803092312.5609F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Stale branch history is left unflushed for multiplexed trace IDs=
 when a queue is exhausted.
- [Medium] cs_etm__tracing_kernel only evaluates the exclude_kernel attribu=
te of the first matching cs_etm event.
--

--- Patch [6]: [PATCH 6/9] perf cs-etm: Add branch history to existing samp=
les ---
commit fed4660720fbc50c143c4ee374a10328c53686f9
Author: Amir Ayupov <aaupov@fb.com>

perf cs-etm: Add branch history to existing samples

This commit implements --itrace=3DL for CoreSight ETM to decode timestamped
trace up to each existing PMU sample and attach the branch history. It adds
virtual ETM timestamp correlation and keeps an internal reconstruction ring
deeper than the requested output depth to cover branches decoded between the
sampled IP and the recorded sample time.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4d895f11deb7f..048ff97caa936 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -2878,8 +2893,16 @@ static int cs_etm__process_timestamped_queues(stru=
ct cs_etm_auxtrace *etm)
>  		 * No more auxtrace_buffers to process in this etmq, simply
>  		 * move on to another entry in the auxtrace_heap.
>  		 */
> -		if (!ret)
> +		if (!ret) {
> +			/*
> +			 * The trace for this queue is exhausted. Drop any
> +			 * branch history so that samples arriving later
> +			 * cannot pick up entries decoded before the gap.
> +			 */
> +			if (etm->synth_opts.add_last_branch)
> +				thread_stack__flush(tidq->frontend_thread);

[Severity: Medium]
When an ETM queue (etmq) multiplexing multiple trace channels runs out of
auxtrace data blocks, is it sufficient to flush only the active trace ID?

Since this only flushes the specific tidq (from trace_chan_id) that was
popped from the min-heap, could other trace IDs sharing the exhausted queue
be skipped? This might leave stale branch history that could be incorrectly
attributed to PMU samples in a later trace window.

>  			continue;
> +		}
> =20
>  		ret =3D cs_etm__decode_data_block(etmq);
[ ... ]
> @@ -3011,6 +3034,116 @@ static int cs_etm__process_switch_cpu_wide(struct=
 cs_etm_auxtrace *etm,
>  	return 0;
>  }
> =20
> +static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
> +				   struct perf_session *session)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		if (evsel->core.attr.type =3D=3D etm->pmu_type)
> +			return !evsel->core.attr.exclude_kernel;

[Severity: Medium]
If the evlist contains multiple cs_etm events (such as one excluding kernel
and a later one including it), does returning on the first match prevent
subsequent events from being evaluated?

If a subsequent event includes kernel tracing, missing it here could lead to
an undersized internal branch reconstruction stack (br_stack_sz_plus), which
might cause branches leading up to the sample to be overwritten.

> +	}
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803090640.2412=
336-1-aaupov@fb.com?part=3D6
