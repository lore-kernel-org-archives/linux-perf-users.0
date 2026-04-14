Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24C3E638C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173275; cv=none; b=YbDKO5OdaBsR85pGo+DnQ+Wc7MT5ChoiZyfd0ZDF1nOHUyM1vqjlJfcN3+52L9EtEZ7BNlNbIdMCi2aB2qkLvlN+zgR8ROPvEGUtgYPeXG9zCNHYQDWoo30HtLYGuV35c2URzHmUraxw0FiEhhhKAE2LrIbUG/+L/DG8I82vcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173275; c=relaxed/simple;
	bh=8cimOyQXEOLpYXMuain/Jb88TjxM356wW9d3DyWnHF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RaE339CoKXVdJG50xCUCMMsZ1hf7GfwsLinLjfF5aw8jiWgBGTluIuimVGh7WiuC0k6tfKKq8sc8ovRcGLrzTD2bYDO3MxCYmjrHNu3s0svM5OuutH4Bh/tqheRiPpToFSpoB24jBDwWQFf70OWMN6qIbVRdLM4a/Hc9Y66+vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIzF4XxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIzF4XxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BCDC19425;
	Tue, 14 Apr 2026 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173274;
	bh=8cimOyQXEOLpYXMuain/Jb88TjxM356wW9d3DyWnHF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uIzF4XxKMWHtQ5HTqzEaAYm/Nh7KkgMk3YR2jMtrQDg4xyvexBja1xQUeJrTxCuP5
	 rjMohnQz90AZLzRNyYU0kjc+k1i8mydZybjOFYLEzpFS5OUB5iGPBds5ZpkM0hsLmY
	 YYIeyRmVKiMFfi6kzTjDR8b4NojAFmBi8wbKPX6TaCjGfOd9IHd8GAgd47frfn8Vc4
	 s++htorabWYaDP3cRYOFnzWRL+WDghHDj+gYBcamHAiOrJVh7zSfo4PDrPPVrcZL+T
	 OhPdgqU44AfcZxUL1491yIACfHuORv+3+ZrFUlieZdwMseotxYyKYETFwW6gP3bHHR
	 1Nrj4RVWyubkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf arm_spe: Store MIDR in arm_spe_pkt
Reply-To: sashiko@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414-james-spe-impdef-decode-v3-3-63baf9c893b1@linaro.org>
References: <20260414-james-spe-impdef-decode-v3-3-63baf9c893b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 13:27:54 +0000
Message-Id: <20260414132754.90BCDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unconditional calls to `arm_spe__get_midr()` with an unknown CPU=
 (-1) cause massive un-ratelimited `pr_err` console spam on heterogeneous s=
ystems when decoding per-thread traces.
--

commit 1f340d9a2571e040cbd5dd8740efe18dff0e27aa
Author: James Clark <james.clark@linaro.org>

perf arm_spe: Store MIDR in arm_spe_pkt

This patch stores a copy of the MIDR in the arm_spe_pkt structure to
affect the printing of arm_spe_pkts in raw dump mode, and additionally
updates the decoder to contain the MIDR.

> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index f9188fdb8e786..ed4515fef2de3 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c

[ ... ]

> @@ -302,8 +305,10 @@ static void arm_spe_set_pid_tid_cpu(struct arm_spe *=
spe,
> =20
>  	if (speq->thread) {
>  		speq->pid =3D thread__pid(speq->thread);
> -		if (queue->cpu =3D=3D -1)
> +		if (queue->cpu =3D=3D -1) {
>  			speq->cpu =3D thread__cpu(speq->thread);
> +			arm_spe__get_midr(spe, speq->cpu, &speq->decoder->midr);

If the thread's CPU is unknown, can thread__cpu() return -1 here?

If so, could this cause arm_spe__get_midr() to fail and print un-ratelimited
errors (such as "Failed to get MIDR for CPU -1") on heterogeneous systems?
Because arm_spe_set_pid_tid_cpu() is called for trace chunks in the queue
processing loop, would this flood the console with errors?

> +		}
>  	}
>  }
> =20
> @@ -1248,6 +1253,7 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
> =20
>  	if (queue->cpu !=3D -1)
>  		speq->cpu =3D queue->cpu;
> +	arm_spe__get_midr(spe, queue->cpu, &speq->decoder->midr);

In per-thread recording mode, queue->cpu can be -1. Does calling
arm_spe__get_midr() unconditionally with -1 result in the same console spam
mentioned above?

> =20
>  	if (!speq->on_heap) {
>  		int ret;

[ ... ]

> @@ -1490,8 +1496,11 @@ static int arm_spe_process_auxtrace_event(struct p=
erf_session *session,
>  		/* Dump here now we have copied a piped trace out of the pipe */
>  		if (dump_trace) {
>  			if (auxtrace_buffer__get_data(buffer, fd)) {
> +				u64 midr =3D 0;
> +
> +				arm_spe__get_midr(spe, buffer->cpu.cpu, &midr);

Similarly, can buffer->cpu.cpu be -1 here, leading to the same console issue
when processing raw buffers?

>  				arm_spe_dump_event(spe, buffer->data,
> -						buffer->size);
> +						   buffer->size, midr);
>  				auxtrace_buffer__put_data(buffer);
>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-james-spe-=
impdef-decode-v3-0-63baf9c893b1@linaro.org?part=3D3
