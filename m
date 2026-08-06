Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666BE384CCB;
	Thu,  6 Aug 2026 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036334; cv=none; b=stcPVmNZOad4Zj+PnMz3yalm5UcO+fUgIqHSrGM8ide1V+ZwmjJetYlPXPn/4bYC1PcbmcMvrf3x7pP7d0vKM7jS0pAjApEc5GwzdcK/ONSxbstZ2wrExTDtrleosKYSHLAyAjLXG6YnOi72iS54S6ze0frGGPH7sW5EVGStQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036334; c=relaxed/simple;
	bh=l3zSn6K90CqOuEnFylWRC5LRf4edRjG5GKRQma8CN3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtzUWcwNIjAVgw6I1WtSwPAaUNZldBLGP1llpBiOwtD9lra77nUL/DCY2xcIG9JS2pCv8j9+6Sr3MUxvWEj1vGs/TUchzfoBIPd5d84sMnBGdP6jKiQSn37/wWN0tjzeBSI2M0eHOdK7CfYsWbWzDxmY5SOaum8iZBqx9h+TIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ckpMAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ckpMAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9481F000E9;
	Thu,  6 Aug 2026 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036332;
	bh=ZU0VrTV4GLDlCfx7g+a3UzwLYWGbzU9Cafj3dXrmRs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6ckpMARmovzb8GA7jcN41tiAxs6P02GoIqR/93Jx+k472VjftW/vJBilnwhKIho8
	 1b3CHjckp2tdT3Oj4xUoVj/PbgSR3Bmf8bVRS+JFjxdp70v8DHvUSyl3MF6E7v6jWb
	 sZy8rMz08u6jDcr67Yrfcf1GqmNBxH9BC8IizSQ2Qgv4i4I47ttwMtP8U+bnmtXAHl
	 sBnvuY6caeKLEuLSECNC0gf4sCEdpT30bJn67DZ7v3PwSh9tkPpaIjP3kk8JB3Y+xN
	 VdlrO7oUo81la9VxR3J6oxu+mefjLW6fEEUyDpayd3HB828y8GAr+sal+IidJAPM/g
	 XOyYi5eBCmbwA==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Li <Frank.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Yury Norov <ynorov@nvidia.com>,
	Ma Ke <make24@iscas.ac.cn>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Pan Chuang <panchuang@vivo.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/3] perf: Remove redundant error messages on IRQ request failure
Date: Thu,  6 Aug 2026 18:11:42 +0100
Message-ID: <178585020446.3647840.3969322133081891560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717103123.34887-1-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Jul 2026 18:31:16 +0800, Pan Chuang wrote:
> devm_request_threaded_irq() and devm_request_any_context_irq()
> automatically log detailed error messages on failure via
> the devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/3] perf: Remove redundant dev_err()/dev_err_probe()
      https://git.kernel.org/arm64/c/a2d0c34f6dc0
[2/3] perf: arm_cspmu: Remove redundant dev_err()
      https://git.kernel.org/arm64/c/3bee2a4d210b
[3/3] drivers/perf: hisi: Remove redundant dev_err()/dev_err_probe()
      https://git.kernel.org/arm64/c/5f254ed7149e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
