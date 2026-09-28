Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3C38B148
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620484; cv=none; b=C7gEJqJQP5aSUyer99qlpr4ORNPwN9VY+B7OldYoyBNJCm5YvHIZTl0hBfaqVD1wiEYopopaM5OEH2930wFXuy8JK4EJrhLgabkCbNxPNrrdD8BaWMfnudtA1bDTG2MRqq93J0yBR8Ub8rUPgQHcfXYT7NzChzb69cyvZMJ4O04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620484; c=relaxed/simple;
	bh=9yhGGgRoGl8cx/bBVFtNpasXp6CEGCtCOpD0QtUebFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fD6/DOKL6iv55B9GRKK/OmE6NeJpd/L3EvWFsSUQg7M6mh0Hr0quY/sh+y8fwrJEQ7kyC1k4r98KjVbThl/cg2/8pHnP5Q1XdNUmFrK3ZwyQx8j79iDUpq+yMHlVrYTocO+hPqOjnn/7EM/iSVwK9ezgIF8D9kZli3HbSLS6i0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX/6Gsyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX/6Gsyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04BB1F000FF;
	Mon, 28 Sep 2026 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620482;
	bh=9yhGGgRoGl8cx/bBVFtNpasXp6CEGCtCOpD0QtUebFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SX/6GsyxOwWV55qi5XzCqYmHioMWz/8rPdzxPhDWQZYG+pNVudFokB0N0ks6IS1Qb
	 N8mlFqmwfu32I/SsjnXkurSyJmIaF5FscIGzEJBBoD1D0kiBrCuU/UlesLZIibaOcS
	 VmIVTm5MBIvlJqcPZAZib9eCtIA+SR30ky/2Yv2BuPv167WBaIAluiLJFl1uRb5ItB
	 joWq4XZdLe8HvWBlqLWusQ5N36qyo+DovLjCutfD693UGiA/P9QcSSSOX4zexyGv8D
	 89FUiBUySmux82kTngpNLWRtyY5QKNhfuYt32pVlRyGEY96VBPwIT5xXCa3wtCLtwy
	 mP42+iX4E1Xvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/26] perf trace: Bound the fixed size augmented
 argument beautifiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-6-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:34:42 +0000
Message-Id: <20260928183442.B04BB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The timespec, sockaddr and perf_event_attr beautifiers read a fixed size
> type from the payload without checking its size. The sockaddr payload is
> addrlen bytes and the perf_event_attr payload is attr.size bytes, both
> chosen by the tracee.
>=20
> Check the payload with syscall_arg__augmented_args_valid(). Pass its size
> to the address family printers, which also bounds the AF_LOCAL path that
> needn't be NUL terminated. Like the kernel, accept an AF_INET6 address
> without sin6_scope_id, RFC 2133's 24 bytes. Copy the perf_event_attr into
> a zero padded local, as perf_event_attr___scnprintf() reads a whole
> struct.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D5

