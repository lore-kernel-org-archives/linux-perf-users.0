Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B333493D3D
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992995; cv=none; b=sh2fA5sEfpXGYeG0JVwCY1OLJP9IyZRKphkIe7LA83yq7wauxi7Bp7782I6e5nVi6vF+I4D/SVO4jwUihwOj7xbg3NZyBzGFrhPC8R8pDszavZj/WMDIK8quNgjM0RP13Rhg8VJNOns0jH/KUT0C4Riq//js5y5GhtM6wlV4V1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992995; c=relaxed/simple;
	bh=5MRe6KGtL/LOfEPtPHOyrloM44EZgHinBf7rUXHkY2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NijJVl/UQ2Lq99q4HVWqglo6aT7nKAlktdEzVDWuNrXMqgMMIxU0hdpQ6Xz90CN91DN/mf+AjRI9RseRIT7i2QZrX5e28rs4yUjnMgKYlZY9/+bTLgat22/B2ACl0gmn+Jhs5zvk7loRWIj5QVog9qnISu1pd07C7uM9A1fSwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+qF6qxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+qF6qxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78211F000FF;
	Wed,  9 Sep 2026 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788992983;
	bh=5MRe6KGtL/LOfEPtPHOyrloM44EZgHinBf7rUXHkY2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+qF6qxk97vSLazA9n9lL3TNBZh1/CEcU2OcgSxfhA5zlsHRxj12mvLwGIIZsnCs7
	 qluBrYzr+VnnQ4K5TTsYV6LFOEJ6u8qa1U+YYffqSgOrRvhlO1bE0K3mPge4/gGkB7
	 TNxzpI9PzGD6zxkrpLrQQe/oh8g/st3ulXF8wQ0zNXd0MoY5hz6PZp6+ZKIA21iYVf
	 UPnHkPJwFsdg7nBtPDwC4wV3iTRdzbLSazM3pOfQegyXzayOhA7HMXEkz4NM8N35xk
	 CYLCUGFaYcjgz8TNGSV/TORh4oRIjM8h6RrWHuxpeopZwHdExdzT37aMmvKdzqvDUW
	 TwRkHTdwSW3Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf test x86: Fix missing __msan_unpoison
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909222048.2138387-1-irogers@google.com>
References: <20260909222048.2138387-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 22:29:43 +0000
Message-Id: <20260909222943.B78211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> __msan_unpoison may need the sanitizer header including for its
> definition.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909222048.2138=
387-1-irogers@google.com?part=3D1

