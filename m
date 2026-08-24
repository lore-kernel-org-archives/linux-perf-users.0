Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF336C0AC
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561660; cv=none; b=cXoG4HSDcarQKAcmGhGr7JuFnKBhdDk41ZOzR+Jyu+EbALBqa+IUDru82tnQunz4EvwFqUWdT1YwpTcA2kfveu5ZFsruYGvpy0N+CPnE4se49kwXcEXgIHtMJzyJJABcEMoC3D8+8iKDdMGbIcSnVRlrK98qiUb6IOKVCnFb5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561660; c=relaxed/simple;
	bh=Jy5A4ofDK2PAKOEaw75j/Qv6W8mTxClNSA9OS/+IRfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=la8ZrEyuE97Tw9vu2VpdZboP8C72QNmv5qrNRFQtRXyXqZVDxO+OjHZ+qlk8nKYyg8pTS+dNQ9JpE8DRyn9kwPYkXcwF+U53jPSeoNAYcS8XhXRW35pUAtYlIQoyLIBleXYPxDUoagO5gNdR+cM9uOoU/HiABuuGfxRGcS/wL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G62wgfof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G62wgfof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D711F000E9;
	Mon, 24 Aug 2026 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561658;
	bh=Jy5A4ofDK2PAKOEaw75j/Qv6W8mTxClNSA9OS/+IRfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G62wgfofr7ZqakTrq3WK8jpBxi/8OFITnKDvcvbqrDkzT8ZEbEGAMR1VxOSrU9ktZ
	 N49h76dtlYot937pWZNC/SB/ZPdRk0kmcbvY8+iQmHv/dfoHeSi4OGdhXz7iByRg56
	 ZCG6QClqb3uLC/An6yKE64HASuQL39fU0VmotNEoHvliwi14qgRiQtcNVfV0qV0ONj
	 iKPPEXwFdmKo+l1IuozuptEcfnF3NM62sKl7TX9trX9hBuz1sQoYEXxsz43XXZFypY
	 BA2ShhnRU7xNp/n7YN/htJzZA148Tioak5dVDw9zaehmuSTwRO9dfGrqJG3mKA3aGK
	 Rd3xjzLKUxDTg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 05/23] perf/x86: Use x86_perf_regs in NMI
 handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-6-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:54:18 +0000
Message-Id: <20260824085418.D4D711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Support for sampling additional register state in NMI context
> (e.g. vector registers and SSP) requires an x86-specific register
> container. The generic pt_regs structure cannot represent all of
> the required x86 register data, so switch x86 NMI handlers to
> x86_perf_regs.
>=20
> pt_regs is still passed to x86_pmu_handle_irq(), so there is no
> functional change to existing handling.
>=20
> AMD IBS NMI handling does not use x86_pmu_handle_irq(), so this
> conversion does not apply to IBS. IBS support for extended register
> sampling can be added separately in follow-up patches.
>=20
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D5

