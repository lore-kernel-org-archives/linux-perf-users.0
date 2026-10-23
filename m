Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783227;
	b=UHMOVI8Ke5MMlocaFiA6ITILpLskLJmAfzyjM1eoZDXm5m9kGIXQm11vQddAIKJNN8bW
	 LanL0+X5xFNpZa6gdMN6kAC3bKlxX8UYn7lXFo3G6ey3fxk1RFOrz55W65h4jGd5FR1r5
	 osJW6Wti8OikkYmPEWBFdHRAfaFpFbyUeFbXIn2bccH1LwiZhJlcwarMtC4qNfLDZ9xNH
	 OQqaMOWo5XQGzrAg4FwzsfRju9BAIgQjk+E+NHI+94xX+kOAAcAIV+Akmz33pgujee+Tu
	 wx9BGZtim44Jj8PXOfxjfsKHUujc7yiK3QiRNvulq6wsMeSeCC7tURRD7eAI73I9w4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XtPdsp6ihXWfYFOsTCb1h5lHa3PBLUXrZBDCkMhe/Eg=;
	b=Jo385qjRHonYrHn2E+RADwMYwxi0Ag7/OxnDn+d1tstw61Q3p0mmoIwASw7Na1BEKvIc
	 uZ16R+DXOC2fGp/7eAVAiirRnQlrW2ntWjRVK01WRGT2ooUP2Yt4biQr15fY6Pzij25aV
	 mpgTr/NT2hdaiI8S5ydgn5y+tBcuRLh9VgIEuKpyhdYynkZTP2CutCk+UYapofBBEFdxm
	 L6DzjtgGZJQie1f7tsoJWw5jYMlaOjaAsym/Cr7NRpdTDss3lBv4NIzmvCh+rm74slAkk
	 h9Goy0MC66qWIxaF4wCuWeWzFlQhFGW/KRYuNY/lm3b9GP/yru3F8seakQdQrykqauw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3seCuZ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42D606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3seCuZ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0961F01825;
	Fri, 23 Oct 2026 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783226;
	bh=XtPdsp6ihXWfYFOsTCb1h5lHa3PBLUXrZBDCkMhe/Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3seCuZ8SuYUyVz456bIZenm4pPf5PWIwITfAtVf6vXQLemOWfYFOj131fKv3B0Y+
	 CFQBvX/1EwOies/IRjSIxPfFgrM/ZRt3NAT0C40jlBEbqW1OrICoIzZt3UZ/fa/Yku
	 K9NlLLj9r9nBtvWtvXyLM8eyM5Z1/WojRsJqaErVeSB71FE+94BOphXt/yZ/KJVdjy
	 wzvAGVK+2qZDzXb1V9o2FeMc0Zpmc5saC9m3h/CBmkk0oOcyY5a7n6bVc2PxpiufVc
	 Fw7VB0j2/8Z2iT9g4S6zS1fCwmYRTQfOLgLBjUPbf49V/oPwou2TZvFqeQJYFQgstz
	 PklbR61VRSWiA==
Message-ID: <sashiko-outbox-183106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/11] perf bpf-filter: Add lock_held() sample filter
 for global mutexes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023190558.3050796-6-irogers@google.com>
References: <20261022203003.1779152-1-irogers@google.com>
 <20261023190558.3050796-1-irogers@google.com>
 <20261023190558.3050796-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:20:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add BPF sample filter predicates lock_held(<lock>),
> lock_held_read(<lock>) / lock_held_shared(<lock>), and
> lock_held_write(<lock>) / lock_held_exclusive(<lock>) (as well as ':R'
> and ':W' suffixes on <lock>) to allow recording perf event samples only
> when a specified kernel lock is held (or not held with '!').
>=20
> In this initial step, support global/static kernel mutex symbols (e.g.
> lock_held(cgroup_mutex)) resolved via /proc/kallsyms. On sample
> overflow, perf_sample_filter and perf_tp_sample_filter inspect the
> mutex's owner field directly in kernel memory via get_lock_owner()
> without attaching any BPF fentry/fexit hooks.
>=20
> Lock symbols are classified by classify_lock_sym(). As kallsyms gives a
> symbol address but not its type, this uses BTF where possible: a
> __percpu_rwsem_rc_<name> per-CPU variable (always present in BTF)
> identifies percpu-rwsems, and the BTF_KIND_VAR type of the symbol (e.g.
> struct mutex) is used when vmlinux BTF has global variables (pahole
> --btf_features=3Dglobal_var, which scripts/Makefile.btf doesn't enable by
> default). Otherwise the symbol name suffix (e.g. '_mutex') is used. A
> misclassification is benign: the owner field is only read with
> bpf_probe_read_kernel() at a kernel data/bss symbol address (functions
> are rejected), so at worst the filter won't match.
>=20
> Subsequent commits extend lock_held() to other kernel lock types,
> per-process and semi-global locks, slab cache locks, and RCU/SRCU.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023190558.3050=
796-1-irogers@google.com?part=3D5

