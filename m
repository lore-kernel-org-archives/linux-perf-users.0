Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B63B1029
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869974; cv=none; b=JRdY48aJWC4WatTt84yPr4iMMxcIcirxgCLbaq6utAs2cp87hoMRnS85G2BZAR0IcBTRFb8qncljJQXdvWEyNVCuHwNpWC4MJKBCYC5U+nJWUFY3Q8hw7qp/22QzJRthXAN22iNuw7OVqhdmSACfwRhDasl/BSUe9hM2naqtr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869974; c=relaxed/simple;
	bh=IPXZW1WHmAqOACRjYbqsd73TLWMlMdufPJxVWPU6FXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TrO1M0jsnRDzg5pv90GFFyqw1nu2ZSY+sQzr8PFVPt7Rjg6vSTOq2442pbx5LKLFzIlSpThTYErkrTKyrZAiEf7IoQ/8sgiXoRed00O1w5rEGIQbvVPIxgfM0qVhomGPMAdLEBJowORJGkNYR8C7qZNEnw4xQfEl7jTJNHUqjuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdZt8Jw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdZt8Jw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303B1F000FF;
	Thu,  1 Oct 2026 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869972;
	bh=IPXZW1WHmAqOACRjYbqsd73TLWMlMdufPJxVWPU6FXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdZt8Jw3g8/t/jUPQhfZDQglGUqnin7CUQ1SRggyMlqpff/CSJIIcBRbuUgjMM8Nn
	 tscHfAxHiw9scZo276OF1eVNPp22yLvTI70T3wBUCEdY9sqNO9tFZZj7nEG0MrmWaK
	 qG7364LP+3xcGw831tzWFSYWj8p83Fem1Vx92Fu8Y7RZJShMV4Sg6PfEtrWt5yPC6g
	 38KKA9PsK7Eqo8xZPLGQICuMGqstKvq517ZFIBY/f7zitjqPyfDGwbkA7xcXGo7/F8
	 TvrMMszR+QJW31i5GXnADRauPC61e/xoIrq40UYuwYTLmj7nHmKf725PU/kyB9UOBc
	 qVoauFs8ewWHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf python: Track linked libraries as extension
 dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
References: <20261001-james-perf-stale-python-build-v1-1-dd3b14644606@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:52:52 +0000
Message-Id: <20261001155252.B303B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Since the Python extension switched to linking perf libraries, setup.py
> only lists util/python.c as a source. The libraries are supplied through
> LDFLAGS, which setuptools does not consider when deciding whether the
> extension needs to be rebuilt.
>=20
> When a library changes, make invokes setup.py, but setuptools can skip
> the build and the recipe copies the stale cached extension back into
> python/. This leaves perf and its Python module running different
> versions of the same code.
>=20
> Pass the linked library paths to setup.py and declare them as Extension
> dependencies so that library changes trigger a rebuild. Include
> EXTRA_PERFLIBS in the shared library list so that both make and
> setuptools track those inputs as well, preserving the existing linker
> order.
>=20
> Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries fro=
m building source")
> Assisted-by: Codex:GPT-6-Astra
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-james-perf=
-stale-python-build-v1-1-dd3b14644606@linaro.org?part=3D1

