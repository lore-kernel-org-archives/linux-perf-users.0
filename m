Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB573C0A12
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523111; cv=none; b=qxAGTNQBgqtzbGPxoXmbo30UtyK28iec1reseHiLaXPkjbF7c07zBM6OmcX3oP8LHacT4JlY6o315uew4FcLkrahzHbayXL1yCDsmo4ZL3JrPaACW95y+964MQT/GAPKmfgf095OrzVzSMOBjmBDbsUua4a+R2pbMboAD+sG11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523111; c=relaxed/simple;
	bh=vlhaCvm4mgfXrivelncYcZRsqdnlLO7P+PwC4QP7juo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXLqCSa1ds+UE0fWe+VJ8b+YvtzHXDlrv/Haq/GFMuzFxXvrVHE8zfcSXdEQQ4LrjHiiBgROcEL+pfp8FvBcBn0RG5RLCHirVk3XOFUuGSws+y9w4p1es9jjOu6vlmLNCtVG1mXWVaypq2YDZ4/GUnsMrlFppJD7oOQiYQS2Hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuuTlV5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuuTlV5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977111F00893;
	Wed, 16 Sep 2026 01:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523098;
	bh=vlhaCvm4mgfXrivelncYcZRsqdnlLO7P+PwC4QP7juo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MuuTlV5cGewPcRNU0uNRO4wPCudmq8u3UkPqTNYl3D1yDffkF3z43Wv0EYP7U5hE0
	 io/mOtWdDuNQI2oQR7TQFAnHQk6WZn2oTOCWnCJPoGy8e811qyrpYOwhlAm4BjJUiI
	 9TTPYpF7K2axGFYKgk28MUJjCCI/j+R4YaOPJGxFY07PYyJlMQQK4d1a3BTmgasUGs
	 PSppJiyccyKZ3ZGcBmuoUo+qvl4L0JGgvt4Po4QCV/80lvfWI57OaCNSv4JlHNSvAZ
	 Rjq7q9Sm0O7yecvqy6vkm3pO71pBC91f+1GUTmqevBtdYZ7a058+cI50j22uQ6gPrJ
	 qEBBWtJUkuhhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/26] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a492844346e8f61b175c099b48bc94ce275a8b97.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <a492844346e8f61b175c099b48bc94ce275a8b97.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:44:58 +0000
Message-Id: <20260916014458.977111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Assembly syntax for operands varies significantly across different
> architectures, which prevents the operand location (op_loc) parsing
> logic in annotate_get_insn_location() from being directly reused.
>=20
> To simplify the core logic and improve maintainability, move the
> operand parsing inside the for_each_insn_op_loc loop into arch-specific
> extract_op_location callbacks. This refactoring is intended to be a
> cleanup with no functional changes.
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D6

