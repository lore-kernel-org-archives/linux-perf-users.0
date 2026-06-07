Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6ACA6F;
	Sun,  7 Jun 2026 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837065; cv=none; b=jUeSAGpE4Xg193Vhr+y7+j/XYi1tOrJnjoQLaSzjVDn4DX1ul1Pfta05cox71nUgsFRMX7HfvWr7tx4sB7RSXyZvugqHIo1STJKG4o9L6Tk6HNh6y/e8RbcBId/5NK4vZ5Pwv57cy0nnbFo0X9Qa93lDg3AA1qeysJ5moRdQDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837065; c=relaxed/simple;
	bh=UEslFreGYuprYNJFZfXeX5XScu9uWRsWTBdUl9mXiT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQtM47T0H7A4VGBz0BcERGDtjGzvK41qM/+7G0HUTz4nVcSxn2erExAOwfOoUfR3gTWFVR1KYvmjD3t8LMnxgWwNMTH/74p2bKKiUlH49FIo3kGIcNsvGjsRwDkuv+9PjbOeMtMCQZ5r9Pm2yA2WCIJo+ALbkHy9THdxPB8DM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E81UaIgg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E81UaIgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307351F00893;
	Sun,  7 Jun 2026 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780837064;
	bh=UEslFreGYuprYNJFZfXeX5XScu9uWRsWTBdUl9mXiT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E81UaIggJYdMLzzfYOwtytcl0XzPLVhvho1QI0tTVECRVCG/x2yoEO0lu7OfOb+9w
	 itWVaOrOpUwz2beeDnD00F+J3xpOwsgzjGIdSf5mwCilRoIiL9Ob39n5Rsk48l5G86
	 sF+GCv8r+YImk0t5nUiFO4d9aDHIIXYM6cmiRbpOfGcZ5EEI88ByL6bWaqUPyVDP9k
	 BZhA7R5EJXZ8agoXhQQRSheh6nRrd+HK1o7PB3A1F2PjmXvwjKwg8hNJH8lQaTydN7
	 iDMnk721Ka4qittJgxzs8AXFCaE93F3YUmftretrmE+r7QWx1Mu804bP6u+oIx6AUA
	 nDwb5FHB0EzAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: perf: marvell: Extend CN10K TAD PMU
 binding for CN20K
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: conor+dt@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260607125101.17778-4-gakula@marvell.com>
References: <20260607125101.17778-4-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 12:57:43 +0000
Message-Id: <20260607125744.307351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to add a CN20K example node, but the p=
atch does not include it.
--

commit d21c87a34e4ef8a32cf63c6310a789363873d765
Author: Geetha sowjanya <gakula@marvell.com>

dt-bindings: perf: marvell: Extend CN10K TAD PMU binding for CN20K

This commit extends the Marvell CN10K TAD PMU device tree binding to support
the CN20K SoC. It updates the title, description, maintainers, and compatib=
le
strings.

> dt-bindings: perf: marvell: Extend CN10K TAD PMU binding for CN20K
>=20
> Allow marvell,cn20k-tad-pmu alongside marvell,cn10k-tad-pmu, document
> CN20K in the title and description, add a maintainer, and include a
> CN20K example node with the same required properties as CN10K.

[Severity: Medium]
The commit message mentions including a CN20K example node, but the patch
does not contain any changes to the examples section in the YAML schema.
Was the CN20K example node accidentally omitted from the patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607125101.1777=
8-1-gakula@marvell.com?part=3D3
