Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288F2FFDEA;
	Tue, 22 Sep 2026 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051731; cv=none; b=Ei2zj+z1BdI3nGhZBO2CACq7hGxG88n7wmpEOXLYmxIVGGWrcpgMv3r5x4HFodmR+k+LkbAqvyu1vHulL92dtUVHPbHOxQEJeZrtlR73NIsoS7XNVFMLSGudIpgrzR2gJw3WfbNQ8B2ncvLuAB5m+xVh1BGR8TXLXK8jS8wyya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051731; c=relaxed/simple;
	bh=+t93XiSouGtkK7atKnZQoivEePbV8JVFGl007Gu0Uzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S9S/PyLMZqwMuPgF2NNOD4VZgOndCkaL/zGfQRQKKE1Bpz/pK06be323sraGQfQ8uMUwgoFbhBfqfcDkX5fBjjPK6krx1W1O46ANNm0hBlUy0OeheXWQZAM8GGkueigeG1GdQzX3PFdcoCydx28+VRESXWpGRaWlmVsh3bYcCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8UwMKqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8UwMKqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B021F000FF;
	Tue, 22 Sep 2026 04:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051730;
	bh=+t93XiSouGtkK7atKnZQoivEePbV8JVFGl007Gu0Uzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8UwMKqP2prdtgbCFKgr4jycz6wExwq0amNNkAmxS2sryPKSDd2wDIL2IiLAWIh6p
	 j/CGuukPZX/pJtTEBinolLrDts8Y0P9jRteo+EdoQIHFc+ZUy2PwxfG3XHSbyhCLW1
	 MQvXH/bM8YzduFKs8GfSUHYaiPt8VTAFYSNMXUKMgIP+RL7QJqsGR47TN7YwNEPIhQ
	 0gv6Wa5fP6BAxqqPjDK3Vbjk482kPBznO7ExVOYxk8CrlfNMlDVYsCgIWZ6tVO7TFW
	 uquRoWd58szT22L+NVlSdBlTHXHOSk8q4KRFurYRB1gTrr/1Z9NY1KJvO5F1sbcDCB
	 /1h1VNENRAsOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/13] HWBP: Add modify_local_hw_breakpoint_addr()
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: kvm@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179005114295.388919.7866464354733590848.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005114295.388919.7866464354733590848.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:35:29 +0000
Message-Id: <20260922043529.E5B021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add modify_local_hw_breakpoint_addr() to update only the watched
> address of an installed hardware breakpoint on the local CPU without
> releasing and reserving its hardware slot. This is available when the
> architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.
>=20
> The caller must provide an installed local event and a valid address,
> and update other CPUs separately.
>=20
> Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf9=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D5

