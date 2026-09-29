Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79E2E8DEB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648686; cv=none; b=pDBNOLwa3upZeVs9596IcLFaSDmW5ygjBh9DXv6tmytF12tOJGbyylRT/BNiM5FkQBKqQhgoTzE0FmSbx5GYADmsty26ADbTlRiCecdhqU7MVJ0ncz0pVfE4IZeqSatu3feFwzELuzW7e3cEXVqDrQBRLYH3PdSnfeX0LRvQXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648686; c=relaxed/simple;
	bh=gKvKtql/gw0dFDHAgjkvILzq0EeJD+TFNfdz6/lcDr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPa9qjPV7OY2bztmwCw6Ir2UgwR/IifJk/xacq6Z+speQjcZmqRM+0bRY3a2HoHhqsS9Li2hOCBfZ2iTnctLplD1CboK412bF1IFAGqGGATH9qxz2/XkF1HPW3SaZZBC9U1yMVQYRQcT5tIfMOdAw44kYiTypujhU1zgdc1+2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3q7Uqw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3q7Uqw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1961F000FF;
	Tue, 29 Sep 2026 02:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648684;
	bh=gKvKtql/gw0dFDHAgjkvILzq0EeJD+TFNfdz6/lcDr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3q7Uqw9rWur6MVUwVNLj8jcdVXvXfOfY4m66dnJ/bJ6QsqEjFYrJM0ynenRZ8zLn
	 ycRnB/JQPdshVG4sNUFpGilhl6kxkPBELk5bYA4HvJi/eBVngKleR9WOGvIDz58xiM
	 9fTGnQvnobnI4N9ubn0jUukkJ2CGYT1ouRHW/7Uwd/ADMErTAVLtDkXN/39jNn2C48
	 MuULjigY3z1cQyT85ZDva0vzOpjupUj9r8cwZ/I0Z8B/n57pGaaNxarAcXTTe5VhLO
	 cPpe6sHKw6JYEZB0+NXQNcIPDhD5HdywINLnmQ1Te09CTPKDg/cIDSzCv9hddGX3z9
	 WABd9f3cVoSgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/9] perf python: Initialize debug output on module
 load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-9-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:24:43 +0000
Message-Id: <20260929022444.4E1961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Unlike the perf binary's main(), PyInit_perf() does not call
> perf_debug_setup(). As a result, the first warning or error printed from
> the perf Python C extension hits debug_file() with _debug_file =3D=3D NULL
> and emits 'debug_file not set' without a trailing newline before the
> actual diagnostic message.
>=20
> Call perf_debug_setup() in PyInit_perf() and add the missing trailing
> newline to the fallback warning in debug_file().
>=20
> Fixes: ec49230cf6dd ("perf debug: Expose debug file")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D8

