Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD5374185
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551522; cv=none; b=bp6ePq+nZfRBJVbe06NhJVFsZmY9vhyBHHJJWb45O2yY5VqTGhFS461pU66gQjUWwPF+9mkoYPF/S9ZQRA9cvEeUPURfYvkEb3USdNhi148hJQHK3Ia+ZiJTYqW5WhwHjPSofN7k+wjtFYaGJgU7gYw2TMh174wh7cUr5XN7ru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551522; c=relaxed/simple;
	bh=qH9sR5E0p7kZwvE0W4f3iUH5E5Ub1lM0VVoIPdyO4Aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5dgMUspW/r+4KGEoaV16lATVIrLcyI4yBlbwuo4ICCBNigdIRMmZE/67Q2N5wv/eiYVoywIxcv5cvV96ZcN0twhO3nXkOhSXV/AOutGxtmmdH+hKzX0UW2jgd6PkAhaZq1KUnFZoQH77BElp6moTPDNKLZave7icXKhfDAEgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq90hv1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq90hv1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966FE1F00A3D;
	Fri,  4 Sep 2026 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551517;
	bh=qH9sR5E0p7kZwvE0W4f3iUH5E5Ub1lM0VVoIPdyO4Aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gq90hv1n+ICB3p869DGVjftGLIQekHfzNWNSR8W1axonoFu7EE0RLF4cCLqlEfmtg
	 WUXWpPy8yA66gsqDtawziE+ZWFV8Ms7C1KHAbAdY8yYyYJZbNmw5ZoOx7uyq7/+eaj
	 2V8YWw/soj+XGRs3qDJv2ScdjNMh9nhcC2jG89PdVseTvL+kgMiHse8AvvOyA6ApwX
	 rKiaCsdCciFuuxRQN86CmuUz/QwN1KQJPjqh7SrC1o2PmhZki4MQ15cYStQTMDKCc0
	 urbsJCsnzYnJw9XLiUIFCp+k/8QAmLz0PawRrmEI9myFSeJkh4ZGqkarWJCau3CPk3
	 OqqB3BBMp+56Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test: Avoid call to missing cleanup function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904194954.1192154-1-irogers@google.com>
References: <20260904194954.1192154-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:51:57 +0000
Message-Id: <20260904195157.966FE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Cleanup function was removed by writing to /dev/null rather than
> temporary files. The exit path still had a call.
>=20
> Fixes: 44f6b4402791 ("perf test: Fix hybrid testing of event fallback tes=
t")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904194954.1192=
154-1-irogers@google.com?part=3D1

