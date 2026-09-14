Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7042DA20;
	Mon, 14 Sep 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399172; cv=none; b=Li+HVH7cPFL22dklT1ZC+SeKySyWCCjs0GQt3GQf0493zy3R+a1kYE/PWEgvaEadoLesOvxwpOF19bzSnGEIUMi5QD0GbsMiehsKi5q3GpTkSX4JUleVTE69gAz2JWuog7M8BlhlfRc+hbPS5iTCzsdfhnLPfxeVOwOHlD1yPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399172; c=relaxed/simple;
	bh=2uJ7BmGhZerhmJSzTQO5c4fpLZMsr00QyHru83U1UBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRMCj3OAq+ZwpnwO+alSC+arJ952QqiHhCJPIwWoqLssI4Lx5K29tXRCwOTbYqvGRrZlyLyQhBbR4Js6J16mj5atbz2R/pj5bVOAeY4mYzHV9aj0YuzDHKAwpd+OUHV3lKiLfIf22gOTkipra4wzvyoCpE3ICCheOLI/qwE0O7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2fm94Bm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2fm94Bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ADB1F000FF;
	Mon, 14 Sep 2026 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399170;
	bh=2uJ7BmGhZerhmJSzTQO5c4fpLZMsr00QyHru83U1UBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2fm94Bme37MJYkuyK508Oh5gSmh67z8J/eJbQKUo4CnRLv9TFF0lqqQfkf8s7sfr
	 yeGV1aEGksJp5YnEGP26S2Wd61nk3OtkoXXXNXbrrw74izGuCQFPeK0CfeYC0YXFcy
	 mX4cuYZmVFp/ScWFnmt3ukjracFeSs6QMf7/fTt5r1gCcWDL4aoTvGzkNFYgmqRz3u
	 N5EUgtHW2WMuTJXhoZi0VC1ZvBIOUl2XU9SSVgEeWxdS7RbnwBSZ3ElFYki3f+v2hz
	 dCVqrpLduY46DV93uq/gERIWph36MxGWtmlBrDPW+/W6jknnISuWMWxGzz/+63bb3b
	 k2DpZhz9/uLnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 13/13] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178939033192.94750.3869705255745304633.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939033192.94750.3869705255745304633.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:19:29 +0000
Message-Id: <20260914151930.52ADB1F000FF@smtp.kernel.org>
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
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D13

