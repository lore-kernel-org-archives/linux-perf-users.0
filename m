Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441A1FE471
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340987; cv=none; b=CqHht8esicuFGBYayqKwCvgSYuM3sNanAaPP1eqw6groaB9uw8sCVqmqcq7Ws3bMlNjjDy6MSRgxveJR0ji0CCjsMaPzXV/eg2UyeSQO1lE5R2Qn5Rq2kLbK8UZpdixz/GMTgQIVYuPoa+uoWIub33XXFJ743FTf2R1VhAiESyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340987; c=relaxed/simple;
	bh=PDrU4/o3e6Gn3gHehclhHIBKL81MKQQ7q93BY+6QIVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZL4gyb3e1XJAYHE3EHW6bHN4tNY1QMayGFjeGlqH7QJwb1BozkQRWPxZzEXBRnzey8esw8We1Sr06BWqvKRE5xW6r1vXZGAu1j6Wm75DPdIFx0+fQoo35fKhiIfXPWoehI20Pbdp3ZxbJ8H1b7ZS7k3oP9zcg2oSFr3yx2sj4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF3pr9xj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF3pr9xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FFE1F000E9;
	Mon, 10 Aug 2026 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786340985;
	bh=InS4nrdPzXdPGdSBsv+jx4k+nzt+oOdgRzPuKe8OTtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aF3pr9xjkorrI/YW6xqQ5ofdSPuFBUTH+PLsmjhJYt1QwqOd31bxsNIt8tUG8w/eY
	 BHQd/zkHxpiSWwUTokwQYGhzG6YV97HWv7ubohjMXOAJAmHMo4lO6ytAg+CH7tn8KW
	 bhxEzxOlZuqH15MkhH2lZR0+05ODOrfc3Grm46Abl3UltQ5d/Wkf8q8VJX7V3DeNfE
	 S3ZYS25KktYmF/C1mAx2/bpOTWk6nD9lEV9FRWHqKAqyFiXTljXG0psdAlB0z3FhQZ
	 E+Jf2UuTa2/R7jLUfxxVSsUcOB5Xv0e/ygRQE7byZa9A10Mbm3sSd/7Ut5K6i5OMoA
	 2Sc6YumLG5Pgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] perf c2c: add function view hierarchy entry
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260810052647.588867-7-jiebin.sun@intel.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com>
 <20260810052647.588867-7-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 05:49:44 +0000
Message-Id: <20260810054945.82FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Deleting a function-view child entry causes an out-of-bounds hea=
p read in `free_callchain()` because the child entry is allocated without t=
railing `callchain_root` memory.
--

--- Patch [6]: [PATCH v8 6/9] perf c2c: add function view hierarchy entry c=
reation ---
commit 3fbce53bcfd8d8abeda29f9eded35e05dfc305f5
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view hierarchy entry creation
   =20
This patch adds the entry-creation layer for the function view hierarchy.
It implements level-1/2/3 lookup-or-create functions and synthetic child
allocation logic, reusing cacheline_idx to preserve source entry identity.

> diff --git a/tools/perf/ui/browsers/c2c-function.c b/tools/perf/ui/browse=
rs/c2c-function.c
> index 4bf8406fde556..4099d4c7e7b44 100644
> --- a/tools/perf/ui/browsers/c2c-function.c
> +++ b/tools/perf/ui/browsers/c2c-function.c

[ ... ]

> @@ -847,6 +865,259 @@ static int __maybe_unused c2c_he__prune_empty_write=
rs(struct hist_entry *l1_he)
>  	return surviving;
>  }
> =20
> +static void *c2c_function_he_zalloc(size_t size)
> +{
> +	struct c2c_hist_entry *c2c_he =3D zalloc(sizeof(*c2c_he) + size);
> +
> +	if (!c2c_he)
> +		return NULL;
> +
> +	init_stats(&c2c_he->cstats.lcl_hitm);
> +	init_stats(&c2c_he->cstats.rmt_hitm);
> +	init_stats(&c2c_he->cstats.lcl_peer);
> +	init_stats(&c2c_he->cstats.rmt_peer);
> +	init_stats(&c2c_he->cstats.load);
> +
> +	return &c2c_he->he;
> +}
> +
> +/* Entry operations for function view */
> +static struct hist_entry_ops c2c_function_entry_ops =3D {
> +	.new	=3D c2c_function_he_zalloc,
> +	.free	=3D c2c_function_he_free,
> +};
> +
> +static struct c2c_hist_entry *
> +c2c_child_entry__alloc(struct hist_entry *parent_he, struct hist_entry *=
src_he,
> +		       int depth, u64 ip)
> +{
> +	struct c2c_hist_entry *child_c2c;
> +	struct hist_entry *child_he;
> +
> +	/* Function-view children never own or display callchains. */
> +	child_he =3D c2c_function_he_zalloc(0);
> +	if (!child_he)
> +		return NULL;

[Severity: Medium]
Will this cause an out-of-bounds memory read when the entry is freed?

If perf c2c report is run with callchains enabled (symbol_conf.use_callchain
is true), this entry is allocated with 0 extra bytes for the callchain.

When this undersized entry is deleted on the error path below or during
cleanup via c2c_he__free_hierarchy(), hist_entry__delete() accesses
he->callchain based on the global symbol_conf.use_callchain flag:

tools/perf/util/hist.c:hist_entry__delete() {
    ...
    if (symbol_conf.use_callchain)
        free_callchain(he->callchain);
    ...
}

Could this read past the end of the c2c_hist_entry structure and dereference
garbage memory in free_callchain_node()?

> +
> +	child_c2c =3D container_of(child_he, struct c2c_hist_entry, he);
> +	child_he->ops =3D &c2c_function_entry_ops;
> +	map_symbol__copy(&child_he->ms, &src_he->ms);

[ ... ]

> +	return child_c2c;
> +
> +out_free:
> +	hist_entry__delete(child_he);
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810052647.5888=
67-1-jiebin.sun@intel.com?part=3D6
