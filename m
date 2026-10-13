Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348F501F2F
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898731; cv=none; b=DICtSCrCNlox9tbNFhc86pXzcadOEwzFt7IBk5oSmTbqlV8iKBb3aO1Tw1fa+LcaCbrxgrhM6QsDyvU23OnoHsuMwKCyIlBCn2VwYeup4yP7dlUlnG5231j5xEe4JqLaZ8YncCJeu7N1PO67rMVvL0bn1UzSoNrDjaQb5wyVCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898731; c=relaxed/simple;
	bh=4Y5GYOCiKkX4J5iCw3CxGDBtB7BITDFbh1AgTFwCF0k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V4Kd+Xad3myaSay0P+I58IvI9WsAcw0mWLoyPv8rqMu/mTCY/xm9OhURoxwCffYZJUj1sdHfY8+0Bp0zG0Jc8kS3UDDk8MNPIdcOoEe3Yb8cKqMZHrLQzCtp4L6/lgnkBLg91WdUrcJ1ujUZSQ5ConsFKF4wfRGEOBiNKqSQz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk81kJUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk81kJUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2CB1F000FF;
	Tue, 13 Oct 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898729;
	bh=D5paWtLERyVm/KTNzxqt4YSbmp8bb8GJ6RtHC3CJScM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wk81kJUUZolC86XZPdp7FRyz25NjjAfAH7DxKHXCBUeCNJAPI5ptRKGS5Nlbex8OH
	 F2SXlRIEdpLwCX3sunJ7CGQ8Q2qFTpka3VDGBJLmaDuYyew3R0tA99PCCq6rJZsdtB
	 A/hC5R+G44jsLHBCaW9bQ/FUIduuZAssBIB84Lrd6ru+Pny5XfeVwpvli7bLGNz0ix
	 GQYd3GRPbhT6cPtQp6MlmzFIMeMMZDiWmuPI+JorfmVDYzqQUmPHK/09Wjng6H+HyS
	 1RVFO2F7HtPiQ2QJvZLSHYqbkqui2HBQrnc/Tp4nLtszPwFVAtfJkLXu0FEQE1IXFE
	 h1bGUTI+LFF2w==
Message-ID: <sashiko-outbox-169834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/15] perf annotate-arm64: Enable instruction
 tracking support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4980703a94ddadb06b3df925aacd2efc7d7c3308.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <4980703a94ddadb06b3df925aacd2efc7d7c3308.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:38:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Enable basic instruction tracking for arm64 by implementing three
> essential functions in the find_data_type_block() call path:
>=20
>   find_data_type_block
>     -> arch_supports_insn_tracking  (1)
>     -> find_data_type_insn
>          -> init_type_state         (2)
>          -> update_var_state
>          -> update_insn_state       (3)
>=20
> Changes:
>=20
> * arch_supports_insn_tracking(): add arm64 to the list of supported
>   architectures, allowing find_data_type_block() to proceed with data
>   type analysis.
> [ ... ]
> inference during instruction tracking.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D2

