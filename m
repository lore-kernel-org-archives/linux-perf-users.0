Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1484A3F3A
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075301; cv=none; b=S7Wo/TWipIlTA+qEgnrJX8dp9apE4aoML9ahcf22IErttX2B3nidOmr2ylsWfNkPweO1lL1+paQ4lov/jpJdnAvoccBhFzwc56HTQ8ZW9Us4n5fJ5vUJOXBmdha7U1JHmumtm5EeEknb72i3TaMxLwDb5P0jLs6AKPTVSmiv5a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075301; c=relaxed/simple;
	bh=a8poXbKdpqDYheayEdC+iLlrG9v0Afa3P2y1n64JINs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OC33fC2+Pmju/RPrqADqNmto+GuSYq3rIpekoOJeJ0pImyBXBm/8y2YzdneuRlJ2LgTlyrU36eK+oCsPUK0PknI0AaN6eVdTytQ82fgKQT1BolbuT/DmjTOsSfaCr23aJhi0sibO5xdDWQyO86x2fT33D4iI9udGGleU4FlQuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGcEEzXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGcEEzXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ECF1F000FF;
	Thu, 10 Sep 2026 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789075293;
	bh=a8poXbKdpqDYheayEdC+iLlrG9v0Afa3P2y1n64JINs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGcEEzXINKtY/gFqnkjsiQTQLrzPujg82nkiVGD9HnHdZrQuqPILq/xbSvzjuNAKH
	 hAtzuMMGm7AF0lpvcAZR20UETLstP6tTlkmtnk2zVMt6egA4ZmTl9hUkiHKdLjLYX2
	 eMDe+Z4KxS2dOIMVn0fovGTOqDtzB76zp/JAgaThCi6Wy1Byd63xNtJghOQnPEZ5XQ
	 uBgHv6l68ZwINrpCyXszgrk+sAIYXvJfDni5y7WcrEPBfNqde2kO/5sedl3JAUoA5t
	 BaGcytMnWxwBAugrNbXje+/iJmB2H0fESxl7NVnbCptR/DA2RbJ8clote721Q+haAy
	 jhfijxPkJ4mPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] perf header: Fix HEADER_COMPRESSED validation
 for comp_mmap_len
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910211221.3154261-2-irogers@google.com>
References: <20260910175634.3014018-1-irogers@google.com>
 <20260910211221.3154261-1-irogers@google.com>
 <20260910211221.3154261-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:21:32 +0000
Message-Id: <20260910212133.35ECF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> This commit updates process_compressed() to ignore comp_mmap_len =3D=3D 0
> when validating the compressed header. A zero size is valid and may
> occur during testing.
>=20
> Sashiko review flagged string.h was missing (preexisting problem) and
> so I opportunistically fixed this and sorted the header files.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910211221.3154=
261-1-irogers@google.com?part=3D1

