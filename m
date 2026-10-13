Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C75111A4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898720; cv=none; b=l3wTuNWslUyOD+nvWWLmWc8ojId3B66X/m1BW7pan+GbSzhB9eZ06UQtiPZPz5fAifXum2JwFT5Jeuc4n7xbPJ4Xza8LVIM323DmN4/BoZ79pZ3eWn8qazrXToh6ATJh9j3G38LUtqq497FYV9r2c4Jth4MxNOC3l+5RUn7J+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898720; c=relaxed/simple;
	bh=bToorqi+il41P6bp3e0ejNeT4xFYu+nbRjmhjegzx2Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aGuMH1U2jkwvNY3fa0tCV0yzmosX61aLzux1tiBUoVmGxMx/evr4YQX+6bULDhs+WGdncaTrBcGUlD12vUx71cFzexsjuAATg9pXLXQZJ6P6ezVUnzPbBwVzzae3m3WNnk81WchSXOe2Gsw31Z/+sKEkZZBdro4G1NBtVt8heC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsfBqtxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsfBqtxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F193F1F000FF;
	Tue, 13 Oct 2026 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898719;
	bh=EaLxKHKzKrrycim4y0DKeiCYq3gAbX0MfiD6rkAYvGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BsfBqtxOdP3R+6YhxIRzx9aw84N4wJ35h+FGhWSZM6fugmj5m9x7s3LyH2bT8V44n
	 9+l/bwLGsXgEG/+oo03fxjIB01xPFtQJRIlkUPlfJyAAlttmB8s1jUnlV49huuz8Lx
	 ZhGHWsxfPS2t/CsY74z8z0OMLI38zrZwfJtkYqHIzBZ+S5GoWzpU94hv+2o8syLg4T
	 0OtGJyAXeHUTEIMgt4FT2Nd7FAaZohGI08yjSTdBwQ0WzA1niOKqKlIyjWrBBQEJeK
	 FoYAIW02LCE9FOxbUWEV+lT9pX+pht4Mvd7ciGJ4pcq+RUEFIaWNGxzHvJHPR6dIgF
	 kC3u78O/6NKOQ==
Message-ID: <sashiko-outbox-169833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/15] perf annotate-arm64: Support load instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <e5891f8bef0563681bf49300cef50dd66e3e78ca.1791629326.git.wutengda@huaweicloud.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <e5891f8bef0563681bf49300cef50dd66e3e78ca.1791629326.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:38:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Extend update_insn_state_arm64() to handle load instructions, tracking
> register state changes when data is loaded from memory to registers.
>=20
> Two main categories are considered: standard load (e.g, ldr variants)
> and load pair (ldp), for example:
>=20
>   ldr dst, [src, #imm]
>   ldp dst1, dst2, [src, #imm]
>=20
> For data type propagation, a load pair can be treated as two standard
> loads combined, first loading dst1 and then dst2. The difference is
> that when loading dst2, an additional memory spacing 'mem_spacing' after
> the first load must be added. This mem_spacing can be derived from the
> instruction mnemonic and the size of the dst register. Each load operation
> is handled by introducing propagate_load_reg_state().
> [ ... ]
>   final result: type=3D'struct task_struct'
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791629326.gi=
t.wutengda@huaweicloud.com?part=3D5

