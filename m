Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C7429CF5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187972; cv=none; b=Lp+tfHZV4bWre/n4rCIrzICfXNodync3hEqjVlTST1biVjuOqIkVU0CCaYS43417p5BlP4qxKB/iYZy0cXN83OOJSTpP5rpX/+7GgsQSIUPBgSqciQkj4wfjD5VBuSfKFBFXxi0dDXXqfWq4UKB9Q5b93PjD2zvxEWCv9kB8mk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187972; c=relaxed/simple;
	bh=u5rnNiGxanPphcLuhQMTz94wGUEumpVBSmzPbm/JO9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tu/+4N1ZEM0bWq4RpN6hq2wHCdzxXSqiiuD2nFgbo3zv3eEboQbgjNe3fqsTuIRKfCzNJz7d4p2eJ/dayIhq78Bfyh5gPEwfhYqDu9mfvijDV+htwGMV3PGsVpdEx4l00G2+cHxnpcGnOfuECSSIZIDoGy1NI/lWm8lrtCEE/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpRjv9Dx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpRjv9Dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4758E1F000FF;
	Wed, 23 Sep 2026 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187968;
	bh=u5rnNiGxanPphcLuhQMTz94wGUEumpVBSmzPbm/JO9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WpRjv9DxCshmRtZbaLHTT46LIazKxrFrgq/NblcZr8J+3iuJgeY9r+Q0N9ayFrLRJ
	 PPvh3EXY0dZGTh0XGvzrXU1BKbX8f064LSxvXBgZXK8BFdea8K1zUNvbJo0KF3W3mG
	 TUOua6yTLBv3vrLK9GhRF1a2fdtEhy11ky0xdnJvll3k/ckKLTvZPoAOa/jRbEmIW5
	 QiNfiAnwzjFizeaGgaZZATdZYGL+FF1Gc71E+FMgmUvhyKgvEhKksgnN/eRTEEvdLP
	 ibntPoDB3gzsYv1CJF9tqIS2Ip+9maqS+5Bo9x1BVZmixARdAIc/bfYgHiAWikQC3F
	 PUldRQsJkbK9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/49] perf python: Clean up pylint warnings in
 ilist.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-4-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:26:07 +0000
Message-Id: <20260923182608.4758E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace bare 'except:' clauses (pylint W0702: bare-except) in ilist.py
> with specific exception tuples (OSError, ValueError, RuntimeError,
> TypeError, KeyError) and use a safe '.get("name", "")' sort key in
> IListApp.compose() so that ilist.py passes pylint without warning
> suppression comments and handles unnamed PMU events gracefully.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D3

