Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4449C4DA
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303523; cv=none; b=Pc4a0lkyhTltDcA10dPJu3R3rIUtazy5tSE3QGTM0WzG5e27X5F+kzmI5UUKXx6+lo4KHLeg29iOqkfEa0cTH5shJyk1XFzoJ1AqGf5Rpaa/sz100iJmENUzGFv5wnZb0c47R9cjS34ypVQe1Zue+4LmeiGZRwij2fxpMJ9Ursg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303523; c=relaxed/simple;
	bh=cuLgDc6AzXMiGQH1aq8pGafDiwjz4ZOUvDKdI63Y8us=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iWgx7samdhpvro4kuYAEKIUhJbmrtdM3sxUrpxgjHWcxsqzShM6MWw49D+PrOBNiI5pClX2mkXFlUyCovb0abdoziupy+EidRW7QHQm09TtQWjyCRoonhwBHnSVGJuzUYq8Dzcoz6clB0KKV/sGGAjQwF+nE5Sc9UoTmIgRzjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT0cOUKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT0cOUKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3871F0089C;
	Tue,  6 Oct 2026 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303522;
	bh=cuLgDc6AzXMiGQH1aq8pGafDiwjz4ZOUvDKdI63Y8us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VT0cOUKmE0mAaWT4FERrlrxEBvPQCFiDjL5rIZnHyr+lUlJVLmoVPCdCNAizVcjcW
	 VgzM6iv70NNnoSoNCJprEYKyVUCBXrI2ttQT6zrhGvbU0NIYcBHC5ozoJG0b4xXQQ1
	 2YD3rMRlcdDSlKyk3TRXcebJHLzpxTMrIO7cpOLLQxgLWFGxsAJZicsDgdy8rL9jUN
	 sfGoQoen7ZYhm7pADdw0taQllgAaev9TMXidlaW8hWLOnSThyQoQRdrZhVPie+C9Kj
	 tjcUhnczVd3byi/btya/FuzoeCFPjxrReGM6dSjxvS0S9aCpLg7h/bpBAQMkLlLGAV
	 KzhBI6iRaYG1g==
Message-ID: <sashiko-outbox-162235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf test attr: Propagate the return value from the
 test to the wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006161309.3078488-2-acme@kernel.org>
References: <20261006161309.3078488-1-acme@kernel.org>
 <20261006161309.3078488-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:18:41 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Michael Petlan <mpetlan@redhat.com>
>=20
> Currently it does not matter what the python script actually returns,
> the test always passes, as the $err variable is always 0.
>=20
> Fix that.
>=20
> Fixes: 8519e4f44c2af722 ("perf test: Add a shell wrapper for "Setup struc=
t perf_event_attr"")
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006161309.3078=
488-1-acme@kernel.org?part=3D1

