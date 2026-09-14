Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD48209F43
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351591; cv=none; b=P8x8fZ/dCyil6z9E6yHXiCjvKlgyx4LYdMtoPNjej19CGqmje6RIux5YshHorwF4OtjoL/vdn/aP3gKMDZKUJOojRkHnP+fpxvokVC0lxjkh3GLvY3P8j5q7qgh3Sh4lCvD/yGzLGlDdr5A1LCSSiFxowAPUFfG87T7qB4ifHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351591; c=relaxed/simple;
	bh=pqiNWQpoEvoAwNOpzEgB9npv44q9Hg++1+zzgW36f4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fsMdBjcqNnxmMRY6xfGOaMCRc7LL3MK994ypqUEpgASwoGhjUGr/pTzkEz1AAxfnTGzgJNqTN4RV8zNiK+PiiNnFu+SToSOij6z2xipulx+XVOg+4+vbTSAlrInl+h7S83k0RsmyWKLvIdbKU7RMLkecActOajlj8t4BxHfdcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewh3bLNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewh3bLNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFAD1F000FF;
	Mon, 14 Sep 2026 02:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351589;
	bh=pqiNWQpoEvoAwNOpzEgB9npv44q9Hg++1+zzgW36f4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ewh3bLNxEXK7o1fJcR5V11fMbMuhc3CMJ1/FEb9+GhF2dZMstrfKhF+8QnuKy6irr
	 J111fS/MysJu13orbOXyiXDIlCcIJBenMj5dAp812zRwYRQO/EKlgWS8Spo26/Uq5r
	 bGmS3UwNgPTpjL/UKNjpxsYT37kBAI6TnsCoJ4B06nYrqLbBIZOuXwk8IORYWZlu0S
	 IM7Or5PDkhRD/u6hG+hpxYNshCI9HnhEpvIUEklwbVnqO9AcQGNc7k0E0+TLVY3YJ5
	 f5nfj8dQAI8zlf8ALf4xOIMcHCjUn3AeRjFJM/YsNZt5fmVNvySBa5/zpSvSELP2Be
	 UhFjRDEXKwyIg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 05/10] perf regs: Support x86 eGPRs/SSP sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-6-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:06:28 +0000
Message-Id: <20260914020629.6BFAD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add support for sampling x86 extended GP registers (R16-R31) and the
> shadow stack pointer (SSP) register.
>=20
> The original XMM registers space in sample_regs_user/sample_regs_intr is
> reclaimed to represent the eGPRs and SSP when SIMD registers sampling is
> supported with the new SIMD sampling fields in the perf_event_attr
> structure. This necessitates a way to distinguish which register layout
> is used for the sample_regs_user/sample_regs_intr bitmap.
>=20
> To address this, a new "abi" argument is added to the helpers
> perf_intr_reg_mask(), perf_user_reg_mask(), and perf_reg_name(). When
> "abi & PERF_SAMPLE_REGS_ABI_SIMD" is true, it indicates the eGPRs and SSP
> layout is represented; otherwise, the legacy XMM registers are
> represented.
>=20
> Please note that PERF_SAMPLE_REGS_ABI_SIMD is set by default on platforms
> that support SIMD register sampling, even when no eGPR or SSP register is
> requested (for example, -Iax). As a result, sample_regs_intr and
> sample_regs_usr always use the new GPR layout on platforms with SIMD
> register sampling support.
>=20
> The patch only supports eGPRs and SSP sampling, the complete SIMD
> registers sampling would be supported in the next patch.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D5

