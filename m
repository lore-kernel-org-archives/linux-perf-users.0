Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8273BE16F
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629229; cv=none; b=Aq7Bf2H9e6L40W3b/SjG6ZNIYhmsRcWclme9Rt4bndDsqS38uYIfNHxncLE1R10wvJ+MxoCrT1oZyIEJp8clP1sb/RmQqIMUO42xhZl9Ja3GPZeh+edmz1HUelZKifZp/zEql13vQIewEUkCNbhVPL57iqNu1TJj/vzRpp8xouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629229; c=relaxed/simple;
	bh=+RYxUj8bTj/s50p9+dXL0YHBcBExCT3Dtr6FisKWmvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YS0IU+BOguE/5rjlv/yt9/OhK/Hkfu5ruC0LFxz8A2l9WSaKqbesEmSE/DTqMltkrtaASdNvCnM2SVK2nv0Zk5fmOWlxYoyq1KUnspidt2LOZFT2HHc/Wuqs/vB8DP5QPj1hS5co+4eWVlLN7ktGi3zrMOecKsb6DahffK1M2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arrDUJcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arrDUJcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2D81F000E9;
	Thu, 13 Aug 2026 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629227;
	bh=+RYxUj8bTj/s50p9+dXL0YHBcBExCT3Dtr6FisKWmvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arrDUJcZc+a7Kid8nkPPTVF4cRS4Fp4Co1PfHS8xPyfqEgMBqdJj5WddJrSOyRvYq
	 jJlyt9ePSfMEwn5+knAFvFzFEug5TK9MFHLh/Uc2LZ+0bGPstp1GZJ0/SBugL8BOSM
	 greAD3aYKmscGJkpW70PER4b5Mf0wnG/PBwHQfUUaEqibfnb71JiCMymkhpgXR9Zbl
	 I6YQ+GvTa9eGtaIEpHMMzzhXKOoEsktXcxA/QjAJoesIvock2ytUKdIjCdWfILCN1X
	 ARJF/3zDGntPIPIlSbP6F8PlkmW/kDKTEJtATjK78o3EKIfvo+VrsUXm2an6UJcAF1
	 qNjbLL1IpXvHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] perf tools top: Add --weight option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813132907.50738-2-ak@linux.intel.com>
References: <20260813132907.50738-1-ak@linux.intel.com>
 <20260813132907.50738-2-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:53:47 +0000
Message-Id: <20260813135347.8E2D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a -W/--weight option to perf top to collect weights too. Useful with
> follow on patches.
>=20
> Assisted-by: omp:GPT-5.6-Luna
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813132907.5073=
8-1-ak@linux.intel.com?part=3D2

