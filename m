Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06A370D55;
	Wed,  4 Mar 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656211; cv=none; b=Xg6u5l5wuB3Q16oihR0EvfZ8neg1CyzeeHYrp6ortZY1uVEvv/wsvMLsgcSr25ZO5m3aCDTuk3i8pMAmq4T8XVbTwcT6UidL6yjyhYPqOgNB4By1knRbHh4k5TM7Z7LI+fEaQGe64L+iuTwlduVOuYklzO0ARSPKWLx5Q0Ka8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656211; c=relaxed/simple;
	bh=et6aMYo3QuuYAYztH/UN7kmVLs8NFq7aThaJMhdSFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPYO/AmZ1ubOdYM4CDVPod4UvoCvce2grSpKh4IMEVghGZJlkcavjG8Lx3FkIIfaiSJA24gaMlqF+1Eg5BvwE2aIBY+M/3dlHgq/VtMpNN6jHf4n3WjBX8jXE1VaPlyX8dOwSzvmsD3R7jhKjdNRtueBQuAMtrQ7WGb5VSiWQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXLDMnP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXLDMnP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C374C4CEF7;
	Wed,  4 Mar 2026 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772656211;
	bh=et6aMYo3QuuYAYztH/UN7kmVLs8NFq7aThaJMhdSFW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXLDMnP5uBpuIphJxf2K5d9Pz6f6KcD0T/sB3vZdQClkCiVqXBp2+2KJtPoYkdIMI
	 ypKJeuMlUYtUxf5DzzAA+Lbl3NtR1nhnMB2FjHkE9ruGGvy6QXrkz9qTZkaOxEyOIJ
	 yTt6hiZzT9N8nIvCyjAeqnz2WUPxAVsXONflaiqhQXA2Eml2orrHG0SGwiqyP/7kEM
	 QqmdgRfG6ZuL8K6o62Hk6OeAbJ9ddp7J1K06efwiIvyhe9TDBlP/rBH3JpL8JNrcM+
	 Px0nZ2NTuxq1gkMNm3dOtDkhZ3zc4yMNV/bMMqnT/f6YCeZUWFgN1tnE588JWhVy2N
	 w4KG3TI1gAFyw==
Date: Wed, 4 Mar 2026 17:30:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Collingbourne <pcc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf disasm: Fix off-by-one bug in outside check
Message-ID: <aaiWUGT2HLrqnm8n@x1>
References: <20260304190613.2507582-1-pcc@google.com>
 <CAP-5=fXZ1JQANk55R7PXKk0m6PP27GBrEW5pTBECa9TYJACeWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXZ1JQANk55R7PXKk0m6PP27GBrEW5pTBECa9TYJACeWw@mail.gmail.com>

On Wed, Mar 04, 2026 at 11:49:02AM -0800, Ian Rogers wrote:
> On Wed, Mar 4, 2026 at 11:06 AM Peter Collingbourne <pcc@google.com> wrote:
> >
> > If a branch target points to one past the end of a function, the branch
> > should be treated as a branch to another function. This can happen
> > e.g. with a tail call to a function that is laid out immediately after
> > the caller.
> >
> > Link: https://linux-review.googlesource.com/id/Ide471112e82d68177e0faf08ca411d9fcf0a7bdf
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> 
> Fixes:  751b1783da78 ("perf annotate: Mark jumps to outher functions
> with the call arrow")
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/util/disasm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index ddcc488f2e5f0..9e0420e14be19 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -384,7 +384,7 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
> >         start = map__unmap_ip(map, sym->start);
> >         end = map__unmap_ip(map, sym->end);
> >
> > -       ops->target.outside = target.addr < start || target.addr > end;
> > +       ops->target.outside = target.addr < start || target.addr >= end;
> >
> >         /*
> >          * FIXME: things like this in _cpp_lex_token (gcc's cc1 program):
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >
