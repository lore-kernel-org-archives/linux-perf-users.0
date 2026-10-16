Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BA37E5D8
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172824; cv=none; b=J/FJnfQEOuIGnKd1VRfBva5Sa36anCdLwTHQuY124OslWPp11NYpdbC6oM1L3R4Y6nmZjp/keiRfwezbe3J3lwebYq8GH/3i15MqqDKuxy3ktLsOfp1RLGswj5Oh5r87lsvIcEtF7/WZGGzlkaoOMt5No6NmQIjmhndypIrt1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172824; c=relaxed/simple;
	bh=lomhPB2YvR1wI3OtgajkNGijvSTKciM5PyurvGfUEJ4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=npmMlYkviPHMA2yQhPdOCtFKNsGjGlxGW7OTgb6YdpEXkAzse/bPvjK203yRob1849Im4HNTipwxGIBE/a3DRZ/dHlKB6rd144JjUD+l/yRsgl0GzwYPUAAJILmZrfv6WFzCTOttjrLpHthvMfVap09GA8YX+nkU7cMzeriWgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loYJ58gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loYJ58gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445031F000C4;
	Fri, 16 Oct 2026 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172823;
	bh=lomhPB2YvR1wI3OtgajkNGijvSTKciM5PyurvGfUEJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loYJ58gMnyJtVppaM0OvTbj7srbgGaoym9rDiocEGSPW4HRz37GR19+j3BHZC35ep
	 xeooM7yiD7VCUs+Go83zNuuYsnOp2BU79wyNK7mWNi6YMZojeihEiamAoazQ0mGNVn
	 O8E7hiKksBW+EB1XPgh8qblof2N/4GD7oBYZMU+JjwjAMsk61CHdqDtQ2BKRpOBdZc
	 SUKpfGovHAE55WmgBtpPqc+Br1x1Mqs9Wjxk1pJcLemVkdbOdEthS+XYbCCfGQSGV9
	 RfJODMqQD06hYX8CHN1qf1u6zukrnfq2gzrvJsBTcEUZT6tDhMnpw7TglFKeFMELeR
	 yTTXg9Q6RvgPA==
Message-ID: <sashiko-outbox-174746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/17] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-16-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D15

