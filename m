Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949434;
	b=JINI8HRQMQwe1v3m/iT/l0F779Ha1kXGBsBKmAs2LEL6kW9D20cIYLJR+lfRknfKcuc0
	 dh2+i9h4UPS2HmtpIfG9ZGxYcy3JEDRFS+LR9kohk6deprSRgrrWTnx9PylfAgnd1+qOn
	 bBxexaXNIs2QUIORtyPTHPHpnjgQd3x+Gnsgn3ossk6MvAJe5mmDpK/3n7EdF8R2Pgf+c
	 1J7RzJo/nMtZ73WKEgYhMt11IvtBEtAV5tMTzix0g8YyyYBvKK1N+Xj0vA1txIGKUvta6
	 BtWdHdBsHrOleiwagtWUeUCfQd8ykEE/6BwQyNgjhCrLyV4+jSrUcvo4et4ag9Egvvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949434;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0GB7AbAu52OMxQ5Vp2M0yBxem0pWRMDJwldOnSCSygs=;
	b=P6+TO81Tj0qJLZzho335YpePb7ZcfugyHSkq76IGvDbsfCeiOAwBKt0fsngRqw08ZX3G
	 dFxsYk6IQzn+l67mN0+Mqok3Cbh7XiqvTM4nSDjZAatJ0lqeirlqL9EH7pgg7fjJo7xeH
	 Ij8Nv6Xl6VFzhntNlcX/3CcNhc+B3Aau5FgoCYLkOq1VNF9SN4wwSZYQ118qyNuSySZHd
	 x5Uujqfiezy8eVMMqsRkdf8/7lNKJlXFo+PJSpV2xsW/6Uwpd5QPYS/ZTbY7GGZzwmXLw
	 aQPO3QvLSEZqbty/d6kXbJBHDc3h87maiRclcp8lbEfCiCT47xaXEbbKn8NRN5XHFog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaSXNRZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD93606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaSXNRZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5AB1F0089F;
	Fri,  6 Nov 2026 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949434;
	bh=0GB7AbAu52OMxQ5Vp2M0yBxem0pWRMDJwldOnSCSygs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaSXNRZ6MgJr4Qx8XIAd+k39uwMBbnLsPw+mzNIZnMSa5WHQE/nrxAt4+cR77ZiR+
	 EoW7/XIG5u5hRhcjBM+cYuS4YmYg1WfFAhOWWzok3Sth4g0+Bwa6b6ZnZNlarFxEiR
	 GWJTOPHC+QXLSdXoTrpfvHzn+w7pK53mkaPZ1YfSY0wrNM7RbW034JISaXXH4juEcm
	 kq6AyM9yYWCC/kXaFMtcyk4N02vOaNKsuC8LCGbiYq+HX9pngk3HtDtZYtbaduqpSB
	 /x2DsF5ZTDHHIFDAtr01IxJzrTSjOYYWX9PM6F9Jm2K6YT2EXHDe368AVeb7PUtixS
	 Tp9OliGJsNAqg==
Message-ID: <sashiko-outbox-200982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/20] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-9-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:17:13 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D8

