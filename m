Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F830BF70
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970366; cv=none; b=Xl5v4XCQI0oYhQQP0aoPcAs43YvyZfVtDLhgzkRVJeYSy30RM2xzjKOvfDBFQqgX+ZdsEfKdhzAhYBGw4/lMk3ifJn0f/kyoh0vog/XnnSQ3nPhafiDFS/AV+Cn0lMEZm8LzzsUdh1mLypBEDsVN9F4jC1qe+ucqzk8bsYFsYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970366; c=relaxed/simple;
	bh=8zin1P8igtf0jMYp+qXr371EoatUyvZrKDqOIWhwbBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCgU45VabDx7HvS6/CizNJhBU881TybdSLgDrveKJ5ZuqfpRAvu33pO52jhclSjj833c+iAxpfv+moo9lhHZkcGGvz832455RqKAPAEi+SCY7kxr0TUzgaqV509GvNkWpKR6bbjGyT2GMdt8TCA3k/BA17o6RaXtEfSuXtZtONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkZO0jLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkZO0jLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685051F00A3A;
	Wed,  9 Sep 2026 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970364;
	bh=iAtyXUnMsnqDesN/pi+CJ4lKoPja4eb2oK61oCSVR1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkZO0jLSYMfxozbv0miwYwNJeaqd/XvzUOJHdKMVc5yinM8jWoywLdk+v4IxXU/SC
	 qy3EPkJ/CJya8hQyfbXuHxAIOQdFcEBF6hQF0SG8q1sSGUSU2cguWJBNfjG7qjNSRS
	 yTfByOxtumT+Sh4SNcP1w1mvvsuBO6Xq55llTr7Ar8hbCqNf6I8dn4o6rALfPqI8aR
	 hmCdjXRL+3h1EVuxdW1r00cRodHsvjaXxl7WEfb3R6GmrlP3iPqQGlgDs2Ij4H+qiZ
	 hBDHaADKL71iW7UclDSBu3HNPv9t/2u+XofZTFg/xBvgWcqlMM2FENDd2aJrLuVswn
	 EdHFqx0zFB3Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-7-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:12:44 +0000
Message-Id: <20260909161244.685051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>=20
> Example output of perf c2c report --stdio:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D6

