Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37A3E4104
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622089; cv=none; b=WGt5G4/hw3WI7THeAU4e/D+s4Bn7Rk6DFIK5MPC8WAmJzp1iQr4xOkXIB9axrtRE2eAbLgNK/2lnvPqgA+WVx0FtbKbRCElweqbPGY5xsPNCs8Qzj7KImKTXMlB7dthPSzQwfjq0NyfknkzNYoFu7wqG0iRxVxcZOq9oI/wZHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622089; c=relaxed/simple;
	bh=cS/mn8Mez3fNkiPkGpskB/vwhK35svHgQ4QRtE2kndI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AxZvhL23U0ef2/Q/udt2xvfMa+JHqyb0DT6HXX7Z2q0BXtEBUfnx3Ej8LIqE7tRGb2WJHgiVhjh0RdN6IragynjGR97aZ1xhxwISi5fXLZKSQaEdBJR4LHhVTCSROWzB4mtzn7IQ+AurJpXtdXNyXthBmKCP7Uj6mOiEPCGp9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYuLvZ3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYuLvZ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227E31F000FF;
	Thu, 17 Sep 2026 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622088;
	bh=cS/mn8Mez3fNkiPkGpskB/vwhK35svHgQ4QRtE2kndI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYuLvZ3otgxoRPaXjtK9ebRUYqeH3HOGG6/3x1bSUb41zmfG+wBurm1XKIvsXfSnM
	 Urn7M7ehqTY5nXb+44mKrNQDP/ZNsWb7jq1pWXCkFvgyCfJwltTM6LWhSgYWXGAH8z
	 RG4hFsyGBy49D0EFx2i5zemop0y8d+OS6D4huc9VRosZqjZGbrklEBiDhsq6+kHnrj
	 IaysYWHpxixDljc7tWQkWusj6xd2uzvnkufEqg4J1Kure8+/bjG4bOtb9kA46YMLTm
	 QOkwzn5MLMDhJOSqDzZO3MoD1HN28nBwUM/ZpJ+9UQQ/87aujf/rcXWPJWZDNLjNnh
	 5ZPz2bPT2weQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] perf evlist: Implement evlist__can_merge_hybrid
 using first_wildcard_match
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-2-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:14:47 +0000
Message-Id: <20260917051448.227E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add logic to dynamically identify mergeable events spawned from the
> same wildcard alias via first_wildcard_match. first_wildcard_match is
> populated when events are parsed, in `perf report` the events come
> from a file and so the first_wildcard_match is computed by matching
> event names.
>=20
> evlist__can_merge_hybrid only tests whether merging is possible and
> doesn't modify the evlist, so that it may be used as a predicate, for
> example, to decide whether to display a hint. The linking of all the
> matching events is done by evlist__merge_hybrid.
>=20
> is_pmu_core_len identifies core PMUs using the hybrid topology of the
> perf.data file. Should the file lack the topology, the PMUs of this
> machine are scanned but only when the file was recorded on the same
> architecture, as PMU names like "cpu_core" are architecture specific.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D1

