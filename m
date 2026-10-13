Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C065524B12
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912563; cv=none; b=VV7c9mdwPepkR5RHrkaJQfZNAIYAYggGvG8HPolIHwSkrn85EtlOzvgHab9efM6uFIQ8LMy7GmMMEnrKomg2mQhoOUqzaFI5Zq1jtBBT1JSpfSojyqRho9HUT/Y3ujakboT5Rqp8tE+mYtvaB46m+kbYIqZ7WJ16BQrlIkSw+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912563; c=relaxed/simple;
	bh=T01yFB5Rn3f5PceUsFYz2E1STnR8R0UENaqF8nBBBSA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UaiBEaaCX47l7PoEKSNrM1dzSY+hnK/ehvhkRG8LbI676ItEt9MgrHEce2dRyhBe23KrqJ9u5ksvexq8ly16gH3QgxuFwNfqGseue8wR7170ZcAjTunTDCGOp1ur0/N6KZSsEkbvQUP4DIMztyuqifZLf7AuBnXytyYnBgXsZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpQ0t6S3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpQ0t6S3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A641F00893;
	Tue, 13 Oct 2026 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912561;
	bh=lwD66YgkSYYY5fqQY+vcTkh6l+lBPkWpCWS7WAGdxVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cpQ0t6S3m77OpyEfGLkV7U1aEBvMqzvzqA/qa6j6KQi0S7WN1YngseUXp/wDj49N/
	 KFJ2CSPpqWjOCS0S6H4gNaC1rK/l1zevE7zSeOM6vtyZT/6WZ9n6M6MW1W4fcQuHCt
	 nWG3OSbDyz+0exxDQZvxvzRv/HKKYYYXiP81uPb2fd2AWOhVJSx2JfgcBzoFUOeX5B
	 Z+cyZgTbdLIAa7uvCOpJmsXEMn3MOsrIZDFN8CprADNidAwXHTYafAmNxd+vNKO438
	 erCgW8ZVYzykFoLP1Sk6tltBaxEibvFJRpgmGzWKUZZ7H8w54Amp3g+CP3YGWQQ3Dj
	 AHTigMoYTmlEw==
Message-ID: <sashiko-outbox-170228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/11] perf annotate: Simplify symbol__disassemble()
 with dso binary_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-11-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:29:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now it should set the binary type of a DSO properly.  No need to figure
> out a filename suitable for disassembly.
>=20
> Just call dso__find_binary_type() and dso__get_filename() for that type.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D10

