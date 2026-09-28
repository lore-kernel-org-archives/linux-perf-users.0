Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5338B142
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620680; cv=none; b=VGf1yhn/jCmH1ivyaWcn1RM4bNvZcjxKqeDVDB3E1lM1b3jo9XepInM1cnwKz9hDte8amxXgEQFZARET83gtIRbbMATWNSdTfM3Vn5/YUlrucGrRUxGyyi6OrjPxTg+c3TOg+xaMfK3X7oC9Y24xU0HFfmE7P18Ka7urZ7MNXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620680; c=relaxed/simple;
	bh=7/6n0vu2vwnVFPy6vTfAnRPwhpeSOkfPwuoDGPBMKDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/Nc7rSq+WEu4koIpIVLOmOOAq5Ltun2qupA5gAPJWAdPVMbB8p1cpQjuOwOtnl3Pcg39UreTQSXtrrtb61aWm1V3xPYuXCUNECmr6Pvo6y7tXcHLQtsZ+1eJcxpvF8XE0A6Jt8kV7kMkCfH3B5kILf5+Gd/OPnqsgIlqKhWSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZBV7vbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZBV7vbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9554D1F00893;
	Mon, 28 Sep 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620679;
	bh=Mp10Kwm8/w1AXj9SBGQBOhYIMMuHRKsD/nshXn8BSWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZBV7vbpWUSJVHZVVBEjnVeuWiYEIyz53OXP+nVQROre4ns/5n/ldyLovpDI7B8z8
	 Od0OJr5WsllucIWiyAGWZQJZVZfMluGeHi2ZvDTas9akSQZxG/tJqzHCzyyc1TLVhS
	 /17jQheHk6vFCRmsC92v6Mt8/eTEdDS2biYXlZCsFMlDoc/8S/RULnInOJ5jwYkr1j
	 +tN7ZaossJTTe6gQ95KmCDweD9JhuOpV5ZlZJW9GaBKrm4+sGg4SQjhUKKKMfsOXdw
	 MF+RRcLVSD/0pVAtK+KsroV6gD0/3xoaccmhOYy5SwbggJqwNUy9jgp/WLIkvFs0hu
	 o+vfH4N1rTXFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/26] perf trace: Remove unused code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-19-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:59 +0000
Message-Id: <20260928183759.9554D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> Now syscall init for augmented arguments is simplified.  Let's get rid
> of dead code.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20250814071754.193265-5-namhyung@kernel.o=
rg
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D18

