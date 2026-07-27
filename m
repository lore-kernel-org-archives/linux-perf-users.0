Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71B360EC6
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169979; cv=none; b=ESq/aYMgiWKyE/HKYZkhluOHHxMvtYwY0H2v2nlxZ64lChYR75n7Jp7zbZCU1/Z4jnpHZK9JKoNeGMct/1UX00eGa1id7i7XaPoa8/zAErypUno0vE1aoNgBFzoBAFEZSLLQrDtuBcCQHiNRE9xZ4Z88uoRYEh8InCU9DfQCrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169979; c=relaxed/simple;
	bh=gNO9kXrHmUn1FjqVWVx3Rck8wiQcvERjK01oPAirFJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGxIXo4Fo2h/AodDnVSGLMQ5rg4LxWKN3lJ3HFOQpvyyUsh+KdykTC1rXjT7HCgK6SvFCBREx6jP25TVOHVhA/lhNT9bkO0t/Nwn4uK/rtiq9mmt8/xAc/ywCPXXXwirnhw4U1Mul6QgfnPs58U+5ZsOvD+Jl+8q+6AWPLGuk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1vhAndb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1vhAndb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7821F000E9;
	Mon, 27 Jul 2026 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169977;
	bh=8mXK+lVIr1JVGWUKVJs1JxQouxPFkne/QNIykxI51mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1vhAndbz5qS7bzd11BnzWXtkcvS9FG0DsF2DUjrJNvsNWcawrED65EPx7wvE/v2v
	 kcfKZGi5EMTPGiWEZtSJvM8SG//OCr/rE0chHLRgLQmdzypYxakD34KT85XMXoeGZE
	 pKIEW5v/Fp1ZFyeBOcn2Q3RXYbRwVYtITZIDMm3j6CU8Lhok0w5LYtdpcz1nkP/+aR
	 2L7RVgEsRPtk7ylMhjOaKBxCVEml4R0r8K0hTTbTsMRK747JaW7qqYRoj3CZWzqEDR
	 pO9vBN5x9g7hS7DDYsW+AnG0sejfCUiLisqUMxhDYxoFs8vBMXamxOTo6oKppGymZD
	 W/cJ5CeGeLd6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf thread-stack: Fix heap buffer overflow on
 branch stack wrap copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260727161705.64807-2-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:32:57 +0000
Message-Id: <20260727163257.AC7821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing NULL pointer checks for `ts->br_stack_rb` cause determin=
istic crashes when processing events on a thread stack that lacks an alloca=
ted branch stack.
--

--- Patch [1]: [PATCH 1/5] perf thread-stack: Fix heap buffer overflow on b=
ranch stack wrap copy ---
commit 15a96772c52a6e753408d6e7f8ded1a5bb10c331
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf thread-stack: Fix heap buffer overflow on branch stack wrap copy

This commit fixes a heap buffer overflow in thread_stack__br_sample() where
the memcpy size for the wrap-around portion used an unbounded ts->br_stack_=
pos
instead of the bounded nr variable.

> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stac=
k.c
> index c5ce741b07446..1360f44421ef8 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -642,7 +642,7 @@ void thread_stack__br_sample(struct thread *thread, i=
nt cpu,
>  		sz -=3D nr;
>  		be =3D &dst->entries[nr];
>  		nr =3D min(ts->br_stack_pos, sz);
> -		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
> +		memcpy(be, &src->entries[0], bsz * nr);
>  	}
>  }

[Severity: Medium]
This is a pre-existing issue, but while looking at thread_stack__br_sample(=
),
is there a missing NULL pointer check for ts->br_stack_rb?

Earlier in this function, the code does:

	src =3D ts->br_stack_rb;
	if (!src->nr)
		return;

If thread_stack__process() supersedes an existing thread stack and allocate=
s a
new one with a 0 branch stack size, or if the allocation for ts->br_stack_rb
fails during thread_stack__init(), ts->br_stack_rb can be NULL.

When thread_stack__br_sample() or thread_stack__update_br_stack() is
subsequently called, will this unconditionally dereference the NULL pointer
and cause the perf tool to crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161705.6480=
7-1-acme@kernel.org?part=3D1
