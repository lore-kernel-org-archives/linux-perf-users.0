Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518D14F128;
	Fri, 10 May 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350300; cv=none; b=Zp05bDs/ZH+tHvDBk8RnVjSIVU2J+JiC+TXJKQm7V/+Q3UnLfXRtwL5pqpL5W16f22BltjAmiD9r0Qs+qIRvAfeCXR7siLo7nWse+wTGJWoY8ToENsumkad5kG3oAkm41h1gshS41xNTxwHb7xT9eCkA27woZk3mwg3jfj4lGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350300; c=relaxed/simple;
	bh=q7yd+LxWVrFgZb4nADozbMwcenuTYYFwIYSo1N9rU/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsyVP40BWoQclnHSXBege01N9p4T3yIwZuDJt6G0BlI6IrVyNg91JyY1rN7JH57jD7yeXWl+UphlikDp9+lHmaIHBe5meXuJV9jWcIQghrjQAEmdeRP9gKa7FnZBRr9gJ6vJlxs13lYc0cThPr1QkORz8ElOAc+j96PzwIuN8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBM92HgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBM92HgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE8C113CC;
	Fri, 10 May 2024 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715350299;
	bh=q7yd+LxWVrFgZb4nADozbMwcenuTYYFwIYSo1N9rU/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBM92HgLZb8A2EIOPr33caZV87whBXqDUfRwTn+gP5Ujcq37ym5vd9UqTfvaAwf6W
	 0sazTkmZKe2dxb9hKsf5hatPuKxuUe/zXnXGWHBsyv7fCazmtXT4uy402IWu/8xlM9
	 eTtNl0L4TCLHrLZMrnI3zCJbTIeDjYReDZ7kNwC08eDpptCOTKrbGrLD2Jl+pjfXu9
	 JPqWPBE8qz3DFibXSzdUSqV6mwdKNtArF874ycbpdky33Xti5qBWkmftKI5aqN8RVH
	 igZQL7q46FFeyOIAc3WN8SvH9jEw1nPjYvaWDhW5R8Xv9Y9LA/lX/RlgcDxbZ1qq1l
	 oar+U1u8gv4BA==
Date: Fri, 10 May 2024 11:11:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf sched: Rename switches to count and add usage
 description, options for latency
Message-ID: <Zj4rGMsl42_GiDjc@x1>
References: <20240328090005.8321-1-vineethr@linux.ibm.com>
 <3buy7zyybshlphybersfof2acjcbrpxllrcvobizwyse4356nd@7sp74wyxbbfc>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3buy7zyybshlphybersfof2acjcbrpxllrcvobizwyse4356nd@7sp74wyxbbfc>

On Thu, May 09, 2024 at 02:49:56PM +0530, Aditya Gupta wrote:
> Hello vineeth,
> 
> On Thu, Mar 28, 2024 at 02:30:05PM +0530, Madadi Vineeth Reddy wrote:
> > Rename 'Switches' to 'Count' and document metrics shown for perf
> > sched latency output. Also add options possible with perf sched
> > latency.
> > 
> > Initially, after seeing the output of 'perf sched latency', the term
> > 'Switches' seemed like it's the number of context switches-in for a
> > particular task, but upon going through the code, it was observed that
> > it's actually keeping track of number of times a delay was calculated so
> > that it is used in calculation of the average delay.
> > 
> > Actually, the switches here is a subset of number of context switches-in
> > because there are some cases where the count is not incremented in
> > switch-in handler 'add_sched_in_event'. For example when a task is
> > switched-in while it's state is not ready to run(!= THREAD_WAIT_CPU).
> > 
> > commit d9340c1db3f5 ("perf sched: Display time in milliseconds, reorganize
> > output") changed it from the original count to switches.
> > 
> > So, renamed switches to count to make things a bit more clearer and
> > added the metrics description of latency in the document.
> > 
> > Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> 
> Makes sense to me. 'Switches' seems to be context switches, so it might
> be better kept as 'Count' only.
> 
> Hence,
> 
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks, applied to perf-tools-next,

- Arnaldo

- Arnaldo
