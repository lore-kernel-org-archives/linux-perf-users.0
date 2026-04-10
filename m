Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B3280CC1
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783054; cv=none; b=SWTGuc9iiwJKIhFUEpahKgaXo/tdzYh5/hk3LslSJLSQqo29T9jP7mBRdpytS6/m66MU17TT8G+R3QwlYNYBbMnUxygvzIXFJinDYvWoRdyq87LffQ1lZVmYsiaMqQOH53l2ScS7hPL7Uawte8RhzPbi4jjQvvtPbTr5GekVXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783054; c=relaxed/simple;
	bh=tXu3AHIbdDOaOdO1NoETUatu1acSL6DD3+aVtRLFBx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdXat3ACEHKSzV901R5jYWhQdCs3iL8vALdw/J5+7twkf5LXOzDVYwn2nPhR6VdFezNdvN64g21qM1qCzRLpeKIWKvwUlZRXwgyCyoj1pBCtJ4aTka4Zn7fqF0kIzBkBPsru9apfi54Jr5WJ4+9gwiBq8brM2xGn2Rzxk6CN4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV1CcaJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV1CcaJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DD3C2BC9E;
	Fri, 10 Apr 2026 01:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783053;
	bh=tXu3AHIbdDOaOdO1NoETUatu1acSL6DD3+aVtRLFBx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HV1CcaJ5TShXk4AVMgwC7v67u8d0MpISiEMoGsvn1gacqr+Vm4FOtWMeuhmS+jSZo
	 nWrEyda7CKqEYZ/4RDlI35aYthP/8pvdTiivKmtJt0EhJhlAH2OPH3W4167i+9YQtp
	 00/gE+wErH/IPbSGWljYb7A/nSFsB8K/vYcqe9q0IY21s4VR5WREzI+ykb34dId6GD
	 FpA857t6Hq1lqIkXdfbVMwHILn4pnD58Yzb1VJ3fprY5ecdewPFfL/taGZoNIPPJHy
	 BQeMhkjqtAQh1haQZSzcDxe0H0IkGeW+AQvT4CpPZh2iskQ8OKg2IAGwu0t34rby8t
	 uEX+cV12myshQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] perf header: Sanity check HEADER_MEM_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-7-acme@kernel.org>
References: <20260410004000.148138-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:04:13 +0000
Message-Id: <20260410010413.B4DD3C2BC9E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Integer truncation in `do_read_bitmap` leads to a severe heap =
buffer overflow when reading malformed `perf.data` files.
- [Medium] The newly introduced minimum section size check mathematically u=
ndercalculates the minimum required bytes per node.
- [Low] `MAX_NUMA_NODES` macro used for validation is structurally brittle =
as it is defined inside the body of another function.
--

commit e1c73bb8da303b10ce33d83b53452c1195efcf94
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_MEM_TOPOLOGY

This patch adds validation to process_mem_topology() to harden against
malformed perf.data files. It introduces an upper bound check on nr_nodes
using MAX_NUMA_NODES and a minimum section size check before allocating
memory.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 2c6f7c96e2dcc..45f533fbb8fdc 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3306,6 +3306,18 @@ static int process_mem_topology(struct feat_fd *ff,
>  	if (do_read_u64(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_NUMA_NODES) {

Is it safe to reuse MAX_NUMA_NODES here?

It appears to be defined inside the body of process_numa_topology() earlier
in the file. If the file is ever refactored or process_numa_topology() is
conditionally compiled out, could this break the compilation of
process_mem_topology()?

> +		pr_err("Invalid HEADER_MEM_TOPOLOGY: nr_nodes (%llu) > %u\n",
> +		       (unsigned long long)nr, MAX_NUMA_NODES);
> +		return -1;
> +	}
> +
> +	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {

Does this check mathematically undercalculate the minimum required bytes per
node?

The formula assumes that each memory node consumes exactly 2 u64 fields
(node and size). However, do_read_bitmap() unconditionally reads an
additional u64 size field from the file before any bitmap data is processed:

tools/perf/util/header.c:do_read_bitmap() {
    ...
	ret =3D do_read_u64(ff, &size);
    ...
}

Should the absolute minimum size required per node actually be 3 u64s
(24 bytes) to prevent structurally undersized sections from passing the
initial size validation?

> +		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu =
nodes\n",
> +		       ff->size, (unsigned long long)nr);
> +		return -1;
> +	}

Since this patch hardens against malformed files, could the truncation in
do_read_bitmap() overflow the set allocation?

In do_read_bitmap(), a 64-bit size is read from the file and passed to
bitmap_zalloc():

tools/perf/util/header.c:do_read_bitmap() {
    ...
	ret =3D do_read_u64(ff, &size);
	if (ret)
		return ret;

	set =3D bitmap_zalloc(size);
    ...
}

Because bitmap_zalloc() takes a 32-bit signed integer, an
attacker-controlled size exceeding INT_MAX (e.g., 0x100000040ULL) would be
implicitly truncated, resulting in a tiny allocation.

However, the subsequent loop uses the original, untruncated 64-bit value to
bound its execution:

    for (i =3D 0; (u64) i < BITS_TO_U64(size); i++) {
		ret =3D do_read_u64(ff, p + i);
        ...
    }

Could this read millions of 64-bit words directly from the untrusted file
into the undersized set allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D6
