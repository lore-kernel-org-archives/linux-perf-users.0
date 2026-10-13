Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E55372DC
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923163; cv=none; b=o2oVoUClRh89arEyazcLSJvTHmv1fRz81gS2C8G3YeRltL6sVSpdH9W4J99wlKDFfW0PxLlPCvRmCcv2G8CjBpwdGxcsnhKbgwBq4m7jW8jjtsbPEAClWSSP/UBBzD4b74d0KkwqfhSbpcSXaSZsPPqJL53Ck+hYQzI4JXzM7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923163; c=relaxed/simple;
	bh=GJeAQquzeMdZDIU/hp5Fi8n2v+WnDjnNpX3S/sVg9B0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y9gWaSHegUiXHeG/YqKO4/XW+Al4q/2wqAzhridGvrW++/Twa5AhB3diopSGXFcwZ1218jwx4zbz/pZtfFEQaaIC9N50tUW/4M/D35+qTVZkkKSn6/FwqkLIperS/PTj1q4XQ5ovhX8KArD9uVzxGzg9oMEut5cxJZ654zA/ZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4HQkjXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4HQkjXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61CF1F000FF;
	Tue, 13 Oct 2026 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923161;
	bh=DieCYLXy59jUgj7GBehm5tKDfwhWi82b+IIBBGtbz3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4HQkjXkiZUHN1NIl8azhoekst7rD3olZ5eFQY2Y9bY/eaKjHTbUdkaTNhiLsA+aW
	 38WVsJ4s23+Owg45uR6PRy57EDQWlYb2Y4VMwWYmLVFZ4fTD8k7/ZOBYYO5t90cTiQ
	 HcBDLc3TjSadgjH8PEa9NMKKBnYIhzSbBJSfywARYS0fjk93pi8HuRDav+yAxrLwri
	 gO89rYxuvHrX32y25MUtdV7ajamURixOlMtb/bh5Gb/sTy9jG+whYBFEZWRH/zBkKO
	 hSjSh9uVZB0lgwFHmkV1c/uyI52dNtGN13WL0WM9wjhu/xomLjIHqVMzxu+r8WaZx8
	 oP4K4YKbuKZUQ==
Message-ID: <sashiko-outbox-170459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/19] perf evsel: Don't dump probe events to
 PERF_TEST_ATTR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-9-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:26:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Events opened just to ask if they are supported, i.e. the ones in
> is_event_supported() and is_libpfm_event_supported(), go through the
> regular evsel__open() path and thus end up in the event files written to
> $PERF_TEST_ATTR, with everything but type, config and disabled zeroed:
>=20
>   [event-0-38654705664-3]
>   fd=3D3
>   cpu=3D-1
>   pid=3D0
>   type=3D0
>   size=3D0
>   config=3D38654705664
>   sample_type=3D0
> [ ... ]
>=20
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/linux-perf-users/asWQvXRdqp_RK85c@google.co=
m/
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D8

