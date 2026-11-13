Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591020;
	b=FtMp54hrjbOl70XOOdYLBGVpMlUxyyeFRRlda+AqyqJgqyJUrxGKmg2Ik3lj+QBjBMIF
	 +/Ka0VfSlP8Ac2HHdY8KdFAmv1g9JtQAL9pww5Eh6oAywKF6/XotFTXZCfe/J4tPnD+CB
	 eSG6jmn3j57TfwTmGphePBDBq0LJK1Ddbjahx3U/29DnqIRvQTosdy63Stcstv59oBs7N
	 /lOZZqzKn7ZUBFjKLTeMlmKUoIR+Pf0bUeFc+ejpMGkDs8Zp2+NkT4+S162moEUbOojYk
	 eUh2ye5p6UTANtuZTCUr7fi8gULVQxHurctJtifs3EM5QkuYph5Qs2LwlAsw4+1db9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6ZCgenqGcbMGfQMQJ79dAD33Bz1t1NC3n2g1NXQYSrU=;
	b=xsn4/hc1CEZodpMWkzA8NTzMtbXbx5N8mizcFd3M5GPc7rqclpDgH1dArHSsaUBB1cGW
	 eh3Np74Epww+sPDZ0xbyyi40NI4N6FuLFRCaDhQe98QLaKm2R4pBp+v+MNw5uJRhIPgbm
	 RDnculYNTuT8yFK9kRp8cpXoMwW14ai1kFAkoe26OanmAZgyXHnGD4RfipXI98VWZBWJf
	 i3RLC6IEeKHA3Bw+uWH3lT1pHJzkGa/nL3HL03LLRPtWFpf9Qif+CjOCmGLv0k/O7VaZF
	 6zn+qFtLV8Scmx//2Km9jxhVLoVRvt6aJYgFGb9r5BpQ81ETcIEjz+HE2buGibarA+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n59gyUnz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA86070F39
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n59gyUnz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3E31F000C7;
	Fri, 13 Nov 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591020;
	bh=6ZCgenqGcbMGfQMQJ79dAD33Bz1t1NC3n2g1NXQYSrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n59gyUnzzmcqwfJrd/SMTsjoh968/885c0YY9tmQrTtS1381/zmlE39EIxmOnX37c
	 l8d4zY599ZTk8TNtdKf05pt8mP6eOJPCVlaAUex6o461tj7PpGZabFidq5LDpSxeN3
	 2vZyQr6Xk70bfS2zYZ6DcH2WHCkf026gan0QYd8EnMsXeQwi1ue9hunl2SO/GwgIP3
	 attK2z5kPl8wmId4DZH9FsDAQ8tXq0vKaBZNWhLCUIKJwxQ/kFj/KZvKzoDnrRz/Wt
	 GC+fCN1Ukx+8FwBZVttbpaO6fC10mKD6ehDkr1kc4JGvV9ACBbvc0cF3DWsaxxfvlH
	 +oo2XbwwbZsWA==
Message-ID: <sashiko-outbox-213312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/23] perf call-path: Use struct dso_symbol to
 retain symbol DSO lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-10-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct call_path stores resolved function symbols for the lifetime of a
> call_path_root (in thread-stack call/return processing and db-export)
> without holding a map reference. Similarly, Python callchain frames and
> nodes store resolved symbols across Python object lifetimes.
>=20
> Replace bare struct symbol * fields in struct call_path,
> struct pyrf_callchain_frame, and struct pyrf_callchain_node with
> struct dso_symbol so that each retained symbol pins its owning
> struct dso until call_path_root__free() or Python deallocation. In
> python.c, this also avoids duplicating symbol names for call_path frames
> and allows pyrf_callchain_node__get_dso() to report the DSO of resolved
> call_path symbols whose ip was zeroed.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D9

