Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184C3AAF6D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561228; cv=none; b=JYSb7Ncx5pCCXPIjjGauVrpBSc75CrazjkUGe3Q06TnV+5x3viVLEe12kT/1WQC1uowaFVA3UmuvWcXeYj+j3YB8yCpQKo6gRorsVFOIYKFioJwbfUnVdwUPXuDopLPIPjEMEjtFImFP0+oQznhQSPciw3Ln2fkodyorh9hyFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561228; c=relaxed/simple;
	bh=A57qZ5LJA8716POGw8LhSIHrqvbIYNZD7NXixYvWR5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=imL9t21J5RqLYt4rrw5twWuMl2lSVO50UGedE+i6VDwNFV1Ak2fAmVpVzd1mlEw7ZRac6XmJ+W3iKU40CJJKk0LUL8ByQ5Z5xcS0bbQqSRqb9DM8DVIHUm8G05rTrDrWw1hsmDqi3+dOzDsz1xXtgpNvzwcKdbn+8XC2IQx1X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvVcQrlI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvVcQrlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B171F00A3A;
	Mon, 24 Aug 2026 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561224;
	bh=A57qZ5LJA8716POGw8LhSIHrqvbIYNZD7NXixYvWR5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvVcQrlIV15yhGc/AgxGaB6Ctu8jJDDGRfhdRz2Lhbh3VPMvYglQFfqQSU3sy4Dm0
	 U7n6F1pPP4sdjTtQyBx5ukmrP57yi0/la3m0rdm//YHjkWZUPlM4SJEAndT8nx5kTJ
	 rEpRfgShCMaRT6vKPxCGCspxBaHawpiWLRHzeTPhBLW0lOMsLJUgnxOD6UPq8j+e2/
	 bcY8JqQ3sopUIKAO00iSyB5i17GniJDlbzGa9AWd5suvUm/1wZz4lMqLlvSlS4kOqu
	 mrGGJI7TbUSL4aI9c3etF/dzfczLgLK2O12uIWPUgJ5pDlmDNSohwNuRYxEWpr+wP1
	 +kzEETVCQQtmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 08/23] perf: Move and enhance
 has_extended_regs() for arch-specific use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-9-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:47:04 +0000
Message-Id: <20260824084704.A0B171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Kan Liang <kan.liang@linux.intel.com>
>=20
> Move has_extended_regs() to include/linux/perf_event.h so it can be used
> by arch-specific code.
>=20
> While moving it, enhance the check logic and rename it to
> event_has_extended_regs() to match existing perf event helper naming.
>=20
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D8

