Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701025;
	b=R3qm4siVi935lnUwsDCCum1ZqPbfI/9842Lx5Hv6UWlReSWNsVTtFK8DDhYwWUEx43bc
	 Bw3/dZPECEtco+G4N1mHMS+Y5a0zNm7nlm+wAOHr5r8Mkrp/qC5D2IzIEpsZairY29W1Z
	 vP5mf3Z9jjJ4CUf+DmkecFs5L3F4lcFgzbABoKZLnIIJarMWxQZhA8usqK7ftkEkwEmHe
	 YNs8lp3+VjNlGxrS9awx3uPPy8ItZs18rGVrlcFzibyR5hMX1qrfTPRE5zrWPZ9PTnXc0
	 nt5GcWetN87vkUwFEWCTmhJWus8XUa6gp+ZHrbK3SR3IAIUDfZEWlJNnERsR7RNbkIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RBvBrF8LmxrVC5Y+CBWaeWdLTdlpnGb7MkNU5Z6fVqQ=;
	b=qud59xa9464ULXF6EKvo04x/12iJnx/mPLfHDI4cd+5TuwXlDcrdwa+6oy8h9Gyihnef
	 yiSHEtP95hkrtfpdR3ykh8nZKnn78vszprsX5gijW5U1X60JEtoct8Y+UZ+JMlgJip6In
	 jfuk1Nc7/kfBbVwOAAUt5rvoWIsVeemZT6HAeORCi6ybeJSsi0dr+VbnINcr6m2bCDzgf
	 oh1suEqmmpKLMYnvnTW7VYannomm0oYBTHi/gVjIgR5qIncqALat+l4qN4IHCnBbpxhlN
	 wQT3BOxDZaqNaktJRiEhjFsdZI1rhyV5Zvhv2RYINpBQYnRmOe9j5ENJeHNUIg0QrWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxuslGHe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28352606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxuslGHe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975271F01825;
	Thu, 22 Oct 2026 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701024;
	bh=RBvBrF8LmxrVC5Y+CBWaeWdLTdlpnGb7MkNU5Z6fVqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxuslGHe+zyXw9yw+b7sUOgSr5Vo1sPtv/ZkqT/s4H/2028Vh/ixKH9LN22Vj7vA1
	 KiCfYziZy9elzGfSMdGpm60r8PSjmHRQaeLNM8pFmUK2hZw2TBvZo/hDHIIWfTKznf
	 DSxF5AHUGoCFIFDpabidBbQf81x7vYXYsojGJCd2AUaiVFuSVSeuVMswMehFm2H+WX
	 o0sw5KFI+3FAB+tiJUlOz+NTQD1FWoKi6eT1OaA0MJD6KPmsW2LOhxM+LyIRCN9Dff
	 sWNJTQhI2nyJX9VULhfTqzjdM6r7i/qgkuu0KXCrt78naXGpf5Y9GybblJSuDMQ3yz
	 zcEnVp/pvUeWg==
Message-ID: <sashiko-outbox-182007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/19] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-9-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:30:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In machine__process_ksymbol_register(), set the binary type of non-OOL
> ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
> machine__process_bpf_event_load() upgrades to
> DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
> dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D8

