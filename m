Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62F30C15C
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595150; cv=none; b=FrsUYLeMIxm3hL3Zpo9hfpGW/F1MEYizO99+TEEEdDcee/JIO12oO+8WYgn+fbzDh+hHrzkavfhr4pRMx1vzIopGLmHCnu7A3bJy8u15y/ORXA5z35rxU4o4OZDW1AAXprHndWF2dhDrR+WocGyX5PLewMBqTtTgrfXWhckAHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595150; c=relaxed/simple;
	bh=ALDDQroqqA0PPfb2nqvKO5/LJlz2DEkI2YP/5YSZrLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8YroM/HSUsVufmwdIFI16MPJ3hp4E9iCmdarjv4Xmt9QCLtVIMbbRSqqH8ZuBvdrgkUNmt8mVHKLGbIgwCE0iDAYv+FWwd+FO7nj++P9Nsa7HTsKRgokTt64nrrsVp1/iYOntp4PfFVwkzbd7t/EN/sLvUv8YBrLaGt2TdbpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDehG3Kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDehG3Kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF3C1F00893;
	Thu,  4 Jun 2026 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595148;
	bh=TeBLTFLGiw0KUfehHh2vKh9/hVLx+P54A+MCa3nVdIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDehG3KvDLk89gWbVvjQTO5B3SM+6d9tEV9tmWRMWld6Kr5/8WRlmpf5pUfsYq7zb
	 KLHwigpYiF6p60Iaftk0WWxlp8XAoqo/FEzPpxU0yPpL8Qq2btecNIcrL4sCy597pz
	 BWUKyFrWGNPL3asowStjpDIZntIbawx0qWWOib+Aq44yBqhmyv2O0HIKsIkAoIXjq4
	 31QtuBjFlc/DAJP2A/b8YdgB9tJtg3QL5utAvmFtu5dVSBc1QI38dIZtXpSjwez63a
	 5ZPrSQW6kSVNVTrJUvaDNf1Yi641V1yw2ciHofPEsqttAQ6VZlrO8AhOL60VS4Xufz
	 qjt4Se32NlKCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604172850.683329-4-irogers@google.com>
References: <20260604172850.683329-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:45:48 +0000
Message-Id: <20260604174548.CAF3C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Direct access to fields of the reference-counted `struct thread` b=
reaks the build when `REFCNT_CHECKING` is enabled.
- [High] Double-swapping of `PERF_SAMPLE_BRANCH_STACK` flags corrupts branc=
h data when analyzing cross-endian perf.data files.
--

commit 22641fe8dc789606c2c20387f60f64010f88923f
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This commit adds the sample address remapping logic to the ASLR tool. It
parses sample events and remaps IPs, ADDRs, callchains, and branch stacks
using the mappings collected from metadata events.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index be7280f884308..fc619b9f1f40a 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
> @@ -109,6 +109,60 @@ static u64 round_up_to_page_size(u64 addr)
>  	return (addr + page_size - 1) & ~((u64)page_size - 1);
>  }
> =20
> +static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
> +				    struct thread *aslr_thread,
> +				    u8 cpumode,
> +				    u64 addr)
> +{
[ ... ]
> +		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
> +			addr_location__exit(&al);
> +			return 0; /* No mmap. */
> +		}
> +	}
> +
> +	key.machine =3D maps__machine(aslr_thread->maps);
> +	key.dso =3D map__dso(al.map);
> +	key.invariant =3D map__start(al.map) - map__pgoff(al.map);
> +	key.pid =3D (effective_cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> +		   effective_cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) ?
> +		  kernel_pid : aslr_thread->pid_;

[Severity: High]
Will this direct field access break the build when REFCNT_CHECKING is enabl=
ed?

When perf is built with REFCNT_CHECKING=3D1 for ASAN or LSAN builds, the th=
read
struct is wrapped in an opaque pointer, hiding the actual fields. Direct ac=
cess
to maps and pid_ usually causes compilation failures under these builds.=20
Should this use the proper thread__maps() and thread__pid() accessors inste=
ad?

> @@ -554,13 +608,399 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
>  				     struct perf_sample *sample,
>  				     struct machine *machine)
>  {
[ ... ]
> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +		u64 nr;
[ ... ]
> +		for (u64 cntr =3D 0; cntr < nr; cntr++) {
> +			out_array[j++] =3D aslr_tool__remap_address(aslr, thread,
> +								  sample->cpumode,
> +								  in_array[i++]); /* from */
> +			out_array[j++] =3D aslr_tool__remap_address(aslr, thread,
> +								  sample->cpumode,
> +								  in_array[i++]); /* to */
> +			out_array[j++] =3D in_array[i++]; /* flags */
> +		}
[ ... ]
> +	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);
> +
> +	perf_sample__init(&new_sample, /*all=3D*/ true);
> +	ret =3D evsel__parse_sample(evsel, new_event, &new_sample);

[Severity: High]
Does this second call to evsel__parse_sample() corrupt branch stack flags
when analyzing cross-endian perf.data files?

The initial event processing loop calls evsel__parse_sample() on the origin=
al
event, which mutates the event array in place by swapping the branch stack
flags.=20

When the already-mutated, native-endian payload is copied into new_event he=
re,
calling evsel__parse_sample() a second time will bitfield-swap the flags
again. Does this inadvertently restore the original foreign-endian layout a=
nd
feed corrupted branch flags to the downstream delegate tool?

> +	if (ret) {
> +		perf_sample__exit(&new_sample);
> +		goto out_put;
> +	}
> +
> +	new_sample.evsel =3D evsel;
> +	ret =3D delegate->sample(delegate, new_event, &new_sample, machine);
> +	perf_sample__exit(&new_sample);
> +
> +out_put:
> +	thread__put(thread);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604172850.6833=
29-1-irogers@google.com?part=3D3
