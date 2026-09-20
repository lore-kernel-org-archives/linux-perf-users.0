Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D733B970
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882629; cv=none; b=SzpW3xhw/HuwWsrMytJy6qY32egQrOuNAl03TtFbHd7+ibgww0zx6AXnuLcujR2HVaYX2AjWpxDvLv19uipAMFEIkI+ZB+gAr23rq7bYwpwjgM895isZeQLz6MfnYi1ktgxF06EbvDQuyzGrPOiFa7BT/r7DEGoKNwZiMP8DNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882629; c=relaxed/simple;
	bh=faKbGJLMj1NzYudYDBKXshrRfRi3BJm40wrlqh8o5FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jmqiu+ZE2rzbtrso/BlM8o8yKMHGbBXZESpxZRpv8FwQ7G8rDD+Rz9h21RP+9yzoNrdlu/zeOm8XMEwIiVQPo41xXCxN6Exe0c9+iQLtb1uUZ0I3+QpOW5NDJPJ70bWG5eNIMnq2pM56rdWKWhCbbdP+aFSfp0QvA0chAUM4ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L51d1QOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L51d1QOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC01E1F000FF;
	Sun, 20 Sep 2026 05:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882628;
	bh=TwFWB09Y5ssA+IQciYyF7VqIGDDa/+neEEZ+GtlDRAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L51d1QOHzP8LvkeadqJeGlnacmgQcYU4lB9WtvciGNf+5i2GiwKU3787AxFcUQhFb
	 A+No9a+tWS2wYnR6GZJAAaRop9MjpSZMmOB/prItZ3FQbNbcwOKl1Y6yoC3jDC8Arz
	 cqhiZsioX1y2GhLSy0hltECKWpEEdTnT5y3PAZZ2vobMolEYB3YaEZSz+hngpZY3v4
	 GCg2Bm1lTjqFJBapAgZNbCOE1vJV6Yk3GkIm4vwyoviXMIdM6/XW1lrmyeFFTfKFZk
	 O194E6VhH0M/UyAbS+sSzw9mYW/+BmhxPQ00CzIW8zrg4Mo5HHz+FSL8Bf+qxH8/RZ
	 MeP7VIi2J3SDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 49/49] perf Documentation: Update for standalone
 Python scripts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <406301449627f44bc9b38715677bfbaaa1172078.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <406301449627f44bc9b38715677bfbaaa1172078.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:37:07 +0000
Message-Id: <20260920053707.DC01E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update perf-script documentation to reflect standalone Python script
> execution and the removal of embedded Python and Perl scripting:
> - Remove documentation for the removed -g and -s options and legacy
>   record/report script wrapper modes in perf-script.txt.
> - Remove references to perf-script-perl and delete obsolete
>   perf-script-perl.txt.
> - Rewrite perf-script-python.txt to document writing and running
>   standalone Python scripts using the perf module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D49

