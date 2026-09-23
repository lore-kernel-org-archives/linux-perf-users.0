Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8B238C16
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148089; cv=none; b=EG91r40dZ1sh+mmSmrHBnSDdRzDQbH50QnCjCAvaCM4yqEVSzA7uYHd6UOTjOK2WPP+I/Rz2ImvjnPdZIugn2muyrpsCP1T7OOA81BMLe22h/HvqtIRKrBDdHrfK4MeY2JJqIvy8JPE9ANemaIevoYM4CrBNo8WTTLj+KbaqOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148089; c=relaxed/simple;
	bh=XXG0JLPqdZH5FiHAJ/A1T6KXTgx3Rk1ArFA1lmhBl/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFfVIFQ71Fc+wPElp47hqRVuI4ZO6XCW9fnyFihMYDQTmgKUCib9hhsfNHdL4iGp8Lkt+7eLFCpYKEAOXlxuXsGPFqEG+YtQsw3+vkzDxEAK2xxbWTXlsuPXHn1v10rmfgpAxU9QEm7+mQsP49mMDgw1OIT42nHk6ch5X2S6mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGnAMYoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGnAMYoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E22C1F000FF;
	Wed, 23 Sep 2026 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148088;
	bh=XXG0JLPqdZH5FiHAJ/A1T6KXTgx3Rk1ArFA1lmhBl/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGnAMYoZNCX6/UUmFTlrrCbTrhE12JpNKx3VqPaAtC3cc/P8KnAQenrV2tpO39263
	 8qj4aNcQDR49LVTFpaUn7xTTQ5Aa5BU8RKP6jzVFPRlIGtQhN+43OYLeOGaL6WdQKD
	 Xmb/N3acLbYAhKrkqNe/nZjLtlDlOkicFx50Vn2PYnqxLtF0HXCPXAiW6DsKlUBGAl
	 Q3dkczKPhCfoyWQJT29Sd77JGSaisoC3vtCXm6jhd5NfaONLaSVFigHRs3djm1934i
	 WTCwstDFVmmf4MMeRK207IgJyH9Nk6hdKeeajpHMq6q87fqZ4UmAv5++Na+k+E727B
	 qcyKa94A0+fuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/23] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5289bf094c7e9d37990d2d36fdf2deb025478c1f.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <5289bf094c7e9d37990d2d36fdf2deb025478c1f.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:21:26 +0000
Message-Id: <20260923072128.1E22C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When using --bpf-summary, trace_start_bpf_summary() sets
> skel->bss->enabled =3D 1. In trace__run(), trace_start_bpf_summary() was
> previously invoked after evlist__start_workload().
>=20
> Because evlist__start_workload() immediately unblocks the child process
> by writing to its go_pipe, short-lived workloads (such as `cat /dev/null`)
> can execute and complete their initial system calls before
> trace_start_bpf_summary() is reached by the parent process. Furthermore,
> under high system load, the child process may finish before the BPF
> summary tracking is enabled in the kernel at all, causing syscall
> summary tests to fail. Additionally, if initial_delay was configured,
> the workload was started before sleeping.
>=20
> Move trace_start_bpf_summary() to be invoked before
> evlist__start_workload(), matching evlist__enable(), and ensure it
> respects target.initial_delay.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D6

