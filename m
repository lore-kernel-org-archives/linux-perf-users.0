Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589485;
	b=uGtguQnbNcvLqE10syMKUMf+BeOExs9sPu3W6sAZLLaFTYClrMcWAhozMK8wSHuVGpps
	 +pFJJq+aFb9SzbLha23dT2XdgjRvUTGz2PfQ6uR0K9oboEs1e6qvJ2DJFbUT0ZQhN1ntm
	 RB81mDYeUr64ODmduiAcK1JIwxt+xRXaebWtF6qZ1Sfn/SRPwvKiaYRY8m01F16S2NzEU
	 3Fsg17td34wE8yhIThLOoEp3TvN+ILLWzct1gsaNN2SuH8QgUhqW/wdXwycXYvhxrK+MB
	 idhcm31Rq+Op7tBYcEKN+5WRr5cnSOAl4E75jhR1lsINJ3pRxoP7wNh4pAGvhNZE/Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p4AKGAQhTYLRhgh6oDsB9JES5UScOz+Z4vc2Pz3+p1g=;
	b=geEZd3DFLHsM+WcX8T91G0RyFDRqzYi92PcLp6AiBdvLGXyCJ6drc4gTzM4uNQH9DRzs
	 jqpdmuVkN8p9LvB3oSTaxNnELGpvR9hUhu64ATkxSkhl/jA7zMYM1cLng2VIYlxMgkedQ
	 4jCTi6SqfJAcFZJGsr2b0AcXvzOo/Ea8NPxdeUvYdPEWuZ/reyoHf1BPK7Ec286wmCXcx
	 WiABULx3KMQBwrPCD5V4ceSJpZbMpSXwEmC4nqLPKyCHLFpZtzOaDyx1JQcI4xEp3xwBa
	 YTXyf+xmhrkcN9ojpL9J9NiuXLgM4mCUcBrwg5OdwKTY74KtNWQ8thF702T7BKpV58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQA+z+j2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C254606A88A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQA+z+j2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C31F000C4;
	Fri, 13 Nov 2026 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589485;
	bh=p4AKGAQhTYLRhgh6oDsB9JES5UScOz+Z4vc2Pz3+p1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQA+z+j2Fl+h/4E0yJpS7LjkUH2woOXKBKWzXrQIKJQUuspiuxifrhUSLY41N2fUP
	 tTQ4oN/7ADv3wX41oSKGLh+it5JaR+pi6ENBUnyawtozT2w10V7k7WhoU3WSdanW0h
	 RAlr9YOaOH8t+GGtX4swLNvdmaxP4qmTKhq9+Xy74NBJ8OJj+V9fnGddqwqcdmmowY
	 ashk9Cgmbr5XsXrSNvEXDZ1luLfqMwrXAhV8mzIMEidbBnBiuIuJdGFkXD0q7Qr0kY
	 /ZNJrbLTEnMf4JHxV0ekqnFYaTI7me9S7GAV690SuNw71c7/l4Sdnq4NJQuz73tnxe
	 smse6APLkQ80g==
Message-ID: <sashiko-outbox-213268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 21/21] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-22-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:04:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D21

