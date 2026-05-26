Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEB3491E1
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835683; cv=none; b=CY3/Bs8knoy9omeKuqkmdvcinxDdTh2we+zLsU6JCVeEkHt7gRCh2QLo0xXFoKhyKFvra8stSNxMfhk2fUvRqgSOJHUefWjdKgYhY2RkYt2eRt/ReRPpReGlc0iODLLLe4olyyhRfIRPYnknrf/LnYGxSNnZu+kEDrwurwPnn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835683; c=relaxed/simple;
	bh=fLI1ZF9NyZxPf97XPsZo9PsYVDOz80muHQfmm2oKxC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBW3WttpedtBHGy7/tbNk0B2TjiUAXOgFcW9NHZRpP6o4A5g3IQO9V/urFZ7Hu9EnOv44HmIleGY++8NEb55/DQ1aPjetUWy/42SKo7r88oZd7qfh6SBraFZX3jIEJwujE+zKwfwIWNf+YOHfnD+RG95t3Vbib9kUVpx4re4Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqLMFzNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqLMFzNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6711F000E9;
	Tue, 26 May 2026 22:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835682;
	bh=KMOR62NevvpHrBJyKYXKrc1bF5z4cFlC3oJ1rqbkpjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqLMFzNcdLFM+ruxGp5RpKUGPCNe03IB4Tw9Uj5QRzGRv2+LjUPOSdl3BYTuyGMh/
	 vlg10FRVUKimCEdEAZD8Rmyjw6b7gULnttS3S1rOrq/IMZ8yqGP6jlFDMcdwEcNB65
	 wWEOhG8Old0MPLGGWn70kIejwD/eiGuCtW1luBdotRSX1PRJrSRcjq2WRQBJj27nSJ
	 wJcDtjwOIdkQB+Kq1BcPo0pzhO7006Mq4Q8Vcbimy776ed2+PzDqZ08Z3fqJQxLu+b
	 obKKoyAWmXZBngScWQ7MdyTiQWEpDLIpSceF3+nliKwZBthGC3Ta4IqF2Cl2FLqKAY
	 fHiElFrSpDunA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf clang-format: Prioritize Python.h and expand
 other categories
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526224241.4016312-1-irogers@google.com>
References: <20260526224241.4016312-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:48:01 +0000
Message-Id: <20260526224802.1A6711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message contradicts the actual patch implementation r=
egarding header sorting priorities.
--

commit 6df1a36d29968fecb941bfb94a7d676143f46552
Author: Ian Rogers <irogers@google.com>

perf clang-format: Prioritize Python.h and expand other categories

This commit updates the .clang-format rules for the perf tools. It
prioritizes Python.h sorting and expands the regex lists for C standard
library and OS specific headers.

>     - Prioritize Python.h by sorting it first (Priority 0).
>     - Shift other header priorities down to accommodate Python.h.

[Severity: Medium]
Is this description accurate regarding the patch implementation?

The commit message states Python.h is set to Priority 0 and other
priorities are shifted down. However, the patch actually assigns
Priority -1 to Python.h and leaves the other categories at their
original priorities (1 and 2).

Setting the priority to -1 also means Python.h will be sorted before
the C file's main header, which implicitly has Priority 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526224241.4016=
312-1-irogers@google.com?part=3D1
