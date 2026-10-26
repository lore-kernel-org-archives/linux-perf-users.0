Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010651;
	b=1ssa5HokJVkf6WZONfhxPDcKJOEyOqfLHKW2ppscCpA/RZ++MAlYk9vWM8n7Kvamx6yj
	 zVz+xP3VBxyIxdfl0xpJ7wYFQjvyfYllJ/MG5Y3Yxn2hfhB9AOzItjejJ4+eiQXQfjv5V
	 LrjHzq2x8NKJrfDHh2QZ3Q067JcvmHtD5KKKQ85s0IjnMjnlc9qZpmr6FrTThfQWw1ePB
	 07tZV6GDaeLrW2Omh7KHjPiev0nVeLsIFO9beMRPyvyZqfRJHywFHrkuzQvBlk/tXoOpg
	 q8s+3h3lbIIiGnPHgxwxZH7yDgan4VEbqCELc6EQt50INUL6DRo7eWSGNZuyw1Yn1Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010651;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uNSLtacrsK7bHGLP51jwm3YO9cG6z+JLjjWuid1wq0M=;
	b=mvrfOW8uFiOCM0NV0WWeDtv6H3W2n4xwEXzf0u9VI2VmXH+zMvgaspuJQmHRIiw3riMM
	 DFZznqgaAI1KZOQ2ha8OP5n8Hj96RvlkFK5sw0oG4svogZvSN8qMqHoa9R5sMHQEXkxNn
	 YZIlHohcAlnwhtoIf6bJcQDz14+jqRMZ06sfpcStrnlpk1tGKMTkwwe4HjAhQlk07gy1v
	 rElVikEHXGeiOJd/HuYl7yucpBHOSePOWoCssYwxzjaSYN20E6HQThPWpdgBTINhtRXDI
	 BAlCZuCjetPYRbazIhBygE6X7VTpAuLbN7VkL6bSbhHouWxeweJtLghNlLxuTECsNXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUEak4td;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED7606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUEak4td
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359D1F01825;
	Mon, 26 Oct 2026 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010651;
	bh=uNSLtacrsK7bHGLP51jwm3YO9cG6z+JLjjWuid1wq0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUEak4tdvmmFhWCxCf42oFJ6XTo9tD0eqtyHjtWgTfpPj/qxMA+4SPxUiHrTY+YAy
	 RpecCT5N+Ucy2AAkej7u4SlE4uwmvSkogzdDIGZj0tJgGZer6EMfAs+dlKnjAvhbIs
	 1wBGvSxj+SxY5tNds3e8lk9EI48GEufiV4pAl8m4UGuDJGnueetKqPQBT0I6XRtmzk
	 fIKVrZb4qopGZh157w2QTgMFne2GMNhSEsAuI1YHDw7KgI7qEm7iFCO7VDoIgB3yxN
	 pxP5ZnFiGrG1NLpTFX95YxfNsO8MFSdxqjOzSPcBO/wKYMUg/AUDWVvpsVGCof4NEU
	 Q6nrzN6eLgxMg==
Message-ID: <sashiko-outbox-184945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v12 10/10] perf ftrace: Filter
 extraneous functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261026025735.546101-11-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-11-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:30:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing with the function graph tracer using a targeted filter
> (-G or --graph-funcs), users occasionally observe unrelated functions in
> the trace output:
>=20
>     1. Top-level functions (e.g. most notably
>        finish_task_switch.isra.0()) appearing before or alongside the
>        requested target function. This occurs because clearing and
>        rewriting set_graph_function creates a transient window where
>        remote CPUs still observe an empty filter (tracing all
>        functions) before RCU synchronisation completes, coupled with
>        perf ftrace sleeping in poll() on trace_pipe right as tracing
>        starts.
>=20
>     2. Detached/orphan calls inside the target callgraph
>        (e.g. housekeeping_any_cpu() and arch_irq_work_raise())
> [ ... ]
>        prevention.
>=20
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026025735.5461=
01-1-atomlin@atomlin.com?part=3D10

