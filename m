Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707333;
	b=MsPliTDs3S3yWrK2nkteg0fqF4Quv/7b+tM9Ai57EhXQeuIv+aLb6YQR4Doee4gEyI9L
	 Xxzw7I4qste3KNC+AQK1gLcnm+hhxe2CyxBWZ71Rl9J7L/yv5Q5TbcGk5x00aKIF+1m1b
	 1/V8iaYsRTFFebjGwpzxlNq49NtDpAGraNx61dHngiZF932lhkzU8CZOP0/id4+VdfXYs
	 +o/7dqmrUEAGDdkwp2Kpp2N2xh6aFFObzgto8e3MOK+8wHkuSGMxmiqLHH0gHb6SPtiU+
	 6qPjsRyHdkKInUbF79JcqsK1uxoFXdQOxecxmwaZVa6H+NgCibFkQs3k98vh6mLDELQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ClcR3mo+/g6MHRjbbcH1s1bmIVZQOs7mMCcNlpHkHJ4=;
	b=bRVsEcXX0K/pWDIQ6hBfPu1ESDF07C0Lk9yoXYpLBI95TBizFtQUk+/e2/yrHioeefdB
	 o2d7ea2j7+5kUASSibVPUI72pRpEi1tYU5/zu81n0yh6DtPv2jyt78h9zbpsHcmZXQ8yx
	 pcXBOCRG1ClKHAT1/sVl6PSt3RedPFIn24In9H/LHx/3kW/Ao6KbBEYx4YcB1nXDp2vCI
	 z2mGq5tcsu0RF+S3QL8rdxTf0uQdHggnSIeyGD2QYyfhrmyig5HHA0DFXwk9DWypqoiMi
	 TtKCkMJwdnkVO6E9K+p6cFdhdjDJypNm2AWfYO+/lyxe3jTSIoiBWGDkzzP7kr7ez3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d32/8c+Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1B606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d32/8c+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B841F000C4;
	Sun, 15 Nov 2026 01:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707332;
	bh=ClcR3mo+/g6MHRjbbcH1s1bmIVZQOs7mMCcNlpHkHJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d32/8c+QYzDM4LK4M2xKObuWt35FcNv3OGVJidyATSARu4ESVZseuunO3T6s65rFm
	 E50nh98FWxTv09vbw5+ZX/ePu944/emPa2b35wOAg+IRb012lmB3o2UVJC9e92aRaD
	 6tPl42L+NxkqkVBvsa5iDJzoagY5eUuQTnp9oVgzWoHT2b9NE0pUetodBJJ4rXnNSK
	 tMfxeLSqwJe9hRPE0bAEJowF8zj2NYYU/Exew56lFyBXitMgTLp/vRgHcPTraKE7RV
	 ZoWeBtNCyuGUyNZkYo8EvBLDIF6vBJ+wNcj7hIildS7q+QnpvSxCDvbzAPAiWFh9sU
	 ZsA4Btt4Ist1w==
Message-ID: <sashiko-outbox-215172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] perf test: Skip the LBR inline unwinding check
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-13-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:48:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The check only looks for the PMU's caps/branches file before recording
> with --call-graph lbr.  AMD BRS advertises branches but only samples its
> own retired branches event, so the record with cycles is rejected and
> the test fails instead of skipping.
>=20
> Probe the record and skip when it fails, as the branch stack test does.
>=20
> Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline informat=
ion shows on LBR leaves")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D12

