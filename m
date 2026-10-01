Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6D37FF48
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833459; cv=none; b=G95iJ6s9mcS9IzN/IXoEaSp6nYiSMVemIhCOcl58jZUNWTeT7ag+JzeyvIyc7IVfgz5WXPQ/Bg1vFX1SIBIC6KchwuevM5XaF05Vii6E+HJ76qioDlOoRRtrCai3JOesMVCrCOqFsADwW7umKHJQXfre42KpJ6VQee8y88K0Hjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833459; c=relaxed/simple;
	bh=2duOpo2QZtCXAHIUBWSr3ItDQeg2oE2eqEvidfztFXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0bwpQSZKzUP96+0fX8qmfyHjBxSd5YqHEFxbFY9Gou/Kt1sZHbTZxhE9viwmp2dXLvgMtBgJRx1SHUiscljBka+PZESBW2pbT5iheDvVEQH3kw1mWw3NJiDPaLWDd+e4G6L/puTDl66bzPZbCwMAtdmg0YHANdVIJXUeINplX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaPT0/Fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaPT0/Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406871F00898;
	Thu,  1 Oct 2026 05:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790833458;
	bh=2duOpo2QZtCXAHIUBWSr3ItDQeg2oE2eqEvidfztFXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FaPT0/Fb7T+Q27wM2dlKZ8HNu981FcAvFWzVcCzlIUL7FNqEO5glI/2LGFsURC2MJ
	 2EdQaQOxDhIKMKyFLApd4UQycubnFsBuyqanX8XAkU0ZKvC8P1kNR1zkm+SQEhCUGc
	 iZlrmsJ5ZY1bWNmJpNf+WamlGQG1+d9izDYC6fGGT28WaOPq8t7bxsxvVz78UUXedW
	 0zzZT8v9s3UjxpQobh20qy6CEmY10AaQ4RKWuqx4F6OHZLKZIZ3gNYP/7KmOMdBqhI
	 W9Xp1eCoontj0tEVjBcRdcV7+L8DHcH31AT5MmI/vLi9eGnbbVp+s/2wch6z//pu8+
	 NW6R5cm2jWrFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] perf test: Update attr.py to use argparse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001054120.1570943-2-irogers@google.com>
References: <20261001023423.1225713-1-irogers@google.com>
 <20261001054120.1570943-1-irogers@google.com>
 <20261001054120.1570943-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 05:44:17 +0000
Message-Id: <20261001054418.406871F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> optparse is deprecated since Python 3.2 and triggers a pylint
> deprecated-module warning on newer versions of pylint. Replace
> optparse.OptionParser in tools/perf/tests/shell/lib/attr.py with
> argparse.ArgumentParser.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001054120.1570=
943-1-irogers@google.com?part=3D1

