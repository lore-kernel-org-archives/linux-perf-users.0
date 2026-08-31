Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC13AEF50
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182376; cv=none; b=Op8R5wddc9814i4ffxaDAUO6PADXpZ+G5p5IUWS3zPVxZMgbotlwR71FlmJgrppTnMdry/B5Avj/gzn+OR2GkwLfv187OHcbnFQgoB+Jr5Yl+/d+5VS8YXmCQ6thlh1rElPQpatudOcO3rFEnUNE1Y+sxTneWun7dH2WGFdbECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182376; c=relaxed/simple;
	bh=puzuoROGthxAp5/yHWXjP87nLrRmes9I+L8zj2kDPsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jABlUCeYw2bOETr4OLV46Vgnmmx3AozeX7MEaFQ6XKA3K/naB1H6lZ6cXUQLFzD21R3+Domxc3ur+VfbcKpuKLA9WwT7nMI6IZ08S8yQ3+nUjT7NBxAnij+58St+LWhVU1RJ/cOtn6H3DtHmgrLeZsiH3gVK/oWVvJeynZSxmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U65rINuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U65rINuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CD1F000E9;
	Mon, 31 Aug 2026 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182375;
	bh=hBv8jMWdfBWLPpvWgM7icLeug09gPZmSwdP4u+e8Udc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U65rINuTrpHweqL9H47+Abvtuelno3mYArwDa+4fsQQi/cIcc4JgXEMwA03CxF69I
	 4RlijtsfWrbsNOTkPdMcLwGShqE3l1OSlu8BytxDQnlJCcs927JlNWDfYkUN3Vskvk
	 I+8KCH8yi/cSgo3egmRqMYmIaYlL0Hzi7zrU/LN7Hs9v7Q2jDmwqPz9wfWyZooS0Nk
	 Hhp9Qj3tX3ZGjJIdWbfJ29LM+5UoiDCCiloX+kQN6v+gDAISeZchRio+id7g0VwbwU
	 cLw6497dUlKR7rHP+2y8zZTdZ7d58+OUk/zZuOcrnmncXyxElWczXDQypSSw1jrY/J
	 EXkq7+J5Ic2rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf jitdump: Use dirname() return value in
 jit_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-10-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:19:34 +0000
Message-Id: <20260831131935.070CD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
> says dirname() may return a pointer to internal static storage =E2=80=94 =
glibc
> does this when the path has no '/', returning "." from a static buffer
> and leaving jd->dir unchanged with the original filename.
>=20
> Capture the return value and copy it back to jd->dir when dirname()
> returns a different pointer.
>=20
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D9

