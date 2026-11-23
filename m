Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476902;
	b=cyt3DGY6czeS+LFdBuDpmNimtgZ+AFn9AtKIwgZ3z5fwI2Ic9grzyNptSO3eBhClABBj
	 DzlgJVjyKJtfhfFz6I8gvVeCNf2Lfc637u/Q3vEMPS28zundgr8t0VD88tlAZFNY1erRx
	 bpDALwiuvFb/VEB7BdiKcBSOX6ypElBsoRsIkHRDjQM/OwAc0lMOSIsfO07ue4uAtm31Q
	 qeA5KaOUAqAyvMzYlr6EmeLubVuNXPWtqc3SZKejpNVeTA0v6LlcSBiyrRlejIb6k6Kta
	 0wxmuj4MsnqERTXFUoLhQ3vF0uuzp/fKMi3/DuVEBp8xGyJyo20J2XwTPk3NcRgJjmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sO4383n9hQZV9dDsxkF7psb+NoTClFTV/idDmx+qlR0=;
	b=ZN8GuaEKSPl6pvq9tKOKx9UGRFHFEv+nZgoF6GFbfn67TdOZbGe2U9QO0AA3M4g+JeS9
	 gJFhYWg9V0U2LSZmUX2q1S2XeWziqx80nXy5XbOjVAnVv6IVG69VasFVth5TUGz7HBuHQ
	 nB6rL8GmSZfWi18ChEbAUCbX66fYbOFz8T0ZXkd9ueQB+ImCifvgLxovgaP5MPjO9K9Kz
	 68osaWjX4ihKCH7TIYNehfH6o//CpKEcB/dDKB6mnjzi82PO1Nk2d5EKfpXEEXIIjw1MH
	 SiGtAQHNGTUfrYNBym7vlfIOcTLaz5U1PLCt+wOBDQFsxA4VblLpV+0x6wSMOyNa3og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bGnpSW/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F22606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGnpSW/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0B1F000D0;
	Mon, 23 Nov 2026 23:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476902;
	bh=sO4383n9hQZV9dDsxkF7psb+NoTClFTV/idDmx+qlR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bGnpSW/ZTU3PSZdq9pnfsS24plhoOkGr/8BCsDi9DRFwAeKQrFL1286jluUvnhE/K
	 VW7czA5l/E8ggBh2ah9MUope2Tk3WdIGVKKCNEWL1lWtvqk++uszRHF78CRlHN4fyY
	 DoG87roHZq4OXIV2v9PJoitlucfH2yOEu3yK5BSOoxZ42DULgwa8j+rRFxgxB0rXj5
	 85s91391AuClY6iHiuxo0onRwRRiuP6i6eiZQ/6Y5M3Y8ZDj4Z5CVrugiz+62T+esB
	 l+WfJ0ttksUR7BQ1WmbFGskX0djBuEGxLwMKpOp/5P6XS1qtetd/VLFTjA4J68sAa1
	 WjOgfG0vm1Syw==
Message-ID: <sashiko-outbox-230216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 00/11] perf tools: Enhance namespace and chroot
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123232025.1406560-1-namhyung@kernel.org>
References: <20261123232025.1406560-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 23:35:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 1-10: no issues found.
- Patch 11 ("perf tests: Add namespace, nsinfo, and boot ID tests"): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 11.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123232025.1406=
560-1-namhyung@kernel.org
