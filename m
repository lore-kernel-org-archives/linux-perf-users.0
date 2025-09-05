Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB1248176;
	Fri,  5 Sep 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102036; cv=none; b=WLBA75AtblCRFNJvwq1wfE9wYY9N/hUn2rKKXkrs3TK5cD3u8ok7yjJ7iVCGa4Hihst0mKUCdMuNcicEvyuPiFCB0e87N3n5uc6A3uvPPAh3WrRhXkKlocSHtOaZp89JuDS53qYsb++iMpfLiUzouITx1XvLXyZfWQGNi0hv/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102036; c=relaxed/simple;
	bh=cK7wgkHR+iPtZaN+skCDQj5o95KjhZGfeAVtHtFDT2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVCeF/xiUCCWcjk7r+SdISRi4arJTQfYrkiQASzHAQHpFQeeUd5Q/9bIwv9hN91YuvseiyUeu5PTGrThlj/qpxYQM3R2tbaPACNTkKVtXfA/SqRML+9JuM2bYAbEGbGnwyG4xKGPI7yWIQFQhycB/S8gajW1lDC3Yykzj1zETbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOL2RLyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOL2RLyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB826C4CEF1;
	Fri,  5 Sep 2025 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757102036;
	bh=cK7wgkHR+iPtZaN+skCDQj5o95KjhZGfeAVtHtFDT2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOL2RLyYuvigrBAaAairC2NPTtbIf3e/4TtrMCVyAOGLLZnRQGc/dpOulDNo0XnWx
	 pbPrYqjLmsBn498jkrM+oEt7cgu5T6bj+gXQr8IliPlbewgNRoMzcL1TE+mHlVziid
	 tmfi0/j/O24NiNIw6ENe4qNFZP7qytN/oWPcRHJigLpGoKujFUIlL9sBw94+O2xFzt
	 /APORlLXzBe9dJJC9Lov3YkYQMwi83zw0ZTn2KWxK7E83y/vTAPi04DupSm8d0f1WR
	 hML/CI8lMxLw9pHniVCmay7gq/loFJpmstPUe6WhJDB+sKGUMDbVvsSsOK0KO2qdTL
	 icYwg3GHmGDyg==
Date: Fri, 5 Sep 2025 12:53:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] perf annotate: Invalidate register states for
 unsupported instructions
Message-ID: <aLs_0g8yHblKWxyB@google.com>
References: <20250825195748.226052-1-zecheng@google.com>
 <aLKlDp6bl9Qjiziy@google.com>
 <CAJUgMy++zvbgcuzyQUiVHdaTZMa8o=LtSUzy9PXe_sqXHqK7nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJUgMy++zvbgcuzyQUiVHdaTZMa8o=LtSUzy9PXe_sqXHqK7nQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 04:54:39PM -0400, Zecheng Li wrote:
> On Sat, Aug 30, 2025 at 3:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Aug 25, 2025 at 07:57:48PM +0000, Zecheng Li wrote:
> > > Invalidate register states when encountering unsupported instructions
> > > that modify pointers, to prevent propagating incorrect pointer types.
> > >
> > > On x86, the 'xor' instruction may appear in a predecessor basic block
> > > and zero out a register that invalidates the target register state. This
> > > sometimes relates to tagged pointers and normal programs should not
> > > dereference NULL pointers, so we assume such execution paths are invalid
> > > and do not invalidate states for 'xor' instructions.
> >
> > Probably we can set it to 0 with TSR_KIND_CONST.
> >
> It seems TSR_KIND_CONST doesn't relate to a type. Although the value
> was set to 0, it still has the pointer type. I see regressions that
> has this pattern
> 
> xorl    %rax, %rax
> mov    %rax, (%rsp)
> 
> and sometimes
> 
> xorl    %rax, %rax
> ... (some branches)
> mov    (%rax), %rbx
> 
> Normally NULL pointer dereference should not happen, so I assume such
> execution paths are invalid.

Agreed, I think there should be a place to set the pointer to a valid
value again (before use).

Thanks,
Namhyung

