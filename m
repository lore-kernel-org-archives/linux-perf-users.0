Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74E279DCC
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039793; cv=none; b=E2W+/7xpJ/uQubRQvj1mWZ6ENrPo+0A6LvDzwKTrF+4L53scTDGwhiA7mYXrnZmtasfT1XwYyuldiBHi8Y4IFb6FFcAYQ2l66St0QnTC346w9bBi+P+mr/lHVz3all1Pgeo6OPb+5MFGi+5XLcZWFWgKmo2yEHsXX54kWdEOF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039793; c=relaxed/simple;
	bh=LXHTGEewpsx9TDQQbUPaf6vgnwGPReQBvr2Rm7e4LCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqjQmXKio26u1XQLOffN7kWwr14ZWQnN9ED8lDRcKWdO2vAsBkKvWGvwiWCFVNaQuBllTHexBLunLvKOd7WL6gmNUtpxqkr/swvhNKU9TTsOsRBqBivdexIhmJl09ESt9J3TWYUMNYedxkyI39qBsmW8iWu+YBLl8HmEAvKL8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnVXNEnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnVXNEnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9832A1F000FF;
	Tue, 22 Sep 2026 01:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039791;
	bh=LXHTGEewpsx9TDQQbUPaf6vgnwGPReQBvr2Rm7e4LCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnVXNEnXvVWAJYp2rAlqTcBKKdeNQA7rM8nK9VW8qQY/ThMl5GFHNAwCrsXee8f/F
	 FLB/dY9lFebb9XTTrK7XkR0FVWwFvnAyjm/WXSF1eg4iLE3YTmxVWe56HBxgE9/5NJ
	 RPSMF1O0s9MthhIcjpDmIsCGSEx9lq3Df5e6Z17A7Rd2sZdxJxRa2Up9QNeneKcamx
	 f5GKrvJDDaLY4JNrNet5Quh7CTDt6UMa6DPhAeIb7TVFBVAZ3/eI5m5MFyhJOTrLEG
	 ZQBpxmVmJOUFHYmye/Z5YYRDwwtxh1FMd+VnF22skGlCpKtitMV2O6eYgYqnHEeyYc
	 JEAENqMBBjIOA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 2/2] perf util: Explicitly include required headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922010531.1933320-2-dapeng1.mi@linux.intel.com>
References: <20260922010531.1933320-1-dapeng1.mi@linux.intel.com>
 <20260922010531.1933320-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:16:31 +0000
Message-Id: <20260922011631.9832A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko complains "the perf tool can be compiled with musl libc, which
> enforces strict POSIX namespace separation and does not implicitly
> include headers. Relying on implicit header inclusion can cause build
> failures under musl."
>=20
> Include the required headers explicitly to avoid such failures.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922010531.1933=
320-1-dapeng1.mi@linux.intel.com?part=3D2

