Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589091;
	b=l55iTGCDEl/b4PYYMxv2Covo5pN9+3NEbTDf3WOt1k7MN2Mro/iTsStv9rALNSkvY17H
	 Z/wL0WdPx91NTVabbi4d8vgu2+I5Xx/Lf4ztadNvrz6AM3244O08j/0Eo7HxjzlE+k9fP
	 CDXG32WUyPnpV7n7CTKpKkPzwo4wNz5fq+ISlxS7HFcEqVFu3lisjcK0czySuB/GpN2Ux
	 X7YbFN00d9jxkRiUiWN/XUY8PPABxePoq4Vn4EMmwchpyoN80r87YgUVz62D5K7cxEhSd
	 3OM2UNQWsXH0wJoLSeY6yyWBGT3OSb6nhYhTS8YE1G6X83M2LjRXytewt9qv3C7bPTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yHYaQNE9cxNG9RgctsKOJXBnU55Jz85cnLgyAyhctA4=;
	b=j1PKm7UKD6csBfo2rKmFWmEN8fCsPG3RxkWdQx10f800sOiutoxov7uRi7eDfyqfT0nv
	 rFVglFDGN7IBuJQNxs13gTVuRG+Eay5PFQVLxJW3Fd0JbFjlc1SSYNBBIxr0ViT1zct8m
	 4hyom6qggasXCnd/2nCBZg1rarx0YcqPwDbmRknHHv9O70+Gt6CKRCm19vnBnKRYRm8gM
	 InSrzahpg3gPrwLfQV8E2uHAsOGkKib2DTRRw4uwA6EITo3FjY+WJ6+hmv79FWVCUd6wP
	 dGxnWXrbXthCqa+vFAw69Ii2LXU319hRU60H8yOqm4BdOxGH29wdHaJ1RZDn5wIQo/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nz/CyDsn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C70606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz/CyDsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D941F000C4;
	Fri, 13 Nov 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589090;
	bh=yHYaQNE9cxNG9RgctsKOJXBnU55Jz85cnLgyAyhctA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nz/CyDsnz3j7MS6ScO4+sZTKOmVWyJVjpM+rKW6isDGkD0qjXPkpoeCxo3YBB+yBB
	 x43eVM/M/PG+h3WQgS/h1yekh8K7M9kBHEmFFE8LrVQnbdwTnAngwDwn/m/AULkLID
	 Pg/6Wpnx2A2uUloxmI0Z5hVryxLXeRclf/r/aoq8X9x6wAMxIsq3y4M+LTFb0kQtP1
	 mUtaeiU5kIsVT7hVl0DiyOskds3s8DoFtnVTYh4u2qSpvyiFU/CZ7/+L0QUcfYCLXq
	 EUJtnI3DKGyw/FzXh9Zg7CfwTwN3n8IF+iHGTnJR/f622XoUvu5Sjo0zLO9KtkDilZ
	 pNkwlwVm4Mj6Q==
Message-ID: <sashiko-outbox-213256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/21] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-9-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:58:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Factor out dso__is_bpf_prog() from __map__is_bpf_prog() and update
> dsos__find_kernel_dso_cb() to skip dso__is_bpf_prog(dso),
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
> In machine__process_ksymbol_register(), also check
> event->ksymbol.ksym_type =3D=3D PERF_RECORD_KSYMBOL_TYPE_BPF before setti=
ng
> DSO_BINARY_TYPE__BPF_IMAGE for is_bpf_image() symbols prior to inserting
> the DSO.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D8

