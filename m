Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB74A6893
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716439; cv=none; b=MS9vU4sUh4Pwm8sOIK7vhLn2ZbP+oLyfWNLBbAEZQ5uTjXO++Zx0YtQ2pGe29x2WTNggT2npoopPQr3PvYLxEu+4agheZopCxxWzclIlLW1WRDnfC61h4x0LZ1VChW/Y+3aDjk+ZbmarlC3cy741YPfk6WBz10JX4dJ73qfK5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716439; c=relaxed/simple;
	bh=3KG3u7fMa4xb0AL6QaXWckeo6oLImwPNXth1QgQNYnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6CCE1XiS6Aj2PmdLWZJETpKYfIBP76HQw8qFhatQ8MeWS8PlUSkqVBNi2xPWv+GdbF1++O4nq70IHDEqy5wqYK791ZB1zC9r4R56ZelafwUv1/PM3GZlUI+Ju5w5TmNhcvGyHvYaBQ5tgtsU4CcGmYXwXQF3/z8utAeVlHqUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heNGE6nr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heNGE6nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417651F000FF;
	Fri, 18 Sep 2026 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716406;
	bh=3KG3u7fMa4xb0AL6QaXWckeo6oLImwPNXth1QgQNYnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=heNGE6nrxoRI//JkYY7APigvgBFLfMSrV3OpuR7Q0sJh3PriBXH9JQp5qbmbM/GRm
	 d4y8KygWOMTjU9LJgFcfkh+QNFADMBqyY5S9gcKRz7p8kmJQqnZ2I1+rxPQ4+bvUXR
	 2j108Fo6PMClqRNIz4ve0iIaqC/6HzXf9GudaYS6Rxjx8/OjbG/Ff5H678XkBFB1E4
	 Uc3V3l2OS+9FZ4V35zJoxvInAHXjFjuJGwdfLz4jQZYmaug3wZwHt09yq/lz+S7wVF
	 ej+KpOOHqVQJhLUbtx05ShUys3bJ4aEdcjTHaoDIffj/5QJKmB1HvIlf3BIluMDaLz
	 t1DnRxIp1u1pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/2] iommu/riscv: create a auxiliary device for HPM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918072027.639239-3-zong.li@sifive.com>
References: <20260918072027.639239-1-zong.li@sifive.com>
 <20260918072027.639239-3-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 07:26:45 +0000
Message-Id: <20260918072646.417651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>=20
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918072027.6392=
39-1-zong.li@sifive.com?part=3D2

