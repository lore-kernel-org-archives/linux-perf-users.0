Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D3495AFD
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584227; cv=none; b=FuvGTjYRt5dZ14Z96vZ/ZcVSm+qxo/5o5j1t//iT+LE4aq7b11TYOrNgjeA1Te36wSI20R/rYBxUxCDNxj2O9yh5lHhONXMe+kJj4GrJrwgAqnq5gjwBYOYtFAn3V5khUh7jZoqDqS/3W2P1ppQolgiDumOntgC3jYb8KFefyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584227; c=relaxed/simple;
	bh=QFjKqw3QXQqwShERb84E5ivB9HFixLJ28ioc715ErlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fcjKxN2uilPlqyxVgkESoSyTKf+rvQYqnnKIUU6bH3lDR6dBI05WNtZC/Nn2rqkO0Bu5pCtuAutXbwYjsu+ZO8Tsb/4dHyVj+ZqNPjzkOlEAdIJSwbGfpR2d6WrFgE/cdkYQ9AS9VXGLsaOmfJ+ok2gWBrVrF1yPm4/69XHHu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0JWtft6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0JWtft6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1952D1F00893;
	Wed, 16 Sep 2026 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584212;
	bh=kETxInjjl1ojCihD0qSVX6tmguhc3vGZ8/TdZI+VFTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0JWtft6vWO0wWUvRLlnsBXndHp3elnuzDFNFzv4nZ6Bn0gQYNYcyNDjtnw4gj5jQ
	 ykHXMb2oKEHppvsweP+DkYNOTOoND8/0lo4KzMDoAuIu5zz7jmWt1o97weHieUfAxw
	 uGLKKH2Sw7krp3LiPFMChsYA+EWVD5yD+rqghjq2kj3DPjiPtlEtHvaOrK1Z3f9g0y
	 0mvd4aQRNL0mFsEBRjQW+OBvRGknpOHBzfFQ2C/BNPU9FUUGTaHvP3pBeF7BqPjqbq
	 TYW+HqvyXbsh4YdAFcMOMsDOK8YyKF1GY/+i80KkVCsUrq77DJPU/YCzTE6GfI2IA3
	 wuhhG22b+Jlyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-13-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:43:31 +0000
Message-Id: <20260916184332.1952D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used in per-thread mode
> when kernel samples are not allowed, are rejected by the kernel on
> hardware without the privilege filter, so a per-thread 'perf mem
> record' fails:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter that makes those
> events usable per-thread, exposed as the 'swfilt' format term
> (d29e744c71673a71 "perf/x86: Relax privilege filter restriction on AMD
> [ ... ]
> ("swfilt=3D1"), that the old 'ldlat=3D0' check would reject.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D12

