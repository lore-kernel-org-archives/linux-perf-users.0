Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701449;
	b=UrTdedcZ6frX71L8Poory4YFDntzos2+aR9qdR/ciPvN+Bam9511K0M3bnTqMKDoZ44g
	 l/sAh3a4S7N6QtUJ6/8fVr+b5Fvlp2ALyCNB3KFoOZ352UnVS8cxw8d9/sppDA6S+USEs
	 +si26nNDbZrXq/eKQTGcFf+EWCxAppqiwXuEumqLPN5aAUWE+v1pJelR5NdMuTtKgIO7/
	 ZnN83CG2GPf+JZtGWTK3gtu/Uv6ULU9FXv8kRU9ZXXGS+1aH6bSxpK8IFyUaDWEIpw2EP
	 Y+xjnvrmRXDj14TGxWJvd2+LPWMJ5tQszOlViBjFpeFPXhOyL6gt8Fbkb1JeB/tAbMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UNC2pG2huaw069te5I1zscCQhM0tbZkdOwkr24hsQoE=;
	b=BjvkP/sKwAOSlw9m7aUTUe8SR3x/j3xqflCpxcgcjsRsL4RNEnCSt4GNwSLCCRWG31aR
	 gz0an1uRzcpxLbzKbG/OBL2/U3Q2YXTSJ3FkLvNVkFl7Nj8ksUJctzcR0bUZI/aEK6BE0
	 V7zjHikwRYMR/iYLX2ArEvFuR0UaVuNZFFKEGZlAiFQxeZHlSI9CoUpBQQW7ARdkGBHkB
	 kSdMczdwnM8V33jiuhEDDE+Ul7oD5wapGlJ6ZlJ82xaiMfUp2lhAPL0RF+LoQuu3cdBJN
	 9awwLt8Q1rSPZZ8lH5hTc3ZakGenHKLgepW3cBTVRIxJMeH7m4ecM9BDOWf56crSMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEIRttTU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D983606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEIRttTU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FF91F01825;
	Thu, 22 Oct 2026 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701449;
	bh=UNC2pG2huaw069te5I1zscCQhM0tbZkdOwkr24hsQoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEIRttTUHNUUGeGBl2hb2/5RlSDegf1EXLjBVGguPqgwUJy8AuDY6xwbXPikNr66e
	 xSfFbklfHxVezjvJ7TO+48Xg6vgSPRaVEh1QdmMwks4Q/9pNF1nE+cN3oLYarlu/DO
	 krS+m5sAhU2/9Gt7qptTtlXgWELtAnGdAuPBNHJMvwGrgBe61JdlEz/0X3V5gPPids
	 SaIHMk7hCPz37WcvoBHjPtkv5ukXvouhkFWLy8vg8FafLeBpCzOcBa9Wotb2Xn2J3r
	 fE86wCfQaG/r73/1DLuZ7lSambD2cvKSrEnXblkJ66Ia9J/9zYJOAyIlEosLO/JIZM
	 1hwcNVhyHuaww==
Message-ID: <sashiko-outbox-182015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/11] perf bpf-filter: Support slab cache locks
 (&<name>) in lock_held()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022203003.1779152-9-irogers@google.com>
References: <20261020205859.1080743-1-irogers@google.com>
 <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:37:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend the lock_held() BPF sample filter to support dynamically
> allocated kernel locks inside slab caches prefixed with '&' (e.g.
> lock_held(&dentry), lock_held_read(&dentry), lock_held_write(&dentry)).
>=20
> Reuse do_slab_cache_iter() from lock_data.h via a SEC("iter/kmem_cache")
> program to resolve the requested slab cache name to its kernel
> struct kmem_cache * address, and use the bpf_get_kmem_cache() kfunc in
> record_lock_acquired_owner() and record_lock_released_addr() to match
> held locks allocated from that slab cache.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022203003.1779=
152-1-irogers@google.com?part=3D8

