Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942189;
	b=u1aFP75p0nRtR9NoUPJeuHiqxGW+nP7ddc6G8FAJ58tXj9S7DEKEF+k7t2IkhrYg/14Q
	 H+RuUZKnlNiQw+5z/eo3Rw3fKSu+UApsRIelLYiFgkclkCfRcwMuVVjhEzNlP9O6UKiVf
	 HUS8I/74jh2x7vcXNHPZmV85vTsSuJR65IzRozzn/+E4yphFAz9yOY23V0PXor/ZP7uWT
	 Yqdc3GPz8Ie0prQJaBuOSQNoPfk4jvaRozAZU900YA4Z/GLJsaZbtMHHKQZmXlpOFoRfE
	 35BPQPwuDRsXBZ1S4hPNk4Qkv86mcMcxRbJc51oeUWbSYYn6Od9bWlO/gBXmuxjPaNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942189;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9dF5NPm0HLE4KuWhNxg4smhH0ydGBBOKmlWhRelE5tQ=;
	b=SR//CEqKRkuQNEwcDaOIwiwp7qYQJon528SH0EJUBpWlZxZK7HF5OixHEzzSBZme88JK
	 u9TV9WwLm5ofGjS/EAGeGnRh5bSo3wnyQ6NUG8jpKvunSK1+2vTK/2eUVILSju8xwK6gh
	 49iba+ElqI3lpgP5Ai0NV9zY2SP9G1P7A6PEwV5xXGRbPNENb4WOzkGkNwWlqF9n1VFlk
	 9Tic6fl/XCnRDw1DlsGCyPRAZsl56QcVxe33WnIGncIxN31AgUNej7vgANIr1334PK3jh
	 fFrblzixyNTswYWw89CG1vBEXvgXYWSPQKUez4y/LDngp7huFrSYBSRrfPX85fUcs/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KP/fpqxs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE32606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP/fpqxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0371F000C5;
	Tue, 17 Nov 2026 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942189;
	bh=9dF5NPm0HLE4KuWhNxg4smhH0ydGBBOKmlWhRelE5tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KP/fpqxs/kGbexainTn+LHpuGFvhBTaPYSXuVfpy+AWcfYpx+mVs0cqmdKz301LYV
	 TQDa0W1axQaXFO4eNhZq3cSPY2KhtFqtiEX+EJyyAXQ5yKLZglZxSfJvm38t8F91XX
	 YMCACPaWbg4hFPA/nD9zH9ivsbR0/9OnFSO/nQcWaB95Eq+OCH+Yr9HG2GlLQos/6c
	 B7VZP3xWouqqwHH+3Vxcz4wrLoSoS2vQVePD7G3pOm2fxHn+9ti+xjvEt1/axPtf61
	 LeEJva4ZOUxLnHPZFCpCWuFMWOLl6bF/tul7U/k275wPOzHNPFJVNTXYJaFaxCzRUF
	 wLSQGn5LdqQsw==
Message-ID: <sashiko-outbox-219428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 22/23] perf machine: Hold machines->lock for
 remaining guests rbtree accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-23-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:03:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit 1324aa051bed ("perf machine: Protect machines->guests rbtree with
> a rw_semaphore") added machines->lock to protect machines->guests across
> util/machine.c, but direct traversals and teardown of machines.guests in
> util/aslr.c, util/build-id.c, and util/session.c were left unlocked.
>=20
> Acquire down_read(&machines->lock) around the guest rbtree traversals in
> aslr_tool__destroy_machines_priv(), perf_session__write_buildid_table(),
> machines__for_each_dso(), perf_session__read_build_ids(),
> perf_session__fprintf(), and perf_session__dsos_hit_all(), and hold
> down_write(&aslr->machines.lock) when erasing remaining guests in
> aslr_tool__delete().
>=20
> Fixes: 1324aa051bed ("perf machine: Protect machines->guests rbtree with =
a rw_semaphore")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D22

