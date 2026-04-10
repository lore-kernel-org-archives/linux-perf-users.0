Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE73A9D9E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860092; cv=none; b=EukB4TQtbPMjHpH6dazIG7ymxTIBivYNxi99mdjspRGgxOL3mfwMbvcaqQEH2CPM4DKEDWd7mCCOxGk9tL6xEJvPHwOP82uPzUikR+HiXzainnWDFHwzDSePqtfnCtlonXnARi+VUCMXYi2S4/EuSj0oml2K9Dr4KPmAEl6Mo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860092; c=relaxed/simple;
	bh=f6BfJp1nf6tV9qpb2zUpVBMY8NT1oH47UvSJZ84qzLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMEmz6QOoSRDIaK4ocmGW+X1SFusu+bm6r7P8BYvL3r9S5iXwe5K7jtd7E4ov14XIWSDvkbRH44O/nB4QRd+r0P7u/XloyEH6JvtjB8yopcF7LMSIvlFiUZt5Xa8HMXo9QrLy9Wt69UQH4vCJMSkrD2KmD7QlaE6yer6cf6lG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMRViyzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMRViyzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A28EC19421;
	Fri, 10 Apr 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860092;
	bh=f6BfJp1nf6tV9qpb2zUpVBMY8NT1oH47UvSJZ84qzLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iMRViyzqvX07UImO3BR4yI/K6hkzILdTzDuiSyblWyEoTmcHjJaTjpR8/htD59hSe
	 5K2ag8VtgXJdvJQNQjV2MgwrsMqDQxUWFBbLCQEQ1j/jJgnCgdOToP/PWJ6KeCYSTU
	 unxwzNS7VwBYEa1gg1HGMxw947wDsxcvuq0iKYBuHdEdSPYJjnH2UOvtKEK8gP4mcR
	 ysNujtKBNCAfNrOuS9k0OeC6Yu+hQcdLuYaORzq+6pate6irMJAvyvqMyBX61U5xaE
	 Gl4HkWuQ4qaUg2oNANhnCNVpDKqgC5M4Q1xAan2brxmOit18V8wQiVdYCas1tODmgL
	 dLJpZNuyf29Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] perf header: Sanity check HEADER_NUMA_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-6-acme@kernel.org>
References: <20260410220905.200051-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:28:11 +0000
Message-Id: <20260410222812.0A28EC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The minimum section size calculation for HEADER_NUMA_TOPOLOGY omits=
 the mandatory string length field per node.
--

commit 5064a9beb88eb8009f39a18c54d4d42f61a38a69
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_NUMA_TOPOLOGY

This commit adds validation to process_numa_topology() to harden against
malformed perf.data files. It introduces an upper bound check on nr_nodes
and a minimum section size check before allocating memory.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index acd6b07528e01..2f405776e5013 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3005,6 +3006,18 @@ static int process_numa_topology(struct feat_fd *f=
f, void *data __maybe_unused)
>  	if (do_read_u32(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_NUMA_NODES) {
> +		pr_err("Invalid HEADER_NUMA_TOPOLOGY: nr_nodes (%u) > %u\n",
> +		       nr, MAX_NUMA_NODES);
> +		return -1;
> +	}
> +
> +	if (ff->size < sizeof(u32) + nr * (sizeof(u32) + 2 * sizeof(u64))) {

Does this calculation omit the mandatory string length field for each node?

The subsequent parsing loop reads the node ID, memory totals, and a CPU map
string:

        if (do_read_u32(ff, &n->node))
                goto error;
        if (do_read_u64(ff, &n->mem_total))
                goto error;
        if (do_read_u64(ff, &n->mem_free))
                goto error;
        str =3D do_read_string(ff);

Since do_read_string() always reads a u32 length prefix before the string
content, the true minimum size per node appears to be 24 bytes rather than =
20
bytes (sizeof(u32) + 2 * sizeof(u64) + sizeof(u32)).

While truncated files will still safely fail later during the actual read
operations, this calculation allows slightly truncated files to bypass the
new validation check.

> +		pr_err("Invalid HEADER_NUMA_TOPOLOGY: section too small (%zu) for %u n=
odes\n",
> +		       ff->size, nr);
> +		return -1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D5
