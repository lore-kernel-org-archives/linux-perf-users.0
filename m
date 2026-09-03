Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC364399D6
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423991; cv=none; b=OVTr6jdgSA7AgpIv2tsctesQtei3LOOZzPLrJxbZHhyyGIHRMRbxmsxB5naHqZS4OLL9oDLB4oGDJItl9PuVkUQMLkjcvjaFcyOf+wxBoj86g1+FTy1rqibPHQP8FbtApO0UsZzgy74rUM1UXMFNDkBT9JaLBHfzwa6LJmcCgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423991; c=relaxed/simple;
	bh=5ESkwkoR1ONo14NcpuqhRcP9o7ljz4OZvkHUDyIewko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZNTJWkVCsPgz6qKepPrI4f3XFwci9A/tTRbIeKa1NuBAhxE7Pt/XVIT09H0kOwIldaNUpbDA0oh5OHW76uBLI/GEDXRoheb5dkih25nOnK1ONw2fiGHrmbOqJQfhhjc+a/byAt8Ajdj3E3MHi5WxLm2Zgj8+C2VndXfkiOVxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7VaP7QN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7VaP7QN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6A31F000E9;
	Thu,  3 Sep 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423989;
	bh=5ESkwkoR1ONo14NcpuqhRcP9o7ljz4OZvkHUDyIewko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7VaP7QN3GK+a93ydMPR6Hld29o5dygELjagBlayPjm28nF33ZWzsbxIMZs5ateSb
	 TAmWn1ZJvgqKNsEy9xjSoEpOhG6E2gTSs60PIlyGD37BOy9GbDbBYZsHKkiIcpleRU
	 S8NI17qmM7h9l9ixjNnxY+wIOd2pgXVUrLMdkYp36DtGbVAE4L2GLOMhaLFU2KBn50
	 9h+U+HIKP2WgSIonfQwxrwfWC6DWXh/CUEuUf3epX3Vrybsez45xscbT7dJvla8KJr
	 xzNIQHoast9/yJm+GhkKAmwkK2o/IsZh6yGXabEgrccIeiOMbLyOfmonHvXw/DPDCh
	 60Cd7SqFKzK1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf script: Fix unsigned comparison against zero in
 print_bstack_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903082128.4972-3-liujing@cmss.chinamobile.com>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
 <20260903082128.4972-3-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:26:29 +0000
Message-Id: <20260903082629.AC6A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Liu Jing <liujing@cmss.chinamobile.com>
>=20
> In print_bstack_flags(), the variable `pos` is declared as `size_t`
> (unsigned), making the check `pos < 0` always false. This means the
> error return from snprintf() is never detected.
>=20
> Fix it by changing the return type of bstack_event_str() to int and
> the type of pos to int, so that negative return values from snprintf()
> are properly checked.
>=20
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082128.4972=
-3-liujing@cmss.chinamobile.com?part=3D1

