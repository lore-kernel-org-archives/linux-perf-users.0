Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87B39061C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897213; cv=none; b=OTAQ0v0rJykYPtKFZPpftPn92vFAzVN2tZ21U896wF3NV09vYI6TGMQ0XWkxz/KS/BMbpexZs6yqk3w/UylB9qMfVrB5JEY85KBfqHPuAvb9/FgIa3KjoPnCa6OpJCfgzFjWoKCRAnfHP+mbyoH5TmRcK914O20smIQDVA5Tcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897213; c=relaxed/simple;
	bh=s6SevExPKvDtzCVvhjEvEe92ruHnv4xnAOaIT1xEws4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=b9i557FeFAxqPwLSg0q1eC3EwesEUWhqpNtIbANGpUn+FbBAO7GhTeStg2BSMbT3WIrSY4QxCRr07dopxeDusYxI41F0Cb/JQ7aTalVOsKlySLkXRjQXqXbsxCr6sNl5BrNRPVw7l0Go45VnHxJMb5Ovp9uE6V06u8N5+5Unye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/eCO/bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/eCO/bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5A91F000FF;
	Tue, 13 Oct 2026 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897212;
	bh=s6SevExPKvDtzCVvhjEvEe92ruHnv4xnAOaIT1xEws4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/eCO/bqgVL5RiVBWGja5S4zTRAyuEBj31/3atG4aPsFX80iMx1XmQJMwsrwTo8wa
	 Jr5qCnSCvAJNRdK666YS/kptklbYl88fhxGzVjaRAUO1dB7ZseE5f9DI1QG370OmoG
	 VaF9iOu384XCZCx9ENeYndQZebW6twVb/g+kYs8nvWVskVhFKmUhoBQ5C6blPtuaD4
	 z9vN5VOyT5km1Zy9gzCJGU3L+tscMX3RIuNZloabsYKTFY84aoLw82Phvfc8mEXpF9
	 sskfQlP29lySMCPa0E+4p7TLzlaTIMfKeU4/r3vTutj6jnR+QVMuDhOP/X5k8mOJAA
	 V/s2qF57qJR8w==
Message-ID: <sashiko-outbox-169785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf: arm_brbe: Remove the check for TME
 transaction states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013130247.4135515-5-fuad.tabba@linux.dev>
References: <20261013130247.4135515-1-fuad.tabba@linux.dev>
 <20261013130247.4135515-5-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:13:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When an event samples branch flags, the BRBE driver warns once if a
> branch record has BRBINFx_EL1.T or LASTFAILED set, which its comment
> calls TME-related information. FEAT_TME has been withdrawn from the
> architecture, and both fields are RES0 in DDI0601 2026-09, so the check
> tests fields that no longer exist.
>=20
> Remove the check and its two accessors, which were the only users of
> the fields' defines, and mark both fields RES0 in the sysreg file.
>=20
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130247.4135=
515-1-fuad.tabba@linux.dev?part=3D4

