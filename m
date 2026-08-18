Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0013AB260
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069108; cv=none; b=mBBAS3xQvcqqCVOUrVqsQxVDSyYjq8dRFJss8Mhcy3OORxEewIwRIOVP9yqX2Ylf9LxbeE5LAlnThNO3GuoC8vl5eZyLp/vsTcKPQzxbXQemMF6PyvGORPQVvfGqoMNtQRd4k0aKNCbzJXmCZTTlUqSusoW5oAzQYeji1alKu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069108; c=relaxed/simple;
	bh=XAJkQm8Il3iLZCaQ2mWL71iYLopOBg4U/SIKjnNqSA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vpdl9v9MeRDRSrwozATUnzbU4V0NyyXuQdz8PPGWtmygp9oR8DZakFtlG+N8WOv97nKHgJ8CTZ3REYxdt8eFeG6xartsGJ2lLqUiGboCxQN73dqN3ALAo3cPaF9lRKwo01IiZpwubISm0sStRmcLf146d2RIZ1FFlt6XJKfwtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCpzC6sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCpzC6sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DE41F000E9;
	Tue, 18 Aug 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069107;
	bh=XAJkQm8Il3iLZCaQ2mWL71iYLopOBg4U/SIKjnNqSA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCpzC6salawlxATbt4kDlqrTg88BC+2AvMB6W8myMx+ltU+0QMBFKYcSi2TF43rWK
	 n+rRj5HsLkwKmDh+x8ohF/d5NU5LPJFHauLtVedZQEFXagOxfVRWPSeUOuAQt94WTS
	 zgDMAmA1xfKERg7LW5hG5m+FjKjQ8WSW1/tVLGb7kUMp0cjrOLsq0LBCyZBW2tvMJA
	 J0VaecWoTraLTrFjQNRCQuIvIOKCTszQ+yyOPXjKlMVachQ+BN8S+PJNO1TV+UdQ2S
	 97WTLA0EuTn07czkIaz1DOLggDJZ/Pn+fq8gisUEcC6E82maJKna+NFBvH6+7Kfazt
	 h7V8M7VY3tmYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] perf config: Fix annotate.hide_src_code
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kohei Enju" <kohei@enjuk.jp>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818144149.101248-2-kohei@enjuk.jp>
References: <20260818144149.101248-1-kohei@enjuk.jp>
 <20260818144149.101248-2-kohei@enjuk.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:05:06 +0000
Message-Id: <20260818160507.04DE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> annotate.hide_src_code defaults to true since commit e201757f7a0a ("perf
> annotate: Fix source code annotate with objdump"), but the perf config
> documentation still describes the default as false in a few places.
>=20
> Update the documented default and the example.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818144149.1012=
48-1-kohei@enjuk.jp?part=3D1

