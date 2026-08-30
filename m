Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE113BB100;
	Sun, 30 Aug 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101170; cv=none; b=S5Jm2d2qgspV91b9IHGt3E1QddHIm2tI9JGKAWLElJcnwEiZuyeA4P3+JXnUDxbipK1mrxZPjncq3OI6bWCDkfPlRij8mIwcj2bDdlymlRY0fqyCtPXiS9v52szBbeViVFqjYAUdxAuK/cIWEvx+bj8yyG/76Cq9nrA1gJu7mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101170; c=relaxed/simple;
	bh=JIQ7yA1cJiTWrASGik0/XqglZUICw2/uJ+Y0A5McqmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPPFRO9pjJpIhBI8Udi1OAb5PSJdX+WT3fpyLWLz/AzAECmnnXBplFkyj8iGz+lKUM42NG12L0l+HE2Wq5BB5tnivTPKsopIxpL27Hq3sYR+U9XCJw9FpwkQ5xdBrxQW8gpzaqRe2Z9eiBRdXtVLJ6XqfBPABg9bSXvr4bkFIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHKlD5nV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHKlD5nV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A401F000E9;
	Sun, 30 Aug 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101165;
	bh=JIQ7yA1cJiTWrASGik0/XqglZUICw2/uJ+Y0A5McqmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHKlD5nV7d/Ude/4INL8CftxakhWnbNtp+Dw9dhGxoQUy0FLwgin+RsOLhricqr7l
	 tER6tbu0Hw9DxhkjX7yoX4uBNXVFTvfaRaIBVHkO5JofXPBevyAbCAScuOBjMU1hTA
	 eF/6Sdy+8Oop8YVRoOH1rAdR7sC4tEWBCwAkIIk1ZYDHwZAntJyZznpV12z2bgnzCC
	 n0VREBbvEkuJRuPYpRpnbLaq2oiU7Fn9sIdgZNy9A4vDAIcJHTa7YMCbTQgUGJqE7D
	 usBF4PhrfmXFpfq5q/mwD8r/luWEuY2a0VQyg0nmj2AgjCop0PCcMjbkSmrsjJgGzy
	 qMorLlLWyrfkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 14/14] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810016587.64882.16422588995601250604.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810016587.64882.16422588995601250604.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:46:04 +0000
Message-Id: <20260830144605.49A401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow set_wprobe trigger to use BTF struct offset resolution to specify
> the target address field.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D14

