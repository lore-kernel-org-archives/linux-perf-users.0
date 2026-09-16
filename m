Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A83A9002
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522812; cv=none; b=StrJcjHOG3DlZQAeoCx8rbKgSZynPKetqecmdG4cPz0kkxPRtI/MqZnU2OusQROcKETfldl1O1mkbFAYlmhCzuJnsv5ZeghuAr6V80usR0IJIvQ/N/Hk4SnsDV52uqlJdTMUaK4iSAcZ7shYkb8eno4yJ0d4wPelKrbXSFbz7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522812; c=relaxed/simple;
	bh=9pAVv+P8JrrkzN7ENItspCBddJt54NCHEY/Q8ysESkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iDfHIfa1w7YqF7s+I3LnGcTay1z11yVuVhERDc3qyE4B75gO/PAKlAC7tq5fWI207zUlIgSagI80aGks+MhuxqBkAJA99Xo8PYJsN+8Dk/mommVwSa9swG+gMIGK1BgKbC+abnu9Obuo2eioYVuY0nxVpQDXV7CF8gmTNG2ly8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF2DCLCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF2DCLCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEED91F00893;
	Wed, 16 Sep 2026 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522800;
	bh=WGAWh43GDRPoYeEIrLS8u2PuGOn3eEqbuSnbxNURj9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SF2DCLCjOiX0rhd3OIbLiR/jXtETXisvsl77jYqCQq1J1B+seSZlEqear7m3j6YE6
	 ZOMcn76k/x9WjVPlHr+LoiOLOngi3bbnMfz5Jb7xOO6iHe3qMdDuADGECbMj6NFjcZ
	 FOmQZJIwft3clfJM5ulZNP+FEdZe+8H6+khBttsIcsQjfzUvCm/Ef/pYG0qkoSxpg2
	 jm3IZFwYejtYNIGHKhbrqoVPk15CEnvO4F8t+7DdaYn0wjFdGcD8b7D2UXP8bH/Sz3
	 z9SYMeryvosyvR2AAR6Ehp3xLLtSVfLEinJWPcjz0CKAFnuju/7/vJhWYql3tNXJnC
	 sbT2dQGhCyI7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/26] perf annotate-arm64: Generalize
 arm64_mov__parse to support more instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <bf9f2a3f398f475de1479399e8aa531b10d44961.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <bf9f2a3f398f475de1479399e8aa531b10d44961.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:39:59 +0000
Message-Id: <20260916013959.EEED91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> As the default parser for arm64 instructions, arm64_mov__parse()
> currently only supports parsing instructions with the 'addr <symbol>'
> suffix. Other instructions are not supported, causing a lack of
> source and target information for most regular instructions.
>=20
> Generalize arm64_mov__parse to extend its parsing capabilities:
> 1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
> 2. Utilize arm64__check_multi_regs() to identify if source and
>    target contain multiple registers.
> 3. Maintain backward compatibility for instructions containing the
>    'addr <symbol>' suffix.
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D3

