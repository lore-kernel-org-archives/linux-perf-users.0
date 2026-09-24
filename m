Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813B4BA1FD
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269885; cv=none; b=qRtMS6oDU3QYcj3UlfEI90tAPX8xSgCdqvEtl9QSnvE1h0AyxcKuh4cEUeYKifggIt8rLY1RF4p7ncj7ik5v214JtDq/P2AYweb2nkuW01B21z5MPbHzjI4/Xna77WlAAR+miEt309iMMD2v81Z8Lj+Zg4+ftLQCs7PLmgTGeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269885; c=relaxed/simple;
	bh=DJQNPWxeGzoHxWgicoLqEWyxv2NmEC8jledFzQSAWC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nih54jh1ujW4HP/dXY06w7Mcsl4zrnSF3rZmds06fAT7s7IFXmjaAcEbPX6snljB9206FOsXefrJI5ns1BuaM3Nq+NT5GcQbXuM6yN6Y7ClUy/a8NxQoYlALMuaN1l5tZ8aTWrBxn9u5xVgraOX5n42buOy4li+gHI0+4Jdcc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5lUHqtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5lUHqtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943471F00893;
	Thu, 24 Sep 2026 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269884;
	bh=DJQNPWxeGzoHxWgicoLqEWyxv2NmEC8jledFzQSAWC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5lUHqtxXZKzamfut/U9ufrgBmvlBL7HgPGu9STtm2gKED1sWiQNe5PEV4D8xdmaj
	 NpsmPcsPDaG7omHYDOzqKYkAAkXbaLRad81GC5ZA7qvLFmRo5INoIdTsD5+A2yRhkw
	 shiZIJePILWLmd6h7pgMeQ5gIoEZN2WcZK2uACyxCoSpncffsPU3KyyCDp2RL14hSC
	 cLHgclnyuulCxhkzS8e2HVx+ElMOAelwhGPGPAOg1+XZnpsVUzd7QG72vtGkMeP0OB
	 5l3sl9sgvVMB8SUFyBalaY9mU4ZI7ViTdnvx/g9yTL/Z2Ib3zehFBcq134XQB51N9l
	 lR4BM7vgh5IgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/26] perf vendor events intel: Fix clearwaterforest
 umask encoding.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-23-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:24 +0000
Message-Id: <20260924171124.943471F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix UMaskExt that was wrongly encoded when the UMask was 0.
>=20
> Fixes: 1a5c515eae7c ("perf vendor events intel: Update clearwaterforest e=
vents and metrics from 1.00 to 1.02")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D22

