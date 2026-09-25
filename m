Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96D44065E;
	Fri, 25 Sep 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341241; cv=none; b=dl1ESpifa7yntvzqeISfJrEp+4oSwgFEZR4euGwmXimyv0EBTNiE1NwolWztT9LzA+Om19Tx8I78TCOOpU6KGRkYmOhOPW/YCnHGJeY7TI68U2e2kZq+8CUUO1sh8hOMDAIJUcgLY7aUCGO4C1cNhvYmlZCMHItcgtUJ8c3cNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341241; c=relaxed/simple;
	bh=llz87AJIbWyhj0ZA+baC4W0bJU7jcx4/W6AURj19Txs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCrziTaASwWWfHfyWBayXGukShrD5krH9VekapLoxLdxPpwpP0qvgBsQBHDtZxnZOqRmqjoiDSPhWfQwcnB7pTnXuDKUvS08ajotrMRf+w4am+lRPqBuDBGlmzND3nakcNy2UQTi7V7/qO+FRf6U/LtzZJ/vqsIw1ww4ESo9dho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cchWlNOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cchWlNOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036551F000FF;
	Fri, 25 Sep 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341240;
	bh=MPJyy2BHIDkce8XTnOu6bbqLDOSaexmEKIrNPW0uwfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cchWlNOqhst5Qf72EFF87tl/wXmLQl72TuKzWlWlUNn0X3NTaXQzD28Oy48CA1nlz
	 bL40QBrTduL1hZY9ENOrSx85axw8NiFKRNrZjyD50XF2Oto+lVJyil/gwXabdWJsik
	 NSxK4pw5zbQUhrd6vBL1bC8vaFbcJNwMbIWaRNEXko3rRnIUpKxpKrSMbkQsgAgtoo
	 uoqnq3DCit3lH+ZaKRL5XIdBI0YZ0MuVoCVR0gjSIqy4Ag/5zCH3maTd75+Vuk44Kp
	 2hWtN+W8qE1Jp/yIYfs5EFdsBE0J71X4nMZKt4oQX1n52d3w/bUg8ugEufKDGrVTDQ
	 lkGncs7/zJf7Q==
Date: Fri, 25 Sep 2026 15:00:38 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf trace: Tracepoint format error handling and
 leak fixes
Message-ID: <arZwdv3BzLFQWq8X@x2>
References: <20260918063249.2172589-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918063249.2172589-1-irogers@google.com>

On Thu, Sep 17, 2026 at 11:32:44PM -0700, Ian Rogers wrote:
> Running 'perf trace' under address sanitizer turned up a handful of
> problems around the global tracepoint format cache.
<SNIP>
> With these, and with an unrelated libtraceevent fix I will send
> separately to linux-trace-devel, 'perf trace' exits with no leaks
> reported.
> 
> Tested on x86_64. Every patch builds individually, and the series also
> builds with NO_LIBTRACEEVENT=1.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
