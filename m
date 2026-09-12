Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC12DC783
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789193293; cv=none; b=bwzpshgGdZCKyeQM+jS2ak/CbhZm5ascgyQTtGuDjzbPzb9QuvtjUlpVr5jqD1O7YqGiqNez2nLVjHGKtHrwAzhiEqJ+/o2i3oEZ8e8r/nOTFfK3fgQm1Z/4mNHGO7FK6diz/9taJGCSx3nQDhyDKaTq7xt1499KvHL2BNfQGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789193293; c=relaxed/simple;
	bh=iRapIouIxHmll21/6j7rw5rCkrEW6bm5UEZQh9SbnNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eFbL87aT17t0lkCfQyIqS1IdzWKTbb1hBaQSvu7idhZsvm+hhHY6by2UR5CTIqrmoCevRUPBykhyOQzUrvfpvAwvLJNtftFsYUxYOM3i9jnV9uzT27ZSPpEzurIt+swH+Yfv+McJ0l/QKbscbSUoIdsRIrtGMizoIyrrfRdVS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwFicZlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwFicZlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB49C1F000FF;
	Sat, 12 Sep 2026 06:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789193292;
	bh=iRapIouIxHmll21/6j7rw5rCkrEW6bm5UEZQh9SbnNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwFicZlRVU7uR4m/dV4oFVjLi8U9tjWdt9rEbuf8EYOAoRu5+BNEdQ3QCYcBzY0Lg
	 NwdRkMgKoRPI+McrvLw7Xgoel/knE1Oe5kOjSqyUsg0AXipq888wr6ppmFY92pHqKc
	 iogJanxHcVBvbW7Ddcb0A+nY/52nyTzOgFSRyklwvhGlpp9cfufjEytjo1Kab0EnXi
	 F7E+rW1y9cqArx1y/r15TAs9+0ZwafMnHyQdg+KSi1F18zdKJySH38rmjLHtsZPsdQ
	 HQf/y0Q38kwR4X2ZjbI3/b/Gf6AJQbLQEvfl8lzHjAZA+e8PlXNHTwqd+XDB9pec5/
	 ECoOcptF6fOQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf synthetic-events: Fix schedstat event lifetime
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912055619.2284443-1-sh_def@163.com>
References: <20260912055619.2284443-1-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 06:08:11 +0000
Message-Id: <20260912060811.DB49C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_event__synthesize_schedstat() has two event lifetime issues.
>=20
> After a successful iteration, event is freed but retains its value. If
> the next iteration starts with an unrecognized schedstat record type,
> neither synthesizer assigns a new value. The stale pointer then passes
> the NULL check, may be passed to process(), and is freed again.
>=20
> In addition, when user_requested_cpus filters out a synthesized event,
> the continue path skips free(event), leaking the event.
>=20
> Make event local to each loop iteration so it always starts as NULL.
> Also avoid the filter continue and unconditionally free each synthesized
> event at the end of the iteration.
>=20
> Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
> Signed-off-by: Hui Su <sh_def@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912055619.2284=
443-1-sh_def@163.com?part=3D1

