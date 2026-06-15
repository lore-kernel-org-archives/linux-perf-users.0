Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DD3AC0F5
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560404; cv=none; b=K0NaUR/NaKye3ljtgoADmnar0L9Ql4L7T6VrxHmgrePpEdzeTo+M1kZlVNo/q1mXrP5vBt2ACH2O2POtd1R987mTXESGhTGBMgnUc/t4hTicaiLN7WzoIOTsEOWrsCSG3OeG+d7Mr78sBA2NNRktUWYem3j0D3NTEWiSdhZU7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560404; c=relaxed/simple;
	bh=6O5jOKcUeVxLjgZEdNfiaZCsq/Y0xDLjRM+D38epVnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZvsdH5C2DqQUFyu4gpc+GUas/+Cbev04SuMLLJOfGZodD/AhrxZB8+hABVaAGqA7Gj9iBxJorSteF7u+wOxLXTNTnIbtyLIZB7v6XcG/Vf/LlQ3ax44KttIkF3J5FIfCHaP+KOmTcYZP/8X/LL2knfYLiRtpSVJ0BFunLM00UYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi+n2nRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi+n2nRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F51F000E9;
	Mon, 15 Jun 2026 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560395;
	bh=qSIX7aurHuxkbfNLHG1XGS41yU8120Tkl6yg3WsRe7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pi+n2nRaCPTdED0IrtkCFflKg1xABXF6OfCI34LDItQHlPferMSK0QWNQlnyscKNb
	 KAHOcAsPoB1/j12WFOjRHRku8rqylaZrvsU/zNYSd5OXTj+V02x/9ThP7mCLLWOBlC
	 6DanUQ3UG5EXMkxwwQjQGzDUXLRRN/Qrr45e0qjuvEwgT+pJskdPq32eOU5+k6CbR/
	 F12VmCAqjomG3pGCT+v5EPwjf9D0gWnAuCd18tDBcoVhgRDZbsnA9g7ll1/53lVVCF
	 Gcz/WIJ0zEGgf/4EMxa1SX8hkKlN3i234MaMbeboGWzcUrdcoV8PXB0lPjOK92os6Q
	 moNeELW+TTZzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] perf machine: Propagate machine__init() error to
 callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615213657.35776-2-acme@kernel.org>
References: <20260615213657.35776-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:53:14 +0000
Message-Id: <20260615215315.031F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Error paths introduced by checking machines__init() result in clea=
nup routines destroying uninitialized mutexes and rwlocks.
- [High] Missing error handling for the newly propagated return value of ma=
chines__init() in aslr_tool__init().
--

commit 63ae9f1a874939f375ee99fefcd13baacfebe5eb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Propagate machine__init() error to callers

machine__init() always returns 0 even when memory allocation fails,
because commit 81f981d7ec43ed93 ("perf machine: Free root_dir in
machine__init() error path") introduced 'int err =3D -ENOMEM' and an
error cleanup path but left the final 'return 0' instead of
'return err'.

[ ... ]
> diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_c=
umulate.c
> index 267cbc24691ac..9f4d4e281e11e 100644
> --- a/tools/perf/tests/hists_cumulate.c
> +++ b/tools/perf/tests/hists_cumulate.c
> @@ -723,7 +723,8 @@ static int test__hists_cumulate(struct test_suite *te=
st __maybe_unused, int subt
>  		goto out;
>  	err =3D TEST_FAIL;
> =20
> -	machines__init(&machines);
> +	if (machines__init(&machines))
> +		goto out;

[Severity: High]
If machines__init() fails here, we jump to out:

out:
	/* tear down everything */
	evlist__delete(evlist);
	machines__exit(&machines);
	put_fake_samples();

Since machines is allocated on the stack and machines__init() can fail befo=
re
fully initializing it, will machines__exit() try to clean up uninitialized
state, such as calling down_write() on an uninitialized rwlock?

[ ... ]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1a9a008ddda35..26bacb6c1a572 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -160,7 +160,9 @@ struct perf_session *__perf_session__new(struct perf_=
data *data,
>  	session->decomp_data.zstd_decomp =3D &session->zstd_data;
>  	session->active_decomp =3D &session->decomp_data;
>  	INIT_LIST_HEAD(&session->auxtrace_index);
> -	machines__init(&session->machines);
> +	if (machines__init(&session->machines))
> +		goto out_delete;
> +

[Severity: High]
If we jump to out_delete here, perf_session__delete(session) is called, whi=
ch
unconditionally calls perf_env__exit(&session->header.env).

Because this goto happens before perf_env__init(&session->header.env) is ca=
lled,
could perf_env__exit() end up destroying uninitialized rwlocks and mutexes =
in
the zero-allocated session->header.env?

[ ... ]

[Severity: High]
Although not modified in this patch, the newly propagated return value of
machines__init() seems to be ignored in tools/perf/util/aslr.c in the
aslr_tool__init() function.

If machines__init() fails there, could aslr_tool__init() silently proceed
with an uninitialized machines structure, leading to crashes when it is
subsequently used or destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615213657.3577=
6-1-acme@kernel.org?part=3D1
