Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186B40245F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761957; cv=none; b=uwW5bmk3q04RaSr+iNtoaMkKHSKYes0dpff7dBQC1ecbXWDv52qfM1hRBYf9iN4XeYDQQJFhjY1O9DS1cgKBt7i+IQZ7hxHlmd3+tBwCowhWJw7dgfP1T82GH1WJuSh2pxiH3eE4hm++cj5TS5nmPOp4vMv0q66xaplTIdgCdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761957; c=relaxed/simple;
	bh=zzqokeB7qhc9x37QqDnofmCqDZVCoWr2zonEksVHlqs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c7PF2/y9VmH3/nGqCjJU8dJFfdCiDA4S1QX2mpjTSDjnUwOe/PFHDZyr00I8YJkojR4aldlECN4PYqvDis+qSHmiSGq3p/Sn+vbkw/ryHgt6I0+fF07ZomP0pOORvBk5AoiAnalniVE3Xpxa/2UtGLwJavJyItLe5FghymdER2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clc2zrWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clc2zrWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA861F0089B;
	Sun, 11 Oct 2026 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761955;
	bh=zzqokeB7qhc9x37QqDnofmCqDZVCoWr2zonEksVHlqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=clc2zrWDiWGv7zfWx+IxutB6Ix24f2TT8q25z3BkzmCSASzdNZ1VjkyyeWo6gnks/
	 FfxKC1QJCzb3qFZGhAUnUtpwwlbiJNliJzK7LazWePev75YB+J4s00blT8NTu0aF5E
	 hkfwS2SqFUvuGUAscOdhbpw7rhH8Fgj+Yc2iq0OISemnYCGp1HVvw6P9k1tovxJHzM
	 YII+sCTvxp8qh1xzofcypusSDgxKq26PBrlkaFwTM1Oix6kvJnnFcaVqnII2uHnBRV
	 2IiB1ZRwumnzb3BSx/g8lsQjDhFNaxJiuJ7fX9QLvUpgm9WK4bahC4/EhjUCniQwnL
	 SMjgxrQgR1LyQ==
Message-ID: <sashiko-outbox-167516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] Documentation: describe building tools with the
 kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-7-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:39:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Mention CONFIG_TOOLS_BUILD and "make tools_build" in the submit
> checklist, ask for libc-only selftests to be added to tools/Kconfig,
> and note that USERCFLAGS and USERLDFLAGS also apply to the tools.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D6

