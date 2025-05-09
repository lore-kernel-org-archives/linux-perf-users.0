Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F70228C9D;
	Fri,  9 May 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805659; cv=none; b=ZEo+e5y7HJCWkRJms0F1rGuC/FGfGx9OSRtM2oN6QPQ8nrPue0TWGQ9dMylONWUX+KgZCTOn5SkMU0rw2NQsCsLuyV2XQiXGxfGIHPJlatZzar8MBtHvgR+gle2AjkmyIu8/vlK500k6MmN8WxZ2p7YpKzpPSYpRriYwDqX37B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805659; c=relaxed/simple;
	bh=TjJRtu1IKdCYsfE1QjMqNHO1xvXGAyq+p+mPWyCIR54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdkHhXuyTTBxmVespaT0KTPPRcNhqZ9Ljnyobeeo+0bZNEILOpAUvNLnWE86VMKZonNUIpuqgj9fIK4MH/3sfjtqk91HbQ5h2kGZDxDIyjQTjr86uEMHQBXZSiodKL8kLX5yNBNGa/TPh0jaVneNBWebcFOSSGhmjvRANCP/2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmjnWLmb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmjnWLmb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AEBC4CEE4;
	Fri,  9 May 2025 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805659;
	bh=TjJRtu1IKdCYsfE1QjMqNHO1xvXGAyq+p+mPWyCIR54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmjnWLmbRYHj+HLr0b8pdBekNsD15yqatuqPwgkiIJEzlfWq+aDvgqh/bvRDjnEc2
	 yhdHJL9OaSbRjXUqyFeg2je3GDQUmxjmqJCAJYv8+iW3x4+4JiQNK2MicfbIrWSAGL
	 61m0KhYJ3DXylQaZ2YzMebcxudYxUA/k8FiloJLEc6gvZ7rAZsfNlYdn0moxt+E3Tr
	 JM11rbPK2c4y4dgbwvfGWtxSNghFIhQYP1pZYbBeSaKY9gUG45DsSJnj06wgfEshTu
	 MPd27X/2a6BL/9Qa7UPVpnrvBg+XjQJrS/xYDn+4ySSuatKSz2ZyVWjKRMlux7OQKw
	 MJB1sLZlSoboA==
Date: Fri, 9 May 2025 08:47:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Fix some more memory leaks
Message-ID: <aB4jmGT8M8bJEY9c@google.com>
References: <20250401202715.3493567-1-irogers@google.com>
 <aBzFGKKubskQDLrs@x1>
 <aBzrkz0__S_eupgB@google.com>
 <aB0QAUw7N9RaeVVO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB0QAUw7N9RaeVVO@x1>

On Thu, May 08, 2025 at 05:11:45PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 08, 2025 at 10:36:19AM -0700, Namhyung Kim wrote:
> > On Thu, May 08, 2025 at 11:52:08AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Apr 01, 2025 at 01:27:15PM -0700, Ian Rogers wrote:
> > > > The files.max is the maximum valid fd in the files array and so
> > > > freeing the values needs to be inclusive of the max value.
> > > > 
> > > > Add missing thread__put of the found parent thread in
> > > > thread__e_machine.
> > > 
> > > Split it into:
> > > 
> > > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -2
> > > 7900938850645ed4 (HEAD -> perf-tools-next) perf trace: Add missing thread__put() in thread__e_machine()
> > > 8830091383b03498 perf trace: Free the files.max entry in files->table
> > > ⬢ [acme@toolbx perf-tools-next]$ 
> > > 
> > > So that git --oneline is more descriptive, etc.
> > > 
> > > Thanks, applied to perf-tools-next,
> > 
> > PTAL this one as well.
> > 
> > https://lore.kernel.org/r/20250403054213.7021-1-namhyung@kernel.org
> 
> Split into two patches, as one fixes one long standing problem (from
> 2017:
> 
>     perf trace: Fix leaks of 'struct thread' in set_filter_loop_pids()
>     
>     I've found some leaks from 'perf trace -a'.
>     
>     It seems there are more leaks but this is what I can find for now.
>     
>     Fixes: 082ab9a18e532864 ("perf trace: Filter out 'sshd' in the tracer ancestry in syswide tracing")
> 
> But the other fixes a more recent bug:
> 
>     perf trace: Fix leaks of 'struct thread' in fprintf_sys_enter()
>     
>     I've found some leaks from 'perf trace -a'.
>     
>     It seems there are more leaks but this is what I can find for now.
>     
>     Fixes: 70351029b55677eb ("perf thread: Add support for reading the e_machine type for a thread")
> 
> - Arnaldo

Thanks for doing this!
Namhyung

