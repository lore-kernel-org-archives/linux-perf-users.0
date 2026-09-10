Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931C38422E
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041256; cv=none; b=S3UsNJUUq/b3hQwd/JeZ3ht6MdfvfKAn6TzXirzSDcrCt35tw7c5TKgOXOOjJqIE9hbd1XfBzCHbxm2I4GXRm5w3HhDeaN7dWekJsMuqflDIuDJjIN81NaX30O8D/UPhmktNhB9p2Ya6Q/KVwhzAFoYMLeT7I1i7HWzHfwskic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041256; c=relaxed/simple;
	bh=Wj/ZLEUuv6y36zMAjDYTzgCenMXk/PD2Jp6H/Fpq/es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJ9MUu/RumyK/DWtBjzM217ji/ILeYv3q9QYsZJp0sHxp3KrR+erGJ67bP85S7sEg8EADkNPthbE160agCjSuV1gYhYnp6S3Aj3UTjL19eJAwHR5ip8L41hxwlvP/BpLrUS7dwdYNsMI7lOgxlnCgfEHRVEvNZRyrMvtV7u/kuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuynJ5aS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuynJ5aS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048CA1F000FF;
	Thu, 10 Sep 2026 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041250;
	bh=Wj/ZLEUuv6y36zMAjDYTzgCenMXk/PD2Jp6H/Fpq/es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuynJ5aSpNxT6dzBmtfW3MlHRJHqebW2WacFl2EfLHvb/LhLloeEy2LztDy17vmHN
	 XoDr7JaOJgmU76rh948Zrptw3JWRK9EGycG7fts29iuH3U+zPxTC9TwavVcXD6m8uf
	 2YO2vSNDzK/srYXmL2tMI8KFgEQRacSQYz6pDAW1ZQT3YGn6psAkg0Y8DN4gFk3JyN
	 wBNxWZeV554C29YkZp2iyBUl7MJSlgXintx/RzzbijWgrLBODvNUZmcTPBOLR9Wsb9
	 CxjtJfmq0wMECFGj+YCQF7UZfkdTTZ2HCyYFs5IqxodgXPmU7+nRQ63bG/XeLtngPd
	 uF6zMeEvqtqFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM
 configurations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shouping Wang" <allen.wang@hj-micro.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910114601.165237-1-allen.wang@hj-micro.com>
References: <2fb3bda7-cd64-4dc0-99f8-c0fda8d42cf9@arm.com>
 <20260910114601.165237-1-allen.wang@hj-micro.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:54:09 +0000
Message-Id: <20260910115410.048CA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When MXP_MULTIPLE_DTM_EN is TRUE, each DTM will monitor at most
> two device ports. In this case, {wp_dev_sel2, wp_dev_sel} will
> only use values 2'b00 and 2'b01 per DTM.
>=20
> Previously the setting allowed values beyond the supported range
> per DTM, which could cause each DTM to select invalid ports when
> MXP_MULTIPLE_DTM_EN is TRUE.
>=20
> Fix this by only setting CMN_DTM_WPn_CONFIG_WP_DEV_SEL2 when
> !multi_dtm.
>=20
> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
> Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910114601.1652=
37-1-allen.wang@hj-micro.com?part=3D1

