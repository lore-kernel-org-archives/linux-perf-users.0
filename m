Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A634E350A1B;
	Thu, 13 Nov 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038365; cv=none; b=hzohrSrL/kgi8U+cUvuGMmz11VK7BbKSOlWmfXfbrdMyRzTV8xUJt3wYcHfA2s3IcH4PZagJQ6L+TB38fG/+B4odRjLbSq3cU1RQpbyyiC+GwcRPEv34CFgOZWf5MqBAAzMe14UKQm1wNdOColf/5d1+KiTO68VlM3H9+30y5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038365; c=relaxed/simple;
	bh=YO38BrRO3WpSWJadE4XGRbaNi9pExHE9ouW+qph/cF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVIvMiigRTP0pGd/Adq2u1XF57lg3z4SNmt6ofHyruUP02E6nixtGLH7WCv3op7v1qaUIKDGI5qU9VWVP8EiNXwE5noS8CBmPDoft3xKgJNKJEMiIzFy3vLgQaXulnu7dhgnohHdohPcZLkqvAF3uPdR3Qg7T6uuWWr+A88hErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbP7JPSn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbP7JPSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B932C113D0;
	Thu, 13 Nov 2025 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038364;
	bh=YO38BrRO3WpSWJadE4XGRbaNi9pExHE9ouW+qph/cF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbP7JPSnqZktjCaFY1/UyCjj2YMhZoijMt1Ag0R9fExG4RR/Q8CoKPJ72ztygNNRK
	 vEOirNPKf7u0fx4n3AZXzTcckYeYJO/CaEIwJaZadJv/cPbVrvxUOd5y+wr2iti4eo
	 paT0n4nS0bpK4J+yDLfmypsfg3rSUtG9kaS6aDQxGX9dX9rf/27edTjQwDpyZZFLWn
	 YTp6unOe/TsaHoWsgMH03UpYvjJROahYyfe8PhTN1B6luyom8PC2ZdsjQNjceLrbzC
	 RgjrElIejnHoL2SQnz/HTw92lnvMDu02yAq219asuwIzqP3lIuxVQvFVQexk8E5Xvw
	 SNhnTNTq7xvPQ==
Date: Thu, 13 Nov 2025 09:52:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: write bpf_prog (infos|btfs)_cnt to data file
Message-ID: <aRXUmEfApr9UTfsY@x1>
References: <20251107173150.135037-1-thomas.falcon@intel.com>
 <aRO6z1Q76852Ig6n@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRO6z1Q76852Ig6n@google.com>

On Tue, Nov 11, 2025 at 02:38:07PM -0800, Namhyung Kim wrote:
> On Fri, Nov 07, 2025 at 11:31:50AM -0600, Thomas Falcon wrote:
> > With commit f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF
> > info"), the write_bpf_( prog_info() | btf() ) functions exit
> > without writing anything if env->bpf_prog.(infos| btfs)_cnt is zero.
> > 
> > process_bpf_( prog_info() | btf() ), however, still expect a "count"
> > value to exist in the data file. If btf information is empty, for
> > example, process_bpf_btf will read garbage or some other data as the
> > number of btf nodes in the data file. As a result, the data file will
> > not be processed correctly.
> > 
> > Instead, write the count to the data file and exit if it is zero.
> 
> Oh, I'm afraid it'd create a compatibility problem.  But I think this is
> a right behavior and it's should be fine if it goes to the stable soon.
> 
> Arnaldo, can you please take this into perf-tools tree for v6.18?

Ok, agreed, I'm taking your request as an Acked-by, ok?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> > 
> > Fixes: f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF info")
> > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > ---
> >  tools/perf/util/header.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index db2ad19fa50d..54968881481c 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1022,12 +1022,9 @@ static int write_bpf_prog_info(struct feat_fd *ff,
> >  
> >  	down_read(&env->bpf_progs.lock);
> >  
> > -	if (env->bpf_progs.infos_cnt == 0)
> > -		goto out;
> > -
> >  	ret = do_write(ff, &env->bpf_progs.infos_cnt,
> >  		       sizeof(env->bpf_progs.infos_cnt));
> > -	if (ret < 0)
> > +	if (ret < 0 || env->bpf_progs.infos_cnt == 0)
> >  		goto out;
> >  
> >  	root = &env->bpf_progs.infos;
> > @@ -1067,13 +1064,10 @@ static int write_bpf_btf(struct feat_fd *ff,
> >  
> >  	down_read(&env->bpf_progs.lock);
> >  
> > -	if (env->bpf_progs.btfs_cnt == 0)
> > -		goto out;
> > -
> >  	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
> >  		       sizeof(env->bpf_progs.btfs_cnt));
> >  
> > -	if (ret < 0)
> > +	if (ret < 0 || env->bpf_progs.btfs_cnt == 0)
> >  		goto out;
> >  
> >  	root = &env->bpf_progs.btfs;
> > -- 
> > 2.47.3
> > 
