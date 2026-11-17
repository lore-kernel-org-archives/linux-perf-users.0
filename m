Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941792;
	b=Cb53B/BPrH4X2JE4kM16XXGD92sVa83lRUv836EWmDbRsbL9Nr/Xklf+Lv5Qrh/SHk+K
	 4VBjQgaBXABAZLrhxpRDECSg9Vx+70ah1fVnM7kNImrrN8ZtAMc9dUXu6eONRlK1qjYVc
	 FSowKDLtlHHQHYgsVkhXvl4mPWond4BflDP/Xdy828g0h/GeKvy9U/tSv6vVVpbOG1egB
	 IL5pqQdWiKJJC0ONLQxxxkO80XH6jccEdB/8Wt9x20xCdZR1wTWe5tkoQqLDVH2wX/7Qr
	 J0UjmRV5baw7YzK1Zdq2ZAK4kuiJqpr/XA/dyAufi7rAu8QnK7TJn1NbDuFRflCZnsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rquVIUCst+2znL1wA4sG/+jrqAWIIlNCvX2dCojt+UI=;
	b=zWSBRSGgj+cXWsJPnstQBIe5rH/LcQn06I8C9jUDgV2KBB6sscZ1EZ8Lg/jwKMd9uO91
	 K8owYtKZQ8cGbwYCj9W/f25LEVzONwRSdZl9xtRDglt7c6ueyLyTBouo/PPcLbWeqh1OJ
	 DfRJe+FH8piFntwAxwbtdkmVh+aATbmQg8OyiR/tjVuoBY0kLyTG25ETJ+onFEf+hhqUE
	 I94WXxVeTE8h7rXh1S+9CfkbnzdQRYksCjNPAmPGdt+G7Q/Hwr0X56lAwNWUhEUtR4Znf
	 kzivu5NdIuITk/mrxAX1y5fLdKDPNb6YvAMKnHPOu1rO7f12MYGWo6p12xmuVlLaYcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTXEbyz3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317B606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTXEbyz3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2796F1F000C5;
	Tue, 17 Nov 2026 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941792;
	bh=rquVIUCst+2znL1wA4sG/+jrqAWIIlNCvX2dCojt+UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UTXEbyz3SC/Gvu5i8vIKoovBWJGuy4ODjI0DnuuADpbi2ikyTcKBh9Agx+dtlWkIF
	 s9jYHTmOUEQjt9oWeOkPcMj5QZLBQ0Au2cDJxUhmmvHSPaCqME13bVsdJyj+e0AGkg
	 hXqVTZd1j3mg7Um69gckieX5ENVcD/FweRhftCti0myyejmf29f8/lFG2JitfWinT1
	 qhH80uxNhq3cBy9nljfks1OoVvAwo2wNdfH6sMEVQi3XYtsEte+3n8LZ/thxLg71ZQ
	 oFd+il/SLIXvPxtNqoNlxE8MY0QePR2jKYH6PopH02sl8qhhCgH0/6/z6Tuc45VEOa
	 nKQl4V2xExOPw==
Message-ID: <sashiko-outbox-219413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/23] perf dso: Pass dso_data to close_data_fd()
 and dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-11-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:56:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D10

