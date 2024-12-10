Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8623C17;
	Tue, 10 Dec 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856072; cv=none; b=eivAjagiHa9HUwhqwRa3BJ8tbgr2oDhOpsZ2DrJ18wN4bTW1ontTv2tP9R7SJFy5VzbH1hKTpL4h7jAdGg1yMnitnr2OcX+dMgc/UFI3srAzOAmxo4uAc1nYXQt9RkZGxQ3+Iu11OJc0cBnLVAsRjYjjr/LqlRv6QbLekMRmemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856072; c=relaxed/simple;
	bh=soLOHidzIgQWMfr23eBt3zFw+UvWx9WIHXuJsix5L+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTHd1KG3WhrwmwsozdbJ/ZWMCuBhhnuwTutsAja80GquogjYCqifn/e27hTUnamw5tD9aY6DQ3gt4OYbbWLHdhh/8w2ebZrj9fwyjNdyBSOmZtMyhmzHf5HWobae//+HC4ouEqFzshMFUrcyI3pahGLb4P3lM1BmS9cFVvdo0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghjmmVNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghjmmVNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72EBC4CED6;
	Tue, 10 Dec 2024 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856072;
	bh=soLOHidzIgQWMfr23eBt3zFw+UvWx9WIHXuJsix5L+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghjmmVNpTMNddgeyuw7kqDKEEv42JqLM3hDifVyzDH/A5n/3mvBZ822CUtIKpoBc5
	 kZPEw6l6YjwZbwoOx8zeIBa9mIsmkrZu+SQcXmhLiT9accecHTcMo+vVT4CQBLj4ZL
	 oqcr5LCbOBy2qoOjGw4rB3jfGfgtZ8I8EDTlRUqpqd+u22rc/Dy2fxO+HTeA7n1/PK
	 vbuirSBit21sM7SSijaCp+ENhyCRjlZ3oJqUxfF9ywKOgcmdAUk8KfVVtvm84nmexT
	 de+JIoAddSArWV9oh+1psbO/2coCckFWFp1eesCFTIBllphNQo/EpCvv0SCICKnOjM
	 Cp27W/BmTl8AA==
Date: Tue, 10 Dec 2024 15:40:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf-probe: Improbe non-C language support
Message-ID: <Z1iLO-JHiVj_c1Vp@x1>
References: <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>

On Wed, Nov 13, 2024 at 09:21:13AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 3rd version of patches for perf probe to improve non-C language
> (e.g. Rust, Go) support.
> 
> This ported the last patch on top of tmp.perf-tools-next, and add a fix patch
> for compilation errors.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next


Thanks, applied the first patch to perf-tools-next, the other was folded
into the patch that introduced those problems, to avoid bisection
problems.

- Arnaldo
 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       perf-probe: Replace unacceptable characters when generating event name
>       perf disasm: Fix compilation error with stubs
> 
> 
>  tools/perf/util/disasm.c       |    7 ++++---
>  tools/perf/util/probe-event.c  |   32 +++++++++++++++++++++++++-------
>  tools/perf/util/probe-event.h  |    3 ++-
>  tools/perf/util/probe-finder.c |   15 +++++++++++++++
>  tools/perf/util/probe-finder.h |    5 +++++
>  5 files changed, 51 insertions(+), 11 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
