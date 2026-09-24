Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64A4AAC5F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269869; cv=none; b=BKkDcI49wuXGW0pZCTr2uSwlckox2BLL+ckmUvRRS204GmQvgVn79mbolBkYY/HOLGtH72krhheArZ+FZkfbXJO8y92EomauWBuRss5TVw9XDVBpy2Mzmm2LX/i6hI5rA3R3AoTfhdQoaCvc5y+A76V8Xfr+zsFbAjk8zAlylZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269869; c=relaxed/simple;
	bh=BcH/HSbgqxsyqsOgwR+7pK7a/WQ3P959/SF2ff+QeW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVGPUVHldfwo1kkonw0+sga0IxbXORjNXUKGWAW+m4x5+EmTYu5rN2A9BvxunDoPMfauT7YQ7i/Ke6h1ZPt1Wpzmm7PgN8bpfUR5E1IOEHYAlXINHf8AQA5ONA/OavW7LohMOlpsvRdLH2rSXWGeoKbcdNseBTsMlAcZKGwTqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7l74Cub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7l74Cub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34641F00893;
	Thu, 24 Sep 2026 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269868;
	bh=42MHndvBUiIRnAt8KSjR+M/0ZIH/458jysre6kfWArA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7l74CubMeXN8GqsWk/vpmUK/YprF/xJm1AhqRWXEVxDxAmrfFYhl6npOpaBtRasz
	 mZ8N2u7ze0rCky5N3shCWfRjVNvdUBPGusHYI45BnER/dgMn7KbWrj25oyKPQMUs0K
	 lyN9mddD25lOq2G9RDBIKin2IGyJU/mLW8CxyMfbnAIeKYFpLMVq7UhQ4kXJjL333k
	 epDseG1mktdaofLkNDV4rCl+1NWMRN3B60mmbwOXsNN6Qsp0UtNmVUuUHzeMs7FQRP
	 PBqR8FDEuwn/Oy5HZeY7umbbk21LvzxXq2Z+Va+DPxrhl8GR5tl1qNA7efOLbfY1ks
	 zBizft7ox3o1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/26] perf vendor events intel: Update skylake
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-21-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:07 +0000
Message-Id: <20260924171107.D34641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D20

