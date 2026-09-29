Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8439447C
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665482; cv=none; b=LFHa77y6HUb2mvDOcV+yMmyV8OLuQYUV/MLMca0MV7WSm38p+3Mr3oN9njqVm5FEvgpYDutW1p4Dh9pw9HslHQZlTMKJGkykNZ1uYnesPDBNfbP8lc8GnG42ICsik7ZnH15pGxTr/hiXa4EeWuZiM12Nw3NV6YXVCLwiTPxSeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665482; c=relaxed/simple;
	bh=tg5uL86xFtwwab4cmxBCy4whq0n4Dunj9aJo5y3xobA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S47ZByB7h3q5xlVAfjHnytgxSkmbat2EiLrnLBQX2NI8q2rNQpAa3pH6UUE3WCjX0lWMn1S2q5W+QDCyE8ipwjMwn7gakg3NymwlIiHO9XxVcta9nD0ND3cUGqoWdrDkPE65TMsbyinThv9HMYs2ovVS+6Wh5qevJ3fYChvhRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1lmFRbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1lmFRbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CD91F000FF;
	Tue, 29 Sep 2026 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665481;
	bh=tg5uL86xFtwwab4cmxBCy4whq0n4Dunj9aJo5y3xobA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1lmFRboSq3RrUuY6Ss8VbS+DdVjZHw9j/3AYvQefi0IugGa5+lDVWnR8s+RMW6DA
	 SnzvWDgCtEnHMHcFNAOcHAGpxyd1R4IQWfTOFv9A8a9fL170PBA1bCXJ1zaaxcj6AV
	 HlcRFOB9w25tlSaz1weme+uj+T5XbIa/GKphpZs2wGOU4sp10A3WrOOgPERLO/BpaH
	 fQJoJN4fY7zBKkcQLXAGIloB6qDZeKNxSWToY9nlkeeP7lHO11Y6fc3PEQe1s/F+vr
	 ot/3WNvhuz+/0ke2MeKPhy0PYU+e2CY0J2jb26qhfuMVnhxm9LHiJQgqC9Ow4Zi09x
	 G/XBVKQZUYqdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] perf python: Initialize debug output on module
 load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-9-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:04:40 +0000
Message-Id: <20260929070441.17CD91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Unlike the perf binary's main(), PyInit_perf() does not call
> perf_debug_setup(). As a result, the first warning or error printed from
> the perf Python C extension hits debug_file() with _debug_file =3D=3D NULL
> and emits 'debug_file not set' without a trailing newline before the
> actual diagnostic message.
>=20
> Call perf_debug_setup() in PyInit_perf() and add the missing trailing
> newline to the fallback warning in debug_file().
>=20
> Fixes: ec49230cf6dd ("perf debug: Expose debug file")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D8

