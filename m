Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591688;
	b=a3dasYljJJ4XfaBGOgdDuVopMtlY9rJDRQqUJg1bJXNqXusd48Nrn5gKTNXoVF+Wkaxq
	 QLFUiRv8yvoS2ejkpc5dmDt190ytEjpapoDDOegSK40hw87nbNtPEGtFsBneJAsuG7vRN
	 pW2pSNE5WsGtTUoR1HlCQjgK01wUn8RLYSpIeblGhPamDKVJoNVPqaEOZEa/SZwHbMmu+
	 /o5xLaDoSFz+0fXS0gMCh37MIwwPivU5rEJqWhcOjxUHaRZKAPLEOpITkDIA7Jg+QaWJN
	 wiZm/KjGhawelfesJsIScz/bpao8RX3TzVXGZJ27ikFlUPVtgqPvKKOk9rRmvH7lxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OjJaPDtzt/yQy0wkoxdZc7VPWlmo1+ThVoqn3z0PFfQ=;
	b=F15yxyoRcmb47NWFSvX/mNYGTvp1iWzoQmdR8eyrZ9Cpxbv/zq6HWWCsWdaWrSQJTymE
	 4lgeEvxM+oeZ//s1g21XA3n+4u+QcrHZrLJNDRv7xwJ423AvRGAyXxlgQ9bOACo9Vs57K
	 rY85Nhc41KDJXr24+f5TdyT8/HHPz6BXHDGq/XV6dLeWQf/RBwW0empzgFWFyU6pxQ87R
	 A/xvWW8A/BimWMOBkzSMrzUFGJsGYSjyYQk6KS50u3S8ZJ+7xDhOwaV2hrbZXYTtVQ8yW
	 LvhVj6xn8twhtWnkwvttTv2O266IjsYYJNhvs+fcTXOQ/FN9wdw6g1Zr7UbRqfyLqjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfA6geLf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9860703E8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfA6geLf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F8B1F000C4;
	Fri, 13 Nov 2026 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591688;
	bh=OjJaPDtzt/yQy0wkoxdZc7VPWlmo1+ThVoqn3z0PFfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PfA6geLfaCef0eX5JM6G4SQVRk54z2b57+l8MDjsDVWS15eKNU79IuZwN2D411xEI
	 RjGF13ELQuXEtpp8wV+TlpFnybZSzrfP81MeO26enQY6OnFyB65StgRjRCKosjicta
	 hG/zyEPc3uhRAsLWijsQSiOgdlEaQbrYtUtEXpfIFzRIZwgy842CaxtLaOUnajfR6D
	 iLLjpow3xmANbAqW4mcREUkB0T+uAyuuhWudMqomG7TqEcEqWMqYc3WwquPBKB/yC0
	 poPaUMrXQFNbcPLDZWGq/dy31YjivLcsGMZglEVziL71fnRYXZlu36gTsMAaQuQZrW
	 ye0N9EHIwEmdQ==
Message-ID: <sashiko-outbox-213341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/23] perf symbol: Add accessor functions for struct
 symbol fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-18-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:41:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Encapsulating struct symbol fields behind inline accessor functions
> decouples callers across tools/perf from struct symbol's internal layout
> as symbol storage and lazy loading evolve.
>=20
> Add inline accessor functions for struct symbol fields (symbol__start,
> symbol__set_start, symbol__end, symbol__set_end, symbol__name,
> symbol__namelen, symbol__arch_sym, symbol__set_arch_sym) and convert
> direct member accesses across tools/perf.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D17

