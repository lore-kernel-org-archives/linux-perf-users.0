Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591193;
	b=02Wq9CKCKYECAzDUrkP6M99DyUmg1Pw52b2k0CsSaTpUjuFNzDj/MhP7DNzVpNtxdyVC
	 nH1y8jmmNDZDFgZTuJzeGjLYFqsmMcS96lYPDEqjQq0FA+iSGeLFP+3/WER04lggSlU/E
	 GkGxilg+g0K+2IsI7StU32wL0N0OIX9i8oO/7UN2x2ajUBd2DmK2BN2KEjAzPQM+5qtER
	 x1gLQzH0RdxHmOalK5WgVEqsVxPL8FEHXqmB4qEdiRE3m42DI9kJevxEPor9/qO8FwFHV
	 rIX/hdjlxwap75KsjFfttH5SvEiD0hhJr09haW+4MoSzWAKBUpkiTIr+2h/qjM8m5RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591193;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zCMTdwXSL5D4rZBu5Nd6pLYm3zrQhiAcTbUFQwEz73Y=;
	b=4ui4OpfQo4aFOymKQ4mY2b9O3UHeELGttzZ2Ib9DqgYuVCZbSmTu4kHgw8dJ7affn7Qj
	 nv88/fHsDjhjYkx5wifTjHKbNR0UMVc4jbg8K806skqogPVSOH4WJCnnwCW5McnQnz9gF
	 s3i/eCamMv0ZfPCXQVq3fqQ687eLZBe3yBFqUg3i+NdiUe0TjUGkqrBIpexwXHCEzR9i4
	 D/SczrYypdc09p8WV/jKZhWTWLTGzNUKr+cmRSCpIKjbdrzKI4ewJwX3hP1ccA2zIYYdx
	 KzTjstQBQXn7PCVnabgagBg/7UaBwHfAEku/a7Vu+dPE8YlSHwMAvt1cAWXz4RrnNJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXUVgMJl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CB6075840
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXUVgMJl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4441F000C4;
	Fri, 13 Nov 2026 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591192;
	bh=zCMTdwXSL5D4rZBu5Nd6pLYm3zrQhiAcTbUFQwEz73Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXUVgMJltsOmkvieB9Ifvt3mcjlFUmF61oTUQlOANBAO0HKVnyCBJFLeboMmuCngH
	 jO+lc+2KahcFZb1wJLLjuYhcXhI+sGDZ/Nt0S8QYJ7ulLfwVNHWNxPTmbAwruJfnuN
	 VyGdVAzE3ryE6Y+wF1B5pZ3FzxFvy81+Zevz1k7SROpxvg5g4KuAVKnwJamZ/zm3B/
	 j4g8/H9ilbIqaU+yeXfOPQtwpIn5NfHGtEJTEPb5axJbcwc/IYCbkW42A3kf2wzm81
	 FKkfm3VavMw/JQIBVrnrN996dCh34+5kwwKqUN1aCTq+fgGm0ie0C0hp8K4Y8hsfW7
	 1lMaVOtwVkP1Q==
Message-ID: <sashiko-outbox-213321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/23] perf machine: Protect machines->guests rbtree
 with a rw_semaphore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-6-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:33:12 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Unlike struct dsos, struct maps, and struct threads, struct machines had
> no lock protecting its machines->guests rbtree. Synchronizing access to
> machines->guests is needed both for concurrent guest machine lookups and
> so machines__shrink() can safely iterate guest machines using
> down_read_trylock(&machines->lock).
>=20
> Add a rw_semaphore lock to struct machines to synchronize access to the
> machines->guests rbtree across machines__add(), machines__find(),
> machines__set_comm_exec(), machines__process_guests(),
> machines__set_id_hdr_size(), machines__fprintf_dsos(),
> machines__fprintf_dsos_buildid(), machines__destroy_kernel_maps(), and
> machines__for_each_thread(), and check for an existing guest machine PID
> under write lock in machines__add().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D5

