Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96D43D6472
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748799; cv=none; b=AFSoQE3qyeExdM8YSF5TE8K6m9d7GDbUdFjB58OhJvoWdjk7BELrkyainNSqCo94tu8MM+89pjHwXEZ7A37cyE+h7AdAnBHIckRGQND71pJEpkFelpjDydfxrBeDeiwcZlwvI/vkuGJGW3XpGcQQ+qhPd88UruLDc0Tx7gTVocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748799; c=relaxed/simple;
	bh=P5H56jpyQ/7SoTcQ4PIUMcA8qlOygHxccYAqoaHaVIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oczSBO/UK/GN4Y9S2FNfTM8FyjJymdTQQ1Q3FXo7faQlVkdIb/h3iwiRQlQ89zyvcwnt+LLIZD8xaXieIUgXikUK3kp6nnweZZmU2+HCjq4Di5ZQlRb6286J5MrEh3oHxkrq6huvy090ZgQ2y8fKeC+HfBc11rOzTvu7zoSTuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVwn1/OG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVwn1/OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C781F000E9;
	Mon,  3 Aug 2026 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785748796;
	bh=GHJZ+rgkReRcD/oDU9TUD4l4xdazrJbdiH3JPgTpJEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gVwn1/OGadmPlbykpDt/sgOExcpx3Rrr2+HdSnZdX5u/mO4quIqNWIbqB0oGmsfSu
	 dGChKmKyTMMeuTp49xZDX2wzShhZK9+rwRbxSH2JVsQ8oou76/4dQndsZSTkfjGwqq
	 TX4XcMXmL0MhyKIIa4voHrT8VAHwv7OPSr4T1SoFyky+W/vxNMjcFUMdVEUvqKMyC8
	 cY+BbDQK7AtvML4u0EbAreSp5NCi9Wj1bGSjFOJXx3Qq0HyjrKw36xTFCSGtdZsVWs
	 jJu9ULQnxg7tIg2qcpFndPy5jneTS0IsH0Ry8ok5JQ3YUrdbdC6Rp/1hx9QtszwvCi
	 eZUJQ+m+xMRew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as
 not available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803090640.2412336-2-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-2-aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:19:56 +0000
Message-Id: <20260803091956.A9C781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing heap buffer overflow in thread_stack__br_sample d=
ue to incorrect memcpy length.
--

--- Patch [2]: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as=
 not available ---
commit 51033b3641484a31783c5c945c25ef5ee0bfb23e
Author: Amir Ayupov <aaupov@fb.com>

perf thread-stack: Report branch stack hw_idx as not available

This commit sets hw_idx to -1ULL for synthesised branch stacks to indicate
that the hardware index is not available. This prevents consumers from
erroneously assuming these branch stacks start at LBR TOS entry 0, matching
the behaviour of intel-pt and cs-etm.

> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stac=
k.c
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, i=
nt cpu,
>  	unsigned int nr;
> =20
>  	dst->nr =3D 0;
> +	dst->hw_idx =3D -1ULL;
> =20
>  	if (!ts)
>  		return;

[ ... ]

>  	if (src->nr >=3D ts->br_stack_sz) {
>  		sz -=3D nr;
>  		be =3D &dst->entries[nr];
>  		nr =3D min(ts->br_stack_pos, sz);
>  		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);

[Severity: Critical]
This is a pre-existing issue, but does this memcpy() write past the end of
the dst buffer?

We calculate nr as min(ts->br_stack_pos, sz), which limits the count
to the available size in the buffer. However, the memcpy() uses
bsz * ts->br_stack_pos instead of bsz * nr.

When running perf commands that parse Intel PT traces, ts->br_stack_sz can
be larger than the sample size sz. This could cause ts->br_stack_pos to
exceed nr, leading to a heap buffer overflow when copying to be.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803090640.2412=
336-1-aaupov@fb.com?part=3D2
