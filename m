Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786923;
	b=Yj5//+oKsg84LN3GuIPFNShhQI4YeXW71IYgRNQ7AzjvG6akevFZaLEHVhkp7BQmUmoP
	 hD9PRqZPHv4idqeaywtKZW1KbG3d/zN+Mf2k2JJX7VZ7dm2Hjji1UJ1AyMyu5SVV/k37m
	 US/HZfu5CJ0qq79jrk+3D6XN0OIUNcvm4fWvpr3xRBomCyxIgQnTtPsuX3keIUCyqFPLe
	 GkFbwuKzE7qVtvaSSyfCsqqUqCvJISrbobNYIsLEh900HfySftYQxURsjVQV5tqcExgVo
	 6SNWWRZTjzixr3MaRAnG8js4l9IuO0WLjajIXqE6EUb4PxNoeB2b/KB59nPtXOtxrbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nV+zaFhM/yhpd3MBRMbQiGgT5kWhknCDksYxnE6iDEU=;
	b=5i1Ow/qMVi7O5d3qRqo2BmIDIgJ2eC/NJd0gXwHJpXYIR3rG2WIhhSp07VBd7q/ht1ed
	 r7tXFeH2ks/MKD3ZNq8vn9ewLVmvUffO14PzSBJTiYSc6VyCCANbQIo2pW4WdmiSRZA8C
	 r0OAhVAjHnUH1+M+n1qYkKUMJKCGt8LOKlXrrfiFM4rv4nmppSGEJXRFn4/1Oc++ZVmIM
	 SMVfp+GqwSWG7ow9jC5QPD8bJjiJJRisMpatdZo1f0THt4z6NHo9hsS72+FaosaVXMs6F
	 RBVJSE0LemlbmMI6H1g0EkEWdcSUZLYlzSEDfWhy4/akLgjLRGgGT2cuVZ9qjhTMFTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfpjQGqn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026B606A31F
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfpjQGqn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812C1F000C4;
	Sun, 15 Nov 2026 23:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786923;
	bh=nV+zaFhM/yhpd3MBRMbQiGgT5kWhknCDksYxnE6iDEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FfpjQGqnz2xgz9dwdsXF4bB01yNjiMXQKJTdLekY/kSGtuI6G4D3TsvIlhz+s3bRT
	 U9ZLB0Th45CCU43ykhKDE83+UvvGFXuQMaUWIWa1+7sTT2yCsFKlZgKy95kBqX6RGe
	 7/yG/y/FtFks0GiOJi7AYKgTWeUjZI/6ciD92aOyn22FWmBj76R0aIKwYMRFr0329Z
	 DAJIkTwx/j+mhOX7XDS+Mf9zPuh/udijKtw5UfzP/615/uOs7Z25jjRl512B6SDBSS
	 v4Vo7YdpnsikGus5NxJ7wSW12gw77tex8isGlcvzqaWDw2hnU2NRKGljMgTyN5zhUQ
	 pYpg8XYbpTkRw==
Message-ID: <sashiko-outbox-215931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Don't take owner->perf_event_mutex under
 ctx->mutex on exec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Wade" <danjwade95@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115233949.13685-1-danjwade95@gmail.com>
References: <20261115233949.13685-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 23:55:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_event_remove_on_exec() holds the exec'ing task's ctx->mutex and calls
> perf_remove_from_owner(), which takes the owner's perf_event_mutex. The
> order documented above perf_event_ctx_lock_nested() is the reverse:
>=20
>     exec_update_lock
>       task_struct::perf_event_mutex
>         perf_event_context::mutex
>=20
> perf_event_task_enable() and perf_event_task_disable() follow it, holding
> current->perf_event_mutex while they lock the context of each event the
> task owns. The two paths deadlock against each other:
>=20
>   perf_event_task_disable()            perf_event_remove_on_exec()
>     mutex_lock(perf_event_mutex)         mutex_lock(ctx->mutex)
>     perf_event_ctx_lock()                perf_remove_from_owner()
> [ ... ]
>=20
> Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/all/CAP-5=3DfVq=3D2D6XjVEbAvJz54hG6PcwZZj=
n-za0hAfK8YV-J+MtQ@mail.gmail.com/
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115233949.1368=
5-1-danjwade95@gmail.com?part=3D1

