Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5893101BF
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964107; cv=none; b=fLjJ4ORiZkMQA0WFwNhvjM+PRDgKyUhPpNcVyvvy7B2ShlkIS2EkpbHVJB5BE7esW8pGd/D/CIe1M0mO+LU4aKCHtoAUIPlKMUEs4iXcmSV9/VpGm/J/SmihYDBSQ+5PBQp7wwS+6VkBXtsOdzOw06plsA19wPLFp5NhckrgJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964107; c=relaxed/simple;
	bh=6NtitN4TER28/gv/JBfdkMmA3Jtkll+2YEI7AkaWPrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=grXMjo7PkGTyWbdVRAfpbDqKGV0t1XMH7EHDIYJlV1ZF2pi3iRxXbuHlt6BiqM5IapK3frksqOZJwu9rEN1LRvadceWUm1J2f4vLiMhjB7ukN+D/GofhH8FyWuu4/U0SsnE/cceSFjyiVn6zN9fETX9vt4na/tit04Mf//8pUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFV8TWL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFV8TWL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B11F1F00A3A;
	Sat, 25 Jul 2026 07:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964105;
	bh=Y9n6GkgLX63B6iyGfs55ZDyJNh4oa1AmFOmt7EgqZr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hFV8TWL7Z63979DfU6jVMPzbu9+hEINTFesKoF4XqtL2oyURNy1t+JIUpgB7xdED1
	 1MBujwWadvMKRMa08MP9j9lJ+pxVRmLNN+n7o7k1lDHVhXG58l6mVQvcr1P5WoOhBE
	 leKoeI4jdn6TGgpbad25KDXviZQEtGyc+x/0m/1IxxDf+zqokpnd2zWSIODDOyT2Fs
	 y3SiV3ClA1C7VNVqdJNQnkWzikTcu0b/bU5x3thbxSXCP3FAl3RblL/9ab5UjVrhkL
	 m7b5OWbWNfMrENHtqDhCQr7w5/ET8XO3J1XfJpMXa1EP7vFl8lHSdZQCwWW+YcsDAP
	 +pe/6ULMI3FFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/6] tools/perf: Add AUXTRACE recording support for
 powerpc HTM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725070747.81435-3-atrajeev@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-3-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:21:45 +0000
Message-Id: <20260725072145.9B11F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Concurrent use of VPA DTL and HTM auxtrace events silently drops H=
TM initialization, producing corrupted trace data.
- [High] System-wide and multi-CPU profiles fail to record CPU mappings for=
 all but the first CPU, causing decoding failures.
- [Medium] Missing explicit `<string.h>` inclusion for `strcmp()` breaks mu=
sl libc compilation.
- [Medium] Redundant `pos->name` NULL checks incorrectly skip valid unnamed=
 HTM events.
--

--- Patch [2]: [PATCH V3 2/6] tools/perf: Add AUXTRACE recording support fo=
r powerpc HTM ---
commit 00980957c6d482ec39e6aa18c32409446efcd20e
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add AUXTRACE recording support for powerpc HTM

This commit adds powerpc perf tool support for the HTM PMU AUXTRACE
recording path. It introduces initialization and callbacks to create
PERF_RECORD_AUXTRACE records for HTM data, populating mapping information
for decoding.

> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/po=
werpc/util/auxtrace.c
> index e04a0bd617557..74f0a37236b8f 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c

[ ... ]

