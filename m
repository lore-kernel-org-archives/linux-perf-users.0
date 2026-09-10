Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AA414437
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070063; cv=none; b=mb+Y57+gvLeGRFdeHGsgC408iOmvp5kloWXorWhW43EIVlLWpznJYEUs4ySBIugiUxxst3d/UyEacFc9ta+/j61VkxkkiZkLBIrXqZUYXkWgIdPiNbsN1RO1313vcQxV4gHnAviEiSn+yUI03QzXTmzCvTFGvyBwt60Pw9mzR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070063; c=relaxed/simple;
	bh=3hAaF4shPFtg5dTTev7Revl6teLlh5TpHE/hU7fmYpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TeNM19gv7ymoOUL+gcgPiol3msl17SQuPOe+OgQAaCYmbhPOKpqlV2j9ay5J4QlhfNe9tJ0pJp9emvxHqRtgqbLUKZm8mkNdMfzrwTTeA+qr3dML9oO+ijJc65TGqZrtXsoJd33hBaPS/E6qw5mNOYtI//JFwhVxESnMkmdDAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od30AzqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od30AzqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804851F000FF;
	Thu, 10 Sep 2026 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070061;
	bh=8qURISAuA0kwWAQC7akeb+llwpSM2WrWvyybh+rcjiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Od30AzqJCgpey+5wBVzqqvxKnm31r1jLa5sd55ZOlGVBoxtq60sl7eZaEVZfbICVZ
	 ErFS4WfxnKFV3UFTJhBOQ+1QjSO6uDnSJsIYHXtgTEpk5i5UcrmUKAlLn7DkEHLbmH
	 NefyomfzNLV6AU0WeaK/2bcj/4pVuRREgpcTOFTlm4JV6sewgCPtWZDRVu53iPmu0Z
	 RHFT6o2HxgxkIkiJvH+Ccvl1TGF99H0wql4hSt2Uj0VefwfooFaThy9kcp3g/Z5UBh
	 Ax7ZO3QgxpRbV9IS2KRvCCE95LM/C46eenQryYZF4/8AXcBKYXZfIRM/Ij7SfrMVU1
	 9830okDEaJsYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-5-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:54:21 +0000
Message-Id: <20260910195421.804851F000FF@smtp.kernel.org>
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
> Shared Data Cache Line Table     (181 entries, sorted on Total HITMs)
>        --------------- Cacheline --------------      Tot  ------- Load Hi=
tm -------    Total    Total    Total
> Index             Address  Region  Node  PA cnt     Hitm    Total  LclHit=
m  RmtHitm  records    Loads   Stores
>     0  0xffffffffa1658ec0     0x0     0    1302    4.13%      103      10=
3        0     1707     1707        0
> [ ... ]
> Assisted-by: GitHub-Copilot:claude-opus-4-8
> Codeveloped-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D4

