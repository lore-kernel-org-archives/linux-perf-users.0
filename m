Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A7548557
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923219; cv=none; b=uWuzSdlvchpXmKG7/acPJKExWB8nNVq8jHhpcbQO5eeUjlFKJWrg0TIcEjFeGohbbt7ijettHnvgMY6oBoyxfp1yKQOk/LY++ZWFQJluqAN4XNwzjwXJJzpAK7BzNJl3LERrT/FWRYRo2ko5c0gBNAfKza20kOkT5+uL3/VelHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923219; c=relaxed/simple;
	bh=weCDPtteAmemRfCT/acgNAoNWvN59aBdPw2bZi447Sg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ddZEM4kKNWj99c0n8ShpSzwb0QSoBjQz/WvJBHqRTGAMWTdMLWZpsXSQX+KuhjyH+Rp2sCd0YDvVMuC2Omzai25ebueLqkKux/fLm8kB14KcGKB2USuX27IyPsIMM1lPMMMWXzMZ1VUOh4v6FFAnV7WmjXjce+D7y150makjAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IirJ0q28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IirJ0q28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF61F000FF;
	Tue, 13 Oct 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923217;
	bh=39YvI9CaDXZ01IxagauIdbuOnzXFiW3LnzSsKMJ6WTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IirJ0q28PWYhecxMhbGHuaOCLFbN21Pa74IiGPEItnneEMmKfK+uzETj+D12HxWyr
	 jagOJJcMJ1vf8ZyABgVrq27R/ZKJlJUn/8Y2cSbSaDKZI1H9l5BUDN6z6OQfnvDEm6
	 wd5GmXx/VgTHid4/RdsmjFOkK7IdnXv0dftyu0LMA4kiqNvk/9e2eLE5GLsUMjOLi7
	 7kEYnwAJiFqd5ytk1LhwBCn9i8NAZzBFzSknn6dX80sgx/h7YOIwfoFk0UcK6ODLxO
	 GpijrcSjREo++UlHSTvtA9rdD8ljdtR3uj3yobOS19WtaZIAQcby12OQYNQ46SUTN6
	 fIyeeqs6W2wRg==
Message-ID: <sashiko-outbox-170460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/19] perf test: Take turns using the perf mlock
 budget in the mmaping tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-18-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:26:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The mmap size used when none is asked for is derived from
> kernel.perf_event_mlock_kb itself (see perf_event_mlock_kb_in_pages()),
> that after rounding down to a power of two number of pages ends up being
> about all of a single CPU's share of that per user budget, so with 'perf
> test' starting all the selected tests at once, any further mapping done
> while another test still has its ring buffers mapped fails with:
>=20
>   Permission error mapping pages.
>   Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
>   or try again with a smaller value of -m/--mmap_pages.
>=20
> that then shows up as a failure or, worse, as an "unsupp" skip in tests
> like the attr ones, i.e. as a false pass.
> [ ... ]
> None of this is done when just one of the selected tests maps ring
> buffers, as there is nothing to share the budget with in that case.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D17

