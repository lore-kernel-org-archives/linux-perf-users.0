Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC73939C1
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179480; cv=none; b=bWEXuRdzV8p6xLUgrlNaWH2Etnbpkpv4cNkzGizn2lFyWXJc0XQgFFXi0ActhqK7eYvO4RDf1FhBRYWrhK0RGQr1oSG8Kc8qIldpMKEGsFGofaes3xe9Zx4L8VOeTx6lwlWQwfVCAGX0Qn7ZZoeRs5B7tJTGC8JpQCz/v26iNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179480; c=relaxed/simple;
	bh=0U19KuWR4lSZUip8RTTJyoVEMd2GmJFNhMkCOXHbxww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RNquw1fYA5DBuvSMZLnzrfYBOigptjkvOtz5LD4yRpgVE4tvBMhNlof0eUJEyuNf9DXggSYXB93uIDHOLlEw0TZFucUwcePvsQMmmWYcqFsbz4Erilj88SbPwgBQn15xwGyHz8ruE7RWnBIQm19YmknktrkslUJKcKVRN2sEF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6pSfOus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6pSfOus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A413B1F000FF;
	Wed, 23 Sep 2026 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179478;
	bh=0BPlAPgu6ibwGNI98k/M1eA2A9pjZYfvKvtLOpy44r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6pSfOusLG+hTQZgju2wvkDTgfOYVzb9ExXf7fpUHLFaYV52aSu+weN0w87ZJ+Y9Y
	 4fz/VDtsqupNEzS57/c5oHuKTJmAKvZo5BDSQ97NNmPMbY7QdgueJ58HDKx5yRRHCN
	 4MWNyTrUvHf3Vz8ydC3ZEGOm17P9u+4uIkaapDzn3HGGRgF0lb85C9nvnZizvCu3Wl
	 aLUADi8SqCVZKBk+zxzCj/sNKA1QvV7zmVIhr2QYSSj0YnFwLOfwprd8u8tDGHerN8
	 v+SUv4SRPMPcE3ggZAYdwL5r3DMMTdox/LhiWzFBJ4TEF4kjha6xfnbxh92ELQXrN0
	 3emX5/H7ALALw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-5-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:04:38 +0000
Message-Id: <20260923160438.A413B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D4

