Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942150;
	b=2lHU/LO22wceaJqK1YdkIYlFLApbK1ctLUHAtiWqNzqZAkCIZXHskzze9XRxEOVXnszM
	 IIm5RoRqJdPTvY/nOudB11pnoDU1SLabdpdEVzwhrGCoikDAyEmVxFLYQLeLTdAc4Xe5Z
	 dL9U+GRKQE73pj3dXLsdadnztfj1l3MUqvyEws3sr9j3d8fhEM2g8clO8Idg8NnF+Fzn/
	 2d0gQACUclJlFa7OteFJxekdAyP8HIxcBHlMcg908T/CU2p9MU1DuCxK0HmqCYK6sHcxw
	 vTEGXk+2VsUyGQmGinCmd2uZpLfNc62W5QPzl+sA4m+E16DUP8hOaumVGTB9KP7J4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GFR75rW9cha8LHJ/eTxpgzfgmx2BzUmqc+i20UnEr/Q=;
	b=TaxdC2rN+qs9RnWmVJAQ1VBv6w69lfRxBzjfJ7U/1sdJX7A8yjluo2+lbE0NvpoxWucd
	 8KPC5CaQFngx7oZ3S6I08lwrA0DsTPfPLpOadEzr0n7I7HdC2/j1xUvoglYLpyo7OSZ3t
	 dL/qB1x9dNNAxOR5NNDEaV69UGzo6JyRGbquZa230OrdDblF3/flmRzAyo8rnjiQ0NjZZ
	 c6Y9aTDt5LLVWjuHhShaZ3+Xo958MZICj1C0YQluVJ4xweIQzLjwEow72uheU4x8hi1fL
	 SmcNuFBfVnTzS83ZAN1cEuHrvE0wQ49JdOBnIJw6gWieQblGLtBdB4xI/jGxD6eSp+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWK7iq9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F2606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dWK7iq9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57C41F000C5;
	Tue, 17 Nov 2026 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942150;
	bh=GFR75rW9cha8LHJ/eTxpgzfgmx2BzUmqc+i20UnEr/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWK7iq9zFRv7RVAI4+XXXAnn8b3gSbD+y+ue3WABijek4LIeWOGbuu1m4e99S/kUg
	 bLXGFEGGf93R5IJjGstXpmlgzg8bVXaJvlt2PZSZTrsuuNKpIujrs2NxC458gYXFyy
	 caqypRkOSiJDjde3pE3F2niLzhPJNeJAzCHv+jkzEpUIGTZAbyvqGs4KOQQJmXS+U6
	 duNHw5baDSavAdVhzuNtBY0Ad5luGwH/qGx1whWDdemWeTCbWFR490P1V25r8O1Tgg
	 pKRfFM+cGW3B2docPaPugnjdDZotlYf3CsoF4uIgnTNxpggA5XNkwIl5ODOTfzEjsk
	 /h6kiOi9eT2wA==
Message-ID: <sashiko-outbox-219421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/23] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-6-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:02:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D5

