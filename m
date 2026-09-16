Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DA34F46F
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542077; cv=none; b=mZVKoxiF1pQQsr5CNgBabK3a54RlL2mTbk28btzcyGaM3pkxqeFBZ9pmtzkuz1zPgHmMRKT8DcFAXc3LPYRrc4KjnzGiLgagXEJpJptgzFCiG+5it0WZaY4Z9Iaso+BQpkGasQeT+OiZugfQhSfbhfFFaO2dhjToMrYuOPKIMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542077; c=relaxed/simple;
	bh=tJDaWcyz/j9lUXAZH09ZaeQa2pUDhfEsX46NwDFEowc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jwIdbIpbGo+9uMNjCc2njhyw0z3MMsPmPMJM33QobhlnfkLIfgluQF47dBbiNpo5nllWqcFrunBZvRn0/QFsbF+aFu0epIyPByRkMF0bpj5t5+ZsDAdLJhwkfh77NWKdB5bXCBMvVf77/G8beZNjNqrHflFU4vMfsOMjzi+qIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGi2iATz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGi2iATz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6C71F000FF;
	Wed, 16 Sep 2026 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542075;
	bh=tJDaWcyz/j9lUXAZH09ZaeQa2pUDhfEsX46NwDFEowc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGi2iATzH7KX2SWO3rFYcHyc8/eQg/M9b5tzcrzam8bYbuDmm6l56V5h6MityiwEn
	 HUxA5yaYe8YsUqG4v7a45jhPujp1xNdRNO+gsySFVb27W4/L13UVjPmzeV/MGiVVZk
	 4geUdWa8PJiRoIBpVKgUIBii++RAZMgs4mrLDVSmWBTIkZq8UtuVWLHhIfb2tFVOeY
	 tOqtxj53FjfP54IJngM/8ChafaZSyvohjtBg0GJg2Wsz8sGoyRDlBcp8eaKTw4BkfR
	 +I/XAuQpbmZpUITt+JtYDEJOXtn/S4bHaan4vmJnHSqiOFz0ZnSuaO0QoZJB0p1raa
	 MN+pqxzBWkNTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] perf tools: Add TUI hints for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-7-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:01:15 +0000
Message-Id: <20260916070115.6F6C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add dynamic TUI hints prompting users to restart with --hybrid-merge
> when heterogeneous core PMU events are populated in the sample view.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D6

