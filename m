Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B5517BD0
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553335; cv=none; b=XqIT4IAfWyRpWG1V2ZkmHB2hBW4tNdGgjXrmHfX3IfE8s30j1sduDNrBiKtRQyPZKRpSbxw4lOgkyb2AWcRnBrpuwdKu7XyrQDFJ21x70a35ZvVb1zmVCafqF5rs7Nltf/zea2L//cZzf7NkyLKOgLEUNP4KdnJZD+di1/aueW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553335; c=relaxed/simple;
	bh=M5Q+87Pua694xdC6k5mprJxnAfQq/7zH15Op/jGrVM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjNhy00Rpvzzay5ztwyb4HnvWBJdO7r1eixyjZshguRItO4Sodce471QAmyTQ+SWTlABOV8DVPuTq3zbXujZcl+D9pOYEKVufB6HkjkrqwzO333GkrA1SWAueZbfRTzcKN5W9b6ZrE8uqTs9rCmHFZKl42mSzjuPbrBKJPlnrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAT5eFd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAT5eFd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817311F00A3D;
	Fri,  4 Sep 2026 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553327;
	bh=M5Q+87Pua694xdC6k5mprJxnAfQq/7zH15Op/jGrVM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAT5eFd4LATopav0ezvi3Xe13Y7ehF+NoBSKtBmyZJ87Qsf8NKQAAve/TqYlQFlg5
	 PEoCSsKeGlDdPz5DupojRMaMrNd+PcCtrRzwScI3dyqiMTA69lPcMl0S939ms8PKD2
	 aKiNUWoiT2qAPvb5P0K77FkoXhxt8jfb3Kfz9/HrS2f5O61FgK7kUjx6OHZa8XXmfl
	 0GWt4nFvHSj0Yl6HjxL09Yd8PfGGoScdvYVP7kKFdD0mYO4uc4MlXGXZPrUOP5O289
	 EbSaX5IJ5RrS214Z0/jy/ZolneYfQSaDxDZ6eAcykovOIJqAc4sNibQOhSeHFsZmSQ
	 5E+IuCjOjgYqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/core: Simplify hybrid PMU registration failure
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904201313.271421-3-blum@kernel.org>
References: <20260904201313.271421-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 20:22:07 +0000
Message-Id: <20260904202207.817311F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Handle perf_pmu_register() errors directly instead of breaking out of
> the registration loop and checking the index separately. Reuse the loop
> index i to unregister any previously registered PMUs in reverse order
> and drop the extra index j.
>=20
> Also log the failing PMU's name and error code.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904201313.2714=
21-3-blum@kernel.org?part=3D1

