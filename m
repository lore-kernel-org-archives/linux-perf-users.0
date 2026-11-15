Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707220;
	b=yvof0+N6zvJPKj+vSRk6qCxVxRMvU4QQrH2pM0seNYoJIPs9/BrpO6HPdFBjDt2AqoW7
	 ZJT3DNNvpYmHO/sc+PwxA4NhI6AWxnvC1aviS0Gmbr6PhIHwT/mU9CxRsaKJpA3gjldgV
	 wbTP83SbhsyOfaoVAe/IRufCw3Hh0+uD/wZfZx6idhQMR9w1BeclO1+SVIfVDRp4DyOFH
	 NFekvERVowE74dFRt0Doi96A/MrK1LmjxM9JQoQ7UEo8tL++Nn339QQUq446EMqEfArXP
	 H110+2ATE8W9iJXVMoXb8muDAzVLJySLof/N9FxyLqFejhTOHxCu4A28SMrHLJbTrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sk0e6MLF0mY+MfBRqbYSVZBlC1m/UbyMCN1jn3vgwhU=;
	b=Xk6E7lSSfV0ZtGaiiOFx4FYWLfjG91GkFFUneGq5pQ3zCvq+FESMRCuRmIb1M4+HSw0s
	 gtdcwQ5Kf8zlSleo8ktFR+6yogmT5axu2xuYRd0JjyMVkIWgRPnxtgA3e+Dyoza+8aOCh
	 EJCZ1lm3WxLfZ8K/hZJe3RK7CshK0QQG8QX3ReQFSwwtqCTylJBsIjBNfRNy645HnlmIG
	 s8jJtzt1QpodFKnsUSPoINIlfch1i3RlFaSmBJilEJYPtOH7zDF10UoBv8vQoNLg00TFf
	 CMK3O1dOkdV1s9awzB/TYE3UH0lpvH2ueh5WSnzgnTFRiKzRMbqKis/W8X62ryEZT3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft7BfS2j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5F606A323
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft7BfS2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC291F000C4;
	Sun, 15 Nov 2026 01:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707220;
	bh=sk0e6MLF0mY+MfBRqbYSVZBlC1m/UbyMCN1jn3vgwhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ft7BfS2jYX/0FOT4+MVwDb/bZvc4vSz4voFkzaE1Bg6ws+U5K1fzaD69H5wiqmU02
	 ZJgbb0xrtdjhRCY3QlxO7+lh6R1lZZfyN5re3LovgCLYc4cQ7b0vERRwBBvN2Ytewn
	 7elgwcw3kTEHoBKDNTipX3zmmyFMeCum19JQnZI954QV+lEf/zerul9OmecKtoDJlh
	 p3jHYvWl403bh3ygMUG5G9h3TY3Vrt1ZbMqMO0e7YYpxfTJpg3NGho2qUZRL+HGZtf
	 7/hu2Y1YGkE/5K8o/q9verXhQX9nCKL6BiGfdyChchi0XCrxRjHwzyIZunm3+pZEG/
	 FAUaAeBOZr+Tw==
Message-ID: <sashiko-outbox-215169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/12] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-6-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:46:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The per-member percentage sums the histogram entries in the member's
> own [offset, offset + size) range.  A flexible array member is resolved
> past the end of its struct, so the struct row only covered its declared
> size and showed 0.00% while the member row showed 100.00% and the
> header said N samples.
>=20
> Take a member's extent as the end of its last child as well, so the
> struct counts what was resolved past it.  Union members all start at
> offset 0, so a plain union keeps its size; a member that is itself a
> struct with a flexible array extends the union too.  The TUI browser
> accounts the members the same way, use the extent there as well.
>=20
> Extend tests/shell/data_type_flex_array.sh to check that the accesses
> count for the struct in the percent, samples and period columns.
>=20
> Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex=
-array")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D5

