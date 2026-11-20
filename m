Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138865;
	b=zuLFSrIDfPxk71AEDMerDa7EASYbaz+oToZJP4nn6xd/kad/n7F1HcCqZXvjTpN4fEgc
	 P7VCe8sNcrdfGKKZ5mjp+2d6AF/A67Ks3ZpjDMkng0fGKa7qkPyGTNgJFJ9SKRnnqTLb5
	 pTsLvqf6bNOFLCC8YwrHw2f/552zFzEZ6fly+9C8C8illpVL9uYg8GA4iVWUXX+FBVMGl
	 NBlI3Mlj9UC0RuarkOMtLwWsGSUGhY6tfMATFQbLR9SpAYWgmwwIVimbcOJcmlBFEW+My
	 CYcpWLWf3Ab3ioas19p9hG7cIWL6VSefSvZAhWlEx9nIPNli15vZyqfH7fAh36khr8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138865;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CtoF8dl/G57izmaVb9AEe5oy73LNHtTKwtxUOoDKMYo=;
	b=AOL9t0XS/wSbBztVfVK0pcm5SIy19iLldSYy6z094iOsWo9YB+lIx6f7Yaip/zhkdxrd
	 2eqep1txW4D+QZtWvDihtUHRN/TMwRgocRR+Bkd6Oqqi8oFCtBo94kOjH7B4yR8IQOpxa
	 QL5KBRyf0f8GfGvO0EQZdhKE0PNGcOqx5BfPNMxo5Eog2Iu+beAVb0QnXZIZYB1PUyvGO
	 rQ8oqs2XhNEyeoMKr3+fKXl7WcD7csETtdybHpstxB/keGc0ul2C0oKwCOb/4GlsiZZ6B
	 1QCjiqxLvKfp66GRe1ZoUMcv8CDus8zEuKeP8SnxCbSe5hHQVavmF5sW1uLyFAv453A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1gleBt+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D1606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1gleBt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09FE1F000C4;
	Fri, 20 Nov 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138864;
	bh=CtoF8dl/G57izmaVb9AEe5oy73LNHtTKwtxUOoDKMYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1gleBt+2hslHBsUxt0eMyeSqLKdaP3/guGTaQy9aw1VbN45b69xfGpG/0ii87uQC
	 UnwlWBIwlwjukcE0Vdn1BSJeJaGIz1Xg24noPr+0qw5BVduuUUZdzbwczKU5KqibQo
	 Yw2F8mT7RtbkglAz0aEcOgjRSSNQ/K0Q5xj872BpKUS7UgtqJf7h5CypqNgX4MQvff
	 nsujkIdQy3p+9nJuumPvtX995sGkrJfakAcsHm2BUjC+dSjjoT/6VIUk2Z/B5V38Gx
	 72DrYl4USyl4VK89MiN0RvBHr5RBIYgAkRCAdSE+h+p9INe7XyNe2CiH+gqCb5MgzG
	 zc6l8sMd7XmhA==
Message-ID: <sashiko-outbox-224335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/13] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-7-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:41:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The per-member percentage sums the histogram entries in the member's
> own [offset, offset + size) range.  A flexible array member is resolved
> past the end of its struct, so the struct row only covered its declared
> size and showed 0.00% while the member row showed 100.00% and the
> header said N samples.
>=20
> Take a member's extent as the end of its furthest child as well, so the
> struct counts what was resolved past it.  Union members all start at
> offset 0, so a plain union keeps its size; a member that is itself a
> struct with a flexible array extends the union too.  The TUI browser
> accounts the members the same way, use the extent there as well.
>=20
> Extend tests/shell/data_type_flex_array.sh to check that the accesses
> count for the struct in the percent, samples and period columns.
>=20
> Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex=
-array")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D6

