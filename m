Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137354CF7E
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873662; cv=none; b=T1Acha+mff6xP7bu8Ek/7fyG944utc+9VsMD/TfV5iW7FGoUWZ57yMiIGNyFtu0CCRlmxZl0wuAy5TKwkHp7gLy6QKkWROvgvDwiJdstGPSFEkzOo5IY9S26uSwzdSJcHptOaP0nehLNmzEMTO3BjXV96AUU7etorRXOjpiBxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873662; c=relaxed/simple;
	bh=HvbXcBNLn1RNsaXqNg6KjmetDTHdVymR2LAm+N2zbjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fne6tBQ+PaToYLpn31vga97vubHElLd2Yk8WQc4adoyvNCh2xlnoHv6RBSHt4/vlWDJbHG4QGmRZ47WK29D2nkA5PWwWtJjPvXlDREs2Qj5RPQPii5QAkHSlfHpVQAEcpXGMuxLKTa2I9Pi5eNQ4/TgkmuWjb8IEozjxWJvidOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF/K+ZbM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF/K+ZbM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7281F00A3A;
	Tue,  8 Sep 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873661;
	bh=HvbXcBNLn1RNsaXqNg6KjmetDTHdVymR2LAm+N2zbjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HF/K+ZbMIBQ4cq5nzQuZKj4S6INDoiv/ROp7oP5kIiXjAEylXz0IJ8b//UoJyIhY8
	 GIm8YvVqlalLZva+2LbhVmzddW+tiOqgoY7jR/I5dRD1pTPHRaOFAOMFhiQAajZxp/
	 V0xcweZ6NHnmHzEL6fA8rHPWTcugkmseQxWpXG+6IHjnXcwY2pdjV8ofYmNQDX3XmA
	 s77VnC24KzyxMgqTzxtLS0xAaF36QrV64djlUj9k/VxR8QIlrnihsI5yMD5Lfk9wJT
	 hmd0Yy/utCQI2Qp+e62zfqLhTpHmlWkYPNqtUkLfwxO0r707VDnDAPSn0hTaqv6z8j
	 r4eojf22evJug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/26] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a9f1bafb17bc2e2c6152f6e3a0c63b9d72a0e657.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a9f1bafb17bc2e2c6152f6e3a0c63b9d72a0e657.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:20:58 +0000
Message-Id: <20260908132100.EB7281F00A3A@smtp.kernel.org>
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
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D6

