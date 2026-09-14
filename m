Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AA469847
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390813; cv=none; b=WdzTbwj5PGQnFtz5nqa362EkIy93EerrRy+vnSUJCwagXibDVyY3zSUVjvmsv5Bj9l3X4axPqTF42HUPn5lBNYqQ5qUmvBff5xGREzS31gScJJT03IZbm83FrX18sUzbKV4150AYhg0m7vVPIv2mFGvOj1Y0zQLH6wkGEaI+Dxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390813; c=relaxed/simple;
	bh=AcExX6O/EH7yhwrO+pxO83svbAWdVEKzcLyU7rQzKgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OEzzaXDVSluIVjs57QjnqpWpELiun03N43NWjepirE1ewCq9ff70AQwyVQdkxh7GVK3Iwq1TFEmNzsru6x8MEEhL0JridtVnPTBN9vWwxN7Z+DTpdZhsWgS0s/dFBRi9ewq8XilSaXH5SKhnDwu9zVpuFTPPsxmwJop9F6s6b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgAEd9E+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgAEd9E+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036491F000FF;
	Mon, 14 Sep 2026 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390812;
	bh=R950JcRdgs/jjjm4hA5vjGRVQaI4Od2qzcSO5tWqOMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgAEd9E+s+OwY5n7+s5Y1TbskwpGyU2egpwCEAyJZUGWk17w84sMQJgavsh30kXcK
	 LOD81PwXmK4b+VM6NfqVt4ZqO6yrNfvfkjmMJnNZn0dcydztM1roeQgy1chRKhmcKa
	 Co0uCLrJS1xTx3aSwjpPXO6Yp3PJhmgedWG8+togYc5ZsOYQg6VhbDK/unlwJulVyw
	 q5mbltowKoaGoauGfBbPoRlmggkODbs7xPXJ3G6vMcq+yxRkAAbHXfK1FF+Zyu8VE1
	 oZsU4f9euMHEQyGve5N5vtmsdB82zzkLwjM9T8BLSUt727ZmdsQrMD0aQFCi+avw6h
	 izko1aWww+fHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-2-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:00:11 +0000
Message-Id: <20260914130012.036491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
>=20
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
>=20
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
> [ ... ]
>   Pipe annotate [Failed: perf record]
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D1

