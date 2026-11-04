Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755935;
	b=DdbR/H0l0iEEBRPQchVfVf2hJa2ICzvH2ZQ42nwYXSSiZomRBi5YvLF/0Eil5J3d3Hof
	 FRXR/1GZrmXa47HTqDukCo2TDE5r5IxX7yzoj1ku+0a7Zk7U6NfJQLQKZxK+LCwQe+l5I
	 brfSBu78Yd6zOdl7K0cOmqLLOh4Cf1LlTxyAR5wNWtnM3SaQbmKSjUnxxTWHOTGrpgKFP
	 hKbzC5tIZ/agAOR9Kjf8szau3dH3KvlTtGY9PFfxvLA4akp9MweCgWh1lRemVyjnlZNPf
	 strCUW9AX3+UfOG+DDkwsfz7SFP5QQAMWwFX6Dk4P943B7+zqAkXft+DvoHAODcqxjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RkaWltdH5Ztd9GcGVbtYsz0AQ2Nmoxvu4KCGf2TzX5o=;
	b=HbfZC5fqGL1SdE7akUHhcMlgB7tbppqSnCH/gRlUtycRmaZ+7RGMUBkVQouTs1RfDiF0
	 +FwoUlpdYI0Senz7VX9SUumNhaCwOQDl29O25eyr8UOdP44hz2KNGp02XhPrgQSpPz8Xw
	 rBLL1JbhBz3nKKZCwCujH1bjPbZth4rkcTaVtojDl2/JKepNAZJcG0Od8xVSQ8lTDBzgo
	 BDLg7fICjvqboDsDqK6T8xPGSYaO0fQNjx3lbL7AEiqPDW6tXvsZAgQ1fPjPc+EQyrdLC
	 Le0RdF6el167ICrlLSDHwe+ZfWPJn0u+lU0gF5W/mzQEevuQng1x891Sclgpri0gdgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzjtjRRy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9F606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzjtjRRy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9801F000C1;
	Wed,  4 Nov 2026 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755934;
	bh=RkaWltdH5Ztd9GcGVbtYsz0AQ2Nmoxvu4KCGf2TzX5o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZzjtjRRy0Q8TjgwO6+JX9SQ+AqA1YPx4DMCPTn9djv/mC8S9A+IQbAIrGncTjHmTS
	 SbPHzCfrgN/vSA3iepn2kRV5yOo1nme0wY//veVPi45DsP9pw7dbL1GEp2KLsqki+z
	 2oxx3ZUEi8p6pf3a56zo09Hg1M6GxNAEgDIulWI1vFIyR5tgrmXMgZdujfJXqg54kc
	 WHAmgqfuJguTblwf/3yoTXGNtrkgcdh7D2VMN9u4DeUY9sIIBJ0WBy3ClwP/uipcLg
	 bI/8F8W/ogu7v6DV36SzAE/07w9uMssYa/qN7LpBFlDh2S82iCzMCxvUMjg677L/pw
	 cHGFgJPnJ94kw==
Message-ID: <sashiko-outbox-196354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/41] perf test: Make the CPUID matching test
 architecture independent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-12-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:32:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The arm64 CPUID matching test called strcmp_cpuid_str(), whose arm64
> MIDR comparison was only built for arm64. Now that strcmp_cpuid_str()
> is given the ELF machine of the CPUIDs and all of its comparisons are
> in util/header.c, the test can run on every architecture.
>=20
> Move the test from arch/arm64/tests to tests, as a "CPUID matching"
> suite with an "arm64 MIDR" test case.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D11

