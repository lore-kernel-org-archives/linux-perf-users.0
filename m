Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235943A3E76
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940804; cv=none; b=FABb1910UIA+YlzQXaQxRp5IpBZ4I0byEX3VF/wd03qOSrumQxSDFnNUfgeynPp0rixGQGh+6Yqd6EGdQsHLFgpMBV8qEw8FfGbtF/EFc0c7sW+A7d/mFjb8qUfHPjpUOGZQTpm+ZjPOdvUoyqETjctwVEitR+zK38FNvs2eVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940804; c=relaxed/simple;
	bh=ORdY3BChQ2UtAILJedMhi0gqOJisbZ3lYG5a+vtOiyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUBYjejGkE7LjxAl0MCek6SweCMKWUZRwLeSH+XvCRP4jqULHdSkmZVMdZ2GaiR5GsWw+p/dHMbYQBVu6uc/5oWSefLsdWc2+iMvgLsnl5/fmuoDe0TGiw0tu0JI5uB2qsIR3QXwI+HSCWGBnSVbYnE3sZow7YOpAGny5+fCy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbO/bPUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbO/bPUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F95C1F000E9;
	Wed,  1 Jul 2026 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782940802;
	bh=/2e/5ZFdXtsnqMPhULM83nX8C7FvyJkqUqwDCFA6SkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbO/bPUoyA7dXdNuXTJuzhNhIxDsx40WFfG0ZBEW37z8KiKWMhNu48iOuumjPsca8
	 mNTLY7Ya4feQoExh82KHndpMHCdsWcHGLJvUJft8oKnB/iQFJNXnExGfp2jk7uZ6TL
	 i1SQyqbj+XdC31NKTP2XXtzidHU3/jycIKN7sus1wE9EsSDslcJnhKsRKIouskL56Z
	 qpIV5a7Guv9CaRIjRdq8Q8T93NGDOLIxSuLwFg2uAiCbJaqZ3e7EXuaTYTHl0kubpU
	 Y79BSO5Ds+3bqeKwG2N7z6pZDrLYjxFC8nb2MmeS67+ldlxTDR0n64L8oykG3zBpnH
	 jlr25bAsYwR7g==
Date: Wed, 1 Jul 2026 14:20:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <akWEgMBK7Y39sgc8@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>

Hello,

On Thu, Jun 11, 2026 at 05:23:45PM +0530, Tanushree Shah wrote:
> Hello Arnaldo
> 
> Thanks for checking the patch. I cannot see this patch applied on
> perf-tools-next yet.

According to the other comment, I guess you're supposed to send v2.  No?

Thanks,
Namhyung

