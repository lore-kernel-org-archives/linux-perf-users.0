Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06F550DD4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932399; cv=pass; b=ZCSRjey1+lSxAXM4v1+5EBiRDoy59U4dx6/SKF1P8gT4TM6sBmrMoJmF5ryTXMlh8dECmje7Dplsm9kw1cnkbecji2Dj1rEahE2os8oFB0RGlKw2oSsET9lHc+QZCqDsAqtE/h7WORFtiuT6M9O1+oOtN0B11uCmy0rsLVaJUaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932399; c=relaxed/simple;
	bh=xY5cGd/OUwl4SOwi9wDO6hb1GlEWV5WxOS49wEMl6ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWyfLZqIYN0eSMpukt2bZRDjKFprQwi8rgvhb3TmDAVXzeYKSL0fSxjmnHvH7IDXHhPNGU0t0aPHAf0ifZbqe2WdVgfa3jZFMAEtNU1JFeLVeE6PJot4n1VUUMhp+rjzv1Xv3WWkjHSh48DWZwU3c6Pflp3a7FXUBiqysHjPQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZBEnQUB; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZBEnQUB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-533202fe429so965711cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791932397; cv=none;
        d=google.com; s=arc-20260327;
        b=RlzRg9atrEERrC4h+qqEdDMdYf2wzWYXJjR2j9/YHn2HMGVThbCSWVDgeqa3SIbRoq
         DHtHjnQIIQqzBMvrjallga6UopJWjOgjLpNeZl/x0kXZPuj2qZkSVm41jjHlPrZ+9wP1
         hBJMvR8NSTwoPnYr0O6hgDzEvCFLca5tGV2SGDHycBCuX5ZFL/JqzXQvYoRA4AD9AbXf
         A+oIIvp7CoAgkG1d+m1pL/ODGwTG0doYrcN7puf78RsSkmPIzCoC6qpea2DPUR42nMnQ
         OTNDDRcTOIVQs/Ku4r+SrcDwfDOb8DDogHRd8uoOhwUPQSxNc2o7wYuUMFN7Qf4KrY8l
         2rDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xY5cGd/OUwl4SOwi9wDO6hb1GlEWV5WxOS49wEMl6ZA=;
        fh=K/Xgmpkbo/xAH1R4eYs+K+NH44T3PLdTSbCSGDSKKnk=;
        b=HFXZMn7tJbk6P/2MMFvtKBYx6TYMRfzlG0mFqiweZ4nkAmo7LZxY8gUHInowL9i83f
         GZho8G7qVsqo0wXmDPK+/6C0IBSE+c2bAN50vp6gg8xZWKt0SgQzSlETs8SiElbxVzCh
         3opEM2E/HKbQOph6UEOsVSYFxErnVpk9e/Zts1aW9RBfXkAHLkE2atuiPzDY28nFoi+q
         60eOhCEHx4w9xJE7MNYqx4///lqDpA3wrMrBsYdpdqyjR4wx0HAJh/b6flKub1o43Z+1
         ywF5xh0OdpjnTrAURJae7Z23TUROZ6HQsHiiXxc28kYI9ZgIB9VhyuobCz9MDo9uv/zS
         msHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791932397; x=1792537197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xY5cGd/OUwl4SOwi9wDO6hb1GlEWV5WxOS49wEMl6ZA=;
        b=SZBEnQUB9/pOADsCdI0j71YvTlzwiYnRIqKl3syiPHqGWmJ2547U7M2SL8FYKs1M/9
         fK7C5Ae2LcyUQxWGAVybLJptgmD104b4YFm5jPCfgzYo5zJbWhGR7ObXN2aPusl6fgM9
         1gw0a6MiuFOH2Jx0uMM3fY9Oh2EfM4BO8o+HErPUnZQZ0K5EGwVVVVHCtcJGdT9HA2qp
         dUtfbAsnIjKwAV/1hnjXS6dLGWgeUATzH3iIw0AAUNqSluQFFK8b+GZ2/mGuFtpS7RNb
         0zIrs6d8oqWPuyQSqlHzX5W87Ij8psxN1MScuX2XdJek8y6u3QC+wNUlHOhfyBfidlSq
         uulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932397; x=1792537197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xY5cGd/OUwl4SOwi9wDO6hb1GlEWV5WxOS49wEMl6ZA=;
        b=I8s0fznzZaWKR17Pivr3hum6ayG65vQYDMOSqMS6HfmIGwd4xWIpSX7lt4oFLShVrX
         WTMSp3NG+CesoaNh2xIgHCP3MY/cUNhEmDk8EjtVHaktZwdRJBYmG7MQhWieH1pcW3r3
         6h18cEc1Wnb9k9yrHWsKO182ffTxVtrrbu/wdJtZELDVIKqaCJdaFL1+QJBK0ytcktYZ
         sWLDxJZQOPtS9YLEJd+CA/XwwHeYtQTdGTaW+ZtopqCfV/zO4V9Bh0AGiCLXbpXFaFB6
         8khI/7ZTQIWYcqlEU4BAFR13qc1cuU8MR7qFmPZXM7Mf4cGwm7yMY7Ros95ZQhukY7wp
         cDQA==
