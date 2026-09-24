Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40B4119F7
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270076; cv=none; b=lifCexlUgk7PHfVpT3RWCfWl+ShMlsztk3N+ZrVx5zNSkdtuA6EfJKrNuw5nCPYv0pfudO74Ea1+96XxEP0T/IoeRHOC0Qu/gzg5tXVDJk9p1jbgM2376gpIlpHs7BGbwcwM2nYPiBji6fmMR+riFEAOn64hh5XRZHxuubHx9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270076; c=relaxed/simple;
	bh=UXjCR1Y3bzDSK1WvJNtKSqSF0kaHxZZH6mboK40rY9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AliV7sb8oAueXS+cQs2uzN1PGD+/OmAzTgyOBxm5LhKzGPJzeUOBtpVd2kKLKaoXv/+thvHgPgfU4S6ZDjZvZ+37FjkukFOgOjt5sZQFiG53SK0gtvmx6+IkIEdyF/iSDBRgxTYDmhlA9iFVentXVhipH1AZcLwekpiTyWuZmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpLEE4YP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpLEE4YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6507A1F000FF;
	Thu, 24 Sep 2026 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270075;
	bh=UXjCR1Y3bzDSK1WvJNtKSqSF0kaHxZZH6mboK40rY9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MpLEE4YPGc4DfJ7RyRCkIq8HSyd8LXvxhQxlZ7rv0QcOHUSIK469AZ5+HzRGfikx4
	 lOsD352XMQPAkw+uH8FhqRqFk487Yen9oTly8asKXFK0oPC14Fj9AAT7QK6rlYNNri
	 ppcrKaW1AkTD4k9R5TQRsD8XJaacR/o6SDOk/5if58cGZWo23Bc2AQhHhpcVo53GDb
	 eoE8XItOCpaYaeDgYTdd2P5QHE/3T1XBppvrPb5aUL2nd7NqywMdlKPpQMypQLLQPw
	 NnaEDLIQdA3MgFOHQQJBPo8MJX7GoecuBUAtmC+1H+5B8pbXK2smLzrnSYmTeu5Ctk
	 K5QbGfgRmAhcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/26] perf vendor events intel: Fix snowridgex umask
 encoding.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-27-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:14:34 +0000
Message-Id: <20260924171435.6507A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix UMaskExt that was wrongly encoded when the UMask was 0.
>=20
> Fixes: 2bb848f820a5 ("perf vendor events intel: Fix uncore topics for sno=
wridgex")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D26

