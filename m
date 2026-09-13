Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E5825B094
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338880; cv=none; b=HDfuzyLoni2n5WGXt6WcrYFPbUSlz/b3pHQNLOXXwkHrLWIvb/bog5gHmpWy61oO1ITIQMsmLrQCJy4q6nFoCyfoPFD5L4UPRp1WFx50RLPJl0Vgd9+Rl0mZijhrf57T1gXZO9S+iw8zgFXz9+qIyg+ssj1fK5ZSFviIFMOsNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338880; c=relaxed/simple;
	bh=RIog+Wuqy5h79X1IKx1fkqltrEvZiJ4erF+lZqbYe0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CfvVttnRDk8e4dEWQFvnqzc1vPqt7sjl6HbvKRni0MIlq8YAjRQUk/5Ix+Aa7mzHb+6rxhL7qwhExs7ZrHCxO/UgUeJXrySK2U/1dYy53mnfd8ujYa6K6h++A5MS4ZJkUYECRQUnxIl8x9nmZB2Ufup4iC+TuMoN/U7to8gSGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSSTn1gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSSTn1gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EEF1F000FF;
	Sun, 13 Sep 2026 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338878;
	bh=XaZfuBGfsdrCldIpckyL06CJ/CSQz9qqhoXm4Ztr+Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSSTn1glt5Yx5w9SYcIAEgMTUEDva0dHrf7iMaWtgQHJLNgoHcz3zDtUE95Ls4nRA
	 2ZGtCx+RQCIQb+MAtz8tv1bSVy9sGwIymutcj7Uv6JwToNm2CQfzSWlPTaRMR8z75F
	 LUeprK/dXCE97Z45p2SN1HvdTEpWa0gStjvcbSiFyWkabFGDS/g2T67UXymfCbfZJz
	 Sd6DiO1fhxoRa1SjU26PdqdTyTOOzlygYf8Dc58UHqWuNwl9W/T68cXA7KZzrRiZP0
	 9TfwEX3jm/n2JOB+0SEYzkC7lDaaSpZWN2AkZpRUJ0hFTe94T/9T+SJ59ESuKQVYBK
	 qLMramsguCEvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-2-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:34:37 +0000
Message-Id: <20260913223438.73EEF1F000FF@smtp.kernel.org>
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
>   $ perf test "data type profiling"
>    87: perf data type profiling tests             : FAILED!
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D1

