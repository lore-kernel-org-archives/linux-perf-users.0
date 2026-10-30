Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373617;
	b=zr6xle/vq3YzwySZ9UmhzDUSH/qHpkhdb4RDYEPo1OGXnHkJi+LAn2hldBvot6Vr4w8W
	 91CgO0HvAxTkeQNS+XDDwRkjbtWylcrfMfg6+SEn5/bFFts3ESih+cmldstpMv/Y/TJtn
	 8msP4vywAwp9NRK9630D7sBif27wjWnXo7ChxVDNZqQIBisNdWuMYU17jAy7GjxdNAUNl
	 ptbFI6zC49I1gnq8oSJ4lcZnCCQ/4AkZiA1ggFtg47YZmhQpiqSQ0qY0000LOWqIuU/FT
	 92K8Yc8QVuXZhU5SQvjH7gggincEQ/11TjEvxq3xjP0EeLqjOS0jvBylNJM9uylit7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373617;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2IiPt8v6Arb3nwzfTawDBZWdNj4JvdwT6eGzM9BmLEw=;
	b=hfMcgj412i5J7fhutmBxcYSpe3yMjb3wsfHSq76UlRoH2Nnf1smvgVw4SHw3J+uMWPKV
	 RXWy2AEid428sJ0/4nCbBtmRibeErvZoM6k0ikwtn2sjlWJAExODgWY0U3QKn2OgCGra7
	 2DTQOHEOa5MHGR0B5fDR1K2xX9tr8QCMqdLwz4KnYJOx2xTJnMcolhSIYID7JSGZIX3If
	 fQxqWt4awRwF0hHb++8S3J2OhDn4SiNkRCKpOB8DvTKwwUFXJJC7/tp/Q/95zJedf8Kt3
	 wLfIgpm7C1V3logJtHG7D8SW87AuQMiHBn72pP8cybYowWjdmajOrhKXNjreOUkijxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCaNyxPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A307606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCaNyxPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20651F000C1;
	Fri, 30 Oct 2026 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373616;
	bh=2IiPt8v6Arb3nwzfTawDBZWdNj4JvdwT6eGzM9BmLEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UCaNyxPxOnMN62sChQH/FDCjHoiQrQcT4MUPb2HnGyyMQ2owkf5FROVk/Ht26BRJh
	 EY3+Ph2iPGTEOoyQM4At7/9pSNA0CQ2igs/vnn1w4queK6RMAuj8m2Iest1/P3PQ1K
	 TujfYDmh90cX2qkHev+lif8x7/g0jLexLvI1AvLWmQeZyLhLhP+0R9Lib1iFOdz7hH
	 5S22cd/2qJzVhIRbUpmiAk5kWBYSidYN2tuBtPAjh1gg4FRexcwnbW1vn+IYQAT2+3
	 XX8UaidIJdPBvIPJ3ArvRKDNuLI/DJ2+9CNN6TRq+L8jTHJ+13scHmbC+8iIZQVv26
	 ZKtYzltSh+EFA==
Message-ID: <sashiko-outbox-191155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] perf cs-etm: Centralize branch sample
 synthesis checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-8-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-8-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:20:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Move the branch-synthesis option and packet checks from cs_etm__sample()
> into cs_etm__synth_branch_sample(), alongside the existing branch filter.
> Call the helper directly from cs_etm__sample() and cs_etm__flush().
>=20
> Accept trace-start and trace-end flags, this preserves boundary samples
> without a taken branch.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D8

