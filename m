Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A41189F43
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 01:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645131; cv=none; b=IsuXXF8QGpHHpyyTwqio7++ZZrQUD7RqeH4T0PUOi6qpCd00GytOKpgwBHEwfkzpJWmzWupInltXljmgE8zIIFZMe0eTKJaK10mK/CzOUgymFN/HNzd12sYqjx1q1YY/2+w6qit8XI1/FQMSudulg5oUEZ8kiNmu+16QBbPY/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645131; c=relaxed/simple;
	bh=POCw6wYApDk25bT1yqmnnjHaBdkcsH47Vffgs7fYO8Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVZ/QmjmDSKFUty0WZC4+Qm82W6t70XSEZYYM2jVOEO01YHZaVc3W9yUu3C11BXTJLbS2EyXo05Ufe8utXZTa4lhZE2HO4Z++peG8f37gORzG9LxMSvNEheYuHGwA7/ukn/JJn7iroFiYUdf57YGCTj7zfpJCDP7uRtw/7YS5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDpKPHnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDpKPHnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527101F000FF;
	Tue, 29 Sep 2026 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645130;
	bh=bMcrHOa2uu2jith5xgLc7OZUgn/EWdlLPxeqmE9xayM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDpKPHnEgxfxL8ljQq1MT2nizL6eLS1jRfBaLh0xPXGjNp2oF5EMMynEW3zkQEfWq
	 wz33pEgERVj/LVcwKu1CbzAs7HsS5ZDjRbuC3ll1gaIHHFePXBuSbvFY/HGMfB/idQ
	 SlBs3YKVPgQQF/w0DgOY/xSz6wmCjnp0B4tCkquRscGVr8n3t1iqhfY3lkAk/wZdzR
	 Ti/6HpIDVvwybe3TcXgv4TURBYcFb8D1ykiST1MrFfUA1G6O/OP3Bg8BRcdGNQdIo8
	 B4O/22icLsYbAg94EE5fJQP9x0pWVtMTVLirb6E3dYgiWf0KAulXd1kkdtau2LDjz7
	 c0KTvlK3b7Xqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] perf tools: Avoid repeated failing search for
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929011139.53242-7-namhyung@kernel.org>
References: <20260929011139.53242-1-namhyung@kernel.org>
 <20260929011139.53242-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:25:29 +0000
Message-Id: <20260929012530.527101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If dso has no debuginfo, dso__find_dbginfo_type() may repeat the same
> search for available types.  Let's add a new field (debuginfo_searched)
> not to do it.
>=20
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929011139.5324=
2-1-namhyung@kernel.org?part=3D6

