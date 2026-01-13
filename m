Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678723148C6;
	Tue, 13 Jan 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337293; cv=none; b=hmxsPqzhoGqSTWCdLIoOVgTfwuMKujieY4PUldnKlrCwPy2tDCXl9k0JPPn5c43Nq9w7K8cmuLPaowlrRyBQYLouy4FdgQVRLc+fhAVN36hGsTgnhcvw5o4eCTEL4RLNgB7Fjk8HWIkVmhrGY3EFRinl3y8qZsNgZH8CkSmHnck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337293; c=relaxed/simple;
	bh=vdFG9hByGvH/mt525ZcH9NzV9HauP0cj+HFRj5HNHSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmTL3MZRSodSpzV/A6FFctsItSZrH5C4eomU8Fo54iYC2BJR+9hDSskp7T7P6Y2JA8I+P/NntJCkvKC5xHIbkLlKr0sRonBeqFy3LiS9nMZ6PFxMXDczdw6wNSnlYFPpQixxdztG30SclLtv/Q7DF1/uXjaIkyGMo6Cdq4zJr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9uQHZ7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9uQHZ7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B681C116C6;
	Tue, 13 Jan 2026 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768337292;
	bh=vdFG9hByGvH/mt525ZcH9NzV9HauP0cj+HFRj5HNHSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9uQHZ7yMpzuZlZ11q/nQXo4n5HyRgiM02k0n0o5Yew1vmZLRUrGK6NPj8ypzo9wX
	 0gK2tqL9QxNpJtN0FjP/n5njsf1wfzvok/YYCwsfESw6VB+fxWQ166Rjny0pogfSdL
	 mo8BUpZdobNLLMjHXQ7hiPpOfkWe8A7TjI5CAddZOyX8WU3UpCRAavQ8OUhOm97MjS
	 ESppINVyyochfO8cWOMTy1sZxTVq71K12xeThIDjuPOo0wp+asyURbgUv+pSMaWDDQ
	 LU+CUQxMb1rTx/f2zZ21ljKGY0SEzWgKYQPl6QfddYrmLdWOntSAhvlVE6CbMDe40g
	 wGX1eGFG0om0Q==
Date: Tue, 13 Jan 2026 17:48:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Peter Zijlstra <peterz@infradead.org>, yunbolyu@smu.edu.sg,
	kexinsun@smail.nju.edu.cn, ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf/util/addr_location.c: update outdated comment
Message-ID: <aWaviUF714ClwvI0@x1>
References: <20251230165213.102961-1-Julia.Lawall@inria.fr>
 <CAP-5=fWMQ8H8_Y3pNzau8F4pMOZxAXgY=8Rk+YiN2LiYQY+Riw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWMQ8H8_Y3pNzau8F4pMOZxAXgY=8Rk+YiN2LiYQY+Riw@mail.gmail.com>

On Thu, Jan 01, 2026 at 04:07:07PM -0800, Ian Rogers wrote:
> On Tue, Dec 30, 2025 at 8:52 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > The function addr_location__put() was renamed addr_location__exit()
> > in commit 0dd5041c9a0e ("perf addr_location: Add init/exit/copy
> > functions").  Make the comment preceding the function consistent with
> > the function itself.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
