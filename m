Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E0378826
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336303; cv=none; b=pglt5MabPmZlsmcxG6StFhwV2V+W30LBoGgJDpmwCi82iusLoBHeQMlZ5b6Br4z3qB7Xwp1CKwhy5jD40kz/OIsOx0mx76OReqwnDejC+CsxTh3k7P0eCUEt/NOaz1pGM9YjkZe+VERP2v6T/Cw9fnXpRauHeosQ7k+UFVrW/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336303; c=relaxed/simple;
	bh=HJL7WXVVk2BpvZ0odRb8uvMXxscByUrNrqjzoDuqJDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvL+JrMQcFh7wD/HC3/C+3KLQTaBb8zbxFwFAEwTR6ZaTOKXkQ//Il6gF/Rju3c2OgtwhBwJ66LIZFTf31dRrqNQIksTzjylJDA3TirbnnwsvAQkq6s7X9dWbcunJw19Z8t5zvPkNvm48vZzh0RRwmfODIYeGCq9v+d2970TJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NptSL7fN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NptSL7fN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377C01F000E9;
	Sat, 13 Jun 2026 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781336301;
	bh=cZ3AyfaBabWorbxxlOOmtlM2SMit+ucpiwKq6LRHP/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NptSL7fNKPiR+Cpnr7XbAcKUEbX2BbULPTKK25amQbFcNSm6HY22NzL6vvnXPPLLp
	 aHrY3OjknX6kDeqSpSxoWTLCwGUBmJ0fG/HNHYySxsTsCfC7s7et5vGiLiwN1cFw6o
	 qP5QFkGf4q0artXxeDIP96K5TpR+cSsjQ1FeaoLA3EugRw1Cb9SQLy/z9wYrBEqW8d
	 2fizTcuptL/yyWF241xn7f87XBsq7L7zCa7h6rlMJISqgQ+uE25YzmCqzUo8YwIkBk
	 TiY1jp6Or63Lipxb+lE4TwErFW7gs+59aKSR537LmfWl+AlinzufAbTdoC9FvU8APE
	 9AFXGScUjGoEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/20] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-9-irogers@google.com>
References: <20260613071100.1508192-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:38:20 +0000
Message-Id: <20260613073821.377C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing `perf_sample__exit` in `intel_pt_synth_ptwrite_sample` c=
auses evsel reference leak.
--

commit d143b917d0bc566cc248104da6da1d773e04494c
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event

Avoid a duplicated evsel by using the one in sample. Add
evsel__get/put to the evsel in perf_sample.

[ ... ]

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 56a9e439f5f8f..11a5ebf3b2367 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1830,9 +1830,9 @@ static int intel_pt_synth_branch_sample(struct inte=
l_pt_queue *ptq)
>  		ptq->last_br_cyc_cnt =3D ptq->ipc_cyc_cnt;
>  	}
> =20
> -	perf_sample__exit(&sample);
>  	ret =3D intel_pt_deliver_synth_event(pt, event, &sample,
>  					    pt->branches_sample_type);
> +	perf_sample__exit(&sample);
>  	return ret;
>  }

[Severity: Medium]
Does intel_pt_synth_ptwrite_sample() also need a call to perf_sample__exit()
to prevent an evsel reference leak?

In intel_pt_synth_ptwrite_sample(), a stack-allocated struct perf_sample is
initialized and passed to intel_pt_deliver_synth_event(). This eventually
calls machines__deliver_event(), which was modified by this patch to
populate sample.evsel and increment its reference count via evsel__get().

Because intel_pt_synth_ptwrite_sample() returns the result of the delivery
without calling perf_sample__exit(&sample) afterward to drop the dynamically
acquired evsel reference, does this cause a memory leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D8
