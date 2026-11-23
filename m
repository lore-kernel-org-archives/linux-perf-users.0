Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406951;
	b=TI5hG3C9Ozr3YqtiWISfl/9aIvfdyAZTHDXiW3BiH4nZe8TrP3yKf7kvH+1L9Y+IsHLy
	 gurpve9z5/jm6h+Uul6ad0Loj8CvEoZxT0/w5D6prixBcOcxvwp3Ki6PE6aHCswOnaFMI
	 lhTo7DeGw/7utx04Yt2F3ZzhqRTXjtHSigvMfBFHb3XJI8VxaJAugnXy2HYIlno8uPs8w
	 tu7kTboxIGTcH+WeKugbpwc6ne1WzGyTD8PM6EBW6O7NDKAM41EU4VOPYRItOB8DuULvq
	 YNKBi/wyP+rhd+SXeuqVGKlRVXz3XYQfFLnyqAVRbxGEkxZ/1QXhrL2Ijyp0FjYiN3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zkubhR3396LqnF6qX1dCE4RtmRZgv0cubgX4VN5Lm5c=;
	b=3AjyDQq3H08wXsqxFJ7j1KZmvY3XDUPliiA51xqU0sQCcrI82p8xSZgeVas8+CgXbeQM
	 nGv/1IBO5OFR2ucHBPVeFAz5J50F98EaqEF2Al6HbE3pmMWNrCD+eu5WhIWnefaHkt2ec
	 UkGpUeAcVK0lQdX4Wzl5q5fzI2QuvthPixW7NiJRSuh0PzepwG8UExOOT6F6TYeEkZWnb
	 AM4Wkefa27/C6rR+4CwH/PNeIyeDooL0bgKrd9sKyk3WoWy3ehDz7VEu3GidlQj1oelI/
	 LqT8wFf0K7woCuMlIo8PIYFSLCtN80X5YjiHkwRJYYcoUtvELwPUQtRZWUrXsnvAlJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObuU9Ma5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744D606A682
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObuU9Ma5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C71F0093E;
	Mon, 23 Nov 2026 04:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406951;
	bh=zkubhR3396LqnF6qX1dCE4RtmRZgv0cubgX4VN5Lm5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObuU9Ma5ec/4iHFIvvRTA6r9B5h1bY5FAeZXL/xnItmGhLcxmeJU+qtj+XM1aMuC8
	 U5oKb1YAGfnE3ykjVUMDBDg0xt+aZ6/hfRv+73Gk99Y2Qqz8WHEwhixjtFVMMelb0E
	 Z04u1CEXDnFhyrxrrSY9+yRgsWhmOLODOjWhXWmaCQfnLvORCikgYS6zvV+vWXIUcR
	 AqaeDqxuLoupPffomF/OgQDjE+ewn/x5ZA5Lm6ndeOS7CvUtxMb5foqA3cvjeP9mli
	 2kOo0yGpjB0tmRmvEURTjZxK4MEzxZIsh69d1vNfctQhoILJY/jG02R8Hy+w4Tw3uw
	 8eBmex14ahPxA==
Message-ID: <sashiko-outbox-228649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf build: Fix bpf-gcc skeleton codegen and CO-RE
 relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123040151.4094997-1-irogers@google.com>
References: <20261123040151.4094997-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 04:09:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When building perf with CC=3Dgcc and bpf-gcc installed, commit
> 63bdd143c589 ("perf build: Support building BPF skeletons with bpf-gcc")
> selects bpf-gcc -O2 by default for tools/perf BPF skeletons. Several
> BPF skeletons compile with bpf-gcc -O2 yet fail at runtime during
> libbpf relocation or kernel BPF verification:
>=20
> 1. -fivopts strength-reduces bounded array loops over BPF map values
>    (such as bperf_cgroup.bpf.c) into PTR_TO_MAP_VALUE !=3D PTR_TO_MAP_VAL=
UE
>    end-pointer comparisons. In kernel/bpf/verifier.c, is_branch_taken()
>    returns unknown for non-packet pointer comparisons, causing the
>    verifier to explore one iteration past the map value end and reject
>    the program with -EACCES. Pass -fno-ivopts so bpf-gcc preserves
>    scalar loop induction variables.
>=20
> 2. -fipa-sra and -fpartial-inlining outline cold tails of static BPF
> [ ... ]
>    checks (rejected with "pointer arithmetic on ptr_or_null_
>    prohibited"). Disable those passes for bpf-gcc builds.
>=20
> Fixes: 63bdd143c589 ("perf build: Support building BPF skeletons with bpf=
-gcc")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123040151.4094=
997-1-irogers@google.com?part=3D1
