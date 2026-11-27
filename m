Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744396;
	b=qm6wxCkizGut4XB0k8EmZoUUegtV6urZPCa0VEm2tvOZxshRPPTzvSf+VMKVnjO20XjQ
	 ujXsnps8Syt0vvr+v51ZMHRenETDm+sgD6MKuXXDhCmTryQtrxNsKUl15ThGC7xciQGCM
	 R+tyvbqocDkR0MP+ub7Qw7A23tTcrFYiJ24tDbSwOaDA5dWg+llUX/VIIAtSX1cAqP5fH
	 +BqGK1kKLrKbcY1RjaCnBa7Dv0GKWBYYB7Cq2zd4moJtDrJg+X6yWY55GpnMn9c6uKctt
	 SsYkLLdFkpVNqkuD2G4plx7NvXp2GIy9hfvjajT+qa/ZbM+6Rx8hTarB0/ZELYD483w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744396;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NrA6M3+wlmKOnO688IZzbpP2esE+6mDNVgZnFKsrKI8=;
	b=s4c4jS1oH5uIN/mwPZBL2FEgjOo38xrQdxBQhquy6RmWih5JarX7J1hEoIwSB1b2x/sH
	 L7iQ5Cghj5XYJ23NdspXPIYa25rF3jkVjuVe6zWg3inl0bXARKo4cDm8Gq111Fray7S80
	 XW85TRTmUltwyemN+J/mykmT1xeqkJAU6AWQKuCbIPmDlIMSvrFJt6orOIw8X3Um8hGxp
	 qVPI0+NkWUhPhZ0WdzFbeusc1KJJ1rmnhUMIRgGWS784tnKOU04BSeccVjiCcJAxObQLD
	 vb+hutwHaGmGzMFIh6sJa1F4ArxFhYM+cjeJ8p8GFDYuBVrrbC91Ay9QpdMfqLLcKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJBNYcNe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43F606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJBNYcNe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A4B1F00897;
	Fri, 27 Nov 2026 01:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795744396;
	bh=NrA6M3+wlmKOnO688IZzbpP2esE+6mDNVgZnFKsrKI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJBNYcNeuA4INGOFsgo9C/9/qm7EPLcEJdBtrhMn8LKK5xp9br3lT86B+N15MisXK
	 PtSW26NSV9TapQvENrbTvimKTy7vXa2U87Wg/EEI/8EVzMFkxVbQTigMVP36INT/uQ
	 ToqBKtxvNi9L6PYN4P7QBH7lHDw8me+rA95uP1amfQxpuocPiqw/VXk24AvKY93Lq1
	 kL9TjhaAg6yQOU3imf7V8ijSaT7HN8KV0g5LWiUDDCO01L/T4F+JI5HOe/coDib1Iu
	 sWJwbR9Aluy/FTCQi8YTOxxpMEhPU/+8EvhaakZ3Ba12gA/MNiNy8IN4A0NeGQha1o
	 8NW4VUVHdS1rg==
Message-ID: <sashiko-outbox-236420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/18] perf kmem: Use the allocation order when
 matching page frees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127013801.14841-2-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
 <20261127013801.14841-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 01:53:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] perf kmem: mismatched live byte accounting in
  evsel__process_page_free_event()
- [Medium] perf kmem: stale order on reused page_live_tree entry causes
  -ENOENT on free
- [Low] perf kmem: missing Fixes: trailer in commit message
--

commit 638b1c81610cb380bfc3f707e98e97a94a357759
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

> perf kmem: Use the allocation order when matching page frees
>
> The page alloc tree is keyed by the values recorded at allocation
> time, but the free path looks it up with the order from the free
> event while taking the other key fields from the live page record.
> When a page is split or reused the orders differ, the lookup misses
> and the whole stat fails with a misleading -ENOMEM.
>
> Use the order from the live page record, as is already done for the
> gfp flags, migrate type and callsite, so the lookup finds the entry
> created at allocation time.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

[Severity: Low]
Should this include a Fixes tag for the commit that introduced page
allocator event tracking?

  Fixes: 0d68bc92c481 ("perf kmem: Analyze page allocator events also")

> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 8693c6b135cad..3accb5276bd53 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -928,6 +928,12 @@ static int evsel__process_page_free_event(struct per=
f_sample *sample)
>  		return 0;
>  	}
> =20
> +	/*
> +	 * The alloc tree is keyed by the values recorded at allocation
> +	 * time.  Use the order from the live page as well, otherwise a
> +	 * free of a split/reused page looks up the wrong entry.
> +	 */
> +	this.order =3D pstat->order;
>  	this.gfp_flags =3D pstat->gfp_flags;
>  	this.migrate_type =3D pstat->migrate_type;
>  	this.callsite =3D pstat->callsite;

[Severity: Medium]
Does live_page accounting in evsel__process_page_free_event() corrupt
pstat->alloc_bytes when the free order differs from pstat->order?

bytes is still computed from the free event's order (kmem_page_size <<
order), while page_stat__find_caller(&this) now looks up the caller entry
for this.order:

tools/perf/builtin-kmem.c:evsel__process_page_free_event() {
	...
	if (live_page) {
		pstat->nr_alloc--;
		pstat->alloc_bytes -=3D bytes;

		if (pstat->nr_alloc =3D=3D 0) {
			rb_erase(&pstat->node, &page_caller_tree);
			free(pstat);
		}
	}
}

When a higher-order allocation is split and freed in smaller chunks, only
the head page matches in page_live_tree and is erased, so pstat->nr_alloc
drops by one full allocation while pstat->alloc_bytes only subtracts the
smaller free size.  If a coalesced free has order > this.order while
another allocation on the same caller entry remains live, subtracting
bytes underflows pstat->alloc_bytes.

[Severity: Medium]
Can page_stat__find_caller(&this) fail with -ENOENT when a page already
present in page_live_tree is reused with a different order and callsite?

When page_stat__findnew_page() finds an existing entry in page_live_tree
(for example, when frees were not captured due to sampling or a tail page
was freed as part of a coalesced higher-order block),
__page_stat__findnew_page() returns the existing node without updating
data->order, data->gfp_flags, or data->migrate_type, while
evsel__process_page_alloc_event() overwrites pstat->callsite and inserts
into page_caller_tree using the new order and callsite:

tools/perf/builtin-kmem.c:evsel__process_page_alloc_event() {
	...
	this.page =3D page;
	pstat =3D page_stat__findnew_page(&this);
	if (pstat =3D=3D NULL)
		return -ENOMEM;

	pstat->nr_alloc++;
	pstat->alloc_bytes +=3D bytes;
	pstat->callsite =3D callsite;
	...
	this.callsite =3D callsite;
	pstat =3D page_stat__findnew_caller(&this);

On the next free of that page, evsel__process_page_free_event() combines
the old pstat->order with the new pstat->callsite, producing a hybrid key
that does not exist in page_caller_tree and aborting stat processing with
-ENOENT.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127013801.1484=
1-1-acme@kernel.org?part=3D1
