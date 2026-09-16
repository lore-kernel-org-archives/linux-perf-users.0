Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABB3BCD24
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522806; cv=none; b=SS5d+/1zjsxD8kKRYxFV3Td9k4Jtizlh8xySYahPhR09A6Vc5PP6ljDvBe+MnagGyAVNq6ACWZFhYNd0oG3zVQ/szZXzc+XyML2LAnIfZDe78wudJ5MOk3e/tBvep8ZAvOvsyQEqfaZUt/XQNhF7VE+MR/WWEeDSWacoV7gsDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522806; c=relaxed/simple;
	bh=EI/ZBbzPR0HPqmu8K+DtP/kFYJdzY0W5Kb9w+Of23iM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lpu0rWPFWAF/2BQvo/uSm9s6mIPZRtORTONZkJ3sSfjRi0mFnT+RogXMeTHngwgjvj2UBM0MDNwU4JtxIivHxAXZuvth47coLwKNk/Z2mozyKhmMfjWCiFbVWUSs69gmFc35WSjCAVxrcxz/tl3Xk0my2CQ5Iu1TXvSeRyDbd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emvhtgwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emvhtgwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465F51F000FF;
	Wed, 16 Sep 2026 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522794;
	bh=EI/ZBbzPR0HPqmu8K+DtP/kFYJdzY0W5Kb9w+Of23iM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EmvhtgwgQqG2zQ122fRwebCy2HzknB1tlCXPN95eBOAcNMRYgGUjVEM1UM7HBrc3h
	 mGY+mDxYr6oDaUQDZ+histqrT0jdcn5erqmJuSNtRrthkkemnEL0sCoh0jevdY8w33
	 SizyIpsxB7fg2wskHxkou4T3yA4NaMZeP/0+NYfUo2uZv41HTCUVTTnnKMtCIFUEO+
	 lHzFBoRkat14FXcDgQX6vbOuP43vwkZrYNfnqhqYZuj8NFpc4+s0TwLfxlwZv36mhH
	 ZIg4IK72Js/clfGrbwFoMEU8w55wr4Ui2E/iRer4ysqp5ne3xhAHJZ8uVDCfx/Ttst
	 aQ6Fa8typX8pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/26] perf annotate: Normalize arch__dwarf_regnum()
 error return values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <0c35645aec74e08df0c64470f40e45647451b876.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <0c35645aec74e08df0c64470f40e45647451b876.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:39:53 +0000
Message-Id: <20260916013954.465F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> arch__dwarf_regnum() returns inconsistent error values: early path
> returns -1 while the main lookup returns -ENOENT/-EINVAL from
> get_dwarf_regnum(). Callers only check for -1, so genuine failures
> can slip through.
>=20
> Normalize all failures to -1 to match the callers' expectation.
>=20
> Suggested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D5

