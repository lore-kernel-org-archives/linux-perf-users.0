Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1553403EF
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449814; cv=none; b=IOqhh0gs8QWxNEkeuoWR+enKV+7RNwignanOwhNvN+sPITmBw6l+2b0pc+lVRQRIMmOhsd5RHpgDyZB8j6jNZvqvo35x/H5tqMPm1OG+AwXJBsPqOIfdcCcJT3ojsJqkLFEy7TATnXExVUrH+j/WgZPxKSuYFrCfrKepHRGyeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449814; c=relaxed/simple;
	bh=6vj5ZHnKPIs7EVjuoEy3cHHFL4y7a8F3XNRowcL9Ugk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KC2mVBr7Z6RlduSWIQQHo+Drn6Wf2tNfwYb4SfprO9lv8myak0zrqmu1nWiPHAylDD5tBYwiTAHtJc2R/39ToSiRG6Ufbag9RRke6h6iPbHrb1ZviKpnYRrrzGaUPXM7zd41cbdp8NAjqvXYPvMnzvETl+37PuPPplqDm/+2LGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTrmY4CK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTrmY4CK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A05E1F000FF;
	Sat, 26 Sep 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449813;
	bh=6vj5ZHnKPIs7EVjuoEy3cHHFL4y7a8F3XNRowcL9Ugk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTrmY4CKxowgVWotQPofQei5n/Dlv5Q6hZHlQJxEAuU17R1eqsbmr4KUt1+XBfAlK
	 a6aBAKKCzjNypKAV99j0kNXSo57spJ2OddkUdXlnFOFZz/Dbann9jubd+xF5ipyO1M
	 CNmRL/jRR0xvboZjW76SaqWDzJrUoTx304TW/rK4/Ft+EfScC74m4/iOGtNGNwMnUF
	 PUuIKnWKO5SMXvLdO8WDSkW3kQyZBS1tDzQ5bC29tx5ykWBJ70k8B7tpyHrHHdAvo9
	 wBVlnE/Yv1S+49BIQQp0/u901SnXkbekxizCY3qzkknVgxZ+DJjSLUm0hvKP45q6Jj
	 W3BGkesvGzIRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf bench futex: Clean up two nits in futex hash
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-8-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-8-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:10:12 +0000
Message-Id: <20260926191013.3A05E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The worker's check for an unexpected futex_wait() result tests
> 'errno !=3D EAGAIN || errno !=3D EWOULDBLOCK', which only works because t=
he
> two are equal, so use '&&' instead.
>=20
> The CPU map is reference counted, so release it with perf_cpu_map__put()
> instead of free().
>=20
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D7

