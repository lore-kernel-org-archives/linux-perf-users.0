Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F238C2C3;
	Sat,  3 Oct 2026 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014402; cv=none; b=DdOCxBRdC2mhns4yw+qAeT/8ajGAK4u3PXnc4RTaLnCr4UVsj6xm7YupDWqYqtVZ1CrOmdSzSnQgh2mPRupzbzLvfK6ipW3rRIRZhoNRRRGD2nSAenoPEdQM/if9ii3nlYLCxU1S3JycU7HGyMYMJ6yO//ju90YT+NQ967fT1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014402; c=relaxed/simple;
	bh=v++gVU/2GGTpx+1wach56Hr2mReuzZXCd9v248nesGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fd5b31oaiwLnWwLc9TveJ7s6P8f3rslTAyqXWGK9StWHM7DjOfheViMLShzZclQxG8WKbOvtVuqyGSnRhD6wpbqoOaQaGWyZqHL3eZGhwC4YOfdFhlpMJP7djNzQM8MtiSGrr/zV89bgy6VvFmqqf5nl3lIDXP/62vCBytSjxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmIw1P87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmIw1P87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0BC1F0089D;
	Sat,  3 Oct 2026 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014393;
	bh=v++gVU/2GGTpx+1wach56Hr2mReuzZXCd9v248nesGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmIw1P879cMRxvvrG/qQz8H0TcskFrR2tg4cA2XQ7pk2VEKvfI5xIIgkKZRQK0z6H
	 0v3y224+CRxy3M9zjByB2537aBBOi5CQRPBAzPrjUUC/2w+Ye0OWK/p1SivvqqjYll
	 ylkeQMXtIf/u2SRq0D+wX5secy9XlkN1zTEW1EfPqhZsK7ozghn2zlkiMolwTSkWaI
	 bIJk0kHV4dpuTz321HKqgWUD04O7vjGUkbhdqHc6i8C0IgqSSm46CtmvcVsAm3lJS0
	 IgRZ6T4wiuaYiGBE6Lx/aUtxAJEJTwrqyhE6YD7OFCaiBd482eP/Vt5VySRnuDjPKx
	 PkacFYdQhE8YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/11] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179101401403.22872.10717032102618304885.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101401403.22872.10717032102618304885.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:59:52 +0000
Message-Id: <20261003075953.2D0BC1F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D7

