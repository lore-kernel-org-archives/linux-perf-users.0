Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214543;
	b=j7F3LCarJ7I8DkNAD6QkNutnZYc72az2Rgn0teLSs7ADtrlEygQ3DhiIy3NPJhJYpJyB
	 sGglqBO2VjUF7dPLJ5EoPFEqxHX1ur+YZh+EhNJYXhA7lKeYE8H6mwkX7rOsL6sN+OOIJ
	 avLGmdmblkuqvglJq0dAaABZaiO2XNuntX2kqarWYLcyqGarYmwl0EB/ybS6jiW9xk7dC
	 lzcH446NBgp0zEbRKlgtpOtoT/DLOZDSwXMPKtJXoee1wi2t2tRDAiGusIaD/RZH2UhSD
	 smEzpFSWcTFZTZB3dCahLNSiqgN3/UwTb0+53RJYxE12a2FwoNiWjahwpfe0IBh1zDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b8ZSUjebnsYW+mq6GsBp0aB0DJ6DQHjfNC7UH5hTClQ=;
	b=5NrNo5kicK347Xn10iPCyxrm/6MmVcBVB5nymgNkmM45BgmOzOGu1KJ2uehDLiwCtNdZ
	 fmvKNgZs2BrClaeExfGRKiwXIIA1gVd75iiJ9IFSYx0dtc1azux76n0plInJTSbBjW6TM
	 0HpShvl6eGmLOd9EV+OVtwi31Skh/UZbVtrjnF4K8B8J283aXq74w1lW2prji6FaroEgo
	 0dQvmPQ/IlUZ/hbMRP394upanx3Q+bNz3M7BJ2ak+0dhnDn04u/Mr6vlNV64v48DlAbix
	 GXgCsEn5xtVxABxiLfY/kcKXmNCTCjdS7TrVx3YZwtcPfy9IAdv6h3LgAhslPnsHmwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsbNes7l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDA606A6A6
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsbNes7l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7051F000C0;
	Fri, 20 Nov 2026 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214543;
	bh=b8ZSUjebnsYW+mq6GsBp0aB0DJ6DQHjfNC7UH5hTClQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsbNes7loeYvRKy2z37fAXiJlAlpSNsiywfsrl2h0VEyq7S212FEjRh9XgwKAn/eg
	 IOdWEHfdFVs7qcrqmI/40WiQMXltH73aZo32GXHfbBLNHUff4VDcFHEb9rRxhGj0wD
	 V0nsjy1H6YvKd8vM6Ib9NZbTOxfYf1AaNf3eKTSeLIItAzdJG05Bih80vErnx2f4DW
	 kX+5zHQkuMZHzSKY76xiKXNJPuZ8caKXJ6ihc+bD9ffZnQ2AmCeFB+OcuSprC+9DB9
	 s+8Crc+Z7N37twqEhj3qpgu0QVplOrcp3r/o5RNjOsMLFagMtPfSc/77hpTc656aGm
	 d3oREzHdo2i9w==
Message-ID: <sashiko-outbox-226292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 00/30] perf: Per-env PMUs, metric event sharing, and
 recorded event metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
References: <20261120221332.2245191-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:42:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 30-patch series:

- Patches 1-24 and 26-30: no issues found.
- Patch 25 ("perf pmus: Add perf_pmus__read_from_env()"): 1 potential
  issue (1 Medium)

A detailed review has been sent as a separate reply to patch 25.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120221332.2245=
191-1-irogers@google.com
