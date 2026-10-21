Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603106;
	b=hIM+XwbkscBy2ORXI4ugCBfQ2vLmTNdj7rk2FUq0cQRG6djyvnmYpVYOvppSN39RTfKM
	 Gxyx39URx9ncYjXXxuLaw3+q+Vt7k9Y+8p9RBAPRECwNH/fg+Eo5VOj5MGw+rX0jYYwmD
	 y9kJIWQMZkIhqW2vFSOwXFLP7nyEh5m43KOjEi0icocAd2+r8NGNqijfyGJoP1fasHpg7
	 VdhjaakC36Hz4lqL7RUxkVki/z9/+iSAxQWBjbSvAbjng4tPtEqfE7iv/0+LmRrwGOozB
	 OdDwZ6I3wtzvl7s70gZns8UeJd+IBKBAl0e2aRxrrc71rhW+HaVZaGS5oZ73nOCoVCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603106;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j45YvUqNsT9r6P6Ezoxq+6NZLAC1tYBDesIxBS7GxQw=;
	b=INrkChc6Myle/xgJBh3bx5mLUpvXMCB5tZ6cWDh18kizCfvk8FUgEuncMyOJu5YnH9MB
	 ybepVlV+coE2bF1w81gkkjF3NcUOO/Trd0xcq80Ue5quPfNb4bQ3Hi1+2imMv12DWTOO4
	 rQwOz/r2SHrL0t6WWUjFSTjyc6UXjT/qosdW67gw169R+rspdz6yBvrVtK9bl4ItneDvR
	 4c2t8NDH2MLbYJF0mt0ASa+k3ghQaVa20O6Qm72Q0vCOeH6n8kJERHM0OYIFOdllwxH29
	 XfPgSlpbEiQ7jhZQH6amsgTR9ofkxd5l5/kDMbdeOFxPkNoBTPrvfVsKTY2YkXbJADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxRqDpsu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A647606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxRqDpsu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440821F000C1;
	Wed, 21 Oct 2026 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603106;
	bh=j45YvUqNsT9r6P6Ezoxq+6NZLAC1tYBDesIxBS7GxQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cxRqDpsuC4eKdfhy38c5zMbkkmMtCjt1YbGb34+2ZBIeYp40LBBBoU0bzs6o554FR
	 klAtBFRBWzCxQhEggqmEsyGDMrnJUNLIjD7MlFKmrR6UlYwSaCZA5CEh805Ed7g6Vq
	 kUK0cDHRPn6qLH9r7G+2qu3tO1oksGv/u6dczg4xYsaXUV1dZlH/x+dpZQGC5vBhxy
	 X6sntmX6CikAEF6qI91Frgz6t2wMgbJ7njHMW3dkDwpgmrGYZDwaM9Gw83wDFT2JHL
	 Mh+I+Sn/m79y5aUyvT+B4HyH78eN6xHVYq/M4skqH3xHl01ldTE840I0evyDTYnAPf
	 Y2nAGVF0YGpVQ==
Message-ID: <sashiko-outbox-180509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/17] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-11-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:18:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D10

