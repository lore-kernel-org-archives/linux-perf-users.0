Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486720;
	b=j2Q3nYq20kYfXXqL363FOtsnhG+fSd0NzV48rCOPSLXlcW++wIEeaCPdP7o3P5qFeDUq
	 kh6bJDPhsgwUWXxaYrJME8m0s/zyVVmVhq0uBqLVNcF8DpJvQBg5+ilvxyl9cThVRCTrz
	 KL4IcHvFPh2EE0PCqa6Ft4haUSqz2lBeXaxGHArYcFaLKG5MptAKLsxS9NYbM6vtr6NBO
	 rx0D0NvVEZDoSBjsvpt2nuM2J0PCR7S8JDksMcuN+tUYhaYNN95Qr/iDWNGYg/YyuecW9
	 DVK0JBI39Ac7imKR9TZ2CRY8cGCauJgiPN2WRstrS5AwNRwoLwLMyffIQFj1yp9wsAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uk+rjNsEtB9Iw809/X2l6yUZsjvtbN5+ezAieSIyA8A=;
	b=N7/gHW9Zhb/zqqMjKZnioS6ED3dtGZzQOnAYAUOzDfBlxq0kDTC0uUelN9wnExWu/6Bz
	 HwGia69DqnouhrTf2okznGTpsCCXa/A1BLZp3QXX8/8caFY9637/ONZPK3hh2ij0IZRFT
	 AMctz+cXlrwIsxP8oc9Ac1T6zeaYrYchae0Ihll2ayQlwh5Z22BOOWkn0iHplng7Cij7l
	 QgnDxAONhl2YdcvifRSFNrl1Yl0oWsXu20fkdfIEfc/F67y4TFEyJ4fbxtdglRbdOVAx7
	 8pa82GseQiOidsUG+rxeADAXBYzuMYVGc/eUsfrD4IjNQl9ZaeZcLb9S08vpKSSHryw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dC/U6bsQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42A606A333
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dC/U6bsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5138F1F00A09;
	Thu, 12 Nov 2026 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486720;
	bh=uk+rjNsEtB9Iw809/X2l6yUZsjvtbN5+ezAieSIyA8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dC/U6bsQlvsUwAQqhDomXahTjeKkclbyW5uvKRR3KuoX7FfqhTsY8lJYlrlZgs52D
	 Sx58kKuyAdtk0u2wOykh7NbZ/k9NGQ6mOArFSsNxaQDUlIdFKSDvPMCA71O1WJyR3m
	 7hOAma0WSdqdBU+qQIS/nXuJYx54V7mHfUB84OlgUeDn7Hk257/GP7760SnKeqov9j
	 n1EI6LqAA92cDk/yW6XfxfUfNsEP+VJGoDbd+on9q8pYmsfqgQS5PN4hYNSrEgxFMg
	 L0dkaC1C/tBIMXU5fIplgkfne6rlJkh1qt4AWZdv++OG8YjMVOSuMPlFa+Do2jvAhK
	 j+5yjnKEqK6gA==
Message-ID: <sashiko-outbox-211090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] MIPS: CM: export the symbols needed to access
 the GCRs from a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-3-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-3-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:31:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Allow modules to use the GCR and CPC accessors from asm/mips-cm.h and
> asm/mips-cpc.h:
>=20
> - mips_gcr_base and mips_cpc_base are the mapped register blocks;
> - the CPS_ACCESSOR macros consult mips_cm_is64 on every 64-bit register
>   access;
> - mips_cm_lock_other() / mips_cm_unlock_other() are the only way to
>   reach the registers of another cluster through the redirect block.
>=20
> This is a prerequisite for building the CM3 PMU driver as a module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D3

