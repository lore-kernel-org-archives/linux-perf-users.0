Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389F477E42;
	Thu,  4 Jun 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580103; cv=none; b=LJ2na761qKbelnJ5qtMohsllKdv0c5FhyPrk6CZ4wJ1BeKti5hQJJY+2CyGUDPc9YcWQbYyilBWn4WLoF+8AXr446V1bGbd2n+5uv6R6CAoVUVAhn6W9OOb1Lr5WGQhU1cXD9dZr4k9zYxx3yzlAgXoKQuetGStg38M4rhq0gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580103; c=relaxed/simple;
	bh=2RlmAjrvxW7Oswt+wu9yEzNlDWDWxMapoDYea4ZA8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiSnMKW24AUesH2ptD5feFGM3dX5OWXv32TXg4XxEj8aFmLyGJNY63bHaPIQ7JTkdlaSSdx3pEieWXm3CoHlFPrHffjeeRgrNiy9SjiFklLBaTSbzAGuX2WzJhQMfg/dFK3qnVZVokTigEdkgDBtawUdnbeoA0AUJnyLhOUGUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwvUEf7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwvUEf7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C251F00893;
	Thu,  4 Jun 2026 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580102;
	bh=4ZDMTHw1WtIk8Z3Vxapmkml4jCdlkVuMfru4VLynwX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CwvUEf7iKO3v7t8YFVD3Jv6h3HxTcUi3cxO7yieLbY/krik6Y8j3PjF3JpTIglcqe
	 9mVyaXWcbZ2hDQ+d/NR2e+ESWn7lwFrtsPr7uGpDp8A4rDN13gkYt2+inDrBIEx5ll
	 13y8/M4GL/Xk2prWT9avLHCW2xKB/PGP3bnvWrDabQDOHMYNXbrJZt4+NhnIsmiXaD
	 MYVjX7v36ifeWjEKn08XgDPZMtOA9RDPDdtLmGmM1gwO890THznwt/aArCWI1u7mZd
	 4gLKpiS6cSjW7Wu7bToQ3GM1+pVEiLyHvlWoVTkK6Fk+Fd6CFoTT3ccTRzgYn2iJHa
	 3uT4HTBXD/zoA==
Date: Thu, 4 Jun 2026 10:34:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf build: compile BPF skeletons with -mcpu=v3
Message-ID: <aiF_ApG1ykL3MXdD@x1>
References: <20260530195511.71452-1-suchitkarunakaran@gmail.com>
 <CAP-5=fVZ0zOG4yEPjn2Lk2H4zteoHKjmdKdNdMeeTTMCFvZLgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVZ0zOG4yEPjn2Lk2H4zteoHKjmdKdNdMeeTTMCFvZLgA@mail.gmail.com>

On Sat, May 30, 2026 at 03:39:32PM -0700, Ian Rogers wrote:
> On Sat, May 30, 2026 at 12:55 PM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > The lock_contention BPF program uses __sync_val_compare_and_swap()
> > to atomically update the max_time and min_time fields in
> > contention_data. This builtin lowers to the BPF_CMPXCHG instruction,
> > which is only available in BPF ISA v3. Without an explicit -mcpu flag,
> > Clang targets BPF v1/v2 by default on older toolchains (Clang < 18),
> > causing build errors when v3 instructions are emitted.
> >
> > Add -mcpu=v3 to CLANG_OPTIONS, which is used exclusively in the BPF
> > skeleton compilation rule.
> >
> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
