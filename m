Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D76488204
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179996; cv=none; b=YrywwXS8Cm7uxKqGUKysNSwDL9RwsW0uc7j74F6h+t7IqM/zITE2dTxSUtV6meiZLpd5eiIWZEh68skXqC5rg8P3gcglSffSc+rr2hATo1aTkOlWfnMyJXtvahfYXYpYWKgKiNmzhYROZqZpNgy2xLQxn+LBuldoPYbPDC0Sqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179996; c=relaxed/simple;
	bh=9g6pVrZ30AfxBIRTezoSrTf2vrWvVNL4fMkLkiTf0Dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+CVhmL+o6jH7PGEl3ZpLqMjvR4JVvJNRf9JMH8O3dycYSxq/q/y0lX/Qwr6c17aCJq2Rr+1huRSEsXUbK+kBo9R+TwnrZGJFy75DUUa4RF/uckYHWdq1OJ6EUXBUgeBN02in9lHMzSOQdQEU+K0E+pLKE/sg4AWVHUlaDEO+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmHAOeyZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmHAOeyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6162F1F00898;
	Wed, 23 Sep 2026 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179994;
	bh=9g6pVrZ30AfxBIRTezoSrTf2vrWvVNL4fMkLkiTf0Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmHAOeyZm7u0AztwF8gXlfOi1+mXxw+FpirQOcVRkNHMPODqzqrknmTxRnU6KE0bZ
	 +ekvXumKlT6bZBcWce7jc6QbkJOSx5NpPkTcGDLh4TGUMqQCmu4UFw4takhfTDJm5L
	 0LS4+Pa2LoU+SQ55sNMu5L+r9PofFx42fAukRyRmd7KShU1mOiGdzkk2z+sJO2pqgj
	 Uj4y45JhvDkKR1yjbkG8RZtfXdySkGrVw+RBENY43H9zSMcxPN1rSitLmPDHV6mWIu
	 canqSANSNcaoRYIYbaXHkZEe65VmcEA7jZPS0ECoQ99zBElj7UabPqZaHLDpZmb1ok
	 jDTALzwlPemdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] perf cs-etm: Factor out final instruction
 sample synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-7-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-7-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:13:13 +0000
Message-Id: <20260923161314.6162F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cs_etm__flush() and cs_etm__end_block() duplicate the instruction sample
> used to report the remaining branch history at the end of a trace.
>=20
> Move this code into cs_etm__synth_last_instruction_sample(), preserving
> the sample generation and instruction period reset.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D7

