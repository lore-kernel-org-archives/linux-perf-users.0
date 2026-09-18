Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693253876A1
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741021; cv=none; b=gZVTdJjxucDvFmlBh6XykHLHggC5ms8myv+a9F7h2loJSX+AY4Erg9/E8tXOdAnGB7KIcmJ9THf5oUR+CbFpBXhRwYK4vIbcrVzHvv/2C/56ST/6Rj+snKYBTsz1fKH2D0J9g/Vj22tYvWVzuCoj6a1JzmU+Etd3/uq8n2h3ZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741021; c=relaxed/simple;
	bh=k6t/rOo7nj14DONvBr25QP6dNbKhOTxnJgxnURV42zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bAfWb4FEVqZUdfteqUYg0C3BpQoUCNC9APRMasEX9KNsb2SSTBbTfx0cTomKRVMHc2Ysg+2JlgQuVhN+aCW/dPzTJUwoN000XObkpEcH8TNElnNBqmPPmcN/mkhHx3lFrOfR6K9ZT5i58XuiT5luJY+bStQ/lbXaGY68rOfry9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW5/9zww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW5/9zww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C811F000FF;
	Fri, 18 Sep 2026 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741020;
	bh=k6t/rOo7nj14DONvBr25QP6dNbKhOTxnJgxnURV42zQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HW5/9zww66xAUPA0T5HakKw8PcRndgNXyd8jlsZ3EHSJTWywiSyfInwXu0Oq6t0qv
	 KS5b2jUV/Oz5Wcjg5bpbueKr2cz62T/ptGPKXwmfPsANO1ilxNvBd8hEZrol8daZQD
	 MKAbTMtw3YhxYkDf8WhqeSovoy5GpVOVr6h+phitCM3YQcSBZp9PUbe2u0poIy1v6m
	 x3fXwPa3LZ91RB98eG+1yoaXxmd34GMkDZf0YMeHFC9Rfr8E06Y4/XUaOBI8l+Sxky
	 PRYAba8wEMAVyYDvMymbZQa18B4DlHZooFSSbxVcmniR+wbkYy7nxTjnOoBgu05cSR
	 kFIqbHXUf44xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/16] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-4-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:16:59 +0000
Message-Id: <20260918141659.E0C811F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D3

