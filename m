Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470415665C
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958321; cv=none; b=gOtbEDL4fpLOmLwYvZ5G831RqOT0hwroAbxBkANp7B0d0LpIP9jMA9uWKr0kKCKZSZOQx9hRoloeKQXb/yZ1rpzkZsuyE30p2L5lYtM66NekiyD/DSH6lRmsydJ19lIJSiOCCbPoJWi8mBIJ6Fzg050fNJ9dou5fqCo6jNc547s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958321; c=relaxed/simple;
	bh=qqhV0VRygie7DY0FhDg9x+DI0BwCWMlPJhd5ki46gZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=enDyDIPwtv7HoADUnHmm9Z+6cvNobot2yZF2vOAT13/RbYvbF/oRhCy/DHNI3EOP6LrLvfik34Pm8ShPNvlaJCAUue2/YbLhE4a62zb4WOG9e1/08eSrp+thXheD+ovQ7W0NMhObM+bIksDpaPeWLPnowOWMgkxfAWPsOTrRiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+uKd18K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+uKd18K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E665D1F000FF;
	Mon, 21 Sep 2026 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789958320;
	bh=qqhV0VRygie7DY0FhDg9x+DI0BwCWMlPJhd5ki46gZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+uKd18KVYH7XPmmY08Rst+C5raSVSN8EYcKWmWPfUzw5zWvBeIR/NnX7UKd+8oLK
	 J/oIX8isJLcpF9MNeyVowSPbWcjwnFTt4GPOUoz8skDV5lYSpmf82tof04I0yGXtWB
	 rqVn9bWxp/24oVNYIcmlqOzixTEjHvy1pdFvfupXl7AfDPH0QaFcEBS/DcMyFejGRC
	 mfdKKlkCRahyUzH8P57mII8arCXlo2Sw4Rbt5taRkBlMX4e0mspYCulwmv65ORLdfR
	 dKyd7ugRYum0OkRaukmrRbr3nWgtZsrkCauAa0YWjqKzpHOFynXxmRZq6jDpTR2eC7
	 +c/aNOgcfOqNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260920-remove-pg_private-v5-2-bb68b6a21869@nvidia.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260920-remove-pg_private-v5-2-bb68b6a21869@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:38:39 +0000
Message-Id: <20260921023839.E665D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only in the ring buffer and its
> users. This is fine because page->private is 0 for order-0 AUX pages,
> matching the page order.
>=20
> It prepares for a future commit that remove PG_private.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> [ ... ]
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-remove-pg_=
private-v5-0-bb68b6a21869@nvidia.com?part=3D2

