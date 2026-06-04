Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194411EF39E;
	Thu,  4 Jun 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605687; cv=none; b=aEaI87XCGt3qSwTWCLcgqR8Yj6OXbtO9Cx9PNtWXhiuB5/4ewjGfOkSGEM/RAGNFPi51fDQ6Gkopw6ycbChBguLa1mlNHeTIJxFFSSPnMCkY4mdtsyCO1ZgLra9G52e/EWJXxTfth5OoqImA127DB5euZgUpMFDJOltCpz1gOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605687; c=relaxed/simple;
	bh=qg8/KHZKpbMSyILm7vmo8nMSXcTMphI7fDe57QTCBtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwyRV9w9pHybX38BsFvFBQEWLbDIo+A1OZV9+TrlkohddWFz97DstTLRNgiYXntPQ42eBqesa/rL2E/JfOuRi/L6BGjDRoMU2nk3Ob48V3QoEd+X+KUTQGxOdQ87k7c1L2MxT8SSd6l3qI8zMrtsh6zRcSYPnk4j4kGSDCWJH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWTDJq2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWTDJq2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E31F00893;
	Thu,  4 Jun 2026 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605685;
	bh=nEqvc7LBP5T2u81aQdijukvBCGhr4HrO2B1sHhdyD5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oWTDJq2GOcuA7+OTlKD7bnXf9e1/JDmm6/jvsC82lpeXYfSt5o8QFEn3rK4QyobZl
	 pUZcUs0z0TBdmftg3vdT/fEa/+Qv3KKar7WL6GMH75geBGb2tvi5ePgsXiZOARwlwU
	 XJ5bjum4oyD3LdxM8U2Q2TpXXRjB/9guueC5E5Mcpi0LUqRKOFJzQ7DieQSTU9CrP4
	 GLhe3AQ08dXTBYv0kIRM2hGX/N6ZSo2OwhQNeGAiAUnrMhsBTPqUzhma1lk6rr2a3+
	 VnnroJi37qCMIm1RFTOkYkcicNbYBQsvuqWK6aFPr4CkT7/aSWe+TZnIapwQXMDBKH
	 oF39ThtnqUSBg==
Date: Thu, 4 Jun 2026 17:41:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf sched: Fix NULL dereference in
 latency_runtime_event
Message-ID: <aiHi8vAGShdk-46B@x1>
References: <20260604201119.1702338-4-acme@kernel.org>
 <20260604203011.430A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604203011.430A01F00893@smtp.kernel.org>

On Thu, Jun 04, 2026 at 08:30:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Using strcpy() to copy untrusted string payloads into a fixed-size buffer leads to a heap buffer overflow.
> - [Critical] Unbounded attacker-controlled PID values are used to calculate memory allocation sizes, leading to integer overflows and OOB writes.
> --

Both pre-existing, added to TODO files for future series.

- Arnaldo
 
> commit ab6f421859203bf939f45ab57b4ced38c5193ef5
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf sched: Fix NULL dereference in latency_runtime_event
> 
> This commit fixes a NULL pointer dereference in latency_runtime_event().
> It moves the assignment to atoms using thread_atoms_search() after the 
> thread NULL check to match patterns used elsewhere in the file.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 13b801496a012..36da451447b5e 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -1213,13 +1213,15 @@ static int latency_runtime_event(struct perf_sched *sched,
> >  	const u32 pid	   = perf_sample__intval(sample, "pid");
> >  	const u64 runtime  = perf_sample__intval(sample, "runtime");
> >  	struct thread *thread = machine__findnew_thread(machine, -1, pid);
> > -	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
> > +	struct work_atoms *atoms;
> >  	u64 timestamp = sample->time;
> >  	int cpu = sample->cpu, err = -1;
> >  
> >  	if (thread == NULL)
> >  		return -1;
> >  
> > +	atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
> > +
> >  	/* perf.data is untrusted input — CPU may be absent or corrupted */
> >  	if (cpu >= MAX_CPUS || cpu < 0) {
> >  		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
> 
> [ ... ]
> 
> While reviewing this file, I noticed a couple of pre-existing issues in
> register_pid():
> 
> tools/perf/builtin-sched.c:register_pid() {
> ...
> 	if (pid >= (unsigned long)pid_max) {
> 		BUG_ON((sched->pid_to_task = realloc(sched->pid_to_task, (pid + 1) *
> 			sizeof(struct task_desc *))) == NULL);
> 		while (pid >= (unsigned long)pid_max)
> 			sched->pid_to_task[pid_max++] = NULL;
> 	}
> ...
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but could an attacker-controlled
> pid from an untrusted perf.data file overflow the size calculation here?
> 
> If pid is set to 0xFFFFFFFF, the pid + 1 calculation wraps to 0 on 32-bit
> systems, resulting in a 0-byte allocation.
> 
> The subsequent while loop would then write NULL pointers sequentially out
> of bounds, which could corrupt heap memory.
> 
> 
> Also in the same function:
> 
> tools/perf/builtin-sched.c:register_pid() {
> ...
> 	task = zalloc(sizeof(*task));
> 	task->pid = pid;
> 	task->nr = sched->nr_tasks;
> 	strcpy(task->comm, comm);
> ...
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this strcpy() allow a heap buffer
> overflow?
> 
> The comm string extracted from the perf.data payload is copied into the
> fixed 20-byte task->comm array.
> 
> If the untrusted string is longer than 19 characters, this could overflow
> the struct task_desc heap allocation and overwrite adjacent fields.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260604201119.1702338-1-acme@kernel.org?part=3
