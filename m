Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DD282F3A;
	Sat,  8 Aug 2026 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151097; cv=none; b=sDaqk/iHM1ppPxUpBZwVDG5ttaVquHr0kAgrGnHSKXPRI/4tfpvT97QxS8UthzcdowDJiUbBOqZyNUp8Sq0i2EMxC/94kTC2vtbb6IxVp0goyKmp/k9oV5JGpyxVmWMFAapqX5O65mcFPiaSwWsifZzyh53rW8R9t/OIT+VD9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151097; c=relaxed/simple;
	bh=emMsCV+cxJyKlVmXwwX9as/ei5Bim5trcc6v6P1rp0U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SUvQ7ANdqa/MZaM//qqYzyxl6wyPg4v2hk+lwL6qJEhn8CPgsmxvHM8Hn5VE3wY0U10czFRbKh3WK9oZVtKs2MkpoW+ObnHB2Kn/Xqec+O4mAlypc7CGSu+DLy4/I0+cSXclAWss6jLwK8GAcklMwJLHrnbdLAjUpkKS6c3zIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXYk6G3q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXYk6G3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E48C1F00A3A;
	Sat,  8 Aug 2026 01:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151096;
	bh=GX7pXQdT14LYtoMBr1s9RIagYYeZR/7kvlKmfvzQVXs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bXYk6G3qZS6acVvu65NAnUAUrvGYgGDHTSwI0ovdC3DGP4CbnUi1pTkYGyL3OTwxx
	 2f3uGai7tOIyqH0Ge+u7n4xx0lP2B92dbkiewbEgP0iavldgBR1eX7DKSuykWMuHj/
	 STu5fh9hBeO3H+DnqLQyFMS48PaXhxf2L8ifxPaLoH6F4WqWLiBsC2dLmYC8qDVT51
	 Mu4038P3fs1RpA2Xh1C/L4WU+EDgX8+cN8B8cQmggccWbolTPyvJk57Qda/l1dDZ+Z
	 27KSEnqCGNvHlxTEBG8+RdiEa+zqKTD6yqumSjffCSa64KDHp0IZp3XtI+sXNivZDW
	 brNkDyM43SEvg==
Date: Fri, 7 Aug 2026 19:04:54 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Paul Walmsley <pjw@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
In-Reply-To: <920aee80-5297-4d70-a1ea-616976db7f70@linux.dev>
Message-ID: <09a1260b-aa91-f993-e81e-0c636cfd7942@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-5-7909f863a645@meta.com> <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org> <920aee80-5297-4d70-a1ea-616976db7f70@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Aug 2026, Atish Patra wrote:

> On 8/4/26 5:39 PM, Paul Walmsley wrote:
> > On Wed, 1 Jul 2026, Atish Patra wrote:
> > 
> > > From: Atish Patra <atishp@rivosinc.com>
> > > 
> > > The indirect CSR requires multiple instructions to read/write CSR.
> > > Add a few helper functions for ease of usage.
> > > 
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > 
> > Thanks.  These macros seem better implemented as static inline functions.
> > That also nicely aligns the code with what you write in the patch
> > description.
> 
> I don't think inlining these macros in the following way will work because of
> the following reason. It won't build once anything calls it.
> 
> csr_read()/csr_write() stringify the CSR argument straight into the inline asm
> template:

Yes, you're right; I should have caught that.  Too bad, there are multiple 
keyhole CSR index registers in use, otherwise it would have been a 
reasonable thing to do.

What's up with the subsequent followup message?  Looks like a 
cut-and-paste from an LLM.


- Paul
