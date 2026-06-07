Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109C2DF12F
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820856; cv=none; b=JgpHow7xczEv0csY0thqqlJCcyyy6QhXV1b3mFEyLgy5sQ7BFtEf3s+q36q2NeJwilAPCorUbvvdUHuoPmUHn/ETHQPMvhAJ4w/8vgvm7JytO6etr5bbC9VC/2Ch6OKzrgJMZAjZJId5bANIkzA46rrqwfgGggFEc3Xobqc6QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820856; c=relaxed/simple;
	bh=HSLaawaQgC+elrDEtYVg5OaBd9ThyBTLgNjIT/o/8mo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJGVaZbZ6mXfYCUt7zpaa+6GSFj17JPxj2wY8k3g+S1X0rSl8pfZtH5TgrpPbjprW0Nm/i3PwAe37nILZXEVVx4fyrYY+qR3/pfvy55Et9x4k9SPUSIn7u4yozvxHkCmC0AiluFjJb7Lo1ERcepgsFKkRkpgAmKceFh46gO3iIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVYtg4zG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVYtg4zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE7A1F00893;
	Sun,  7 Jun 2026 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780820854;
	bh=TMiB+E5WEyjQak2jyIxTguTud/+39/BFo9nRL27BtIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aVYtg4zGykU1M5mpHIi//AHevU3smnPbOfMOdA9XiTwTYSeKryMZ+0NF8Dv7CQd31
	 2GxX/XZHMmh8fGX4ymnJP+GRTQpw6Qnv6eUzU73CnenwMVpWwkfcNi+T2wBl1gb4in
	 Wqs5RG5JF2MaygiE5LEpCuSZ0ze//zxwTPljZqOFm9G6n3ivp01L5aNtjARMHfFey8
	 ziCqZFxtFZjJsyB54o+6sC4P1SaYl0hwwa31XZZdP3zQUShKk7toiZijC6rWb/lrCv
	 Kc8OGTpdb+Da0Vg4/9LYYVKBdQ6IrleRPgDTmeHdpW/gK8wYXwoXhV2hkoOYXpNZay
	 9xQfsXF6ltkOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 2/5] perf inject/aslr: Add ASLR tool infrastructure
 and MMAP tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607060933.3274263-3-irogers@google.com>
References: <20260607060933.3274263-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 08:27:33 +0000
Message-Id: <20260607082734.3BE7A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Modifying memory-mapped read-only event buffers in place causes a =
segmentation fault.
- [High] Inconsistent handling of `(start - map__start(al.map))` for user s=
pace mappings leads to corrupted virtual address calculations.
- [High] KSYMBOL unregister events are emitted with an incorrect, newly all=
ocated address instead of the original remapped address.
--

commit c190853279a63eb364ce133684668cb85c64d5e1
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking

If perf.data files are taken from one machine to another they may
leak virtual addresses and so weaken ASLR on the machine they are
coming from. Add an aslr option for perf inject that remaps all
virtual addresses, or drops data/events, so that the virtual address
information isn't leaked.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..2c5fafbe5d846
> --- /dev/null
> +++ b/tools/perf/util/aslr.c

[ ... ]

> +static u64 aslr_tool__findnew_mapping(struct aslr_tool *aslr,
> +				      struct machine *session_machine,
> +				      struct thread *aslr_thread,
> +				      u8 cpumode, u64 start,
> +				      u64 len, u64 pgoff)
> +{

[ ... ]

> +		if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> +		    cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) {
> +			if (al.map) {
> +				*new_remap_val =3D remap_addr -
> +						 (start - map__start(al.map)) -
> +						 map__pgoff(al.map);
> +			} else {
> +				/*
> +				 * Subtract pgoff from the base virtual address so that
> +				 * when the lookup path adds pgoff back, it perfectly
> +				 * cancels out and returns remap_addr.
> +				 */
> +				*new_remap_val =3D remap_addr - pgoff;
> +			}
> +		} else {
> +			*new_remap_val =3D remap_addr - (al.map ? map__pgoff(al.map) : pgoff);

[Severity: High]
Is there a missing subtraction of (start - map__start(al.map)) for the user
space mapping here?=20

The kernel space path just above subtracts it. If perf merges adjacent VMAs=
,=20
start might not equal map__start(al.map), which could result in returning a=
n=20
address inflated by that difference on subsequent lookups and corrupting=20
the virtual address calculations.

> +		}
> +		err =3D hashmap__add(&aslr->remap_addresses, new_remap_key, new_remap_=
val);

[ ... ]

> +static int aslr_tool__process_ksymbol(const struct perf_tool *tool,
> +				      union perf_event *event,
> +				      struct perf_sample *sample,
> +				      struct machine *machine)
> +{

[ ... ]

> +	err =3D perf_event__process_ksymbol(tool, event, sample, aslr_machine);
> +	if (err)
> +		return err;
> +
> +	thread =3D machine__findnew_thread(aslr_machine, kernel_pid, 0);
> +	if (!thread)
> +		return -ENOMEM;
> +	memcpy(&new_event->ksymbol, &event->ksymbol, event->ksymbol.header.size=
);
> +	/* Remaps the ksymbol.start */
> +	new_event->ksymbol.addr =3D aslr_tool__findnew_mapping(aslr, machine, t=
hread,

[Severity: High]
For KSYMBOL unregister events, does calling perf_event__process_ksymbol()=20
earlier in this function delete the map from aslr_machine->kmaps before we =
can
look it up here?

If the map is deleted beforehand, aslr_tool__findnew_mapping() might fail t=
o=20
find the original map, fall back to generating a new unmapped key, and emit=
=20
a mismatched remapped address instead of the original one.

> +							     PERF_RECORD_MISC_KERNEL,
> +							     event->ksymbol.addr,
> +							     event->ksymbol.len,
> +							     /*pgoff=3D*/0);

[ ... ]

> +void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
**pevlist)
> +{

[ ... ]

> +	if (event->header.size >=3D (offsetof(struct perf_record_header_attr,
> +					    attr.sample_type) + sizeof(u64))) {
> +		u64 st =3D event->attr.attr.sample_type;
> +
> +		if (needs_swap)
> +			st =3D bswap_64(st);
> +
> +		st &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +
> +		if (needs_swap)
> +			st =3D bswap_64(st);
> +
> +		event->attr.attr.sample_type =3D st;

[Severity: High]
Does this code modify the event payload in place?

When processing a native-endian perf.data file, perf memory-maps the file's
data section with PROT_READ. If a PERF_RECORD_HEADER_ATTR event is located
in this read-only mapped data section, could writing directly to=20
event->attr.attr.sample_type trigger a segmentation fault?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607060933.3274=
263-1-irogers@google.com?part=3D2
