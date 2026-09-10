Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866734718CC
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076481; cv=none; b=SzUVNHn5Hexi4PNo9ph1Lm1kRCPeGmjiTTxCXqYuYlHBhggWniuTi3jPeuJtLeWE6WtYo9tF1GApFCNGWG8OhUMxOTokqPEuah5mmIS2amXoqkARLkVOLw0MpM7WA4NuUdYU3rqkzxs16XKQW5gMFRbgElEzs4R8TnnuSfdlbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076481; c=relaxed/simple;
	bh=FyOlAopWDBBdQaJyhwZ+Ld50PRPWlP3H0w13kx6Z1Hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qulrtn+rhLU2PE61Vgm15oxp6cSp8nQ86Lu35b39f9vyO2a0WP2QcLa1sToHUpIU+ELrTVwr48xehq0sjivrOZYTbDI/kMT9dPrFuIaZtKaxIE9cU0PYPcJmeF7OfmMV0M9WbMAoFBO50INVpvCf7aWrF03vAvny5LiTzKtguf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdP9pSsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdP9pSsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138981F000FF;
	Thu, 10 Sep 2026 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789076480;
	bh=topxDS41CLZCWvBCHvRMT/LbcEyrATde1zzniGoAyE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdP9pSsdTWyU35dcYe81Y9U2i7q1XuVryIaTYOS3gndXOF01sjMYb9LZdf/MdBgVX
	 R1b/XerFMHmE5wWer3cUCYJMwipkTTUqsgkgrJS66/yewuwtMg3rOF7DtQ5cg+YSKW
	 zTrIsV+wcc31EnjJ89qdDg6i5ZVhlC3Y/n5sIitIit9DlLvNe6VHYDRKGeVry36Afq
	 ejmRdU6lu3It4YxJwEEaBggOP4kFpAEaXXvSAUBAsglXHkFcn86J5uKUlBTwNZH9FY
	 MtlFWFh7J4H7w7iunAzxfC0u5Hsi/zIOJyaWijLBZRTeWYe+ImNz09VhoZqJ+1O6jz
	 FnfmYqsxBIttg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] tools build: Fix timerfd feature detection with
 clang
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910213907.3206529-1-irogers@google.com>
References: <20260910213907.3206529-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:41:19 +0000
Message-Id: <20260910214120.138981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clang's uninitialized-const-pointer warning causes a feature test to
> fail when building perf with clang. This disables support for 'perf
> kvm stat live'. Add default initialization to new_value as a
> workaround.
>=20
>   test-timerfd.c:15:30: error: variable 'new_value' is uninitialized when=
 passed
> 			       as a const pointer argument here
> 			       [-Werror,-Wuninitialized-const-pointer]
>      15 |         if (timerfd_settime(fd, 0, &new_value, NULL) !=3D 0)
>         |                                     ^~~~~~~~~
>   1 error generated.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910213907.3206=
529-1-irogers@google.com?part=3D1

