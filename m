Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5E549363
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652572; cv=none; b=R0OUmIm8XfOp1BM2oG8DDFQfjFAz3gRJNw1k4a2KMIZG+84rnUsWOnCM3sKgTSInjnvQL32OMx8O2jFo9m90bvVIvLmDPRupQO/PkxU1mkvpUHEGxW1SZQ04fEYULZMWfweIYVCkD2Rn/EXp1zjYf6tMCiHQGBKCbrwPaWg/bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652572; c=relaxed/simple;
	bh=fuKnaDvEduGhcNs5kfJQlvNcb0P60mQc9cJ9cN6WRPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AR9nspQJhCh6haDnweWnmMEyOBSdAEvY4dXgFQrcNFby4jk2aox2bo+2y/kZlTnWrvgh08gtKulWUw4OJ2W+KmAJ6cMEa6WFcxfje7Q6JeK0PE7U3DHgiKQsz2qbQezDa4xIyGsesY7MROcQhwVb6RBBrAG+ra8nLkXhyTjvlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9pA6JMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9pA6JMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DE1F000FF;
	Thu, 17 Sep 2026 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652559;
	bh=C4lyoudTCfOHg9on0gZwh9EICfkFeXCfHES8WmlPMf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9pA6JMQysW+kPXPLdKmplmOiJKVirbu2LdHVkyVb/9IiFLXrg6rrnfOdm8MuA7YE
	 CKhPEPBCEfNw2pad9Wew3sRvY7rRdqfQya84LCPHVnHCkbV68YsueTS9zY3P5t2sW7
	 DG2mDrWPuQWA9WFCwilYxTgGEi5CzF69g6XLxTQibhYtwaL3txYn+SWNKtQm6yEIaV
	 jdXKymrTB7QczWWwfILfFbSjriww26y//DQYVXrkuxizEBdoCdMJ5v7G1IFps15GmT
	 81lpgrO6os7jb8hNxcdIR6VAnbPw+xY+RYLaZm3UgPyu6vyvFLHQ1vX7GLfVW/G6SB
	 PVHKYgsvvhpuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in
 dwc_pcie_pmu_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917133241.2153478-1-vulab@iscas.ac.cn>
References: <20260917133241.2153478-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:42:38 +0000
Message-Id: <20260917134238.C87DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> dwc_pcie_pmu_probe() gets a reference to the PCI device with
> pci_get_domain_bus_and_slot(), but returns -ENODEV directly when
> dwc_pcie_des_cap() does not find the RAS DES capability, leaking the
> reference.  The other early returns and the success path drop it.
>=20
> Release the reference on that path as well.
>=20
> Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917133241.2153=
478-1-vulab@iscas.ac.cn?part=3D1

