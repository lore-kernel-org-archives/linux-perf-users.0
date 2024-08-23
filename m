Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE818FC89;
	Fri, 23 Aug 2024 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423006; cv=none; b=HBOW4z1ejATbCpDTrYxZ9baaJjJVQCdTKiRAjnjFTnldFAL+RilEqtI+jLaTs7bjJzgr6FsRpAH5OW0+pPRDw0t41MqiDfmGRGPQ0TNA8I4FPC9fberWBo18p3Wco0XAxUs1fWUC4UM0ZTchxWCXna4iKqjN7R35P7O8Bt9ipbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423006; c=relaxed/simple;
	bh=olTMTURwfcZAzprtPckM5ErQH4xytlKY/2UeZkqFsaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1gX2brOGpN6O99rEwBhfYhjOPBrYfqWYyjewCDW906n7PzsSbO3yWGfwc6z4qCtn7yngf3EyKISeqVzFYENqMsm+89XfijpsPlSQprfU8DJVqyGNYOEgrZ+asLFehYGR6c02ULZX9OFEOuE/k4Tj6NLRlgToQm9Tv2so220mmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6OyQreo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6OyQreo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421ECC32786;
	Fri, 23 Aug 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724423005;
	bh=olTMTURwfcZAzprtPckM5ErQH4xytlKY/2UeZkqFsaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6OyQreozmSFIkjYqdbVF9Cbwy4pgptpS/TFEkM7ZgD4bFNL9CVmRysVCxps2jXJx
	 24gdK4DUrCJTpHgfz+f2T71Smoyd2gGpHHJHIQzIKrQPY84Kpaiw4FAGySNaqvh5U8
	 h6eFXgqF5+3U4udc8GnaOtJeN9kRQXW+GmyiuZJR706CQg62UJjRZjwrt9tg4spddI
	 K7tu56EuAyX8l2pvsjxa5XUQ8wtswOfh0ej+nz+sAumc9OasgPb4tUcT1RwgkXbMOf
	 GPVmg68gNUSbNp0r2iUtGcxzYA/MZWAAtIcLjfpZPqL4wLbA+XVmRNu75BXpSzzpqS
	 uTxEXYp0rY3qQ==
Date: Fri, 23 Aug 2024 11:23:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf trace: Collect augmented data using BPF
Message-ID: <ZsibWgNtUUSLEbd5@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-10-howardchu95@gmail.com>
 <ZsiNef72pSLnQO_c@x1>
 <ZsiQyahfNYCAmbZq@x1>
 <ZsiRvQiaIK4qN9Vs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsiRvQiaIK4qN9Vs@x1>

On Fri, Aug 23, 2024 at 10:42:21AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 23, 2024 at 10:38:21AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Aug 23, 2024 at 10:24:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Aug 15, 2024 at 09:36:25AM +0800, Howard Chu wrote:
> > > > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > > > @@ -427,7 +538,8 @@ int sys_enter(struct syscall_enter_args *args)
> > > >  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> > > >  	 * unaugmented tracepoint payload.
> > > >  	 */
> > > > -	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > > > +	if (augment_sys_enter(args, &augmented_args->args))
> > > > +		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > > 
> > > We shouldn't do that, instead we keep doing
> > > 
> > > 	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> > > 
> > > And userspace will setup the syscalls_sys_enter map adding the generic
> > > pointer collector (augment_sys_enter) for syscalls that have pointers
> > > _and_ are not serviced by a pre-existing, specialized handler, this way
> > > we keep the ones we have already and that already take into account
> > > pretty printing network addresses based on the network family, knows how
> > > to pretty print flags (the perf_event_open, etc).
> > > 
> > > I'll try to do this now.
> > 
> > So, step by step, first this, and then hook it to the syscalls that:
> > 
> > 1) have a pointer to collect and no handler, i.e. as a last step in
> > assigning the functions to be tail called from the syscalls BPF map.
> > 

Sorry, I'm wrong, we can use the generic collector and just in userspace
wire it up to the more specialized pretty printer :-)

- Arnaldo
