Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB5367F31
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783508; cv=none; b=LNeq13K1aw8J24jrtiVFmRXcg5N+f4GjMGdRDQzghGxbuaPRvuqbYwYiR32hy32/tP6vIcP0025vxWTSZ4GdURbObyJcQvEtuOzzaSPfUfGWnvsXAfHiVpMkHUeXsUKbuTRFr3XRD5OVGPqRMuvYwN9ABMgYgsS1P0MbqzqHTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783508; c=relaxed/simple;
	bh=U/Gug9/mJM3Em4YkvJjW/JiEfUg9Nh7ZJBeZlS7C7go=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KBIL+FBEO2cqygr1iR7gC0V36y2f8X3wrNai/zPDPFHKmaqGUvqB0rOKL+NhlPOG2g6Mg+nyAE0J4G70HPbRVlR1675tZftdfyGoefTYR6w6UKfkTQEsRCDf3eZuJhkMekOaVqt/Jiw21El9v5UaoUyq1nqGbUFcf6PQMWgNBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMsbDN+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMsbDN+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5042B1F0089C;
	Mon, 12 Oct 2026 05:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783507;
	bh=1LZHk0CtQeLfZCxHr/PgAnuvqWAZdFlIv+Aju7yZzhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cMsbDN+hINIaFGptRpiQtIeKWOZQdYQjtt93eG24NUHIUS/vVCFveXbR5jR5SuJ6K
	 I6dUxkz8j4rjdAE/3BaOA7DFQR7KuNiTNNSDVfNuBgp47u+kaDiWxxN2bkz8XZRFs4
	 DrfunWRaSahJCshD3X1RgTZCk4AzXrMsE7+O9ovxFDo5m3PP/+4jZrJnggz8fT7Jgk
	 +ZpiMmfjxMUPz+rJI22peFGs6nY+h3gs0I51EhIxP9d2vZ7e2aYkS9s9HRvIkHG2KX
	 lhoVyaNXfFJBE+29WJc9ilvnJ8bx/X9n+rhW5HqYbORjDIR3GTF0SeAT0w9/rST2qd
	 /lTY3d6lHha8A==
Message-ID: <sashiko-outbox-167682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] perf symbol: Update symtab type of vmlinux
 from build-id cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-4-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:38:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently dso__load_vmlinux() sets both binary type and symtab type to
> VMLINUX.  To precisely track the symtab type of the kernel dso, update
> the type to build-id cache if it's loaded from there.  It won't have
> any functional difference though.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D3

