Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65583558202
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062721; cv=none; b=L6lSN3wTafpxzth3t5kvTi6sQcOB8Ie8qLQtJYD28voH8rI43YdNbXkCRTbdGBKOfF4oawmcTXluxm7JG/Qxz5z6CJwvpiuq8UqRlrAcGKvY4mKWOJ7SkXqxaz+faBK7GEwN+Cy4faSSczvFYvXXroXv0QfGzNk34cxkX39VFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062721; c=relaxed/simple;
	bh=aYDDXQQE3p7/dxR73O/fXqBaXDYNVl0KYf6B9h/TlRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzAVgqdUAzk+N5t1ZND1y6ALD9U38qES+Gct1XT41VE3AoWdG3KTG6CJI2HMCf3UFFxUkNN/xkLDSgySmO318h8Z3K2IgtcaLTraz4xLOorYczuonZHewAPk1fTGV/ffff6Lvec0izxkAyl8g/H13kP+NkcGFSNjj9JdyJPv2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3IU97ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3IU97ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C8F1F000FF;
	Thu, 10 Sep 2026 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062711;
	bh=eMDSWFRQlP3nym3CvGe7ivTwuxdjunxcHx71htvXD4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R3IU97raOIJdRd40a30O2vcSLBI9nT9VTruFLTBXKQuY+u5lxq6spj20qWT3uKXZP
	 RCkyBslhTSQkCnANoJa/zU0UEaaz3SQvr3jMcR0abHEDjjDLTNFTQ7QylS8B60DWkW
	 oi31XDpLfio24etuFdH5L8xjnwOaBdfhXjyuQm626pSv5P+/+MeQYl3pZQybgWzb8e
	 IwwUkAxSI48/Mr4FmXr2RyKdZOuHZJddbmJxtQr9Uz4MonlWY3RaIRIRL6EBvoE5yL
	 5Z4KtfHmWuul4GjAgynoih9Kxj++a1XmdiQpUf8fLavuJ/ifyu/m21MFJaC02kl9uP
	 p0NfIlutcdyDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf python: Fix ilist TreeNode string type drift
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910174420.3002597-1-irogers@google.com>
References: <20260910174420.3002597-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:51:51 +0000
Message-Id: <20260910175151.A0C8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The use of PEP 604 union type syntax `int | float` in function p=
arameters breaks runtime compatibility with Python 3.9.
--

commit 79e3c05b8663765b4c4ea91366e2819e32834d75
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Fix ilist TreeNode string type drift

This commit updates Tree type hints across the perf python ilist module to
prevent mypy strictness mismatches. It also addresses minor stylistic issues
reported by mypy, pylint, and Sashiko.

> diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> --- a/tools/perf/python/ilist.py
> +++ b/tools/perf/python/ilist.py
[ ... ]
> @@ -343,31 +343,34 @@ class IListApp(App):
>          if not self.selected or not self.evlist:
>              return
> =20
> -        def update_count(cpu: int, count: int):
> +        def update_count(cpu: int, count: int | float):

[Severity: Medium]
Does this new type hint syntax break compatibility with Python 3.9?

Evaluating the PEP 604 union type syntax int | float as a function parameter
annotation in Python 3.9 (without from __future__ import annotations) raises
a TypeError at runtime.=20

Since Python 3.9 is the minimum supported version for kernel auxiliary
scripts, this will crash the perf userspace tool immediately on startup when
IListApp.on_mount() calls update_counts(), which defines the update_count
inner function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910174420.3002=
597-1-irogers@google.com?part=3D1
