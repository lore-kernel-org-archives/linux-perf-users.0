Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266394EE875
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560037; cv=none; b=c/Oe/1mReGJeQDAKjDDHx41yDjH+uOxn23WoKoKrrWZrp2wpqSjUeU4Mu29KJps1hrdbcNG4xv/8U6TjqHcafCMTZvv3dHskvGhINOpD7xa1zw0DRK5ujVa4SjhIyMSG9J8Jhyv1ifTYhCajULzSljQzL6DNsLL2xHJrszioDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560037; c=relaxed/simple;
	bh=KL6fNaDfcgpDA9cynSalOba1YTlcjt+RVp+nH+VBrUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JDe6vUxyzk1Qp55pDjK2DP3YscFvvTbwaw4yzvy3y/86gNeTgaWfqS93+MF/YnOKyt84izrQ4brEqzCJI+PLEnwayiUDGgZuRys/USbNgTR6BcQhspyAq0nr0T5P+K+abMfWETpAM23Jnxw6VnE+Ai/jWvLyAGUIpgvXWdWj35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9rSr1wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9rSr1wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06381F000FF;
	Wed, 16 Sep 2026 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560031;
	bh=Dc5tOHQn/OQiNl9vbxnLWfzH47p3EEwd7AS4QFEdQzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9rSr1wYHCBYyu7P9dDMhmUlHzJ1xK4EMirP3Biek7RmZEopABYuiNAT+ArjEMT4f
	 PTjUqch7p8Ojua/GwPzq8WxeSJQgTdM1toZcWJYIcqts0HfL2wLh0lm+ql50y0mwe9
	 FcQy1UYrJImF3626u5XAuywvz52Sv+0U0q6MYa7liQwhh1k4yMC1RKOohOyRWt6RA2
	 2QrE71lGE+NjQXjfiPTGuUNe0LyqCFnJMeHQZpVUd/qreNNUsQ4MM7FAptqgR/kBR1
	 BmINbvEVDe02Qc1UBs7IADy3dROE5KavAl0WKQwEAlrIqxooQJFDipgu4UZSQ16HJ3
	 /WeRRCTrfEO3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916114740.48230-13-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:00:31 +0000
Message-Id: <20260916120031.A06381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used in per-thread mode
> when kernel samples are not allowed, are rejected by the kernel on
> hardware without the privilege filter, so a per-thread 'perf mem
> record' fails:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter that makes those
> events usable per-thread, exposed as the 'swfilt' format term
> (d29e744c71673a71 "perf/x86: Relax privilege filter restriction on AMD
> [ ... ]
> ("swfilt=3D1"), that the old 'ldlat=3D0' check would reject.
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916114740.4823=
0-1-acme@kernel.org?part=3D12

