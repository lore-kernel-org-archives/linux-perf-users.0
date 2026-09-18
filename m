Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F61C4FC34D
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743122; cv=none; b=ha7EOq7IalKFcFzBpDvNEjPNPW51PIPbfREvVS+QdgHxeTbl22L4GJEZqTlEjYdsq9beINPArchQKNac3zJkWL7ao+xeROJb02zJ8FnAWr4pA8eQ2I96C2zmIGjEuFFguNDeZ2lG15NYD14PJCOZu1vRtC1YsRVFrcazopTI/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743122; c=relaxed/simple;
	bh=TGGf6Sh09q9OX+DZj+/g/X0NUUeG+ZicwBwWRcK+Xpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l4EqB8VmR+jpVBJcYh0Ngxuz+bzdkAy77Q0gUrxlEksSup9IXilVuFvS0Ou81vFwRkrL5gnus3+Qg+YE6fsuedWFzIfX0gITnYYxm543n+DLhe+vfpi3JSPRm8/qEZsXmncZSRULmqyBEBy6YmhV2TTL3Q+V3TKAtb93aTk50zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9iV0VzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9iV0VzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0BF1F00898;
	Fri, 18 Sep 2026 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743112;
	bh=TGGf6Sh09q9OX+DZj+/g/X0NUUeG+ZicwBwWRcK+Xpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9iV0VzVJ7Z+8V9qlTWzcxa9ECHtlVeFD1sTKDoMVWDr1Slq8I5iXglCnjKxMifE7
	 pcJjcjYyBrsmo7nN6Qrq43xidMpPvs2/hMDQa5z/37z7s+vRhSQ7MeQ0UrpI6VkCsM
	 Cv9Rk2vytAZEn1ddfKSHNNLTDQsd7+OGfT/541DhR/M7z9GL6XdQ9knGbabYkuxUjT
	 pRudUVAkOrGi/sKEzmhN9mRQ8NxLJHOaE1Qr069zms5lsXH9/qBww/YKI6QBtgZetK
	 jFVx/WMJZN7gVYO7B7PgwfVbzEj869LoJSI4y+Nmd2R+4HZxVY7Sqs6cDv+4YrN2Lk
	 95MwRmDal7/Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/16] perf test trace_summary: Make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-16-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:51:52 +0000
Message-Id: <20260918145152.AE0BF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_summary.sh tests various summary modes of `perf trace`. It already
> directs output to a unique temporary file without polluting the current
> working directory.
>=20
> Remove the (exclusive) tag so it can run concurrently in parallel test
> runs.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D15

