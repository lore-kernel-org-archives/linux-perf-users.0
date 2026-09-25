Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F2313E2C
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349235; cv=none; b=LT2lvs6uZSFZMx9AitdmvQ9NCTVpZUFOuvvp3C2vflqngU1ZHD5IieXhNA3DFsdFnVmIl274rUAfgMDNU39dLuJyF/xAhARCz3FmfS8fjkp1hyHmrnkgZc4nKfGOy+AsEdUf1kRWl0g4NQMnHE7CcYOMWINJpBuUehZ8x213Ils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349235; c=relaxed/simple;
	bh=b5N43tD8tk1osNIB/VDFIBGmt75Evvx56HFaEvO51BE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IyroVbsdXq0z1QXZh3zmBuDwGYD0X+A8yckYUDMVa/kYIc2F2xIP0r4Q8Fl4/CgHcpVvKAzfl9q6Xh1gYxzYjtSzPLriopb/gUkUaaCLmJtkbCovdBeaP0mSzpQsxmL5NLfwF64bc9miXZ5ki0QJ1Vg+p1DPy8uMYu3XpGmT0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+107dF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+107dF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59001F00893;
	Fri, 25 Sep 2026 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349226;
	bh=b5N43tD8tk1osNIB/VDFIBGmt75Evvx56HFaEvO51BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+107dF/qEEhPnPveDQmr4XMvBERe4PDeJ/7wqyEe12jey/8tkjpDtrsp3wgORmpB
	 WfddIlDSNRFaCDFyaEkg8h4uWAPE2Y+MHv08AskJUkxad6lx9/gNIW8Va3c+WpPn8U
	 f53l7CPc8YaOtGOUyQ04GRQPrizbvoelSu0DGRdBWxUW08jhj7c64Og/AaJxUXodGn
	 ysu+NWR49nZzHS8erp3ENf8RQacUbUE9zxcQZ9ieOMFWjwxZtHLzbz22/TZTbD23wg
	 kkdPqlotXgvudPnn3azDEWZwETgbawrmQ50qGQ5qcF3Fc7ZwUMm9huI/hNQg4xkafx
	 iVPA21E/qJLIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf dwarf-aux: Bound the type chases for broken
 debug info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-2-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:13:46 +0000
Message-Id: <20260925151346.B59001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A DIE parsed at an offset that is not the start of a DIE can have a
> DW_AT_type that refers back to itself, making the typedef/qualifier
> chases in die_get_real_type(), die_get_pointer_type() and
> die_get_typename_from_type() spin forever; 'perf report -s type' did
> that on the dwz compressed debug info of zlib-ng (libz.so.1).
>=20
> No sane typedef/qualifier chain is 32 DIEs long, so give up on the type
> with a pr_debug instead of hanging.
>=20
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D1

