Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBB3C141A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603075; cv=none; b=A0tWoMaDmlkBMTFMXZ2BLwoC69ktrLcujFKRzwweuQBg84ecB2S6Z/47PcadXVsIu0aiQI2sVo16UOCrL3foziS2Sri2RrM9t9NVIWYn/K8IQ+Hyta+YKFWk9G1vCXJ7YYOH7uxXZM10WbfrQ7zEePNyCT6LNEZd34tkZl/cbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603075; c=relaxed/simple;
	bh=/q/rAAyc8tZc7qSmD4IxSbF/uS5LgbILArl9r7eDarA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z9LF1W/cWkoqCZRW8k57oLPF3RLP9PrgaAIh5Jje+JKhUN9KD6YJ6IcAxqG+lIjyEPs6gd/YuLm1ddFFs3MgJDgWfDfj8lr3Hqftb1zfAcbK3iafeAVCiXhzRnF8p3dUzM9Jjh3bE7Xyzfdi3flq1DQzVSSRKEZKMmwjO8zVL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knvR/3j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knvR/3j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948C51F000FF;
	Wed, 16 Sep 2026 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603074;
	bh=/q/rAAyc8tZc7qSmD4IxSbF/uS5LgbILArl9r7eDarA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knvR/3j7jiiiSov89scw4v+TFU5vOrMT2J9m/SnGXAzdrab5sxJLK4gXSG57saWmj
	 nzLnVNe7RFaZbmUMYsmP8De+s6FhEKT96srIGprIm3fPicebAPaUdw4EC2+wrfoPao
	 pYR2mMteCXM/c6KB2NIW0I56ARZLwxe3desc4IAeJ4AlggvKxhwDL4TX2qKj1YDmdp
	 6XsWFaRhHO3IJoTxVT7Ao1PpJ/PUAcHP+d43ezatSMOIoe3/CVlDhrezF0fwbVyM/H
	 5je4m75XQRICuGBYdy3WyIL+nUyDnb5+TDC20iJX1ErcwZMmB66Xde3Aw/uWRPjR+i
	 ZlBPWb4M2UNdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] perf test: Isolate test suite from user
 .perfconfig natively
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-10-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:57:54 +0000
Message-Id: <20260916235754.948C51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Running 'perf test' should not inherit the user's ~/.perfconfig
> environment as customizing core properties (like core.hybrid-merge)
> will trivially break stdout matching checks across the shell suite.
>=20
> Explicitly set PERF_CONFIG to /dev/null inside cmd_test to globally
> sandbox the environment for the entire test workflow. Test specific
> config, like annotate.objdump, is read before the sandboxing so that
> 'perf test' still honors it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D9

