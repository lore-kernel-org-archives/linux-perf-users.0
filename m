Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F53AE706
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741902; cv=none; b=eIjWEYli+Ba+Uq0GJiuQQ5fsqhspeEf2kcWVq9OvYTE+sXr4wYTOinAAhn6owZCIPEzzzp4ESzbINc4tAWohyJYF2dG4xra7X5igWpPikcL08ARcyzYCn15C5D2GCk/PMxnfspJ3paQHIEUeeIvCesbbRIUf4S2qxSxbvcEMX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741902; c=relaxed/simple;
	bh=ONY/p9jLjLVh1+hEgTyzk5dOQaIGYJMG8ZVf61F2Bf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cZykFowykYgjjN53p5B0xeRcXuun5QTuZ91OW9iC7N4bsJ01nZoPlVaBHSh6VR9+40i0T502XEgZeHDVLcN/Eipd6wzHyu+I9wduAuFzUz5MPVky4D5si64kfRfAYKf07v3W4nQT3smYybY3nE5Uowks2lBZsFBx/bGvPEujreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUUzmbo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUUzmbo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91E1F000FF;
	Fri, 18 Sep 2026 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741900;
	bh=ONY/p9jLjLVh1+hEgTyzk5dOQaIGYJMG8ZVf61F2Bf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUUzmbo1Emq3Qrkh2lZ9AFvzzIvP/RXOI6CnrpwS+REaZjPrpJIe99NzUpZVJ1ra/
	 2R0OL3gOx5ip7Ek2rp3Td3+tt3xgdjQCnBDAcR7uRK0Eypfp4vVQAucgFYRP9tS7aK
	 /3mem8DfpqqS11I5YDQ+yPYI5yQPk4K/aaD9ZhJoSpeGbkb0wEWksXmcaQ05NbnTTd
	 YHLr/z9lBFLr8hpjrBkLc9Sn4n/sHqwZnlXbIQ00qiOtVZtlAV1N1PKWLYMsy73vOY
	 Bt7BJ2QTdgnWw45Z8NfATkGFlMnI/uvCdYu5YomJ/5EoosBT+EdU/EbxheFyL6AaPk
	 qhbYaFAcWG3kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/16] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918140659.2501976-7-irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <20260918140659.2501976-1-irogers@google.com>
 <20260918140659.2501976-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:31:39 +0000
Message-Id: <20260918143140.5B91E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
> 0 for syscalls that were not of interest. Returning 0 from a tracepoint
> BPF program vetoes the event for the whole system, so an unrelated
> concurrent perf trace, perf record or ftrace session listening to
> raw_syscalls would silently lose events. This is a cross-session side
> effect and shows up as flaky failures when perf tests run in parallel.
>=20
> Furthermore, syscall_unaugmented previously returned 1 without writing
> anything to the __augmented_syscalls__ ring buffer. This forced
> userspace perf trace to listen to both raw_syscalls:sys_enter and
> __augmented_syscalls__ in its evlist, requiring userspace event
> deduplication.
>=20
> Address these issues:
> 1. In augmented_raw_syscalls.bpf.c, never return 0 from tracepoint
> [ ... ]
> The inner report becomes a pr_debug() and the caller prints the error
> it was given, which leaves out_errno without a user and it is removed.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140659.2501=
976-1-irogers@google.com?part=3D6

