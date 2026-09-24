Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E23DE448
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228441; cv=none; b=GqnpkbjI+KdCeMlphuI8PyxF7Lpbr2D0+gsA1erm8Hhje3f1aVhmlh6pLHK1cdSSANgEatnTqp+javXBtJ6JUIaO80gcZQEngoKLBxA8zLN++y6J8JP0JKyWEfsAeXDsaKF3hUMQD6JinecB1OzmCJsqppzroM/IjWtw3osTyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228441; c=relaxed/simple;
	bh=TxMqIKBTIC8c83UM50dYI5Ah1dFowFRD0HfRotDmM24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYf3yd3eBpsHg3dCnI8btOvMT/cuwNu2PJYT7vHXAqqPKdFmDRHfgkWczYvwA1M6MzyehVNbzL79DLYGAqybTrrS3TGMRnz3TG3t46b1/lsqsN9sP0mSzVXGIEtgtv53jhSvxHSYwQQ79larEpSsVTb7cXpcQ6wrR8YyTGwsFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G71EMzx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G71EMzx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997891F00893;
	Thu, 24 Sep 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228440;
	bh=xY8rStn0dK9xlH0IbCfw6kay4TrDjIeiY3EQNXu0568=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G71EMzx712NJes/wd2uIg5cYnunAvbwlkdRF3UCJRcyTiyeoRXr2f4m4ZPeWoL1mg
	 k7byErsi+L/oWVaRv1TG1fi6SiLkzZzfwqCz1JPCnlv6Sf4xkBwSSbUJT/wjOoLM9I
	 XfRla/cqBiAK24Ouliye1DsAryex8eJv4Y+E9vOHUKmkVwXesLoUa0C8OKehcCNsCn
	 h9IUb142cL4WRnKAfokoD0Vrayifn/l0HkaliUHTTTvQ4fGCqDE7eE0wN9VzaODqoA
	 cfGyX8VoQanNRxb+3Bhld/dCKYV2Fr02W3qfFLAg2ptnQgnhuQLS8RJ7Sv77J/GkD7
	 s0/rLbn34VcOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/21] perf vendor events intel: Update emeraldrapids
 events from 1.24 to 1.25
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-7-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:40:40 +0000
Message-Id: <20260924054040.997891F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/0929815a4859319c27d2aa9099d3944=
0829c5d7a
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D6

