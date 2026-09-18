Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07660397949
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713381; cv=none; b=bxdYMUj7f4Rq6lSaaRx5IxkIEdIsId5AeiOVGWj4fePPNf5zeoovrpvg1hbjM+ni4VNitDXZSiwuHr5NXB1goXXJMJCJuVINwk9v6M09PuSFq8Jg8Hh6feKlTKth8PIJmd18l+cX4BKMe+/lwUn89qqxWhSaLp8x8W4JOcFF91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713381; c=relaxed/simple;
	bh=1FDJ9hPvVWWSThU1hF8Wo2Gu4YR7r0tiC/CHLoDrpnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppUheEYx876fOGG/w9jdJvYdzscGVhpARTnUptxbu9b0/GxAgZfx7iwodOBt5P2pyQ8mW3vTiuBEys9i3dvbIM51Rv/ZRwe0XGITFxa+xXlT8ocu4Agvy9zoCO1v690GybqB3eKrlK4PXyuGjvoedcw/y5yFZ+fLbiL67W9V3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixAKLUdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixAKLUdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B051F000FF;
	Fri, 18 Sep 2026 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713379;
	bh=KkuPZqTCWnirmjvSDpBXxc+zr9r0Zey3SP99FRuvjZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixAKLUdqfiHIusHfYLqERPbzTQGL7MV2qcMin4aICbGKiuRYCsNE5DZuqux3Eugwe
	 JidJ1k/9vvZxtyGTkbw1nWbabLn4iNCaQ4MgCHRTq5n1Ri1vaZ5bh+lwlCMAPBTqy0
	 e5o2Fl13zhB7yZYU7WXbxBRJ2/UY7MARntdVGugWWIBusRPcdO/Q/CMRDPKNa2uTYB
	 MAv+Z9CsJnIjwLkvLfNSfAI3ihQ7AnuEF+b9SPSWOXBX+0wE5s3BOpBCh5vr9U916z
	 GJi5htY/yIQfmWAJBfTGsra88UzJuIUGPs1r7PXwyMbpSU2Nb2C28tAecNZyWkipes
	 GJgxLiv2KKinA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf machine: Add session back pointer to fix out of
 bounds read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918062620.2145220-1-irogers@google.com>
References: <20260918062620.2145220-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:19 +0000
Message-Id: <20260918063619.78B051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> thread__e_machine_endian() decides whether a thread is live, and so
> whether to read /proc/pid/exe rather than fall back to the perf.data
> environment, by recovering the session from the machine:
>=20
> 	session =3D container_of(machine->machines, struct perf_session,
> 			       machines);
> 	is_live =3D !session->data;
>=20
> That only holds when the struct machines is the one embedded in a struct
> perf_session. It is not the only one. aslr_tool keeps its own in struct
> aslr_tool, and hists_cumulate, hists_filter, hists_link, hists_output
> and thread-maps-share each put one on the stack. For those the
> container_of subtracts offsetof(struct perf_session, machines) from an
> address that was never inside a session, and the following load of
> session->data reads outside the object, which is what ASan reports.
>=20
> Replace the derivation with an explicit link. machines__init() takes the
> owning session, or NULL when the machines is standalone, and
> thread__e_machine_endian() reads it back through machines__session().
>=20
> A NULL session is treated as live. The tests use synthetic pids that
> have no /proc entry, so the read fails there and the e_machine falls
> back to EM_HOST as before, rather than being decided by whatever the
> out of bounds read happened to return. perf inject registers its
> session with the aslr tool once the session exists, before any event is
> processed, so that tool keeps reporting file based threads as not live.
>=20
> Fixes: 70351029b556 ("perf thread: Add support for reading the e_machine =
type for a thread")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918062620.2145=
220-1-irogers@google.com?part=3D1

