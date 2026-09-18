Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810E3BB138
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742130; cv=none; b=GXDXiAnur+hlBmPi3qThN0J754PjW76eIE4B48xX0e3RuOlpB0h51bRNF0xK5ZQ6e2+mZXM2zc3znRl5vwdRJKydIVjFLje79VjRNnJCjHV8Kd8By2yjYSbGFjOQXInk4RqsV9cFrujTscq6RlAWhIo2bCVl5R1GLCOZ92SQJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742130; c=relaxed/simple;
	bh=gds6m2JcbrDGbvWuOuye4Fh95vmLGxbvgPJYqqwFKGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jknm+hyIJInDSHzEmgvHE/Q3i+lltUH5moPeACOsEHTOitXLTuYE7YCisWuMRMp0Sg+1DU/DMG/4HJVnclREzdRhtn42dTtdoxrnzyexUoDkwMr2YOZMQOMQl4aC9I+e9ZAVyXedOaqzGABaSMFf5ZHiT6lwH3+JgIqeDcfs0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnbOAH36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnbOAH36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86FA1F000FF;
	Fri, 18 Sep 2026 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742128;
	bh=3YIEyUw8VXku/q7ydhLPW9DuSjsdqzuxxS+D7+I88/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnbOAH36sOW4QXTt0//c4k31avc9jVXTtxhn411Hn/A87qGUBEHO2UNE2NVlU083o
	 j/JJmeKZDxsYmgc1CoPJCT0irpbT8le/gUUekpwlsggccrpMThkDjcAOBQkEi1Ee3Y
	 4SbpryRcnEWgmN2jvj+1UorYVNGSp6H0mFtJkskbU3Z52L9MnzJxqQV8wFywYcUQEw
	 0vooXejlIuN8BksksIPz5fqtmrKJ0LAUG5E99I7knONcqLbbDoqb8SWSGjuFM0dbwS
	 OGji/GV24vmmFMcXZXEGxGOWTwFIQ+QdELdfnh06By1RFpDB5nvGiCPbLRLju4csRI
	 0SKIDEXMaXZCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/16] perf trace: Handle fork and exit directly in
 BPF filter maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-8-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:35:28 +0000
Message-Id: <20260918143528.C86FA1F000FF@smtp.kernel.org>
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
> of the target re-enumerated from /proc after the attach, which the next
> change does.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D7

