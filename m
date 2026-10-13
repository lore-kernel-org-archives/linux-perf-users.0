Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D33D9DC3
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930856; cv=none; b=BPk2WdXFCcz1miyZcxf8+6XUV0I6m4biLdRSfOUbZtKvruZky/w5usN/YspQlGJeLIzqxbgkvGWyc/G/Gv4iE46mgzGHrMzak4QYo6OwYbfjl4p5ZKyWQsbMvw4vYSdv7OZZM1G5SKOwyZvQqdspkKn4IpbLWP97RqsTerpeOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930856; c=relaxed/simple;
	bh=PQs+pjwI2/mOTCJUybX0pgb9t+m8j6IAVGeY3E5WCZQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YRsDfvrQ6cQvsN8J8v1LepK+oDXCYjLLD/QOhjP1Pb1sllj9aoB2aCLBV53vRZS7ulEPNQaWlhlbDSbU0iALwlNF3x5cxeCrhVa+2Dfse0+CGMove4EKk8ErxeM3awSwMnDBuArJ3+UiFkC2+t7QyirLlrBgBHxnaHrkdFav4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReizazQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReizazQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959231F000FF;
	Tue, 13 Oct 2026 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791930855;
	bh=PQs+pjwI2/mOTCJUybX0pgb9t+m8j6IAVGeY3E5WCZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReizazQ3fUN40IIqyjhjpsy7lzt4d43+u7lvNyzKtZIuK1VQ1S1IJJnsbrj4VjyjW
	 GIZbb1I1Ab8MSIfXJMcRJ1I30TPN4Gaf+6na/PIx1NkgBk3wuXWtzSc91wvAicyJ75
	 2GnjK4khVS3K7EurVo1Qu+6nMl60spo/QTANwrD5jjhQLexbeNxHbE4uyd/UXpPtf2
	 UxcExlbJRnhmw2N6PeMrxgAHwpLR7jWRxfkQyZfKe8U6Eto+b3xD5EclCN5qyH35EX
	 CDfTzyZWD204MRKLS8aei5N/UYr+595i71dmnKN1Knoa4DPYwyDdz6bSQoq7DCTeKG
	 PSzIT5qBXJG1A==
Message-ID: <sashiko-outbox-170581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-4-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D3

