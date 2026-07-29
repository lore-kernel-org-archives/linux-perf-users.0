Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624F488DA7
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330125; cv=none; b=nkRBSNgPlPhJ565Cy1QX/2fBjGxCfsfxdEy1aE0OIXpf/0kml9uncrMZce+Foo9n86C+qJ3e+CEeit+uaJGscjb/bpc4X1tHB/G2j2rTXblqtmOEZgieRrYYhayOkYHdPwVG6lb41NO1d/rQ6ZCKi3UmPKq9dK3GBpFVtyP90eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330125; c=relaxed/simple;
	bh=qtk10SpX6Y8XKtmt1Y+WO7Nr4yPehygOHtRCjrzgUbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/qwWEcnKO9IjQFIlRSs1HO2Jwg/ROIgSQaoYRm3FIUGT2fwNye5bctAz61rMbK7jDBRAWxTT2lsxOZy4PwGj84JmKqlRhibOFPzocYfx2P7mq2Yubsze3mQ2XBfNEMI72EcAyMjUudOO4/8yLktgAncINpXxUG9e/VOVgBPZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW4EOaC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW4EOaC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DF51F00A3E;
	Wed, 29 Jul 2026 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330122;
	bh=K7wVxcQ8qbSkJlUG0u4I078FPRZpp89e4Pk1n6aHMSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZW4EOaC56BjXX4vUx2lkTk6gIy0u6qyymoxQi+Bx52ylRljXg+HVS/IEsLLGo72E6
	 qPHu38UIw/l2wY29172Bh+G0VGPBeS+/QHfRzPMW+BRGHJy+KxGpsP1D5VkAzIxWe6
	 XiFnKM7oeaDVWhR56EMjK55+G641ZgwlgplybkyS4Y9Nb36qJMptcbzLCGUFU6/jE/
	 V37cd1nMNl7mK9cBV4EkKkhPpug/2BCW1g2lWEYUsoSGBo4l+1U+SVOAp629sBCHt+
	 xCxtibS9BBJ2yDWA4MMR8pYC2Y4n1SrtaLFXmj7RZ+bZ3RhtrsMGqvLyzlmPVJs004
	 heBwrQRXuuysw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729124400.65009-3-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
 <20260729124400.65009-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:02:01 +0000
Message-Id: <20260729130202.39DF51F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] htm_info_fill() and htm_nr_events() only record the mapping data f=
or the first CPU in a multi-CPU evsel map, causing AUX buffer decoding to f=
ail for all other CPUs.
- [High] The aux_watermark calculation can silently overflow a 32-bit integ=
er when large AUX buffer sizes are requested, corrupting the synchronizatio=
n watermark.
- [Low] Missing explicit inclusion of POSIX <string.h> header for strcmp() =
usage, violating musl libc compatibility guidelines.
--

--- Patch [2]: [PATCH V4 2/6] tools/perf: Add AUXTRACE recording support fo=
r powerpc HTM ---
commit 5b630f123328eb3828ca515d55d6bec2c77c6ef7
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add AUXTRACE recording support for powerpc HTM

Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.
Introduce htm_recording_init() and the associated auxtrace callbacks so
perf record can create PERF_RECORD_AUXTRACE records for HTM data.

> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/po=
werpc/util/auxtrace.c
> index e04a0bd617557..c77ffc4c6a9d7 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
[ ... ]
> @@ -32,11 +34,30 @@ struct auxtrace_record *auxtrace_record__init(struct =
evlist *evlist,
>  			/* Remember the first matching VPA DTL event */
>  			if (!vpa_dtl_evsel)
>  				vpa_dtl_evsel =3D pos;
> +		} else if (!strcmp(evsel__pmu_name(pos), "htm")) {

[Severity: Low]
Should the POSIX <string.h> header be explicitly included in this file
to provide the declaration for strcmp()?

> +			pos->needs_auxtrace_mmap =3D true;
> +			/* Remember the first matching HTM event */
> +			if (!htm_evsel)
> +				htm_evsel =3D pos;
> +		}
>  	}
> =20

> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc=
/util/htm.c
> new file mode 100644
> index 0000000000000..7757f548ef22c
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/htm.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HTM AUX tracing support
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/string.h>

[Severity: Low]
Should the POSIX <string.h> header be explicitly included here to avoid
relying on implicit inclusion via the kernel wrapper for musl compatibility?

> +#include <linux/zalloc.h>
[ ... ]
> +	evlist__for_each_entry(evlist, pos) {
> +		if (strcmp(evsel__pmu_name(pos), "htm"))
> +			continue;
> +		pos->core.attr.aux_watermark =3D
> +			opts->auxtrace_mmap_pages * (size_t)page_size / 2;

[Severity: High]
Can this calculation silently overflow when large AUX buffer sizes are
requested?

The result of this 64-bit size calculation is assigned directly to the 32-b=
it
aux_watermark field without being clamped to UINT_MAX.

> +		pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
> +		pos->core.attr.freq =3D 0;
[ ... ]
> +	evlist__for_each_entry(evlist, pos) {
> +		struct perf_cpu_map *cpus;
> +		int cpu;
> +
> +		if (strcmp(evsel__pmu_name(pos), "htm"))
> +			continue;
> +
> +		/*
> +		 * Get the CPU this evsel is pinned to.  For events opened
> +		 * with cpu=3DN, evsel__cpus() returns a single-entry map {N}
> +		 * at record time (not during replay).
> +		 */
> +		cpus =3D evsel__cpus(pos);
> +		if (cpus && perf_cpu_map__nr(cpus) > 0)
> +			cpu =3D perf_cpu_map__cpu(cpus, 0).cpu;

[Severity: High]
Does this logic silently discard the configuration mapping for all CPUs
in the map beyond the 0th index?

This function explicitly extracts only perf_cpu_map__cpu(cpus, 0). Earlier =
in
htm_nr_events(), the array is sized based on the number of evsels rather th=
an
the total number of CPUs:

tools/perf/arch/powerpc/util/htm.c:htm_nr_events() {
    ...
	evlist__for_each_entry(evlist, pos) {
		if (!strcmp(evsel__pmu_name(pos), "htm"))
			n++;
	}
	return n;
}

Are multi-CPU mappings missing the necessary space and data to be fully
recorded?

> +		else
> +			cpu =3D -1;
> +
> +		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D cpu;
> +		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
> +							pos->core.attr.config;
> +		n++;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729124400.6500=
9-1-atrajeev@linux.ibm.com?part=3D2
