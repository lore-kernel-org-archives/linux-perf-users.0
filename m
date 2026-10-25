Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968306;
	b=GMjuAVqh/Xi3HJNjUJpoGkshu1uBrXnq1pNst5/JGBn9qQCSYhZALKlefE0jcad/g6kW
	 Lxcc8WVxmH8+H3jAJqQC13hn5GWiFCeoidXXbNsaqUzeSc23eLuKjQlOmw69U2Ut+REKH
	 YANm6echsvjBk0XXBHmBnShFRoC1PT2997R0NXkGbvp2KOJt3EcPzviz1xznDoYm8xNPG
	 4vTQrxIrlHGCXgZNuMxbXZCJOcR54k1QnPjHZiS7PeoiS8H0xRC+ifXBw5x5se5XCElcJ
	 RfkkFIp3dEMAE7BFAGB1SL7Sb+MI/42QUnEE/4M+AUYE42SzMssC+Mixz2kuomNMShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y+cJzWLr/MFEfzR/0J86NJZxfX9KcMtzZgD/Nza+6JA=;
	b=BdiC9cG9TJaN3K1sz8VBYjuQwIns5gQzQ6xbCt0rXSYRzxL21GSppbW8rMFXK05ynzHH
	 BMDS35q9u5F/vPjKo5xBxHnN7jmAzKRxsMk4Sf29iwCjZDVbB87cZt0XA9Y9/KP23w7He
	 WCrjxhuQITSoQ9wK/G+Mr0KGgif7Y6GQkN1Mt1J6afBdPXLsKVdQEWGKO7sH/mv0rejgb
	 gd1ABo0eu8TL472ZP3Du5GgBNyc4X8Wj9BUthrGnKRNlU1iM3TxkP0gsf+xDOIvL3DO98
	 UxOPzt3F4tocjbM+rSBBonqaf3dry+seIMWucmoN29UnczMKzNqb6/312mKuuWoB5xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="laDBRb/r";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C69606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=laDBRb/r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF6C1F01825;
	Sun, 25 Oct 2026 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968305;
	bh=Y+cJzWLr/MFEfzR/0J86NJZxfX9KcMtzZgD/Nza+6JA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=laDBRb/riR7qNrbV8MWXdeQDPBUVrnB2L0twsg/55bpQ/feDJ/ikBi1Di2nB2LXZ5
	 JXnnc5vWBqM21fo6Ni6bpH1s1tfbS796jJTDlzk2/lmZqwoqnkZh5/M7a6Nn+QpgG7
	 DR6JhfVAP+gQQc32n2rFu3cujOuU7C0sxu2uefHQS5eiqHWa5A3m76hv+1UkGotfbi
	 A2sNG9XAyx5aLgX8gQLVsv0pg0LJIubmt4JlMxbjkAgFcuLhUlE7CVyDoxDmckfC7k
	 pLJYUTHZXyIcC2klXHzB+dBkZJvWQcl6jGzZ87myYxtAZxJqAp3/kUCjCUZhN1wQJ8
	 lkxP/6ZMyH5cA==
Message-ID: <sashiko-outbox-184499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] perf evsel: Add bounds check for
 PERF_RECORD_CALLCHAIN_DEFERRED ips array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-2-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:45:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In __evsel__parse_sample(), verify that event->callchain_deferred.nr and
> the trailing ips[] array fit within event->header.size using
> OVERFLOW_CHECK_u64() and OVERFLOW_CHECK() before exposing data->callchain
> to callers.
>=20
> Fixes: da27c4379ce6 ("perf session: Add minimum event size and alignment =
validation")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D2

