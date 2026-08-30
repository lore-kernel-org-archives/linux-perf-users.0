Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4243B3BF0;
	Sun, 30 Aug 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100669; cv=none; b=YPS7PssWHx2/Ydw3/LCLy1IQGSyqDqAwaycFmre7bjJERl4ZztWXmHjjcN3FeralIEZ7oFv6f+mYVg1ZnndE3Dcmvk7ANitwzGCGnGyEiihQAN+hnGCSUhX81Ruvb8XiXaFGv1ZaEJwf9Hxyk9PYakDI8jpjOpqTpIZ/ZjI26AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100669; c=relaxed/simple;
	bh=7F8B1NL/WDpcaD9mGBl3GOp30X8BOA7bp6VGWWi+rkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzIRHRrG3Lvc9tV+BWzvEo2kvl1D9b29QHqlGfjn3N30arihU29qs+uNBctE5sbG6kottzvo9R+yQx/jHoSC1q4jrNklPFkSlbEhc4q4ZIkpyxZUGCj0pmcsRGqDGdUrp92AAgQ9elc1Ie4WNciPXUBPALRJFDOmNBDWdh7z3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg03wm53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg03wm53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C0E1F000E9;
	Sun, 30 Aug 2026 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100668;
	bh=7F8B1NL/WDpcaD9mGBl3GOp30X8BOA7bp6VGWWi+rkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vg03wm53SW7lKo7sga9OhCAAGZEC5HSb+PB2eaY9wGYLi6DL4/GIXIUf+xLtq3TZy
	 H7hJAtaGhGiCcyalbo/Q9r1VEC9aKWdhHcgrvEHrUMG8AyLA1+bnxw2QbFfT/n43Gg
	 c1jdn9IV6PQuHfNzVfFEapkLCbsgqIKKe4TD6iYTk7wzVwvMcXy2XkoJgTiZhNDAk6
	 6lYd0bmV8oiVLIc9Rttd4nkawJJNs2Y1lYRlj37hZ/0jDB1+PoAglmDQhujoDjaSmc
	 kAvKYz5FRargdZkdNM59KwWlsY74nmIu83r/G2vMT3o9TFkk66/n23QQikRANsnuVM
	 fKE/vAveGV7dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/14] selftests: tracing: Add syntax testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810012113.64882.5058142196886031547.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810012113.64882.5058142196886031547.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:37:47 +0000
Message-Id: <20260830143748.37C0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add "wprobe_syntax_errors.tc" testcase for testing syntax errors
> of the watch probe events.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D10

