Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591449;
	b=1nFRElEBBxH4656rJQLlPudgbxD9oK6VQ2RqbmOU7fIVnoOkkF97zq1MPU9fZe2rmr9S
	 9x7JV53HrM68QKlEt2WFt1bMhe0LRG8LuBZ/zvgF7RpknfPM3rbBzD6PhvWWnkk9XZu2e
	 f7L2QkPWqMobX/ClTTWcbtriTdc1bPTwT0OQbrJ7QI9R52uml78IIB4Q9Y8Yop+slEIFN
	 T208M0KnZ0FbKauqXdh0fpn1DidTakbSzMzObQPeLHL5Gpl/KDgyAnMYGFzv4X+lI0E3e
	 OLagCm9AH1zoapUtXgXCLPPhCHlQXjGxRHhHqccxz/53UGwJB7LLM7CwdsujGuzw/Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jHFYPoSds7kRxLpMqBsq9N9U0twVBZ/uOu1hT9tLtwI=;
	b=kd5j3Hl1yDN4RqCQseciT7jgyyE0E2argZPbfxSDSQ+xq6CT+9XBLcv8MZonjDOafRbj
	 /iGu92E4X2nfoVR7YcTGsu0B4UOXoMs0Qve+wFU6MBXOxcjRFrIPLLsC4/6vCHfDlihhA
	 kD7dhVacTHLD6+HVYQbHV4HPSW+hKsAAJ0ezuRuwAFUW7bYb2v517encuoBg7pDkogw/W
	 50Kzf3RHgpEk6J0GG9oxIK98GE/XDU00RMhO4983HuZ3Vwqp8K7pa0thVQ6tKS9kGEwhe
	 QpYzpsERWBbweAJQYfXdv497h8pfHckgTNKzaH0dJ/jG2bDoHK4XzwIupR+jMdWbiqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTO1zyrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AE607C354
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTO1zyrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447071F000C5;
	Fri, 13 Nov 2026 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591449;
	bh=jHFYPoSds7kRxLpMqBsq9N9U0twVBZ/uOu1hT9tLtwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTO1zyrVgy/cJTceFP5Pl5Rcrx9NSQG4xT98gHzLvuhpmQg6w+3mVz/ev1qD2L0qn
	 95f+C+Pf6B90YhAGol5mFDpxkajFInnDSDxP12NjM4jtU8wMqUXoGtuWXa9c2nbeyl
	 iOMFWqdZk/jfog/cJ/KvMXdRWxFtVkapYR3TEMDmZQOF8sXfY9E1r0J9MrSGFufbjl
	 NsK5nYekK+qUFzhzVaMTUgntmlR8P1PpqGwLv+5WkQDV3yplAoIf3zJhenkDPqsZuN
	 bNbkUSgq7MxM0/3js8qmK5y8SN1djVDUDNq3OHIe4jwIkhwC+g7ehaBUEdUy9UqzFk
	 +bwb5xOUTnewg==
Message-ID: <sashiko-outbox-213332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 21/23] perf session: Add dso__session() and
 session-scoped allocation wrappers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-22-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:37:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add explicit session-scoped memory allocation wrappers:
> - perf_session__malloc(session, size)
> - perf_session__zalloc(session, size)
> - perf_session__calloc(session, nmemb, size)
> - perf_session__realloc(session, ptr, size)
> - perf_session__strdup(session, s)
>=20
> When an allocation fails and returns NULL, if a non-NULL struct
> perf_session is provided, the wrapper invokes perf_session__shrink() to
> evict unreferenced symbols, DSOs, and cached debuginfo across the
> session's machines and then retries the allocation once. This avoids
> the thrashing overhead of periodic heuristic shrinking while allowing
> perf to recover from memory exhaustion.
>=20
> Also plumb a back-pointer from struct dsos to its owning struct machine
> so machine__session(machine) and dso__session(dso) can resolve the
> active perf_session.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D21

