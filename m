Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BC39D3D0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228441; cv=none; b=T2e5Yxg5ab5uD5F8tO3rjcrEywb9d3/BElEMuWQZcHHIlRFlhhxrqTZb17tfhuJaisR6ce9CSWT0+Ui7V+cK602+rjRBdhG/5SEijqNIb9M5nsPSpBVq0CrL9K76daIy2TOVPpZFvUzNgTWp9Tzfxr2M+HxeoBialxq+RTrgw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228441; c=relaxed/simple;
	bh=3KbJwqBAvs/jX72PG3RkTktXbuayyG9c4084TUim0ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ToU41kfjXdrQigJii5SeYXEMNC3nwTQrJ+VxTsBHSyvBcJI/5Xmd1yGjXNRu1p0kxPGIuhhs2ZWexv6p++UDO7dM2Ym7KQLKTB9AHi1Cc4V/6VeHEm2k1xsbnrmm3ZS6Kor3mQZr/EU1y8jfPB9PBss/xt0h0WCu5UlpDRvQ02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ0NTGi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ0NTGi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7F1F000FF;
	Thu, 24 Sep 2026 05:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228440;
	bh=B2rux+AAjHQio/K64U8Z5VyJpyvrOywUHxkO1wFr2S4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZ0NTGi6a7QCjAMySWNvqEK/x2FCVPalQknz4ey133qkyuyTejerdc0Vh5707Mov1
	 BKjhsAIagtnlQDMp4Vuv51N4nwl09mmVMsaDdbXJScpG4/1yVdkg2riUmAIztyAHvi
	 AupTkj8GTJkAZv7kMAA/klUI5MRkjkbTCwpbhheE9zVSn0gOzAdyZ6CsnH2o50Jsji
	 gXa25GqtU2F3EYjQzbe4J6pB6kt/TXHbc/isSysZ9ZOCRxie2lIpg3y3tB8t+88WlV
	 E3l4nr/yzhUIq2+5nLJUR8ODSSiJZ6k/ZZssXL734SBNROCkI8s6jdux1oaYq/XvFS
	 /6jk6LPPJep3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/21] perf vendor events intel: Update arrowlake
 events from 1.20 to 1.21
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-4-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:40:39 +0000
Message-Id: <20260924054040.12D7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/335239ef9a63a3a6e198233678f8987=
61cba38aa
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D3

