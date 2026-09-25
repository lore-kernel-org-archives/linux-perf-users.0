Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2146C844;
	Fri, 25 Sep 2026 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338289; cv=none; b=nrak0RuLBzCuBBirkM4QP/8eimzVDUw0oMeIyzCfJJ8cLycEBbpIDHClwuZdte9WUHDWB3rLDsXK1puKQdntwtGInal0QlQ9mDd/O18sSWiGEOz39iOELhBhpk+F6T7QKHgmHzj/aM3MpSA38eqd2VBilmFq97nIRqWAD0zKS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338289; c=relaxed/simple;
	bh=gj62A2SpGZAhUgc90zdhvT7pPKGEdSt5NSwdC4IaOq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDfOcAJmccsNRQuX7dm0ljjtf1Hux7lt+Bo66mGJCc41PcrZVBmhKYSZdnbU1OklJlGybAzTBkMPG+qnRwDehtuLsBf8lzfsCmqXlCiqgipCuDlfLNkCIw1rIu2E9x35FlQQYZoTjHDz+hLhAJQ6ZMTzRxSjYXBGwrk+rx7oXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhHZ5V92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhHZ5V92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265121F000FF;
	Fri, 25 Sep 2026 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338287;
	bh=THj7X5BYhRyhBWSsYEa3Qh57VlIqUQyhi23en46tx3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IhHZ5V9219Ubw6cVhLmMC+sNgR4AhrAWeTzyGCVhFDTiUbJYQr4rMjis13PwBblLQ
	 aKY67/KSdvz+Oca/3seYR2y8GwhhxXKmEabO5w7SDhYjvQ2AygdUr4RcOLigtdImce
	 mbZDmkUDwVK5x+abdMM2TctPwfN2xeP4b7X5rday864ZlH7hMku7sVe9xv5RxxyIxQ
	 gbQZUAopGi+qsnzfdy1UAVN95aFqpHDGNH5dmITr9oWtlpB3EZ6MBOWaYjyO6QM4TU
	 xfsKm49JshfbjJYnrcckfKanzdDUnC4FnRJ5O6CSgTZpyfxgl0VAotVr0QG6NzeWdH
	 FJeZuRIzYzpkg==
Date: Fri, 25 Sep 2026 14:09:11 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf machine: Add session back pointer to fix out of
 bounds read
Message-ID: <arZkZ-3QFuZHs75G@x2>
References: <20260918062620.2145220-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918062620.2145220-1-irogers@google.com>

On Thu, Sep 17, 2026 at 11:26:20PM -0700, Ian Rogers wrote:
> A NULL session is treated as live. The tests use synthetic pids that
> have no /proc entry, so the read fails there and the e_machine falls
> back to EM_HOST as before, rather than being decided by whatever the
> out of bounds read happened to return. perf inject registers its
> session with the aslr tool once the session exists, before any event is
> processed, so that tool keeps reporting file based threads as not live.
> 
> Fixes: 70351029b556 ("perf thread: Add support for reading the e_machine type for a thread")
> Assisted-by: Antigravity:gemini-3.1-pro

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