X-Forwarded-Encrypted: i=1; AKwUvBx6ZLX5vifp3Zmye02u1akYTwyHQol/HPDGAz9qfiisipeaTM6KpCOcJZPei+vaHYbMn+PcRi+U2kU9WLx2m7/X@vger.kernel.org
X-Gm-Message-State: AFq9FYIT40vqfjCWo9Y8dqfG+XkZTBxqHtvb82Lz5IVwV/6MxhcooJnP
	8BhpiTutBGKeM2rWCLYIpalicckdNBSlD0bbbC1UCa0nNoQK53ekheLzKxwxUOtXcELMoKcaAxL
	gxp7/1iWgl6aRQ1rBAVQuGcET/3Ggr2YSUxC419jR
X-Gm-Gg: AYBFou3QdZcTpttitdtu68O4ZuKn+arjrClOHSsFV6h10aNg+/EdZGfq0hZfob3sBz2
	TCwsRIWIBObRtb77EE6/MZDIWPgLMIzUaKTFEfMzByUjVimy7ozlPgAwaH5Bk9Fuyx6LoMnHBqy
	ctcEV+Gaxweya2yXAhMy1iBCi9gvmNXCF1tXaLRk2t3q57Ocs3mtqj6E1H7yz+J9B0NEBDw61Ma
	lvx05b1mzB82x0K3jP4PfNTaG41cvbouwEiDg+A9+y6oiJtJE4SfYqnShyktuyvojAnZ9e8RlZo
	t9BCc43cfScQTh3oEivNB5ljjc1iP1kLiAm6ytMJxfinx121LALI/vfRicDPbfqTL1hWTprRcFT
	IkXN7ejTJ
X-Received: by 2002:ac8:5c8d:0:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-536029187b3mr1791311cf.2.1791932395941; Tue, 13 Oct 2026
 15:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org> <fb2f83ea-cbe4-40a2-bbb3-bf2884ad8e05@acm.org>
In-Reply-To: <fb2f83ea-cbe4-40a2-bbb3-bf2884ad8e05@acm.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 15:59:44 -0700
X-Gm-Features: AclHuK-lBc-qQ1WS9bs-jEpVE3FRQf-vRMZYUNnHNAOM6niBmkWu-IQ6L4u5gR0
Message-ID: <CAP-5=fW0eOoWmN7kRUhCOVKvYsGs1fvqC746_HVa41MzjcOs-Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:47=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/13/26 12:44 PM, Bart Van Assche wrote:
> > On 10/13/26 11:24 AM, Ian Rogers wrote:
> >> Assisted-by: Antigravity:gemini-3.1-pro
> >
> > I think this should be changed into Gemini 3.1 Pro. I don't think that
> > the "Antigravity" part should occur in the Assisted-by tag.
>
> Has this feedback been noticed?

It was noticed but it was clearly wrong. The assisted-by line was
expected to be AGENT_NAME:MODEL_VERSION but in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/D=
ocumentation/process/coding-assistants.rst?id=3D816d9992d9ed434ec52cfbd6308=
0d518e535a41b
it is now requested to just put LLM. I can update this in v3.

Thanks,
Ian

> Bart.
