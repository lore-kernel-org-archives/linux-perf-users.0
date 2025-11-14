Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579842F5A05;
	Fri, 14 Nov 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104911; cv=none; b=kjB1HpkX153j+HQK/pkVpDyC2cxnIG9vNIyqbxIu92x0Lil+NHmDIoxeDZcloLsF6SSaXqYzKh5phmcaeeBq8pzT5AZaVoPVrn0JtDOiEFl8ndnz42XP5ENAm+ghQGpt1TlPWomFRPl12bTuTho9ez9Eht2kFSzw9nnv66DwO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104911; c=relaxed/simple;
	bh=FjnMlcv2z+/2PdZkTbt0s9xYqAI1t/6KriFBiywpthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwWPkrzE1L96hWnDN+Oz6JviK1jFQCjbjkwegr0C+h83j5jCrQF9OBSk96v2838JkQePs/XC52/IeyFHRulMQ23hQMolOXC2PQVeuWz6vhm+ExZVUT3sXueqEv9T3+W3Khn0ErLCArTd7blUdPhJG7mJiHKF3xcZsHAtKVgZr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuLtgzIJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuLtgzIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBE8C4CEF1;
	Fri, 14 Nov 2025 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763104910;
	bh=FjnMlcv2z+/2PdZkTbt0s9xYqAI1t/6KriFBiywpthM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuLtgzIJKQBNLYbNBCwG6ikNm3Lrjdmd/H0DQplTYWJDAh81ZpF9EfiQiiNs5MI/Y
	 IHSVDqnU9GAxk+z8qryah55YghCmPNnnWo1+3/IHVudQdYFdyDzJhV5NOaG8foEyDi
	 M6taHaNtSGkDO+zKaWuameEiPJy8UE9+dzPwn5m68F9UdoGs0orIkbLI5QUrvI66+p
	 iICmlyLdaiLrIUngbrH7/W5IvLgxvHgqxBN6rKgiWTwsry5pW8o7Q30eQncAw/tEZK
	 ONthCx8RLC4dTduZO6f/lwuM34stYwa4NmpNe45gGgiQlYCTyfU6u4SG5GMfHcYg2l
	 9Z9bscBP4yzYw==
Date: Thu, 13 Nov 2025 23:21:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: write bpf_prog (infos|btfs)_cnt to data file
Message-ID: <aRbYjFLCpLAFrMWD@google.com>
References: <20251107173150.135037-1-thomas.falcon@intel.com>
 <aRO6z1Q76852Ig6n@google.com>
 <aRXUmEfApr9UTfsY@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRXUmEfApr9UTfsY@x1>

On Thu, Nov 13, 2025 at 09:52:40AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 11, 2025 at 02:38:07PM -0800, Namhyung Kim wrote:
> > On Fri, Nov 07, 2025 at 11:31:50AM -0600, Thomas Falcon wrote:
> > > With commit f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF
> > > info"), the write_bpf_( prog_info() | btf() ) functions exit
> > > without writing anything if env->bpf_prog.(infos| btfs)_cnt is zero.
> > > 
> > > process_bpf_( prog_info() | btf() ), however, still expect a "count"
> > > value to exist in the data file. If btf information is empty, for
> > > example, process_bpf_btf will read garbage or some other data as the
> > > number of btf nodes in the data file. As a result, the data file will
> > > not be processed correctly.
> > > 
> > > Instead, write the count to the data file and exit if it is zero.
> > 
> > Oh, I'm afraid it'd create a compatibility problem.  But I think this is
> > a right behavior and it's should be fine if it goes to the stable soon.
> > 
> > Arnaldo, can you please take this into perf-tools tree for v6.18?
> 
> Ok, agreed, I'm taking your request as an Acked-by, ok?

Sure, thanks!
Namhyung

> > 
> > > 
> > > Fixes: f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF info")
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > > ---
> > >  tools/perf/util/header.c | 10 ++--------
> > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index db2ad19fa50d..54968881481c 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -1022,12 +1022,9 @@ static int write_bpf_prog_info(struct feat_fd *ff,
> > >  
> > >  	down_read(&env->bpf_progs.lock);
> > >  
> > > -	if (env->bpf_progs.infos_cnt == 0)
> > > -		goto out;
> > > -
> > >  	ret = do_write(ff, &env->bpf_progs.infos_cnt,
> > >  		       sizeof(env->bpf_progs.infos_cnt));
> > > -	if (ret < 0)
> > > +	if (ret < 0 || env->bpf_progs.infos_cnt == 0)
> > >  		goto out;
> > >  
> > >  	root = &env->bpf_progs.infos;
> > > @@ -1067,13 +1064,10 @@ static int write_bpf_btf(struct feat_fd *ff,
> > >  
> > >  	down_read(&env->bpf_progs.lock);
> > >  
> > > -	if (env->bpf_progs.btfs_cnt == 0)
> > > -		goto out;
> > > -
> > >  	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
> > >  		       sizeof(env->bpf_progs.btfs_cnt));
> > >  
> > > -	if (ret < 0)
> > > +	if (ret < 0 || env->bpf_progs.btfs_cnt == 0)
> > >  		goto out;
> > >  
> > >  	root = &env->bpf_progs.btfs;
> > > -- 
> > > 2.47.3
> > > 
