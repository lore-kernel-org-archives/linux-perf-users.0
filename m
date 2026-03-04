Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3333CE4B3;
	Wed,  4 Mar 2026 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661924; cv=none; b=eKdcaUGdnJmrbMJyXpz6hxD+muq9lHCu8DpOigieiv6pNRsI0sT3ZUyKPpwawozX5JCBWItmMoQvzd4CqL7k7sJLqO0+7bGbk0bgnvL/xfs6h+zXjoHnqSoZth45DjuFuRgmDHBiBs1E2ylRVMcDbAiOjzz5OccxkV+snC5kwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661924; c=relaxed/simple;
	bh=U/3yw4K8MTY7Jq2U9AHgG9hj/2lCUNW5R8RcouL1fd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BONlXlUg6b+I/BllRkYa2lRy654ch9cuaxCq0UUXRYnA05YPfFiX6cskXN07wLbTEIMvIB9Ch+cmhi02l8aE/WnNChXKvWMuhIUYWKyWOfOTRpwj+T5NjA3A6/BDcjle9g76JO2Ak7lF28INelvcltVS44EvErIbkcYuPi3CllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXFC7mHS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXFC7mHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A081C4CEF7;
	Wed,  4 Mar 2026 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661924;
	bh=U/3yw4K8MTY7Jq2U9AHgG9hj/2lCUNW5R8RcouL1fd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXFC7mHSIThcad3aDjIy1ttv2g/oPUENBDNw3sofEDtDlFRx5XwjLeLpXreuIk3Sh
	 YyIc00DLiVW4ROcTERZuUeWncQhEtgGiDaK40NMd0bXrftCisiLIBSLGqmmw7zOijS
	 6n4F0KmOYRIH9oLoAMNVUUbzXWYNdwK5od6MaduZ7Q484Xk3S+ktEEwMxEdvmKPUeK
	 alEwNGaj3RhJEG9syq7eddAnLxVtj4ySvca7EbJ1r2zVV6fMNKJv41Me9j8pFglmQt
	 t86FbnIh48iSW5mK8gjn6NSQOM/l8wl2DOln9H9muZ2ma68NjkYoDP3AxcgdZwPxG0
	 VnWay5CVeKIXA==
Date: Wed, 4 Mar 2026 19:05:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH] perf llvm: Clean up after a failed disassembly
Message-ID: <aaisoZRkbVSZVkB9@x1>
References: <20260303230043.2074593-1-pcc@google.com>
 <CAP-5=fWL0jKGQuqBzP0xMWVkzu48c6JzgwWQ1+NkAxgbpSPpcg@mail.gmail.com>
 <CAMn1gO6ojcmH-aciLT8XCMPMx8LaNSpUDzAWGjTUp1kGnwMd4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMn1gO6ojcmH-aciLT8XCMPMx8LaNSpUDzAWGjTUp1kGnwMd4w@mail.gmail.com>

On Wed, Mar 04, 2026 at 01:10:02PM -0800, Peter Collingbourne wrote:
> On Tue, Mar 3, 2026 at 3:29 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Mar 3, 2026 at 3:00 PM Peter Collingbourne <pcc@google.com> wrote:
> > >
> > > An error returned from a failed backend will cause perf to call the next
> > > backend. If the error happens mid-function, e.g. due to an unrecognized
> > > instruction, we will end up with duplicated instructions in the output
> > > unless the backend that failed deletes any instructions that it created
> > > before failing. The capstone backend was already doing this but the LLVM
> > > backend was not; fix it.
> > >
> > > Link: https://linux-review.googlesource.com/id/I377eef3cd662ab98fbcd69e5004a259fa3d7aa06
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks for the review. I guess this one should have also had
> 
> Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
