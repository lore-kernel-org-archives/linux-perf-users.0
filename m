Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E14B0E26
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576971; cv=none; b=iNfB3wkZFB5XFfQFdE35Yt7XO0WlCsPHPKxV3Srse7TNYYkPMlWdB2MRKoeyMpSyhKJiD51QQfQtVqdeLnPNSTPsq0rqevAkcUNE8iT9FUyx4dF5zyw+KzqcTF7coRdZaa2Y8TlFYOLExrCU6KuMHiu75ta8IeTHXbGHPlR5VdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576971; c=relaxed/simple;
	bh=5XHDrU3yKpx5CZSgEV7ZyLybyIqUC6MsHbGUZLL0Rqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ToAiF0fW+sPaZ3fNcCDNcEWZo7LiqLGPH0KfbJlM/KQDvkQvoPoUaSt6i8GoRXWofwMSj++htK9OgxNmSPUrCLWJIVWcNckg2SC17mUHmA982u0gCrXkUETG5lTDfmS8JdUZ023oXxViUXtUCt+8NST61X9TyYlXm7hY5RlEveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD8WN0L6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD8WN0L6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E131F00898;
	Wed, 16 Sep 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576956;
	bh=TNpmmhYrBQai2nKFAJMvTjbLr/0YLyukNoJ30702XVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FD8WN0L6plF9C0p17bXF6LdGNpQwR27OTzwwsBSTiUJDi5Bu4BSI0qdexW/kdv8Tw
	 rwODP7nf9/X6p7C7jgmRqEvmkbUbvxsQUad95iqwJPqUMEyl1la+6IYH0zqa/y13wj
	 xZi6FuxEuyYkRJp4xlCsYzQggeiIsPrQqvxLTfft8qY6s5+Sw1yqJ0tSRIHluQF1TZ
	 McVNDrQ5m/Sm+4Cmm1dJCcA3AcUC5iHcbPuc5pcgXGU2i4k7PnLCONVzm0N+kxvto+
	 evNgGNEUUiwHT+MKPD02NHLUYbWQdsSPxUexZoVi0RSUEWb3mFkv0jfWoIvLIrLX9i
	 8MA+a1E04uTNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-5-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:42:35 +0000
Message-Id: <20260916164236.06E131F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>=20
> Add memory region field to the cacheline list view to help users
> identify the memory region to which the cacheline belongs. The memory
> region field was included with the introduction of support for the
> Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
> Nova Lake architectures.
>=20
> An example of the new perf c2c output including the memory region
> field is shown below:
>=20
> Shared Data Cache Line Table     (176 entries, sorted on Total HITMs)
>        ------------------------ Cacheline -----------------------      To=
t  ------- Load Hitm -------    Total    Total    Total
> Index             Address                    Region  Node  PA cnt     Hit=
m    Total  LclHitm  RmtHitm  records    Loads   Stores
>     0  0xffffffff98c58ec0                       N/A     0    1208    4.06=
%       97       97        0     1602     1602        0
> [ ... ]
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D4

