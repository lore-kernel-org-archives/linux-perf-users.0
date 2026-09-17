Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370093769E4
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627774; cv=none; b=ohXslCt6W9j8FL1Gg/KFHrAJGqC1veXnLlUW4DTA104a6MdFQB7i1V2qZHb0SpvAjLzqdofn8E7bqiyNtGOWKdurrfEf8UtHBDedIK2FGM+vV8j2DntQzzc3SDknQzN/LgvTM1J9rkJGLnu+nWC8bBbJ00o3JiLL2FvcLAMH3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627774; c=relaxed/simple;
	bh=BNF4aKR85LNb1qySoTnuvUHdeZUjiZDQ8V/KJZsh2c8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMFmQxB733lmtt9JFv5EFRUN82b64QKD7sOovkC/M6LPvAn7+3m9aVXrcS0WqVrHiHf1zB+nywjQMKSg9zFFBnM+Ts/JcRxA4j6oO3ZEbUQoOuM7KFQxWv3JQta3jQYDsBuJ0ipN9fM89UC1llRBitNa9N5g0ed48MjrSNLH3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmW85c9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmW85c9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70441F000FF;
	Thu, 17 Sep 2026 06:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789627772;
	bh=BNF4aKR85LNb1qySoTnuvUHdeZUjiZDQ8V/KJZsh2c8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RmW85c9ns4MZdrWAFlz1+4ml14FZczIr1By2TecrUt93SiW721k6iE0WLkx4OgTla
	 XtyQiRIZirz12gRzgmjqQtQ7pq5n/5hkeLqHrcYBmwxAQcOUBCy2rXxNl/zlMkd0sz
	 QaFcYPr8wUPPtfVqhuh7Hcoi8RRA7sHWa9idskEtBBo+8MP1U8An5Te+XrQrsXWiO2
	 BYLMgtYwL9PPNtwev8ZbVLvJt0Pt1abWs/gYZk7yNHMYuGfgl8/4M5tsdsb28yDfcL
	 AVpmwTqEndBGHr4sycmgsX83QF/FZ8tnVgz1bioa8RfGGeRKHfa87Dg9DNXczBPS3W
	 S62AmE/ecJ5bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/13] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <91623303ca281e878444068063fba4bec464bc60.1789626978.git.irogers@google.com>
References: <cover.1789626977.git.irogers@google.com>
 <91623303ca281e878444068063fba4bec464bc60.1789626978.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:49:32 +0000
Message-Id: <20260917064932.B70441F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789626977.gi=
t.irogers@google.com?part=3D1

