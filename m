Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FA199385
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693951; cv=none; b=LY6H6IsOE19X8LOCy9GqGx8bG7KsZeD+2jCxU42vRThCCeqZ8Rq8evwtogcBP849GyCwz2EaV2zNaVS0nAsuvOpIb9JtkdTnSVksXpYi4vt1B6rvMitKC8/TfznR5gHfeEzMFlR6WD0hP2T2HZ/1GfPePz85kDVnW2bmTYEWRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693951; c=relaxed/simple;
	bh=fCqeU1cOJtLL69TZwtsJPdeG6WjwHZLj5WutjYqB+lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dAWL6ex8846HOEXLxvLe8yQPhR6MdAf4b2Qup/AEQh2mXRBMWY/cMmDjIaPL1naQKF20ALZz0qjELb+Hpb7EkWOPTnXFyif2nPpiyddj3CQaFkUOR5uZAv/HWZx0Nbg2rm2pDuJWFpcnh2/Z3Vf0V9tjlR1nkq6mT9x+MSLXxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o11FhDMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o11FhDMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B370A1F00893;
	Fri,  5 Jun 2026 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780693949;
	bh=GqQRZiZxy3FrzYKkdXakqfIOxHjlqKbT00n8U1SEG2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o11FhDMm1QdxDmS3BZX0l1situ0/V/xrD530WquPOfzrzz2PzQRoGCWlIAETqGJgi
	 ZBOjB2/0P8JQ+jXnhxWgYD1aBFyO/SF0VmmbXpurrFmpXVLo6tvnLZRZM33J/9XnbN
	 WAXcdJaltQk5dio/t36P63JiwroMFxRLUnIR/GNrRYwGLB6lI8aAtKKc2tbwDwp+EU
	 0nDjGAmJTMPKNWInD+UM0Ps9rjezmqlTXcMbQUFM7La3e6ZdBB03T2T4PwMg64qKAv
	 wzUs2RqI1Sb5AloG0ExRqzyOmBf/v7s8m6Dd0p0tnHRjhaOIPHcKBuq11bwljQUcpG
	 rh02vG2nu61tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605205649.2566948-3-irogers@google.com>
References: <20260605205649.2566948-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:12:29 +0000
Message-Id: <20260605211229.B370A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The ASLR tool fails to remap the `pgoff` field for user-space anon=
ymous `MMAP` and `MMAP2` events, leaking original randomized virtual addres=
ses.
- [High] The tool leaks kernel ASLR addresses through unhandled `kprobe_add=
r` and `kprobe_func` fields in `perf_event_attr`.
--

commit 5f7118d61e85f58390f8e97238a20e6193ea5f8d
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

If perf.data files are taken from one machine to another they may
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add an aslr option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

This patch introduces the core ASLR remapping tool infrastructure and
implements remapping/tracking for metadata events (MMAP, MMAP2, COMM,
FORK, EXIT, KSYMBOL, TEXT_POKE). Sample events are delegated without
remapping for now.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 75ffe31d03fea..65c7eccccf4d2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -2923,12 +2963,25 @@ int cmd_inject(int argc, const char **argv)
> =20
>  	ret =3D __cmd_inject(&inject);
> =20
> +	if (inject.aslr) {
> +		struct evsel *evsel;
> +
> +		evlist__for_each_entry(inject.session->evlist, evsel) {
> +			evsel->core.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +
> +			if (evsel->core.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
> +				evsel->core.attr.bp_addr =3D 0;

[Severity: High]
Does this code leak kernel ASLR addresses through unhandled kprobe_addr and
kprobe_func fields?

For dynamic PMUs like perf_kprobe and perf_uprobe, attr.type is assigned a
dynamic identifier rather than a fixed constant like PERF_TYPE_BREAKPOINT.
The perf_event_attr struct utilizes the same config1 and config2 union fiel=
ds
to store kprobe_func/uprobe_path and kprobe_addr/probe_offset.

If this only checks for PERF_TYPE_BREAKPOINT, it fails to scrub these union
fields for kprobe events, which could leak exact kernel ASLR addresses and
perf record process pointers into the output perf.data file's attribute
headers.

> +		}
> +	}
> +
>  	guest_session__exit(&inject.guest_session);

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..4b4b00b4d52d9
> --- /dev/null
> +++ b/tools/perf/util/aslr.c
[ ... ]
> +static int aslr_tool__process_mmap(const struct perf_tool *tool,
> +				   union perf_event *event,
> +				   struct perf_sample *sample,
> +				   struct machine *machine)
> +{
[ ... ]
> +	/* Remaps the mmap.start. */
> +	new_event->mmap.start =3D aslr_tool__findnew_mapping(aslr, thread, cpum=
ode,
> +							   event->mmap.start,
> +							   event->mmap.len,
> +							   event->mmap.pgoff);
> +	if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL || cpumode =3D=3D PERF_RECOR=
D_MISC_GUEST_KERNEL)
> +		new_event->mmap.pgoff =3D new_event->mmap.start;

[Severity: High]
Does this fail to remap the pgoff field for user-space anonymous MMAP event=
s,
potentially leaking original randomized virtual addresses?

The Linux kernel's perf_event_mmap_event() function unconditionally sets
pgoff =3D (u64)vma->vm_pgoff << PAGE_SHIFT for all mappings. For anonymous
mappings ([anon], [stack], [heap]), vma->vm_pgoff is initialized as
addr >> PAGE_SHIFT, meaning pgoff literally contains the original randomized
virtual address.

If pgoff is copied verbatim from the original event for user-space mappings=
, it
could directly leak the original ASLR addresses into the output perf.data f=
ile.

> +	err =3D delegate->mmap(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}
> +
> +static int aslr_tool__process_mmap2(const struct perf_tool *tool,
> +				    union perf_event *event,
> +				    struct perf_sample *sample,
> +				    struct machine *machine)
> +{
[ ... ]
> +	/* Remaps the mmap.start. */
> +	new_event->mmap2.start =3D aslr_tool__findnew_mapping(aslr, thread, cpu=
mode,
> +							    event->mmap2.start,
> +							    event->mmap2.len,
> +							    event->mmap2.pgoff);
> +	if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL || cpumode =3D=3D PERF_RECOR=
D_MISC_GUEST_KERNEL)
> +		new_event->mmap2.pgoff =3D new_event->mmap2.start;

[Severity: High]
Can this similarly leak original randomized virtual addresses for MMAP2 eve=
nts?

Like with aslr_tool__process_mmap() above, skipping the pgoff remapping for
user-space anonymous mappings here leaves the original ASLR addresses
unmodified.

> +	err =3D delegate->mmap2(delegate, new_event, sample, machine);
> +	thread__put(thread);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605205649.2566=
948-1-irogers@google.com?part=3D2
