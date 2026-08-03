Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A63DDAF0
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749223; cv=none; b=TLES9osx+2oDdswMMzJviH9rQeq8dExbZ5vPzmiFg2dBTAtw3PDVxB+z/Z9IYjHYU4c/5FIzCIJ4vdJu7Swk6bK98izxwB+0AhxEW836U0s+uzOx6oI2m3Ra+5nHPxcJxei9J3jWMpvCPmUpxIncan7+QgbFFVd4pppH7TeHilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749223; c=relaxed/simple;
	bh=k+F4qJ8h1invaFQ/j7k0n5LN6aMOJ1NSUJ69H9ZA/uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwAoPORxGBDOVSZTiZ53IhmPML56EgOWTTHO6txVAeOGXjFpNSpRyYI9K5+qh3XTTaZhL9Zj+dRgeE6iylDzc0NTKNNNYvM2ve/IVBSTeIMnRFxiBHAn9ooUwO6Z1w+39jP+jAT0YP6RIXCb5VNvDDPnVsGoy4W7JHjUiTXEkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZRAjDZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZRAjDZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C24B1F000E9;
	Mon,  3 Aug 2026 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785749220;
	bh=nGVRqvNw6kuH6cc7EAn/HNSual7PBTzqBP8oKe9GRaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hZRAjDZBGAcQaYzlkDDlhLZ4JvJq8gfvfWRrfqCyHz941mSiPok9FK/vyqgtfZa84
	 9slUNeKl/uV6O9pojDyyXxa5rLWSaQwqRfjcoyrXZQJxRbzhEjB0JXdYchIGVbUoBe
	 HJMIgXqW9IU91pBE4QXX1V1BsKCQdiSdRZfbwiXP93p+DqeysCunx6nkpddRK2SZk5
	 6vjmcigJeHmbnnDYEtUrsebQDKCNyDdiLpNhUQ0rHNV/cxp+CL6DUojfEARQscUTOh
	 sAVWOTueFlj7KUXuRwN5WwBp/8R0s/vKOHjEtQBqQ8wIIq9n57bknI84LvW5Ym46ZR
	 vOvzU9Yp2+GiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf thread-stack: Bound wrapped branch stack copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803090640.2412336-3-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-3-aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:26:59 +0000
Message-Id: <20260803092700.8C24B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unconditional dereferences of `ts->br_stack_rb` cause a segmenta=
tion fault if thread stack initialization fails or if it was initially crea=
ted without a branch stack.
--

--- Patch [3]: [PATCH 3/9] perf thread-stack: Bound wrapped branch stack co=
py ---
commit 3efa75c3f04529593a5a6a18971bae8fa6a9617c
Author: Amir Ayupov <aaupov@fb.com>

perf thread-stack: Bound wrapped branch stack copy

This commit fixes a potential destination buffer overrun when copying
wrapped branch stack entries. It correctly limits the number of entries
copied to the remaining destination size.

> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stac=
k.c
> index 1a3dffa83bde2..51eaedb47bb1d 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -643,7 +643,7 @@ void thread_stack__br_sample(struct thread *thread, i=
nt cpu,

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference earlier in this function.

Could src be NULL when we evaluate src->nr?

tools/perf/util/thread-stack.c:thread_stack__br_sample() {
        ...
        src =3D ts->br_stack_rb;
        if (!src->nr)
                return;
        ...
}

It looks like this might occur if thread_stack__init() fails to allocate the
branch stack ring buffer, as the partially initialized thread_stack is
already attached to the thread:

tools/perf/util/thread-stack.c:thread_stack__new() {
        ...
        thread__set_ts(thread, new_ts);
        ts =3D new_ts;
        ...
        if (!ts->stack &&
            thread_stack__init(ts, thread, crp, callstack, br_stack_sz))
                return NULL;
        ...
}

If a caller ignores the error from thread_stack__event(), they might proceed
to call thread_stack__br_sample() or thread_stack__update_br_stack() with a
NULL branch stack ring buffer. Is there a need to check if ts->br_stack_rb
is populated before dereferencing it here?

>  		sz -=3D nr;
>  		be =3D &dst->entries[nr];
>  		nr =3D min(ts->br_stack_pos, sz);
> -		memcpy(be, &src->entries[0], bsz * ts->br_stack_pos);
> +		memcpy(be, &src->entries[0], bsz * nr);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803090640.2412=
336-1-aaupov@fb.com?part=3D3
