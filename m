Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693D33ADAF
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424429; cv=none; b=Zv4bZCJKOZfP+dNCmXhCe/Ef2SYurLQ430p/aO2BJ0PKQcb5zh2VmQS80WbHvtNQV/hxCy+V77x+Uz0h3JcM5soxRQwQT65Bm1a5dEJhivvqIJja+i/pcjYf2aQaEqAaHYDYRz+sy7OQNa6zsx2/oWOMw04YI4fjPnzkNPtW/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424429; c=relaxed/simple;
	bh=v6W6fAO6shRzud4KGZGpdzYNDe9z7SHd9MZtKzYHRSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RyX6io5avL0FKCIE78kQkEUVMV9BUSWElnrgCenFw213cO3OhPkK1WqRXkQTN4TYmeSAq9CYepKD1uDsQOWap4Abh1BaYLeQe5SwwzIUmZkO0SvDEvJqiEEuY7XWK3dPeyLl2tUJlmbUmr5nsDe3sJScfe99v7AcyTTcJSOHnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vpsf7xux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vpsf7xux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C8F1F00A3A;
	Thu,  3 Sep 2026 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424428;
	bh=v6W6fAO6shRzud4KGZGpdzYNDe9z7SHd9MZtKzYHRSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vpsf7xuxnwJr1pGxPPp1HIlxIP3Ang169MGpQInniL7HyIyMCgIJ65ew6T2g/fJxa
	 9LjthV7cigaspj82CZunUwMwxrt5B60B/WIZHNklPrtW7dDe6TU4Otbr8ymC+iNp6T
	 xdo9xtlw/eOg1PUkRENOo7uB2dW26qQtMCxLAMDFahGxGkRZOhlr4j1CmNe+jvaSJ1
	 J4N6jXPi+yHlC9f233+/aYkMDBxnVjrrrBTpFE/aTOOD28PR4ZHOaxBE1+Q9GCm6I2
	 5RGh7PL/IQGWFs3OQhAgqj4Os/EzHYexvQH5d2FWkrMjHJqn/hQwITvSOV6OH6G/nj
	 Z51FCQqgerbgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf sched: Fix resource leak in
 enable_sched_schedstats()
Reply-To: sashiko-reviews@lists.linux.dev
To: liujing <liujing@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
References: <20260903082128.4972-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:33:47 +0000
Message-Id: <20260903083348.11C8F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Liu Jing <liujing@cmss.chinamobile.com>
>=20
> In enable_sched_schedstats(), the FILE pointer fp is only closed when
> ch =3D=3D '0'. If ch is not '0' (i.e., sched_schedstats is already enable=
d),
> the function returns 0 without calling fclose(fp), causing a resource
> leak.
>=20
> Fix it by adding fclose(fp) before the return statement.
>=20
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903082128.4972=
-1-liujing@cmss.chinamobile.com?part=3D1

