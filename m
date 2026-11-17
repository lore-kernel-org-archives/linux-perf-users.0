Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946251;
	b=kuhSXBotgb/FgiVL5Z/doQdY+2dkUt15NmfeKE/0bAUNJNguEcFXhLQao2/Qn5sbNH70
	 6EuqkY5/UyzmnBVnRZBFAdPBDFLvsU6mHaP2bUsuxqcQ8XzCwacUw/8/fSOODTe3Obzhl
	 MwVrV0HTc1swfxnbmG8+Ox7RemFUUtzjfraq1KsNqt34nuJGtSLgLq2jiHiv6IIQ+Ef0P
	 k7XZM2gF9VjdwjnlYBt+8tRdvflFPeWJXp55hhm76KlrJBOyD2rCGN0K3tiLzTnBKA1dW
	 AdXVpaJzrSdELAqcyUY/nurf5CBvrOQgaIC4OSYM+umuzAcGJzAAuF5nnxs3Affg4RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946251;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sP88gFXZlTCoc/FxKHxILD3CYS1f8ZtPpmHNYxcs7pQ=;
	b=2A4VTVdLv/9EoAITuCVe1qrY2fIJUctkix28xn2lLQYiCdG7WzgOYErAGo585pEKLuIS
	 khB4FUWfesJnVbB9NwHQukJWjHEeweWXL5wdggnlMrwDK9Q9N8F0wty6pzIriRyK+0brS
	 BJk6ledPZi54cF/a/CR0R3X3L7qcqxELI+X4Kn6Zh2uj2+GG/Z6c7DOZG5qKw+Od2mItp
	 jbPvOdGEqmLuUC6fCYNKdEVt2F1T4DEF+4ZC9Zj+AS100+WaxV/rtlkkSNajMkDHW9pF2
	 qF9mq22IUW0tFvcbqNCjmH6cUiGLXcLJi17I1o0EiRlKLk4xYT98B7NHnjFxTCYy2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zm1G/Gh8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2A606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zm1G/Gh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124FB1F000C5;
	Tue, 17 Nov 2026 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946251;
	bh=sP88gFXZlTCoc/FxKHxILD3CYS1f8ZtPpmHNYxcs7pQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zm1G/Gh8hW8o3SK9fft1eurq1B4tuYV6bI2XNQYTViJB9IOxrTR1I9X6/1xUWyQWM
	 klsKSElLRcsPTSwV81oolws8X/XWmVnLRMcV77RCgWPrI4XTbJxFJVK3+aeNwFeJNt
	 S173uYlHSgHRp/ICU0Iw5VmrXcLZRofvJO543zRFhvtz4LS7DtDJhq6uv4xq2ZcdnE
	 EvK9vSOqbkibgfR/OfXJlmO3kDQJi+MJdLynPqmdWJq1nUteUhdmxSo/BuWMMNJBd+
	 GHfZtsJhyxnIhfPA58huwj5A7U45wRpRlqKzOxqQ+AEwwt97jVrxPg1PPU+5VALm3E
	 hqEQSwZfEFVuA==
Message-ID: <sashiko-outbox-219568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-7-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:10:50 +0000
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
> Take a member's extent as the end of its last child as well, so the
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D6

