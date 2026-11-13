Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602118;
	b=txMWLqySrQExnN0U4lncDY2HFTD2WVN6533ElqIzMQPQ7DmQdNrg3bZVhpngIAjW8Hwz
	 ICAtJE30YihoTsOQbbxMQ2YiWnrI25Hg1i+U/5tSs2+2spuvwPkrJJOZq6kO+qxDY22IT
	 VrbJUg+e8KO9nbB/eDi+o5y9lIvi+iO50pOrPxomf5YJRBEuU7ThclBHTDtfYZUGDnMcV
	 TJ2ohaR8VvrpCvWc+npa2dplsLrJ/y8Lkm92LPepeyolfJqj/PixFZKZvYzFjI1t1NTdq
	 bPQaD9IuIpyZZgbLQ9hRV1onFVrWmUD9CEME0PmWpkPiPSI5z/7yvhnXf/C27eU1DvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lLTJhulpmwH/HMRP7n1+YgX1VzZ+rZDXHiKuH+sJi5Q=;
	b=XHVnkERvihkNDOnzzGrTAYagsWU+Q/GfZEkAdnZsuSwpjW4zM9wFL7x2EwGRRvsF+oqr
	 if8cqc48KFczzyeL3ppvLbh5aldCiFKfFi63wrnfUYFonXbYE/B8Y/eyA2hRribOdIoJl
	 O5bcLDXTGV52Xp3BR3fgVr043szdMyoLqiP0YJdc7eLszvKEA2WQJQDPUUwmMdErUCHfN
	 q1SgxF+kfk4mHxnGWZMCl2ODupExwgU0YbNyuUacg9FgpMZysKvz5niht9VEfSigsrV/e
	 LZiV3AxIPgK8ADWYS0Vt0RG2T9Wex/5C4X1lgW4M1pEaoUGfYpikTVIHZSfzoNMHyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4KL4yr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F33606A89E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK4KL4yr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F31F000CA;
	Fri, 13 Nov 2026 20:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602118;
	bh=lLTJhulpmwH/HMRP7n1+YgX1VzZ+rZDXHiKuH+sJi5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oK4KL4yrHLXUJGgIzY+RCarEscPt03QKUIVglPxhzxgvDNJg/22aEOP4ofuVpGbiL
	 cjqnF4+DkTBXrN2OU0UsitdOmokDQFTKCBD0keiVYOJvAoFdXd6+1ijNbIwNjayxK2
	 L4/GGfVNE16cfLafVi8xuKL2XDYfi3dLijQz9TCQnLhZiL7LJImkE8pSTal234pt7m
	 qK0DTZkikoyCjuOoOumCGGO6ErEz85O7Z7LMdkTQGAZsEV5aFNfcERm/shJ2INXonI
	 5g90djGLD6P/BjdMiXLBJDED6yx8u3RgC2Zpf3hgR0l1uPI7XUnIhIhRvXg0IEsaQ0
	 Z9YMjvgTVvlzw==
Message-ID: <sashiko-outbox-213652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-10-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:35:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The record this check uses writes aux samples, and with the single data
> page the other tests ask for they are lost:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> so no branches are decoded and the check fails with "Failed with virtual
> lbr".  Record with 4 data pages and 128 auxtrace pages: the same trace
> decodes 64 branches and still fits the mlock budget.
>=20
> Require the python perf module to provide session, not just to be
> importable: a perf whose python bindings are not found can pick up an
> unrelated module and fail with
>=20
>   Error processing events: module 'perf' has no attribute 'session'
>=20
> instead of skipping the subtest.
>=20
> Detected building perf on fedora:44 on the runner with Intel PT hardware,
> where the subtest failed with "Failed with virtual lbr" in the container,
> and with the python error when run as root on the same machine.
>=20
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D9

