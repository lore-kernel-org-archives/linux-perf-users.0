Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949089;
	b=ZmIGd5Crm/U49NkhIa//xlIj6vZv9jVsJZshWpFNchwVbPcloPaN8EorgKOxosssypZy
	 UPQolpsEnJFbAV9Ql2SqBpynTXxbYdUyCy9oMIyn228kceOlS6nAcCWpT844WqdkrDhIS
	 M2SgfYvygdRutrCwjPavEer6SoysHALnIVUuKmE/mn7jjX+AayRDvJCY8MtP4lFdA8pVF
	 Y91LaEa0051C/jH5lhH9KMGY69shHH1U2uJdiraB8vSWWIj0iwrEDuSF7vuLTc+3UvXry
	 aO5zFBz69g9EiFzXeh1YiXYqnOycJywNwVgon2Z+NPRPl4lOpzmeHmSk5VsNnrd4xig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TaMFKwm7ZXv9N/6/DAAjypRfCaFl9t6q0dBDZljhMTM=;
	b=AmbDfWj1SKCmAb1rkCzCGZDxZswYET5Pu9R7AbgIYsI2Nu+2GV+O8pZb0wwisHn+drF8
	 mrDI6OlnwGZJSCmBgcOjqAlmOd4RPUqUQTQAVXi7k+wU7kzVe2iRVnnv/GQSmtyItXos2
	 n3guAHzJY7RQuGqYUeD4acckbDCVpfH+rUq+/VOqPNjO1XGHWB2Yfn6p7IzhrjLDwmmzW
	 qiGmdmmWlEf1MERi1tETxgW39B6T3Watv8aT8MjX/K79qcrAlCySMtw8pY8L/b6TLKL38
	 telNYhymlry4B9De/JTeNvAepa7S4G+QTntBV8iveINnv7dUJwU7+2Y43Co9Ekm9uUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7V958Fz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA50606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7V958Fz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3111B1F0089F;
	Fri,  6 Nov 2026 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949088;
	bh=TaMFKwm7ZXv9N/6/DAAjypRfCaFl9t6q0dBDZljhMTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7V958FzI0KEiI0lHNCepM2bXIMytBc3uGUG5Co8L0cDI4FrQAqszAh6BtwbV7JD0
	 KJqr54GCeVuKmEy224fV0f9/9kzZxgpIxbhrjpBDiWuWt9I9ENb+V1VssELDvLHoN6
	 bCAKwKoEGak33IlIFSzLb9RkZwOucHZB9AYNfFUNb5mpl80FEkvyPP/Zaq1wI0yu2T
	 Og1GV2VDRzZohAkItdvyPV0zlsvYwIMgqb2BgGSBeCn7M7VNztqoEtKGrxWzc68nbf
	 3XEhc+UrKXqSLb9zXy3odWXlFk6NRgd2FYEeHP7pmhyO4M+sO2RUP/9DX7CZVcoZcU
	 bNut1q6P4zlJQ==
Message-ID: <sashiko-outbox-200968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/20] perf vdso: Fix unlocked __dsos__add() and
 race in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-8-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:11:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf vdso: missing Fixes trailer for locking regression in
  machine__findnew_vdso()
--

commit 4eb9a9569b89c8e8222d4936fcb66a2bd40347f4
Author: Ian Rogers <irogers@google.com>

> perf vdso: Fix unlocked __dsos__add() and race in __machine__addnew_vdso()
>
> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
As reported by Bart Van Assche on v2 [1], commit f649ed80f3ca ("perf dsos:
Tidy reference counting and locking") removed the write lock on
machine->dsos.lock from machine__findnew_vdso().  Should this include:

  Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")

[1] https://lore.kernel.org/r/3f57ddf4-b1a7-4c91-8983-c8cd83d0f25c@acm.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D7
