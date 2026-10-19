Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82143D6CB4
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389677; cv=none; b=d8cN/RdGbrsbMcLkL02fu3z3QWvNNUzKg7wpH4hSIUZh0QypLpb1rniG8msdiNurBcVNpQcaOJOIXTCkscgTDHSikcK5GRsslfM0YthQCs0ud1dfmbLK8Z30HRGPooShZ6LUtsIrf+vaN9PTNGFeKPYTJNxoqQJA7WWtqCKupdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389677; c=relaxed/simple;
	bh=NI+3lSZ3WHNXtltmq30+rpewOqV3vGtfFqleJbIo9cE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KEncrUbomtzam8Ltk3SkrdKw87ZJAIvb7yjveB8ocNM9j2LMsTim5Xvf3lIoneK6ZsTiiYljrVzQPFr4/DCW3smeKWY1UW2EZpnpp8VfoQvllosKAtaFyHiE5QSagoLavR2TLiJcab8PSgGp7l4dvF8uF0JEQ6mf14912d80MYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyZLIM/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyZLIM/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB81F000C4;
	Mon, 19 Oct 2026 06:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389675;
	bh=hVmtuS79RO+S6EyPktSzX3IZQxCuzk8UrdXxEyUOUxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyZLIM/8/FHX0Kg3cvyqVUhFhvWDbDZ7nb5RqUCF/lnfcaSthv2cSEse3QV0MPvBd
	 1gnRMu8ulfl7OHdTYhekLMk9lMvjl2HCo/Y5TZobEzmmX9YeJXgZttFkFWLBodz+SV
	 RUjV4rgSf8NZ1ypUpMo0mjKtuUkyWk1GdaHd4O6fE5UxNsXWZcxvIwNnMtmE3ZS2IC
	 pMQNDuITjVPENz7Bu1W8fVnHXBLgxXL/pnXug2U6LkwlICsJj7JXv6kHo9CuRrPdFJ
	 wU0ZMUmapGkgWJnxKS0yW6q0LSa1qF2uWWYGispKv8UVFsM0+2OeyURIT2Ywa7imN/
	 edhHKRRJ3HgXg==
Message-ID: <sashiko-outbox-176680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] perf test: Make sure maps to have a machine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019055207.39325-3-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
 <20261019055207.39325-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:01:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's be easier if we could guarantee that maps always have a machine.
> IIUC this is true for all real use cases, but only the test code has
> an exception.  Let's get rid of it and make sure they have machines.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019055207.3932=
5-1-namhyung@kernel.org?part=3D2

