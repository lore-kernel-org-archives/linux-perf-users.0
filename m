Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E733BED5F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148156; cv=none; b=I5sfaje6gGhBSMKJezp71FjzhLNG5ZpZgc7zq+QjKDvcbHeZ+AE+JVMVuvlsdj9tXLd44E78nM/MtMqZF//aN2U0jpo8pvFWzIhBPW1MiUZiAW0Oi2jnA/G5G/QmgjUi90tLzPeiUWw7hjvIMBlRcp119Tn4iSNJZKUGJ1WV5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148156; c=relaxed/simple;
	bh=YmBVIqNCGq8GKCNVZRigxSlK+KDFMlmKsg0XQRPBAWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bH5POj9hBPHE0+jdPZWI0DKE/QPNF1CYI40rV9CNedDUu6Cz0dJ8ClDN+kw625aiZVIolEebmjdgnGJvAcnJ7LWO3ZIw3ykyjm70wcn46/AGbBt1u5mZIGtAjHgsfxrCdATbxZxJkPNtqv4/KqRkMbddFwaN8I9g56QUzNlLzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFPWlHCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFPWlHCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8D61F000FF;
	Wed, 23 Sep 2026 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148154;
	bh=J/BdJDNPr4Ddb24OSA4HP+6OgOoKRlc4c4FFucVpJQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFPWlHCXlhaL/ndeQnj/ZZS7vW0770VpMWRFG6QGPQKhVyzu1B71J0KZx24TKS/7W
	 xs6WJrgyctxOMR5mnb4ajdqvOHbGLsPPCCc44CuTrI8+ex810tiboF3aCEgLAwTdxY
	 e6a5cPlsDlzaAaiRmaD85azr6XeZQLT2WskGP1Py48uSwk0cbkGv9tNfwnqcr7wMN/
	 n8AHbDNMWyrXdtpBPNtviJNPIKAvwjnMox8HX2mSiQ0uwkntQ+mJQKLaQyS91y+p9X
	 kSa6Mx//ZZ/yRA/zAAiNGgnlRB5DQbV1zKsqECL3Xdz+v/CZHSg19+usaW2DOxYhad
	 6MaO8lRv94mSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/23] perf trace: Handle fork and exit directly in
 BPF filter maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8e1a57cf9d14205293000aa5b0508a9849178dfc.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <8e1a57cf9d14205293000aa5b0508a9849178dfc.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:22:34 +0000
Message-Id: <20260923072234.8C8D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Updating target or filtered PIDs in userspace upon processing
> PERF_RECORD_FORK and PERF_RECORD_EXIT events introduces latency between
> event occurrence and userspace BPF map updates. If a newly forked child
> executes system calls before userspace processes PERF_RECORD_FORK, those
> syscalls may be dropped by BPF PID filtering. Conversely, if userspace
> evicts PIDs asynchronously on PERF_RECORD_EXIT, the kernel may recycle a
> PID before userspace processes the exit event, causing the late eviction
> to silently drop a newly created task that received the recycled PID.
>=20
> Address this by attaching BTF-typed raw tracepoint BPF programs directly
> to the scheduler task lifetime tracepoints:
>=20
> 1. Attach SEC("tp_btf/sched_process_fork") (sched_process_fork), which
>    runs in copy_process() in the parent's context before
>    wake_up_new_task() wakes the child. Using tp_btf rather than
> [ ... ]
> Routing sys_exit through __augmented_syscalls__ the way sys_enter now
> is would close it.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D13

