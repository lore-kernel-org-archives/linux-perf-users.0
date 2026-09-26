Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4D388866
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404373; cv=none; b=i60wDZmHwvR8J77QlmuxSkFU+gWwWPi1S9lS8IKAzsQK+1rA5HfzYbrYbI9AmZjEHKBP1yVHw728+ClhJUZoJxY4HLoG1o2Br4BJkrGhIiGIi4o7Hk6Al6uPzLgzDqlaiXaCQgB4dUgQ/Xpbi05l2HSP4cU51CNMBnpioWdYDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404373; c=relaxed/simple;
	bh=gJ56VSMxDWA6xd7n3XgVDswg1gOJeMzK4Z9jUSM7Oq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGFLXGXYMfBpYysEAZkDwkmY3ZhNuhAvaJPVRpZPqTnqF5CJNF2dSad+/xeR/GQwhRyElUY/C9GM02YTz9KaD117Idrt8HYNkyoDnUVJiB3cpdoJlh5Osf2S1NJ5m/rlLshuu4laI4HVMYO0ZhGIr1opKo+Dq5T++jjuW297zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENzLRdUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENzLRdUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740F1F000FF;
	Sat, 26 Sep 2026 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404372;
	bh=WT2AQFtWeKf6aVL+vlkgZZPOZ3apDdvDNYjlBaYzNUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENzLRdUcXVxq80NsNVsRgwoNNLNjn35STftzAsiE1xKozrSw7aBqHVWQpw2F0Ktig
	 rWnwPugrejBkOq6tBbMZiVFalZgS0B2R+EB/oYz8p1z2o2YiPjt7T3RPiOi68cDZgE
	 a9GiO6Her01dHwgbkWvxLW9c+iI8ihR8SNW9QMxzQa+zDTvu7gvEzDGsPD5dudNg9n
	 V0qPuHSVFiJFzBzDCRhoNIRxVMB0Yi+MXCg3hDyyAH4+9RDpHhAMRnhQ7CfFG72GqA
	 Enw5ugmw5zP93fSmrhhnbGg3tJwmbpc6sVqgxZn8rtnSiw/8B1vsgN5yaeXJyN3zmM
	 Nfbs3DJEyW5qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/49] perf python: Port failed-syscalls from Perl to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-26-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:32:51 +0000
Message-Id: <20260926063252.5740F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script failed-syscalls.pl with a standalone
> Python script in tools/perf/python/failed-syscalls.py using the perf
> Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Support both syscalls:sys_exit_* and raw_syscalls:sys_exit events (the
>   legacy script only handled raw_syscalls::sys_exit).
> - Use session.is_64_bit to distinguish 32-bit vs 64-bit unsigned error
>   return ranges (0xfffff000..0xffffffff vs >=3D 0xfffffffffffff000) so
>   valid 64-bit syscalls returning ~4GB values are not misclassified as
>   32-bit negative errors.
> - Add argparse CLI support (-i/--input and optional comm filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_failed_syscalls_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D25

