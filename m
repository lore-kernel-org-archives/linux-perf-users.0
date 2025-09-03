Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66E289E17;
	Wed,  3 Sep 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921665; cv=none; b=rJNOmmIc6tLVn48DkaiOLZhbE0RelihTkvzwO+phVoVbZp5WiPHK8rQ86sBO2xnxd1oOkk8aukXjgwxU19TC2IDWxXqldsu+nr10COlx89yjhq1RESyVZH/63eOhW67aD3wTYJmVg+5SNFA7ciifGNQYLX1mOWZsxe6z3BKrVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921665; c=relaxed/simple;
	bh=LSPcx/b4GxO1reo0OroCmCKmkpmZRyqb5S7uud1x2ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY/PQWG/qix7ALc3iG0Qtjqvf/a2QOq9XBuEnHMJSfQMf7EHugsE9wA9oQ5nc/NCZ5OvuHqRqaxyG6ELWYOP2T2rmHsS3+O95e3dMBDHHG9Hw+R9KNP80aKiV+iwMDIRwOIH9taUqVq9fctHV8QIr12DLih8iLRbr17hJNynwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D78hzjcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D78hzjcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5936C4CEE7;
	Wed,  3 Sep 2025 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756921665;
	bh=LSPcx/b4GxO1reo0OroCmCKmkpmZRyqb5S7uud1x2ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D78hzjclQIczvxXs4uwWIrxbbcqejaoP0HObyt4n8xjnCGr9+Br1Puryux9582/mz
	 59JmzZeHxd6qsS5M+cVnHV6TOXKZFO0gi7WTwYzdrR4AigGxfrQ/o7W+60XGry3P+1
	 L7mDIfal42JRB+bhNgs3UDosPDYgeohXDVria/i7gxUKutk/mdwvsh7RsMmU7pRqXX
	 LQFzhU6RkcskvTxnCEAR6yfHQ9ctk0OO+m9f+1oV72YbAxT9ywManM8y1fLUPz9sm/
	 mbJYEZXCZ5+9VzeEm3LTozfm5fTBxCR9FzUs/zc6Q8GH9sDhAoEfbjcsprApZ3S/1a
	 bRvLFYcTHDzRA==
Date: Wed, 3 Sep 2025 10:47:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6.17-rc] perf tools: read_build_id() blocking
 argument fixes
Message-ID: <aLh_Px017dpHgNMC@google.com>
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <aLhf9wc3_1OIFGkZ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLhf9wc3_1OIFGkZ@x1>

Hello,

On Wed, Sep 03, 2025 at 12:34:15PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 03, 2025 at 04:15:25PM +0100, James Clark wrote:
> > The function now takes an argument for O_NONBLOCK. The first fix seems
> > straightforward. The second one is _probably_ fine, but I can't really
> > see any easy way to fix it because libbfd handles all its own IO. Maybe
> > we need to compile in both versions of read_build_id() and only call the
> > libbfd one on regular files? Or maybe in that specific use case it
> > doesn't care, the commit message for adding libbfd there mentioned Wine
> > PE binaries.
> 
> I noticed that yesterday and have this in the tmp.perf-tools-next
> (thought that had sent to the list but didn't) branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next&id=4bfe653aa3fefd429671aa27413a1124fe65b9d1
> 
> But since this affects 6.17, even being opt-in, I think it should go
> there together with other patches that Namhyung is collecting in
> perf-tools.
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Yep, sure.  I'll queue them to perf-tools.

Thanks,
Namhyung

