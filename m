Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5236B939
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040251; cv=none; b=qeOuaxzzT/uhd7tcC3PoQSuAacsBkE4Vy10Zpa3eR/Vt2KNz64/F71ErwbWGTr8JHrHKg2RD8UjgyT9ZPuHrK7Vb9bsTVM4e6jBQOX36Mi81PqSNPLigpLASCCArKoWMrzM5aMQroXKyhGk/fR95AC8DYP4R2RG6Td+LZo7vb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040251; c=relaxed/simple;
	bh=L5Uv2iTUlQcEZPghFyef28u+h5A59HKn5CAUN5ql6O0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZE6clBL2T4/xtb80U59W1q2Kq/NbG6g7is1r9GHa/3AlkfXD/37csosY4pLBtVOVhgpcbGwB1P4jnUdDtx0+NN5ATuh8CZ9QE6nAP6VS8d14K9tSaNF/+1P1Mhzeqw5Lo3kuUQdVQGsV2HVzxxFwhN9E49O9YWpENULMLA29xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYQnUThy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYQnUThy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD601F000FF;
	Tue, 22 Sep 2026 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040249;
	bh=P6Iu21l+P8f3aI3seVrubjHom97UnfEZX9nO/15Xcd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYQnUThy312jAH03f/OOxNzMbkxzFxD4lZcLtHpceYrUO669BBnFmlUPvk4vydbsR
	 FJtlYLb+z5Rn11weodzy3ZRLBI4eI6Ks1v2xdSolnsl0Kk7jO0q+nyM1b6DMyFiWzy
	 dcK0Y34NkHluxt4AHP+9tuozBG6vQY1D4yiJEHeKv+5R/2ZHu/MS6DYw1CeELwJfMR
	 iydroGT32jpcLanZTGls7zySSmH9L0tPP3/8Ob9Dq0nHD6h1t53s+xJ9L6oU1XoePy
	 1g3ZUPmGtT3DG2w3x6TnYxSvZefMsw5hk0rexiWbGpi0GNEBlXXnHcDlxGkcg4ujHO
	 TMQInnCPCFwbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf/core: publish perf_event_cache with release
 semantics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaidev Shastri" <jaidevshastri@vt.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-mb-perf-core-v1-3-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
 <20260921-mb-perf-core-v1-3-ac56a719c02b@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:24:08 +0000
Message-Id: <20260922012409.4DD601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: unnecessary and inconsistent memory barriers for boot-initial=
ized variable
--

commit 502c74ee5072b4297e79a78cf708d77e31d6b0e5
Author: Jaidev Shastri <jaidevshastri@vt.edu>
Subject: perf/core: publish perf_event_cache with release semantics

This patch replaces plain reads and writes of perf_event_cache with
smp_store_release() and smp_load_acquire() to address a static checker
warning about memory consistency.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3b5c592630e17..74cfb13fec7c0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5313,7 +5313,8 @@ static void free_event_rcu(struct rcu_head *head)
>  		put_pid_ns(event->ns);
>  	perf_event_free_filter(event);
>  	kfree(event->addr_filter_ranges);
> -	kmem_cache_free(perf_event_cache, event);
> +	/* Pairs with the smp_store_release() in perf_event_init(). */
> +	kmem_cache_free(smp_load_acquire(&perf_event_cache), event);

[Severity: Low]
Is this acquire barrier necessary? Since perf_event_cache is initialized
synchronously during early kernel boot, it should already be causally
guaranteed to be fully visible across all CPUs by the time any tasks are
spawned to interact with it.

Additionally, if a memory barrier were required to prevent data races, is
it problematic that the allocation path still uses a plain load?

kernel/events/core.c:perf_event_alloc() {
    ...
    event =3D kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZE=
RO, node);
    ...
}

[ ... ]

> @@ -15404,7 +15405,8 @@ void __init perf_event_init(void)
>  	ret =3D init_hw_breakpoint();
>  	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
> =20
> -	perf_event_cache =3D KMEM_CACHE(perf_event, SLAB_PANIC);
> +	/* Pairs with the smp_load_acquire() in free_event_rcu(). */
> +	smp_store_release(&perf_event_cache, KMEM_CACHE(perf_event, SLAB_PANIC)=
);

[Severity: Low]
Since perf_event_init() is an __init function that runs synchronously during
early system boot before tasks could potentially allocate or free perf even=
ts,
does this require a release barrier?=20

Instead of adding synchronization overhead to silence the static checker,
would it be more appropriate to annotate the declaration of perf_event_cache
with __ro_after_init? This documents the initialization phase ordering and
safely silences static checkers while avoiding unnecessary code complexity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-mb-perf-co=
re-v1-0-ac56a719c02b@vt.edu?part=3D3
