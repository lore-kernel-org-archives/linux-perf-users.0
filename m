Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F954774
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850093; cv=none; b=I4XZrxFE4hWELqTRlIQCit685wOhJk6nNtod9hleHMvoZAjNVk3uqamK/JKCh6SeVLrWVdGbpKd9PivOp2d6y8vaMklw9/PNy8EfNQq7ljdwgdCSofU4ryYvJt9tQeBPUHE2bFz8VveEAefr5+3OFlsuVLXqHqFBPbQmGAKiWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850093; c=relaxed/simple;
	bh=DWZWmw457MwYtkIyDFkh71Sp1JLCQsfFDf3bRb5kRXE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E/FOBV0ozKyfbly3Jl99tl1DPLZGG7+TARObIpYl3e6GNqZMfPB9AByoTtSyEUrY+wwusudgECv5Xam4Jggk1/Flr2gnzwUafy7LI8gJl6hbu0IMiowIxcZNGKpTwg4UnO3rrUwpkaDgP6FQxxGLlvz/ZRkMo8ipcnOc6Gm5rXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbXETeYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbXETeYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD081F0089B;
	Tue, 13 Oct 2026 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791850092;
	bh=IhhRcsglx7FF13uBG7vOTaCTLp7CAWm5RSeLDsk1bM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbXETeYCzivxdr0DXpc2ohmuoyRT8SJ0QI0Y9sAfJEDghW7HrIJ0QC3SmAehXG4WO
	 wZFSP1o8wViqSAjcIqr+dT289w0x/sMehZoznBVlFTM1cWynsAbmIULy5SKEf8/ze1
	 LRXlcyoY3xJmdr8ep7EolqriCiJl4a9TWxoWTqfLcI/+S4BscInutEJ41U4D93E4B/
	 pHp8RWbirQ4eSh2HK0Z3tvN64/AhcSNmYGOF/mrD1eNS68BLarPnWCuekZZrk+81P3
	 KZX2fphE8U+JG04l6IAiBcOk01dyS7VBw0GDHeBiAFqDkTqJm7IIe8utmxC0KHNiDW
	 UsSRIA5ASUR2A==
Message-ID: <sashiko-outbox-168777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf symbol: Fix symbol loading from libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012235938.87912-1-namhyung@kernel.org>
References: <20261012235938.87912-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:08:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The dso__load() should return a positive number (number of symbols
> loaded) when it succeded to load symbols.  But dso__load_bfd_symbols()
> only returns 0 and it's hard to check if it actually loaded symbols or
> not.  Let's return the value of dso__has_symbol() and check it in
> dso__load() so that it can return 1 for success.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table wit=
h libbfd")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012235938.8791=
2-1-namhyung@kernel.org?part=3D1

