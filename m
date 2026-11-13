Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588771;
	b=pbTdVOpTv+SuRHoy38/ygLAhqYmQo40E24bMgf2rTXFXs4I8bDWH+JSG+edqKvEq+xT3
	 dmP54qs3bkYzwPZ4FgHJAOP68b8aAEnK4f4x+L5UWqn50jR9FzP0gtb+AERUJFSEpTtW+
	 RaVHALngjb8E1vrffuVURf7LNtosqQ8NyL8xi7PD1E5YTQ/LTwCdpv7uCB+fwQD7BWjeZ
	 RMpqfOLxc7UFSV1DQ2aBJNwUHCO8Wsvm95QJYlyuEWk0AJkUQbmNA3PeYYoHzcBA/fpCs
	 U0WED8tIUUXye/qETf34ictxUJlZ6wWuvcyYS3yGbEktqFL8KgOHj9CoLrST6b6C4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lDjqnH5nP2lBlYnRf2VNe2hOk9Auw/SwTl1xdN8lQRc=;
	b=k2G8k5bIVLaXXqkeFcRGeTwMrtMJxUfu8cq3ac90+rd2khFEi2xMVduvr7iWU7tv0fKY
	 +IzyRCD3jZKrTn38O62wEFQa6Nvcki1ikGP2Z+ccIpnmyOnqZ/kNaVxx1aUG6vcyDvLU8
	 LU9Q6ALp6I2hfRRday+fnBs60upgAyC36qtIR5mz4O0jb6TMjHVSnAGwe6kLd/Z7wirGJ
	 Vc3/N1GJtQl3XDucAywB0mXdFEPJE3LrNiKvvheD7AlypMOHs6w7MZN9MhRVRPzkItvvz
	 o9TaGFxk5OZPbd3YBL0akPcqfwuP3xMcy4tyHsBXut+mquQBTCadeqTYr+yKa9r4Oiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw3MbHlb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48B606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw3MbHlb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8041F000C4;
	Fri, 13 Nov 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588771;
	bh=lDjqnH5nP2lBlYnRf2VNe2hOk9Auw/SwTl1xdN8lQRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rw3MbHlbIdVltHz6nFyZxwJvmsC0+otZ7pHl5Odl1XSPuIX+80m8C85ABk/D4v5w4
	 ZfmFMYt3SrduwNZqKzKkMhJVQL+6HjW7k2OkJAvffjIlr1YjJnCrPCFFdxZd/AGgqu
	 jHGzcd8Tt0rpTgcpoSKEstwV7HHnrDWJfXPxmQ9LyhtoTNSg/OPVXfpc/St+ozOEZW
	 jhlBAbic301KS0jLcyCspuIwgQv6Vy2e5wA2CufZaifKVoGxLQ3J84xcn6mISyV7rz
	 bsixcqDrjITaY/z48jBmtk/oaTKg+XuQUEhGRD5oJleDVuNIadyTacRyYP41oHOb0f
	 Yd0UB8EM7LItQ==
Message-ID: <sashiko-outbox-213243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/21] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-12-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:52:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D11

