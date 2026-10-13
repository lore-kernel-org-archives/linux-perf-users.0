Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD1450415
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923133; cv=none; b=ZuVDwo8TLCPeM+r8ecXZ+DShUhT/asocHTiAcWNrUDPhBfqI2d0jxl2Wb/fnTNavEiCATdMbmIBFiScH/zqJvx4PQROuQ5ohFsaTW4WvSIPY0qQgW4e+dxBNu6Y2ZZEaB0ULPTy1z0z3WE/at1Z/RnUrQtoNi6urEpTPtNdTGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923133; c=relaxed/simple;
	bh=KXX6YI+oFaB6TC+Wqje7do3MMGiYR7P4ETHUpJr225A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OB6BmCpKwk9wpk81LZz2mBEusLXCjKfhMGCQr6mKQUlvAsV3sA8sK/NYQHJ3GlI0R+LxI4QxqFEPbSzh5IXdOf4Y9X4rb0YIB11InqUwOlnAbcTrKkDFvfBnBwTUW2oYl26UrLmd0lcis2cqwxOyVi3/AOYI8WdPd891lUvERuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWyksA9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWyksA9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6271F00893;
	Tue, 13 Oct 2026 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923130;
	bh=KXX6YI+oFaB6TC+Wqje7do3MMGiYR7P4ETHUpJr225A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWyksA9ozOHMr78gVxdz41JDpqQaxeJX8u+thmFhdHU7Qb2YV7KnEQVUHsmM6p1Hv
	 W6xGCgju/IUX/PRtP6g2Uhc7ztaNr4P0TWWqkkcbpY1KHdCShbCbyNXRSawbu/HJ6g
	 1gUWeN2r4jWgGf+T9sACmhAqd8uSeQNK9oX+LVePiJth70l6+kaHO7mvsFIpmg9nw7
	 khVf/9p78A1WFkAQZEv11ORibWZkL+vm/8DGlhGDUiDg7Cij8tIhisymjJKXpTz1hA
	 /+dUI1AupY3WvUOehzmNR91b+XROtToKGGlYWZc6MQy4+EsU2JwP7VbID3QBZfNjz+
	 kdrROvpRAtc2Q==
Message-ID: <sashiko-outbox-170457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/19] perf tests: Mark the C tests mapping perf ring
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-19-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:25:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The C tests that run 'perf record' in the test process itself map ring
> buffers and so need room in the per user budget set in
> kernel.perf_event_mlock_kb: mark them with the new 'needs_mlock' suite
> flag, see the previous changes, so that they take turns using that
> budget while the tests that don't map them keep running in parallel.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D18

