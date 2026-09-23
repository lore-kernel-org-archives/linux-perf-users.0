Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A1257459
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183835; cv=none; b=IS2Lysc05OflcW86hkK6KrCQgvho+4GLzA9Sv+tfBKdvPPjDNjPikYVIWJc8zQG3Am2+fixT+1zdECiLyfSUuiQCHEd+DrCA0oq/9XXXRQaD282D1dYY8FnlAxKLF5+xlCl04q3I0wKBGYsGOQhZJgqA8b1l1mBmHVQOSV9JJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183835; c=relaxed/simple;
	bh=H7Kv5z/AakRHE4zQF2rX9PvE3I5i1r/R57oNZHddIOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PN6NZJa2bt9m5smNgoZ06I/cS/9eZZiSPhHd4wQCfbvZ/IS9yNzUrJ9M1LrpbOZ9xy9h76RtaTJOVjoMbn/F1ADtLIct6x2FkTV2/lCAbaCS3Hs597tSNhLbTtKPGgizeOjdkKq3ayYo+yj0aIeJroulGGGSxFm40ImUm+Dzg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbFvXkPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbFvXkPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087581F000FF;
	Wed, 23 Sep 2026 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790183834;
	bh=+pEpvmDnsjiKiT6LUxIVWladi9gIzbeU6UMnR32Tbos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbFvXkPodp6s0RkQk0PDbM3K5zUrffdymwf2G7pJgi9/hZihfXaJzuKQD+d2FYHrX
	 ZcVsQMJ739eGfLvp9MOua72EMsWDlEJVEDKVwqxpD7M4/OOgPoRqPHPXob8mJF8KkW
	 PhmLZOSKf0fbd+vuEww7WGj3F8Ck23NUuccic4ujgV5/U6ofT8Yj8UwGHoZQ8zRnYF
	 gs/HpLplAhhtVZlC2om4fRJWsbjE6WC3GAJkkvktKHQzcJW8XRvoj5KlXkxyEMrMSl
	 SMLAnBpMpZPh+XRe1JlcCur7d0UF1Cp/0e12Jyoi4Q6EO3SxXNP5DeTiJUJ3tligQR
	 WuQJPCJb+CiYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923170903.48388-5-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
 <20260923170903.48388-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:17:13 +0000
Message-Id: <20260923171714.087581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>=20
> An example of the new perf c2c output including the memory region
> field is shown below:
>=20
> # Index             Address  Region  Node  PA cnt     Hitm    Total  LclH=
itm  RmtHitm  records    Loads
> # .....  ..................  ......  ....  ......  .......  .......  ....=
...  .......  .......  .......
> #
>       0  0xffffffff84eb0040     N/A     0    1205   23.25%      544      =
544        0     1677     1677
>       1  0xffffffff84f03a80     N/A     0       1   18.12%      424      =
424        0      585      585
> [...]
>      19  0xffffffff845bc840   Mem-0     0      13    0.30%        7      =
  7        0       31       31
>      20  0xff3bbba284520a00     N/A     0      10    0.26%        6      =
  6        0       11       11
>      21  0xff3bbbe0bc833500     N/A     0      24    0.26%        6      =
  6        0       30       30
>=20
> [1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux=
.intel.com/
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923170903.4838=
8-1-thomas.falcon@intel.com?part=3D4

