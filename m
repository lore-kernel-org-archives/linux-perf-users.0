Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADB4078E4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575686; cv=none; b=D9I8165lY79u22Gf+0v1kTJQK2uvA+bhqJrEJV+IB9XkI8pN/Wf/5DQRxBawD6GpS2Yw438DqAtuCMkBrW5Q2Mtr8LEBPiJudoqvlSF4k1aUcvBHtKNajfg7OPnFs/NaeLKOj99JMmYiab6lMsX5fYr+X3bpbIfDwOARAya78Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575686; c=relaxed/simple;
	bh=e3iMOM6sulp0WmHz6J2XBVobWsnYax8scNllPm7mE/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jejtwlQsMgBNgQCBo6BmysqEdMyh0GIZRAeL6eU5LU3HY9vPI/6GzzC/k0CLEY9dE/UQJvsjNeZvlDJdafPTo0Y9Wt+gzXuaZd5DROxQq+gv3vrtPBqx7bcj6mZzdB3kPBuU/mJEgHFrl7ctu/Xfv+EmXnOWFLNXN/DPrkjTDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4LKOcIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4LKOcIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C43D1F000FF;
	Mon, 28 Sep 2026 06:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575684;
	bh=2H6AYTvWtWe3ovkBeD1gtKzqzoXUJF04p/HxIbxV1P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4LKOcIqCyGBSH9q9ezI6/TxVtSC//cZZM/yWwXik+7VMv7dIjkrVgDdwEDEdyGbD
	 cMocUHZQlrjmFqg0SgUUyyLij57LbJsi4ueF4+kCZMNe7kHKPLOBMSScT/ox/x9W2M
	 UN9UO5nzKRuV1k+ff9F9lvARsG5ufaf6hlg9BbhQTCXA8/icWm6YVUoYkRhk2ypeXO
	 51vvdeO8TjaPx6rTR6eTBv6fxDWOU4I+uLaYIhqC5Zyvb9qDhGJrMXXyo+0j4RlmAT
	 J3VkA2FxAhM4ktCaeOh1K36YUTRmLetqeVT+9Jnc1f9Cje4IEEwXBrKWrbeyI4ZRTw
	 W5bTjBxeBa0eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] perf tools: Avoid repeated failing search for
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-7-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:08:03 +0000
Message-Id: <20260928060804.3C43D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If dso has no debuginfo, dso__find_dbginfo_type() may repeat the same
> search for available types.  Let's add a new field (debuginfo_searched)
> not to do it.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D6

