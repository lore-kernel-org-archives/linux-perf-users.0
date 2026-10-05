Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181C4BD7AE
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217182; cv=none; b=SdYVPAGKnrHWsfURFNe6a3HOz7kUanzLBbAqcokfmNFSWb9e7gZSZbmrsFV7wVGRrdKh2MU5D7woMNzg89O9QT2Kt2wjUe0OdsBAoIIHPtszCI0p4Z1iL1xdtMsoW2BQKzaRCGA/zfD8kQcwCM2LM/TUmWXD8RFbQM159VMBVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217182; c=relaxed/simple;
	bh=oW/iJog9xMKNWY2X+fD5LkuzbOmfkhU42WGI1JO3CFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=izwho/72pnxvex86llPEE8r2dNVh/bdKX7FQCZqSH3VBOMmG6yvC7tT7MtCTSI+rRBfG3q98EhRkBaCfEVo3mRAXTXjfLt4X+E34l38LP/8fBt819YGL18ZlSSr8TfcBiJWCwUBPHlZLaom41xOvdFtCEfjVHuZp6dKg9+KYEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPxhPIx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPxhPIx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8124F1F0089A;
	Mon,  5 Oct 2026 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217180;
	bh=oW/iJog9xMKNWY2X+fD5LkuzbOmfkhU42WGI1JO3CFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IPxhPIx3Z9UGiZkNzVbrFN0BlAHp82uVyLNeaVImFimAPMv/AyVDjA4L07wKsMgkX
	 tkNeWCgRLSfpK/3XD7kF6E5wm5BiSnkriYvrX91yM2HXHz31F1HGjYnLSyFZxJXDx4
	 pNCBkLHks70D9y7Bb0T+XuVsU60NjwQWJcPnV11anvzp9Qkl7+49VjW4Xo9cuEeAST
	 WrcjSWV0OkiGhydCyUWKWvyhbxkVSGD91EQ3KjAjDF90H7uAYQ9jVYeASS31/34i95
	 FcmDUEapy/RQiQxfQYOkPMuYbSAMpPnfhL5CFK1PxSnW+ZHTgEv+UhdeFClV5we5JJ
	 NxQcdMvPUw9Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events riscv: Add PMU events JSON file for
 T-Head C908
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justus Bergermann" <mail@justus-bergermann.de>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-c908-pmu-events-v1-1-cfab33201c59@justus-bergermann.de>
References: <20261005-c908-pmu-events-v1-1-cfab33201c59@justus-bergermann.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 16:19:40 +0000
Message-Id: <20261005161940.8124F1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The XuanTie C908 cannot use the existing thead/c900-legacy event file:
> The c900-legacy mapfile entry is 0x5b7-0x0-0x0, which works because the
> c906 and c910 leave marchid and mimpid unimplemented, so both read
> as zero. The C908 implements them: a Kendryte K230 with the c908 reports
> mvendorid 0x5b7, marchid 0x8000000009140d00 and mimpid 0x50000. No entry
> matches, so perf currently resolves no vendor event names at all on this
> core.
>=20
> Add a thead/c908 directory describing the 165 raw events defined in
> Table 14.6 of the XuanTie C908 user manual, codes 0x01 to 0xb4, and a
> mapfile entry for the core.
>=20
> Signed-off-by: Justus Bergermann <mail@justus-bergermann.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-c908-pmu-e=
vents-v1-1-cfab33201c59@justus-bergermann.de?part=3D1

