Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765028E0
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226023; cv=none; b=p3k4oHT171Tpx0uYsOH4gHmKzSP7XWBoWITE1QmyMSnL9n+3v1+VQVxTP8ufsA4nbQPbaSGmCcvsNe2otpGPESLzVZhuCPBVfqokcZx1szfg4Fw2OVSY7fZj8klI5uvFujIneuItMXCdce4hnMJ2PzDLhVis4ZzrjjIEZN6RGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226023; c=relaxed/simple;
	bh=we58/qI5XX8Bn8DX0r7EEIvCxAxCu/VoAvDMXtjw8iM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FyKj4Go2LGa6SOiiqofRmADs8ZjLbG5mP5Td17JOsm45vwjVeaWCkrfCJdh4hkbh9RY0fO3b2Oed6W50S41mKoCsbRH9xBEdXA81eTFDWCNbMrSJq670uGG8ykesJSLrKHNfkZ03E4Wfmju2E1LXGcamSautW2a41Y9newZ37ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dralPmFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dralPmFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFF21F000E9;
	Fri, 12 Jun 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781226021;
	bh=l/VlHXPzUWPENQqREHyKmMhVEBS7zeznC3Qn2bO1uzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dralPmFsTrs4pezQcSONjloWF2p2ngmq6SvVHWAWeHRYhEHgKAKXOLSOP2jTwwQkl
	 4wPRyJVOu93uOiiOD5hMq/EXQFieSYHNkx//c7x2i8b5uvRrqqbrEId9zowIc2GHTF
	 8p3vN7sCf63exzH6lo75QPpCCVA8nX8xw0w1Pg8An5/bTJzulEZ6Fje+mev+WJBhtk
	 tVFkdWyh1glteacTKaYxuAmC9BKTnoEZig8dyQT2WFe2Crh7OdaW5YbJDhxLJm/DHl
	 RTENh623PL/KRCwt8iY/dPztcyWZ6Ge5tQLhLDUUshM95i6sF6nXvdlJ5D4RMT88Wo
	 jDhvopu5R4eKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] perf cs-etm: Reject CPU IDs that would overflow
 signed comparison
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-16-acme@kernel.org>
References: <20260612003444.50723-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:00:21 +0000
Message-Id: <20260612010021.ADFF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The new bounds check allows `INT_MAX`, resulting in undefined be=
havior via signed integer overflow when calculating `max_cpu + 1`.

Pre-existing issues:
- [Critical] The calculation `sizeof(*metadata) * num_cpu` wraps around on =
32-bit architectures, leading to a zero-sized allocation and massive out-of=
-bounds heap write.
- [High] Global metadata attributes are accessed from the event payload bef=
ore verifying that the event buffer is large enough.
- [High] Unvalidated `sample.cpu` index leads to an out-of-bounds array acc=
ess in `cs_etm__get_queue()` when triggered by `PERF_RECORD_AUX_OUTPUT_HW_I=
D` events.
--

commit bc723e7a90a3b64c38ed57e3f771d57c18e1dc9d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Reject CPU IDs that would overflow signed comparison

This commit fixes an out-of-bounds access in
cs_etm__process_auxtrace_info_full() caused by a cast from u64 to int. It
adds a validation check to ensure the CPU ID fits within an int before
performing a signed comparison against max_cpu.

Cc: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/2

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5e92359f51a7c..d8876b8362056 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -6,6 +6,7 @@
>   * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>   */
> =20
> +#include <limits.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/coresight-pmu.h>

[ ... ]

> @@ -3468,7 +3469,13 @@ int cs_etm__process_auxtrace_info_full(union perf_=
event *event,
>  			goto err_free_metadata;
>  		}
> =20
> -		if ((int) metadata[j][CS_ETM_CPU] > max_cpu)
> +		/* CPU id comes from perf.data and must be a valid index */
> +		if (metadata[j][CS_ETM_CPU] > INT_MAX) {
> +			err =3D -EINVAL;
> +			goto err_free_metadata;
> +		}

[Severity: Medium]
Does this upper bound check still allow max_cpu to become INT_MAX?

If the trace provides exactly INT_MAX, max_cpu is set to INT_MAX. Later in
cs_etm__process_auxtrace_info_full(), it calls:

    err =3D auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);

Will computing INT_MAX + 1 cause a signed integer overflow?

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential calculation overflow
earlier in cs_etm__process_auxtrace_info_full():

    num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
    metadata =3D zalloc(sizeof(*metadata) * num_cpu);

On 32-bit platforms, could a crafted num_cpu (e.g., 1073741825) cause the
multiplication to wrap around to 4? If zalloc() succeeds with a tiny buffer,
wouldn't the subsequent loop:

    for (int j =3D 0; j < num_cpu; j++) {
        ...
        metadata[j] =3D cs_etm__create_meta_blk(...);

continuously write out-of-bounds into the undersized allocation?

[Severity: High]
This is a pre-existing issue, but is it possible to read past the end of the
event payload before its size is fully validated?

In cs_etm__process_auxtrace_info_full():

    ptr =3D (u64 *) auxtrace_info->priv;
    num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;

Since the initial perf_record_auxtrace_info size check only guarantees
16 bytes, and priv[] starts at offset 16, accessing ptr[CS_PMU_TYPE_CPUS]
reads from offset 24.

Could this access unmapped memory if the event is truncated?

[Severity: High]
This is a pre-existing issue, but is there an unvalidated index used for
queue array lookups?

When processing PERF_RECORD_AUX_OUTPUT_HW_ID events, sample.cpu is parsed
directly from the payload. It gets passed down the call chain:

cs_etm__process_aux_output_hw_id()
  cs_etm__process_trace_id_v0_1()
    cs_etm__get_queue()

Inside cs_etm__get_queue():

    return etm->queues.queue_array[cpu].priv;

Since cpu comes directly from the trace data, could an arbitrarily large or
negative value cause an out-of-bounds read if it exceeds nr_queues?

> +
> +		if ((int)metadata[j][CS_ETM_CPU] > max_cpu)
>  			max_cpu =3D metadata[j][CS_ETM_CPU];
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D15
