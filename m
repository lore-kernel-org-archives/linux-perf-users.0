Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323233F4DD2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148473; cv=none; b=e7xWiKWceP8lCbYfmwekwraZCLCKwLlCO14CMFzEqcWEeGtmaFbXc6D+phgHtSP66w02hurarbhFJbYJIP+Md1+YH0pMmHqQcUv89o9bwkrp+Rw7hgtpGo+qoKVkgQoM9WxFNupD/47bJmuJUxJkdTLUJZlWK9BMYmf9Kmc5qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148473; c=relaxed/simple;
	bh=YPZMjK5DhpvwAdLPdWZWagSECE4jghOWsXpWT4zMgYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5UEmzTQHSZrnazUH/+crjy2po1rhqyuBhHLnSCE55Hj8ufeda4N6VhP1uMuyoAhOCncjNFJTPSh8AWJT/s8A8KvqaHt2Rl8TXpuDvSMH8YICaVOkpefFxQmjhh5sGOByGFnzkkmTSmg/JtEw6dbmW3DVJ9t9S/esiZT7N2bydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcrJ06Y7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcrJ06Y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF3E1F000FF;
	Wed, 23 Sep 2026 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148471;
	bh=f+nJPSMBuRHjFJvf7YDXjiP4+sQ1ymN37ULxbktVkjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcrJ06Y72M/Rz176/YMrIdsN/h2xUf8GrSWf+oPbeHn85OTt24M4mZcdTo/2E4xZh
	 BlogGetPc7pyMGkLZ54gNFyP2DPVfM2OPJZ9Hvat/kRQJXOa4GZQ9JwJZMcMNs4CtJ
	 Kl+z7sQPPz4/upJolcfLtwEwwvN+r/GTj5cHR/8WrAxA1JmIsNm87sgEmpf9XksCqg
	 UNSyOHEz3SntgT+HEfnMmYuxEtw/q+MmSCwm0mRs7BPb2MpSX0MlaybzNhNRcpFK6Y
	 beaqG/De+XebD4XQrPWik3b6UV5yET7n4g0uzIQ99rMGO/jZlko1JgK3vvv6j5rfbF
	 bc9Ktj8fO01ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/23] perf trace: Drop targets that died before they
 were filtered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b6d5596ad04aef749be8f57951d70f7e6bee4765.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <b6d5596ad04aef749be8f57951d70f7e6bee4765.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:27:51 +0000
Message-Id: <20260923072751.ACF3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> sched_process_exit() takes a task out of pids_to_trace and pids_filtered
> as it dies, which keeps the maps holding live tasks rather than growing
> for the length of the session. It only finds a task there if userspace
> put it there first, and userspace writes a pid some time after reading
> it:
>=20
>  - trace__set_filter_pids() writes the thread map and the --filter-pids
>    list before the programs are attached, so for those there is nothing
>    watching them die at all.
>  - trace__set_startup_pids() writes what it enumerated after the attach,
>    which is a much smaller gap but still a gap.
>=20
> A task that dies inside one of those windows is never evicted, because
> the delete that would have done it ran while the map had nothing to
> delete. Its pid then sits in the map for the rest of the session: it
> [ ... ]
> last ')' in the file is taken as that one, since no field after the name
> has parentheses in it.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D15

