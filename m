Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB83B95E0
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766802; cv=none; b=E+rfecLY26OY9VfjMDWse1OpDxt77RPc4xn9YFwF718Tqy3tLQFAtZtHiE+E8Z1uMrALw2An3GADhdqULTSs+53sS6MaegKTRPDpvC4uXkiJLQG1AAegp73Ntoe2p+61jQvXuN/wgXQzCmANc7/SO5YPCWzGzU4j4F9Zqfavh6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766802; c=relaxed/simple;
	bh=DZ32EOlqbCr6QrGpCAaNp4wxaHW4C0/QSpaRcWvfrb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oRGkOnHFv2zBqAXMkCSW6al+234FLjT0SllSiN0XKO1Va6kKg2mcWtWm+FCecnGr4hFlhF8CgGbsq75SOqKki9t+ZRQBaNMqex7crdJG8RgXMLPkSzu20lxzWnZB7rZpPsnJc5eZ9z4KpHZVwOftQwF7s9ObDZtkf1BlQ0V12Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExYCw9Xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExYCw9Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83701F000FF;
	Fri, 18 Sep 2026 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766800;
	bh=DZ32EOlqbCr6QrGpCAaNp4wxaHW4C0/QSpaRcWvfrb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExYCw9XccPsfN8JhpSjee9JizVfU3qaip7xNVeTK++HTtGXsolilR7EYvYKT23F6x
	 Fnf8J4K5zNFNUJlYOHVYkr32Tei2SNgN/fBZ/1XHsYDOeo5KQ6mYKsAvBpwIAmhP4v
	 aspe5elSssO5wd0g4QSMcZejNeFkHUt4CefmtFjGQHS4d30WBLQlhwy4tD8xDkMD8n
	 tsKDj5/dDvmll+LgvYKxqndB48gu8VDcxX06k3tNcJ0PndHrVJH/EXJMxRme/WiDyI
	 K1zQThdi52RfNYsMBAnDsXkL+P2P0ClUZRE70wf0cirerbhQwV7LIeK1YAxU7nBDz8
	 WMTdqGQQRtGew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/18] perf trace: Start BPF summary before starting
 workload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-5-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:26:40 +0000
Message-Id: <20260918212640.A83701F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D4

