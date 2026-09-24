Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EF3C09FA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228453; cv=none; b=Bx8C8aVBV75qDEyMIMz2VvdLTbPdo45FaSH8a62faP2ZYskJuAhCMFXOkaNajy07QK5SBPlrjAx6y0hEuLxcNAJLFNT7sb1n2f55p85E9Kgnzca6eD7yVyHwF5xpQmFtmU99fYjjzoTBv0Kxy2PfNaXOf6/Kavwp2rO3Cw3aovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228453; c=relaxed/simple;
	bh=rzj58yDU+Ubyis9tuMxP8DMEcu/ERZXnvRMHG9L585c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nAqNL6N91VkVJEEMx/8bsKfDOaMremVzZFmr90hgDZChf7rY/McJwZWKixv4WT+FG2w38TwOqGogoVX7rJ4dhB1mGWDuNviiGrltvU/gOS0WP9m9mf37IYAOY4e1aZvBv9F74datg90eUoYrPECJ7JW5tDEEfdTdbMhKAKJGaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXI5bChV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXI5bChV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B171F0089A;
	Thu, 24 Sep 2026 05:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228451;
	bh=Yl37bit0xe/oxETvnntIFxxhOFEL4PnOh10TR8vQIiw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXI5bChVrn9MlP2X4sH3P8i4d/PaxZXqGp5NIUUTy4aQHRUQLoFtV/1VYfUClc30g
	 6wXnk93J23yvVpEE5CH+/sDAj9kXMX81Gk5fIgx0JXl0DXWdHJV08+4QQh1Dbl8XkR
	 pe2pqh995gKYIelxj05FM72aXWBU/jca80fUdbnKKH59wR91/V+KlvwdGYDc3u5J2x
	 wNCPOP5kQZdzVESQkLACgDxledbx5/Oijm6BVLmUKCDxy1vDbsjrSbYqCaCz5OS9vJ
	 t4vphVq41o4ZzkPdZP7efSThHqEXX+djBq8EOQq2gXhXpZML+SPqRQwz9YEzgfXfw6
	 Cv1u2kCljv+1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/21] perf vendor events intel: Update alderlake
 events from 1.40 to 1.41
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-2-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:40:50 +0000
Message-Id: <20260924054051.41B171F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147=
c7776119c
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D1

