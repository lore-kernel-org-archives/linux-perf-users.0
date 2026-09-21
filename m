Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2718C933
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969144; cv=none; b=BqxEGoJe4A3fRtpqP7ecJjBMgDy4BBxwLPOd0IGqW36W/RshzKdzKRxjLaBFjJhzAPNviSkrUIUUgROtsovPVFjvlYy7rAAK0E3hq4vV018KledSZYqT8/Rr34xCqa2hD5WrQNPZn6cxsF+nDxqbrZIlwTX98THnm4ooViwGjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969144; c=relaxed/simple;
	bh=nqmoj//gOZRJh6YNYaVJbgEHBCmO9ADXj51u65Ap2Zw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5vA9MOh+H9KUDnI4ViZ0Gr/TWT6L0WkNxv90LruVVIWQ5lFu+Tzo7IBEbg8axIWfloIfpS3pMJ5O3IZNWoalQOwzUxIV+ZD8v2zwAMPfDqVOuBO+YDwLyuCF0JuP8BBGmcojNUg3jD4J1bXM1bxzGow2K5Mrex7Go8peTBGy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyP7nY1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyP7nY1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B641F0089E;
	Mon, 21 Sep 2026 05:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969143;
	bh=iFcv2i3+J1n/XRTWj++aVwRblb11CEa4Jh3wVjUURTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyP7nY1u6grbBilzR2dJ+ltyOalYa49mc9OrIVUeCswJ7kFLE3ELijEo/O6aQILkQ
	 qyHGxDyafMQQfbrMr/EYI9dubXgGye46JCAmnkYmq5MkVclHexHCm9WynLPegyKwHx
	 h/iMTxOnemUi0oz65dTJAoY3BSRq0vrVllIFWW924+UjUG6j18j38Rgj9FODF4Do1D
	 1Z13+8b5VXNUhzK8KJ+75qxiLvWCjZTsHTxpOX+Skkk2R73JroZ8zF3seVEfT3xfCq
	 h4FO1gcXCuQ8hc6JY2UAmx/z2MdMO0MaX3ACF0GZYYGStbd8JJRIyGYJmgGpm7mvPO
	 KmGH9XZt51+tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/49] perf python: Port rw-by-file from Perl to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5c9f991f3b01de3f4f548d31166b691a6b7ef15c.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <5c9f991f3b01de3f4f548d31166b691a6b7ef15c.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:39:01 +0000
Message-Id: <20260921053902.28B641F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the legacy Perl script rw-by-file.pl with a standalone Python
> script in tools/perf/python/rw-by-file.py using the perf Python module.
>=20
> Improvements compared to the legacy Perl script:
> - Remove the dependency on libperl and Perf::Trace::Util.
> - Encapsulate per-file-descriptor read/write byte and call count
>   aggregation in an RwByFile class using perf.session and resolve thread
>   command names via session.find_thread(pid, sample_tid).
> - Add argparse CLI support (-i/--input and target program filter) and
>   full type annotations.
>=20
> Add a shell test
> (test_rw_by_file_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D27

