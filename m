Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEE37BE81
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475570; cv=none; b=mfn7RS2i06EvjmZ+Tn8NQ8QJ8p7LTndwkRtVXSDloP+uti+ZSaZXxZwHis3+kB4qHxa9YXGdGR2dJH9f3NFc+GGkMX9JKKprlahHAd2WHZYgEDMzPv934vqzvEbvlyXgj6M93XVJO9Ccb6AfAr/lsYNJoNOjEpzEsddK4zxMlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475570; c=relaxed/simple;
	bh=WRtzLNPj33ARhUhB1tzzQZDO0D6fD3wATAmUBcDpo+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PYZWUdRV6yVEDwz+NNPttEfn/DxAETbqqdGUHwwQNiRlRHhh7b+HzO981Br6G0d00oR95k1ISqr8hrmS4xmI1SmU2cfrS2VJa0rTV9p+NbMkaKnqRDNDD9s4q5hw8Ai4/C5ETIXQpfguKAYKyZbg4o7MAKgxXbDyX5dHwc1Dm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ6Xfez2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ6Xfez2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB4C1F000FF;
	Tue, 15 Sep 2026 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789475568;
	bh=WRtzLNPj33ARhUhB1tzzQZDO0D6fD3wATAmUBcDpo+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJ6Xfez2eUeBDHZYG35xsFnSuHVSu4pqTwAli4vLCGA8n3QvxOlkrMBihcZt6q2uS
	 Fc8hXpYzbGvCIRc92Oz4AQeSkDu+4uHcTGcPcrhyY1rx0OlICV+cufCFZSyoyhmOuf
	 3GYUcLIEWCvEJGLWdhjPQoAOtU83mW7LA9wAeye9QAc15ByfclXCbZwDv5VwBWnrQk
	 oABxbcSuNudwSK39G366EBFikNvjpD4mpcb12jXU3yiPi+S6CwTA5AJqohL4xBKknM
	 OtBzwdY+Rq77xQa/lqthZf8mzQny9cZLgY8pmELXNFEpUKfg/LXimV/guWSLjtkn6s
	 dBgokn0psiIAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/arm-cmn: Fix multi-filter encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
References: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:32:48 +0000
Message-Id: <20260915123248.9EB4C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The current special-case for EVICT_STATE_SEL filtering effectively
> assigns the "filter" and "filter2" controls in the opposite order from
> how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
> and pmu_evict_state_sel". On reflection, not only does this seem
> unnecessarily non-obvious to users, but it's also likely to be a problem
> for scaling to a full multi-filter abstraction in future. There is a
> logical order to filters based on their bitfield positions in the
> pmu_event_sel register, which the TRM descriptions allude to, and the
> cmn_filter_select enum already (almost) follows, so let's fix the UABI
> to follow suit while it's still unreleased.
>=20
> Fixes: 09178f536bb9 ("perf/arm-cmn: Plumb in new filter types")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ec590cd4cc61b54d6ad=
3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com?part=3D1

