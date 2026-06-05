Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F13976BE
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669803; cv=none; b=TiN2+6zI+wq2IMI4TNPrhLnHoSmoO+mH88BtknmpsOXxYUWkofVAtTas8jz+yRZMVyC+wPIR/1qsdJPsZAfdKQmijHwWyXWrnA1PXkDATybRzf83AmiqI3wu+afB6RvRz/w7VXobyKEQCVq2ZoSBtbUmk5mSFQmPzGQBFnTASE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669803; c=relaxed/simple;
	bh=hLcpOqM1RLFZus2+FE5lJglDqI3+NcgEAeiZM4L9/jc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTPHqM01/U43JturYxmCxoUG8sDUUsIh14rEjL6ouIRAGHS7m+Mf7tjAF5BEcC6Ba92L00FBf5fvhZPT8KZifwur+C2dfCuYiAm9hVJEuPeTn7n0+k44SETPqn59nI7dyfROMRtyNdU3NdZ5izhMji8L2kr8MDeLFI8LdRhmbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVcJrsdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVcJrsdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0CD1F00893;
	Fri,  5 Jun 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780669801;
	bh=pPEnJC0tXZeovDt6Q+dVBZ3fGhXz1c7QWLHJLlNkV90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVcJrsdYDAFuVWh8q/N0Z5krOFqictyQs3CRYToec2CUCWLEnh9k2f4GM3CYbX1LA
	 3TdeBq0EjHPPTud/pod8jNNcF1d28B/IGnm64/shPRn40CLvL+lXj+yu0+BbSMqwz8
	 I+Ggjdc4G5vrUnMZ71R3hn+MOw1wDT9cunMWi8oy1ITZ1B/tfFsO9Cu0PadVeIkgY3
	 cuNyBc+pXvYWJcFAr+vBNmCxVGzNE67L+a7CptgLcXgSN6EgZBDCqhuIRF+jgqajdz
	 4MwA4BPeWn311z1buudSQstyEVVLSZE/rpJ2PXkqlma2IQUPI5XMkCUrOHxLHF6/gw
	 G1krr9St4tk1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf tools: Add bounds check to cpu__get_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605121515.1725549-3-acme@kernel.org>
References: <20260605121515.1725549-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:30:00 +0000
Message-Id: <20260605143000.DE0CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `builtin-kmem` omits the `.attr` callback in its `perf_tool`, whic=
h breaks processing of piped streams natively.
- [High] Integer truncation in `set_max_cpu_num()` combined with missing bo=
unds checks in `cpu__setup_cpunode_map()` causes heap out-of-bounds writes =
on systems with large sparse CPU topologies.
- [High] `perf_mmap__aio_bind` triggers an out-of-bounds memory write and s=
ubsequent crash when a CPU's NUMA node is unknown or mapped to a dummy CPU.
--

commit 84fade77fbbcea06a93ffe9275b1abcc29bbc6bc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add bounds check to cpu__get_node()

The patch adds a bounds check against max_cpu_num in cpu__get_node() to
protect against untrusted or out-of-bounds CPU index values before accessing
cpunode_map. This prevents out-of-bounds array indexing, particularly when
analyzing cross-machine perf recordings where the recorded CPU count may
exceed the host's CPU count.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index b1e5c29c6e3ec..d3432622b2adc 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -576,6 +576,10 @@ int cpu__get_node(struct perf_cpu cpu)
>  		return -1;
>  	}
> =20
> +	/* cpunode_map allocated for max_cpu_num entries; input may be untruste=
d */
> +	if (cpu.cpu < 0 || cpu.cpu >=3D max_cpu_num.cpu)

[Severity: High]
This isn't a bug introduced by this patch, but parsing sysfs to determine
the maximum CPU number introduces a memory corruption vulnerability.

In tools/perf/util/cpumap.c:set_max_cpu_num(), the max possible CPU number
is parsed from sysfs into a local int max. This value is directly assigned =
to
max_cpu_num.cpu, which is an int16_t. If max exceeds 32,767 (as is possible=
 on
large modern architectures or due to sparse APIC numbering), the assignment
truncates the value, resulting in a small or negative integer.

Later, init_cpunode_map() allocates cpunode_map based on this truncated siz=
e,
and cpu__setup_cpunode_map() writes to it without truncation:

tools/perf/util/cpumap.c:cpu__setup_cpunode_map() {
...
		while ((dent2 =3D readdir(dir2)) !=3D NULL) {
			if (dent2->d_type !=3D DT_LNK || sscanf(dent2->d_name, "cpu%u", &cpu) < =
1)
				continue;
			cpunode_map[cpu] =3D mem;
		}
...

Could this result in an out-of-bounds write on the heap?

> +		return -1;

[Severity: High]
This isn't a bug introduced by this patch, but returning -1 here causes a
crash in perf_mmap__aio_bind() when a CPU's NUMA node is unknown or mapped =
to
a dummy CPU.

tools/perf/util/mmap.c:perf_mmap__aio_bind() {
...
		node_index =3D cpu__get_node(cpu);
		node_mask =3D bitmap_zalloc(node_index + 1);
		if (!node_mask) {
			pr_err("Failed to allocate node mask for mbind: error %m\n");
			return -1;
		}
		__set_bit(node_index, node_mask);
...

When cpu__get_node() returns -1, it is implicitly cast to unsigned long
node_index (ULONG_MAX). bitmap_zalloc(ULONG_MAX + 1) evaluates to
bitmap_zalloc(0) and allocates a minimal buffer.

Does the subsequent __set_bit(ULONG_MAX, node_mask) perform a wild memory
write vastly outside the allocated bitmap?

> +
>  	return cpunode_map[cpu.cpu];
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
builtin-kmem.c which is mentioned in the commit message as calling
cpu__get_node(), it appears the perf_tool initialization omits the
.attr callback:

tools/perf/builtin-kmem.c:cmd_kmem() {
...
	perf_tool__init(&perf_kmem, /*ordered_events=3D*/true);
	perf_kmem.sample	=3D process_sample_event;
	perf_kmem.comm		=3D perf_event__process_comm;
	perf_kmem.mmap		=3D perf_event__process_mmap;
	perf_kmem.mmap2		=3D perf_event__process_mmap2;
	perf_kmem.namespaces	=3D perf_event__process_namespaces;
...

In pipe mode (e.g., perf kmem record -o - | perf kmem stat -i -), perf.data
headers are missing and events must be processed sequentially. Omitting the
perf_event__process_attr callback causes perf_event_header_attr events to be
silently discarded by the default stub.

Does this prevent the creation of evsels and the initialization of the
perf_env, completely breaking the tool's ability to process piped data
streams natively?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121515.1725=
549-1-acme@kernel.org?part=3D2
