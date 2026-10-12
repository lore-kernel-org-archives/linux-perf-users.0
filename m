Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C193AFCE6
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783021; cv=none; b=lZLirO42SFU4QOslijhbS5Aym8ONvADjQqHlD7k9OCF9lliuX3ATwnmNC53RK9tWEOUYGmrrE7A30gw9e7l5lR0vuoTB3iIR8z6zB/EjL1we9Zvf2M55n8HzLFg45zKFgyMYfWSZ0/0h1DE99AoYfadwoIhMqke4sYTOtLREYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783021; c=relaxed/simple;
	bh=hae4HQamWrrVWeTrZqkmlTWt2iFfSdaooBNqveAFNmY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZckvR6qb6teWhF/ZLH8/kr8hfoHGe4Fl/WTFYsx3TQD+4JmWBq6IYSwVH5AhKBE7lq9LvRD6vhYxlvtL32IbmPKGykwRmnjnFgD8MO4Lg3K5uQwMU+9TKqMmMPXrRHFkKdHqCnkik6Ns4uWJRi6cK8G/fp8etxKzFUa3WbbZTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1LP79FJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1LP79FJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB311F0089B;
	Mon, 12 Oct 2026 05:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783017;
	bh=hae4HQamWrrVWeTrZqkmlTWt2iFfSdaooBNqveAFNmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R1LP79FJb9vLcUsOE9POCvM+4+cpXFiC+oe0wMhKXeyAbgDAXHvsztF5lDKclTo2H
	 bgvjoPzCLi5j1MZceo2qSFK0mFje2gEqkiJ4wWbDNvAgtYioAa2S+ecVKWIP1emqLW
	 5VOq4j0ebDQiU/QVbb9oqj/v7OCH5J5EHKqzH1F9b7r/kK7WZ4evLLHEKnOckRYSZj
	 VsY5VAXvuEk5Hzo4T2rmRWcTW/F2udRSw0qSX1gTYEnASkK+3r4ZH/Nb6Vp8G2fmPj
	 be3DwfNQTqoYFauoIivtkWDCNBIyTXOl9GMly9S119Ak6t5muXZ5ri86MyOT8vCdue
	 oGRotTTKcw8CA==
Message-ID: <sashiko-outbox-167670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] perf tools: Remove redundant dso data init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-2-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:30:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The fd and status are initialized later with cache.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D1

