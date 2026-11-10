Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349344;
	b=iLYkneVR8mFvS8GBswJYsGcbhNyTpR1mTHOfQJrhQYvV6g6LVAb2fXcBWta5OBKZC9Z4
	 m//GnNSVqL9hujbT523ky+c0SuZQAvuHk2WrjDK52AN9UOvXJXlvWrbAjezMQUlnSXsUj
	 GSRcNhDMrFuRXKaTPI1dk6aT1NcvhmajfIMcj7IQn+6TvqHUb/e+F4hiGo3X8oyYS7bgF
	 zM+i3wbMfjgPq/O6Qd/ibFGwvAg4LuRbhPiRALjbW1CLO47AezPTorJFEsn3Gl4tbjZpL
	 fEtyVx3rYMi2Xf9udEvm9iLFHbJn1f2Qy6LkXtMaAHvwyX0dB4xXwgXnaQVm+EdGgNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oRN5HvO0CBqkuQMjGCiNB/lnQYVRw0AoGyghhRwfjYM=;
	b=LBKcbEE9S8D9ZFCv8LwO3gk6lo726zUwEUv9eB8w724S9Z1mm5rx+B4nLtW0IQoRE65Q
	 LuklQ2S1+wvBSF2U6TinQGBsM7Yd6MDZ0sfOftqJk5ROf525VIRsQp02re9T0OXpLPETs
	 zpkaCV07S1YlryrrrjGU5HmpPYd+C3HP/q+U+k/x1W/BDdDnuqYedvh0k4pehTlIOGmPx
	 OL/L5GvdeFKbiDIdC+LvsoIgsHhgYfpSMDNgd6YHCBXH9rQbeb+etRbq2pLxHk/mAXe2O
	 aCyVwlIpFXoUqA0OiIG8sPcLaUvusEXR/1lzU61wnX3oes3s9d2brbkMig45RRL+jNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxrLUMMr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91212606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxrLUMMr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FE31F008A2;
	Tue, 10 Nov 2026 22:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349344;
	bh=oRN5HvO0CBqkuQMjGCiNB/lnQYVRw0AoGyghhRwfjYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxrLUMMrqY69KF5t6z3wTjv7xmTVqCn5Ik/ZcLTGwdCn+g/1iasiEFRlMwQVKAJP5
	 yiiKi6XrCioV26KKyeGC0q8K4JKyYEEFRUtjHUWBAUH2HIBeVhEk5nr7RoYbuFKI8p
	 sN6m72YqwIPMxc0iv31tqBfvxa2TnNf0kxSGFr4D8IDx6FromvEafXBKxvMRe76Z1a
	 WhcjQA5yE8xLv6TKOSZeyiAIjCUoZwla6WH5RtV8pUdcxz+Y7Y93OJsEUCfZDdh/uL
	 hITv9/PpYO7Q5huLk1xm8gN8/td06WM/oA8Ff1kUBx9QvAar7O8seoM4recW2pNFpa
	 c0G7aleiC+4lQ==
Message-ID: <sashiko-outbox-207821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/20] perf machine: Protect machines->guests rbtree
 with a rw_semaphore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-3-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:22:23 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D2

