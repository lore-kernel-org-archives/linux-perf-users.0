Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214366;
	b=a0E/SgK4JcCi9ucu9WscDAC57fhLtUkbSMSIvBVv04GT7ZHD0Dsf34MYvF5Spo3yJkoV
	 29jHdtm77WKRXUb6I9RWlZxcFj1+UQ2NvPOfXln/CCaPsGCqK2RKmAyKazQ1K0W5g2Au+
	 iKmtq4M7VkeDgaODyqE9nUG8gQr59XCIUmBg4h7t2qko6FL37kLVb2OUJuxOwyrulYJ9W
	 752CIRRWrlzlEcvZspIOFEnpBVERSzQsf0M3bzUU56au06fCyk5vGW9SD+TDQOGGSKSXt
	 HxBHGjn9zGm1yrxsmehYq0jHe4HbNqsiusSP5WiZ4IVgi3M1g1I3FcHWlpbL5dm3o6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/uMI4T+wwViauszfHI5D/Ee66ZRFHydRgmnkAovies=;
	b=zXV0D8L940M7GIIvcc8EN3xAlYknRVfNC/O94S8oeO9MOAvlCZ9gDH8eURjAnq1wcipz
	 xj1cjrFAKacrc/EX8aGVgA0b4cpcm9RKiRmY+H59w12Xn86My9tL1w1RWFpJkYvlVY3yH
	 BbJ3t0M7dW/+28XCUgyiT50oEPTdOZbpjpOBqvgtgDPrJkJ/qgSZb3LrvKJT5VQX4W7Zw
	 O8fYIGhYgDKJBv2ak2ayvJgR2yf1QLVN/rb2luUR8Fpdd3VHCDtPGJtr7RszhUxWU+j4R
	 i8k/980g6AkszdlcmtOCDcld1Pz98u5y6rGKHeEvS+6HAnN4IXBHvy1kcIgmIDfiHbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIdxMqMw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B1606A6AA
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIdxMqMw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672E1F000C4;
	Fri, 20 Nov 2026 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214365;
	bh=w/uMI4T+wwViauszfHI5D/Ee66ZRFHydRgmnkAovies=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIdxMqMwKOfaCa77kaJFXqo4h+qORvm+6P2mG3U2Q9STxTD+qYOGndES/IZX1Z8wi
	 fIP9h3SD4ERYkeisvN9DIa6PeckWIFpyOM3ad0N4cNea2qg1erevno8c82tZ+EvYQa
	 WyjndhKlmITn5y1OXs7su50S64QTrZjlzxRfiyaTVv6YyAuZ+A6X5vXJTyQWggYrGS
	 WsfH0ngpUg5fWOhwwsRrqXGs16Twesao887/4YIuCd97U8k6vsRc9AZwU8gL7tI9m6
	 1eow5Dh4WZVJqsrtxz4XcjVuv2YTPQEKr7WR2HR/PF7h+/s/JMM7gdylX8vyWvUd/C
	 5gEmq14i51W4g==
Message-ID: <sashiko-outbox-226286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] perf pmu: Add perf_pmu__probe() for basic
 open, counting, and sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120222615.2291168-4-irogers@google.com>
References: <20261120222615.2291168-1-irogers@google.com>
 <20261120222615.2291168-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:39:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf pmu: try_open_attr_variants() closes tracepoint fd before
  keepalive
--

commit 000f6d2820c05383b074beef8f5d9879e6d9d78a
Author: Ian Rogers <irogers@google.com>

perf pmu: Add perf_pmu__probe() for basic open, counting, and sampling

This commit adds perf_pmu__probe() and struct perf_pmu::probed to probe a
live PMU via perf_event_open() and record whether opening, counting, and
sampling are supported.

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 1d3cfa0823475..b43afb8b155b3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
[ ... ]
> @@ -2850,9 +2866,570 @@ void perf_pmu__delete(struct perf_pmu *pmu)
[ ... ]
> +static bool try_open_attr_variants(struct perf_event_attr *attr,
> +				   bool is_uncore, int pmu_cpu,
> +				   unsigned long flags,
> +				   pid_t *out_pid, int *out_cpu,
> +				   int *last_err)
> +{
[ ... ]
> +				fd =3D sys_perf_event_open(&try_attr, pid, pmu_cpu, -1, flags);
> +				if (fd >=3D 0) {
> +					close(fd);
> +					*attr =3D try_attr;
> +					*out_pid =3D pid;
> +					*out_cpu =3D pmu_cpu;
> +					return true;
> +				}
[ ... ]
> +static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
> +{
[ ... ]
> +	/*
> +	 * For tracepoint events, closing the last fd for a tracepoint triggers
> +	 * tracepoint_synchronize_unregister() (an RCU grace period) in the
> +	 * kernel. Hold one disabled fd open across the probe sequence so
> +	 * tp_event->perf_refcount stays >=3D 1 and each probe open/close is
> +	 * instantaneous.
> +	 */
> +	if (pmu->type =3D=3D PERF_TYPE_TRACEPOINT) {
> +		struct perf_event_attr ka_attr =3D base_attr;
> +
> +		ka_attr.disabled =3D 1;
> +		keepalive_fd =3D sys_perf_event_open(&ka_attr, pid, cpu, -1, flags);
> +	}

[Severity: Low]
Does closing fd inside try_open_attr_variants() defeat the tracepoint
keepalive optimization?

When try_open_attr_variants() closes the initial tracepoint fd before
keepalive_fd is opened, tp_event->perf_refcount drops to 0 in
perf_trace_event_unreg(), paying the tracepoint_synchronize_unregister()
RCU grace period and freeing the per-CPU tracepoint buffers before
__perf_pmu__probe() re-opens the same disabled attr as keepalive_fd.
Returning the open fd from try_open_attr_variants() to use as
keepalive_fd (or closing it when pmu->type !=3D PERF_TYPE_TRACEPOINT) would
avoid the extra RCU grace period and redundant perf_event_open() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120222615.2291=
168-1-irogers@google.com?part=3D3
