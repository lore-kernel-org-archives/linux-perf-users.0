Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DB364929
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244717; cv=none; b=glhNJl97k2Wv/UBxVtWO0htW7jqIedMYYxiQqmrfOm8vzjhwi9nwxgGRtjfN0J63jLfreXrJ7AF97QxdU2c+JRYDPBtd2waPs9cW8LKLYhgz0WwLu/uR+cQVmQrWJnky63JhnM2Mvp8M7Eji304rxm4OYrDDZti8eWZLlNI4/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244717; c=relaxed/simple;
	bh=66Ohk2lvsyZn6O7DRqhJGtC60F6es8M07hqQuOH4Xnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=drTiP8epnejxQ5eqazA/nIt4JWEcqWU/FkLnluDHIZDT5Xk9UwXbz661xZrQIL6WKL9ro3HWUCN4hpoBoX0z1CvrPFxHLKBJtycahPaIohj6TLzBeeyC5VR4NOeVC2vUHzCxG1kKza9xvqHgM/SgEMTOR0SqvcnqvK0cE45+nGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctAHc5P6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctAHc5P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0451F000E9;
	Tue, 23 Jun 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244715;
	bh=wKS941ePgX6qlk2np1lQeVch0n6yN//gh4ZbW65nzH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctAHc5P6NKlxL+ev/PRSS2vZ9c55pcV+1jSGrCcPdXA7mq3/YwJ9Gfr2LAtg154KA
	 aYE3+lD+ZYLlTJ3pWEYvxEocdTeHzFJ+1tscwczVlu7QOw0n0YPiQq3qa63FBNCUUv
	 XKqF4sdGM52Y8R80/RJrF5VBsBx+/nbnBaF1cOfAm6T9PTl4FoU4czKVtMng+BWL+C
	 SEtJFoxVEUL5kALyKOHDtYxetq10PyUPQbdK5Swa9e8PQWwF4Bmh6S2a2DD8v+QViI
	 vbiJWBQ88zjx3TFfgIsO/VrDE9gmNPprwDb9YXh82iS3ziQZJH+ZC6YGcV0CFueZmt
	 z7Y9H7ewtdFmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-5-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-5-1ba770c862ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 19:58:35 +0000
Message-Id: <20260623195835.6C0451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Temporal and spatial violation causing global thread stack destruc=
tion on local queue replenishment.
- [High] Guest machine thread stacks are bypassed during flush when context=
 IDs are disabled (`CS_ETM_PIDFMT_NONE`).
--

commit 44f2b7bdbbeef1f4cf7936476255084d1e513f39
Author: Leo Yan <leo.yan@arm.com>
perf cs-etm: Flush thread stacks after decoder reset

This commit introduces a mechanism to flush all host and guest thread
stacks when the CoreSight decoder is reset due to trace discontinuities.
This is intended to prevent stale call/return histories from corrupting
synthesized callchains.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8798bf0471faf..7069b4990e610 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
[ ... ]
> @@ -1997,6 +1997,37 @@ static int cs_etm__end_block(struct cs_etm_queue *=
etmq,
> =20
>  	return 0;
>  }
> +
> +static int cs_etm__flush_stack_cb(struct thread *thread,
> +				  void *data __maybe_unused)
> +{
> +	thread_stack__flush(thread);
> +	return 0;
> +}
> +
> +static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t=
 pid)
> +{
> +	struct machine *machine;
> +
> +	machine =3D machines__find(&etmq->etm->session->machines, pid);
> +	if (machine)
> +		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);
> +}
> +
> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
> +{
> +	enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
> +
> +	if (!etmq->etm->synth_opts.last_branch)
> +		return;
> +
> +	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> +
> +	/* Clear the guest stack if virtualization is supported */
> +	if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID2)
> +		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);

[Severity: High]
Does this logic bypass populated guest machine thread stacks when tracing
with CS_ETM_PIDFMT_NONE on hardware where the kernel runs at EL1?

Looking at cs_etm__get_machine(), traces with exception level ocsd_EL1 are
assigned to the guest machine even when pid_fmt is CS_ETM_PIDFMT_NONE.

By restricting the guest machine flush strictly to CS_ETM_PIDFMT_CTXTID2
here, it seems these populated guest thread stacks are skipped during the
trace discontinuity flush, which could allow stale branch histories to
persist.

> +}
> +
[ ... ]
> @@ -2019,6 +2050,12 @@ static int cs_etm__get_data_block(struct cs_etm_qu=
eue *etmq)
>  		ret =3D cs_etm_decoder__reset(etmq->decoder);
>  		if (ret)
>  			return ret;
> +
> +		/*
> +		 * Since the decoder is reset, this causes a global trace
> +		 * discontinuity. Flush all thread stacks.
> +		 */
> +		cs_etm__flush_all_stack(etmq);

[Severity: High]
Could this global flush cause a temporal and spatial violation by destroying
thread states for events that haven't been processed yet?

When a local auxtrace queue runs out of data and triggers a read-ahead via
cs_etm__get_data_block(), it unconditionally calls cs_etm__flush_all_stack(=
).
Because CoreSight auxtrace operates using a min-heap to chronologically
interleave events across multiple independent CPU queues, events from other
queues are still chronologically sorted in the min-heap waiting to be
processed.

Iterating over machine__for_each_thread() and flushing all thread stacks
globally during the read-ahead phase of a single queue appears to
prematurely destroy the thread state for events that happened before the
discontinuity on the current queue, as well as for threads tracked by
other CPU queues.

Is it safe to perform this synchronous global flush ahead of the
chronological min-heap processing?

>  	}
> =20
>  	return etmq->buf_len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v7-0-1ba770c862ae@arm.com?part=3D5
