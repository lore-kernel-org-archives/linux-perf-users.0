Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DF18A92F
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860363; cv=none; b=YKv6TZJ7QhKuN4RlLAiQvFO8LybFQWxWOPVwRtuR8Oh5EPf7CeMMD731jxBPXYnz0IPM+A7Ei047tB9Va0De2Wh9wZbmbrCKkFw2VrYDEqtpTfruJqpJwZs9X59POJfrC8uB2v2j1Zm5luxRzSFH0peo9a1xAGqrTtHAGM+koO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860363; c=relaxed/simple;
	bh=r3uoLeFr0Sx/jvZzpzCsj5FiQgKeCkymx2EOdV+d98A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=saXLFOOfy7aXzZjWgs65PHr5PaEXedd5Z5T5yhiYin9dkeHkxRkZa2cLslSuq3HvMb8HrVLr6qABzMJms8dQGEB+Nakcd5VNOlaKAeooKiNE7FY4xcT5321/AkPKA7AXYwKMyeTkXRK8f6sp3XgQdWwIK1zoQkamEQIxlwBpmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnxWEFln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnxWEFln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD76FC19421;
	Fri, 10 Apr 2026 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860363;
	bh=r3uoLeFr0Sx/jvZzpzCsj5FiQgKeCkymx2EOdV+d98A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EnxWEFln3IbE+Jfbnlb5jLLQPJnI8IAU0KnUQCJ3hPoLdA0NTi9cQgumxSKtRc9g0
	 UqeWTdsCybClbCAq2IuTPFO/FfOM75ZCUj+zYf1F24l0MMeyVl3q93P3dJHWrBQ4pN
	 2EQ9hbf1Bv6ZmK2tXLWofSxSul57qciwdFh9JGZZQc3/ryfMUEoVUY5tP7v0fH22hj
	 P/2d4YbK/hRyKUEhqDqBUym5B+fIK9obn6KX5BhQP210xS0JOLrw4xTJoiFg+GHboT
	 gfMrTWeRP/51NT4RX+gcICg+DGTIwirgcWEIZdzRQagwYbg/kYuGskjPykBAiU4MVZ
	 /D3LUaGDkMOLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] perf header: Sanity check HEADER_MEM_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-7-acme@kernel.org>
References: <20260410220905.200051-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:32:42 +0000
Message-Id: <20260410223242.DD76FC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Heap Buffer Overflow via Integer Truncation in do_read_bitmap()
- [Low] Inaccurate bounds check under-approximates minimum section size
--

commit 005d03d0f059f4f346c521c1c989a61ca017de89
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_MEM_TOPOLOGY

This commit adds validation to process_mem_topology() to protect against
malformed perf.data files. It introduces an upper bound check on nr_nodes
using MAX_NUMA_NODES and verifies the section size is large enough before
allocating memory.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -3308,6 +3308,18 @@ static int process_mem_topology(struct feat_fd *ff,
>  	if (do_read_u64(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_NUMA_NODES) {
> +		pr_err("Invalid HEADER_MEM_TOPOLOGY: nr_nodes (%llu) > %u\n",
> +		       (unsigned long long)nr, MAX_NUMA_NODES);
> +		return -1;
> +	}
> +
> +	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {

Does the per-node size calculation introduce a regression by
under-approximating the minimum section size?

Each memory node actually consumes at least 3 u64 fields because
do_read_bitmap() also reads a u64 size field before its payload:

process_mem_topology() {
    ...
        _R(node)
        _R(size)
        ...
        if (do_read_bitmap(ff, &n.set, &n.size))
    ...
}

And do_read_bitmap() reads the size:

do_read_bitmap() {
    ...
    ret =3D do_read_u64(ff, &size);
    ...
}

Should this check instead be nr * 3 * sizeof(u64) to account for the bitmap
size field?

> +		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu =
nodes\n",
> +		       ff->size, (unsigned long long)nr);
> +		return -1;
> +	}
> +
>  	nodes =3D calloc(nr, sizeof(*nodes));

While this patch hardens topology parsing, is there a regression further do=
wn
in the parsing logic that could cause an out-of-bounds write?

When process_mem_topology() calls do_read_bitmap(), a 64-bit size is read a=
nd
passed to bitmap_zalloc():

do_read_bitmap() {
    u64 size, *p;
    ...
    ret =3D do_read_u64(ff, &size);
    if (ret)
        return ret;

    set =3D bitmap_zalloc(size);
    ...
}

If bitmap_zalloc() takes a 32-bit integer for the number of bits, a size
exceeding 32 bits would be truncated, resulting in a small allocation.

The subsequent loop then calculates its bounds using the full 64-bit value:

    for (i =3D 0; (u64) i < BITS_TO_U64(size); i++) {
        ret =3D do_read_u64(ff, p + i);
        ...
    }

Can this loop write past the end of the truncated allocation if a large siz=
e is
supplied?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D6
