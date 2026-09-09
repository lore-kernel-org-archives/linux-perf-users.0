Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A40489FA2
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991715; cv=none; b=FKEbg3NpI1oHlr3ubf8dMDVdXN0+R03qjyjUA1pQCTDv1dLigmKvzL7CTbY2CSbFNTnPMLPWWcraBlYRmNrwNRs0fx6KLLVFAZmFT+ytRwoxwTqH9gh1QzGqrzXJF1X+zuZAEi9eJel1hizQEgmQarYNUW2+AFheQ+UaoYFnLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991715; c=relaxed/simple;
	bh=bxND/jb/cD3S5uO3YgJZYL83Vd0cHAFBqgWuDfpHGOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n+Zi+4YLgn6NFmElfFzYeWGSbV86E0b61bhVDfJok28p+l/rxHL9ERI6xF5OHrpamp+yJLchZiASf6bmCYlRTKQB0aY16WUJDAVTCuS/xtPJi2O6faOmvbvTrudaCAED8Dz3yVT2mAWlVsQsRFIFQJ2Z5HR+s6b/eagzjNQx88Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLRddw8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLRddw8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC57E1F000FF;
	Wed,  9 Sep 2026 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788991713;
	bh=bxND/jb/cD3S5uO3YgJZYL83Vd0cHAFBqgWuDfpHGOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLRddw8HQ7Uz7YcRFz5DDBDPG2d9zfexhUBVr6k2uBRd15QhQd5CEraolhgd8+Z84
	 gc1jyaI5zkB0Btv38A/V06aC0Lrat7zpf48ONZqpcZmm3EgoVplIfqo59K9NU8NUPL
	 gtzohFm5zjNweuw8CQppsRm5/hKJrsmy5CzJPWGnnulFY5N6T7t796WkPfErfsUgdI
	 SuF8UrIfhdSUevNHOE3IyQWLxwCSrcVggaBCVq9oFpAhC+vUIQH4eRmMkzhcQGQm7Z
	 FvUuYNQ/W0EVgw/7NqPdLVgNdeZxn5nGdp2XfhDjLDYUGZjLTfmk0AGlORNAGf+Ey3
	 Kls8CcOXwgb9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf jevents: Add mesh bandwidth saturation for CWF,
 EMR, GRR, SNR, SPR, SRF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909220445.2117921-1-irogers@google.com>
References: <20260909220445.2117921-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 22:08:33 +0000
Message-Id: <20260909220833.AC57E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend the mesh bandwidth saturation's list of events to include
> events from clearwaterforest, emeraldrapids, grandridge,
> graniterapids, sapphirerapids and sierraforest. This makes the
> lpm_mem_sat metric available for those CPU models.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909220445.2117=
921-1-irogers@google.com?part=3D1

