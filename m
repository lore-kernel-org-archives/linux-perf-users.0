Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E52F290B
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350363; cv=none; b=g5dkiVhL12oLrVOw0MTGRIkSGx9KJYzwNRlWgcHaYvyjXLhl+vswJZBoE+I+iel98CXtfyUfqpcxHK/kphaBGh+62VRui3T4RzZWPmcU+8gc7xy842pN3oLnnYHArRvFN9Savl2UnEML24aysHrHoDEPol2lzRKf/olE3zEaxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350363; c=relaxed/simple;
	bh=u5zb+Gqms3kUXgBXlKz8RjHt3E9jQtaYgEy8+Vl2y+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxPWgt9IXdmcg/0f2oPya1bjwhDDH4nOkvDEs3L8XptMGfxa9dKOFh7EQh/0aNTrDHFo4TxJM4WfsBJdKKWgHVvo1x2/cqrCEPaDHvkM1rrDmKPXRXVFq105QAR91f6KSE0DduNe7no1RIPxQj8dACTeTo8ZwfL4caJHLq2hhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lduIog18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lduIog18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2E61F000FF;
	Mon, 14 Sep 2026 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350361;
	bh=NoUrKnAHYD8PJRqpzIaBoNeQ+WtKbjaXqHOl8pcl5Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lduIog18zIvC1S3yY44WtGXYAjnqPHQK6r4v/fq5Z1vwkDWL6REmxUbQ9Qt+rvNM8
	 AcDbpKhGNZOjFWVgii9FPdoImqqcKMeKZFu8b8LzdXJOSnX6b6kNjSZoUvT83div5Y
	 nu0sgy4cQ0VMJuFayeOofRaG7xFTNpImzfXGsXra61L7NQzCXRmVIq6OiYA8O5HnBk
	 R1+KNkKNDp1nTogi1/u3rysmwP3OquyWa+tnxMpyHaSvbHN68EHxKHOm55QuNxuFEo
	 vroYQQd2fry8xDqwCNdN9O/zPc37yTuFzoUScju+NXo5for72eazeRh052C9XuuoCV
	 tjo2RRdru3EEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf annotate-data: Resolve type DIEs in the debug
 file they came from
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-8-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:46:01 +0000
Message-Id: <20260914014601.9A2E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A 'perf report -s type' on a 783 MB AMD IBS data type profiling session
> hangs, burning all of a CPU and producing no output:
>=20
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf report --progress -s type=
 -i perf.data.ibs > /dev/null
>   Processing events... [100.0%] 746M / 746M
>   Merging related events... [ 58.0%] 293828 / 506686
>   Merging related events... [ 59.0%] 298894 / 506686
>   Merging related events... [ 60.0%] 303960 / 506686
>   Merging related events... [ 61.0%] 309026 / 506686
>   [ ... nothing else, ever ... ]
>=20
> It is a spin and not a slow path: with perf-stuck the CPU time used
> grows by a whole interval on every sample, while the [stack] mapping,
> [ ... ]
>=20
> Fixes: 06b2ce75386df04b ("perf annotate-data: Maintain variable type info=
")
> Fixes: 55ee3d005d62279d ("perf annotate-data: Add a cache for global vari=
able types")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D7