> @@ -32,11 +34,18 @@ struct auxtrace_record *auxtrace_record__init(struct =
evlist *evlist,
>  			/* Remember the first matching VPA DTL event */
>  			if (!vpa_dtl_evsel)
>  				vpa_dtl_evsel =3D pos;
> +		} else if (pos->name && (!strcmp(evsel__pmu_name(pos), "htm"))) {

[Severity: Medium]
Since evsel__pmu_name() accurately identifies the PMU name regardless of
pos->name, does the pos->name check silently ignore valid HTM evsels that
might be created dynamically and lack a name?

Also, this code calls strcmp() but the file doesn't explicitly include
<string.h>. Will this break musl libc builds that strictly enforce POSIX
header inclusions without implicit dependencies?

> +			pos->needs_auxtrace_mmap =3D true;
> +			/* Remember the first matching HTM event */
> +			if (!htm_evsel)
> +				htm_evsel =3D pos;
>  		}
>  	}
> =20
>  	if (vpa_dtl_evsel)
>  		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
> +	else if (htm_evsel)
> +		return htm_recording_init(htm_evsel, err);

[Severity: High]
What happens if a user requests both VPA DTL and HTM auxtrace PMUs
concurrently?

It looks like the code will initialize VPA DTL and return immediately,
completely skipping HTM initialization. Since both had needs_auxtrace_mmap
set to true, will this result in HTM aux buffers being collected without
writing the required PERF_RECORD_AUXTRACE_INFO metadata, causing decoding
failures?

Should this explicitly reject concurrent auxtrace PMUs instead?

>  	return NULL;
>  }

> diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc=
/util/htm.c
> new file mode 100644
> index 0000000000000..9a12a8fe8027f
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/htm.c

[ ... ]

> +static int
> +htm_recording_options(struct auxtrace_record *itr __maybe_unused,
> +		      struct evlist *evlist,
> +		      struct record_opts *opts)
> +{
> +	struct evsel *pos;
> +
> +	opts->full_auxtrace =3D true;
> +
> +	if (!opts->auxtrace_mmap_pages) {
> +		opts->auxtrace_mmap_pages =3D KiB(128) / page_size;
> +		if (opts->mmap_pages =3D=3D UINT_MAX)
> +			opts->mmap_pages =3D KiB(256) / page_size;
> +	}
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (!pos->name || (strcmp(evsel__pmu_name(pos), "htm")))
> +			continue;

[Severity: Medium]
Similar to auxtrace_record__init(), does the pos->name check unnecessarily
skip unnamed events?

Additionally, strcmp() is used here without explicitly including <string.h>.
Could this cause compilation failures on musl libc systems?

> +		pos->core.attr.aux_watermark =3D
> +			opts->auxtrace_mmap_pages * (size_t)page_size / 2;
> +		pos->core.attr.freq =3D 0;
> +		pos->core.attr.sample_type |=3D PERF_SAMPLE_RAW;
> +		pos->needs_auxtrace_mmap =3D true;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +/* Count htm evsels in the evlist */
> +static int htm_nr_events(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +	int n =3D 0;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (pos->name && (!strcmp(evsel__pmu_name(pos), "htm")))
> +			n++;
> +	}
> +	return n;
> +}

[ ... ]

> +static int
> +htm_info_fill(struct auxtrace_record *itr,
> +	      struct perf_session *session,
> +	      struct perf_record_auxtrace_info *auxtrace_info,
> +	      size_t priv_size)
> +{

[ ... ]

> +	evlist__for_each_entry(evlist, pos) {
> +		struct perf_cpu_map *cpus;
> +		int cpu;
> +
> +		if (!pos->name || (strcmp(evsel__pmu_name(pos), "htm")))
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
When an event is opened system-wide or with multiple CPUs, will this loop
miss CPU mappings for all but the first CPU?

By extracting only index 0 from the perf_cpu_map, the resulting metadata
will lack mappings for CPU 1 and beyond. When the auxtrace decoder tries to
decode data from these additional CPUs, will it fail to find the required
event->auxtrace.cpu mapping?

Also, since htm_nr_events() only counts the number of evsels rather than
the total number of CPUs across the maps, would the priv array even be
large enough to hold metadata for all CPUs in a multi-CPU profile?

> +		else
> +			cpu =3D -1;
> +
> +		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     =3D cpu;
> +		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =3D
> +							pos->core.attr.config;
> +		n++;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725070747.8143=
5-1-atrajeev@linux.ibm.com?part=3D2
