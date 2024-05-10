Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E23168AFC
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352449; cv=none; b=iLwRC5HldG2XaW5psTdPZCMhvYmLlcRFHlGv+v5d3MpKBjnSNAfk8r/EiUXWKTcn9uyl6RQmDaNjW/OXicrAuJHdkgDpWrZEs8sEyvBj56gSohkEbtHx50cy2XL+bddPgpcHSdntWARwzWJwpzrV+vGlBHIWGwLzRc1M45FAlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352449; c=relaxed/simple;
	bh=mec7BK4UbKmy11xqMaodWR1yTTNIi/xi35fG8qk5Ozs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyIXCxfUY3xmEr0OSN7TvtWRYH6XXsqMFQ4SM0En5xye1VQNLKR9oWo9rX/mO6AmGg5Dh2lMsE5EHCD/hstg5yuc+S47MIHvlQfzcetu3j2hDgeAoraWrk7TTRQClHmxNCzuQdSlsYsO8iYsuURAvgzh3dwfZpKyshaJWlu4GI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKTrcjEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKTrcjEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406BEC2BBFC;
	Fri, 10 May 2024 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715352448;
	bh=mec7BK4UbKmy11xqMaodWR1yTTNIi/xi35fG8qk5Ozs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKTrcjEmLAf3nSIvoNYehF/imK3D0IgJ63BAW9nAhf9HHLYtLqB+JU4E4hM+wIrUZ
	 rQ4AEaqNi8RIoC/cLiTyyjlsevoiFJ7+c0cMnFpHZ+oZEgOzRwxOzhC7no3mhDua1q
	 cuMK26DifTKvNghypajNRKHxNtyC3ZpqCy8ut+ueN5FAUetwKh0Bcw2Ag7KmYqYUk/
	 exmGyGe1R9YVnop8yVuZ4MD6KlN5wdwNIjnuZAy8bUXoR10yWr+nix2QuuaAqHsDr6
	 rAxUom9bs2Fl1rBH8Kl0DU3SgxS27idR/vIFMJaCiXZDdzJuHZ2iBhTNSfl6jLWvrg
	 WNPyMScktIgTg==
Date: Fri, 10 May 2024 11:47:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching
 sample" for brstackinsn
Message-ID: <Zj4zfpmJhbXGrqRS@x1>
References: <20240229161828.386397-1-ak@linux.intel.com>
 <ZjvhQbZhsda_kvy6@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjvhQbZhsda_kvy6@tassilo>

On Wed, May 08, 2024 at 01:32:01PM -0700, Andi Kleen wrote:
> Looks like this bug fix was never applied. Ping!

There was a comment by Adrian, about adding a comment with some
explanation, may I add that to your patch while applying it?

Adrian,

With that in may I have your Acked-by or Reviewed-by?

- Arnaldo
 
> On Thu, Feb 29, 2024 at 08:18:28AM -0800, Andi Kleen wrote:
> > In some situations perf script -F +brstackinsn sees a lot of
> > "not reaching sample" messages. This happens when the last LBR block
> > before the sample contains a branch that is not in the LBR,
> > and the instruction dumping stops.
> > 
> > $ perf record -b  emacs -Q --batch '()'
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.396 MB perf.data (443 samples) ]
> > $ perf script -F +brstackinsn
> > ...
> >         00007f0ab2d171a4        insn: 41 0f 94 c0
> >         00007f0ab2d171a8        insn: 83 fa 01
> >         00007f0ab2d171ab        insn: 74 d3                     # PRED 6 cycles [313] 1.00 IPC
> >         00007f0ab2d17180        insn: 45 84 c0
> >         00007f0ab2d17183        insn: 74 28
> >         ... not reaching sample ...
> > 
> > $ perf script -F +brstackinsn | grep -c reach
> > 136
> > 
> > This is a problem for further analysis that wants to see the full
> > code upto the sample.
> > 
> > There are two common cases where the message is bogus:
> > - The LBR only logs taken branches, but the branch might be a
> > conditional branch that is not taken (that is the most common
> > case actually)
> > - The LBR sampling uses a filter ignoring some branches,
> > but the perf script check checks for all branches.
> > 
> > This patch fixes these two conditions, by only checking
> > for conditional branches, as well as checking the perf_event_attr's
> > branch filter attributes.
> > 
> > For the test case above it fixes all the messages:
> > 
> > $ ./perf script -F +brstackinsn | grep -c reach
> > 0
> > 
> > Note that there are still conditions when the message is hit --
> > sometimes there can be a unconditional branch that misses the LBR
> > update before the sample -- but they are much more rare now.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > 
> > --
> > 
> > v2: Adjust comment (Adrian Hunter)
> > ---
> >  tools/perf/builtin-script.c                              | 6 ++++--
> >  tools/perf/util/dump-insn.c                              | 2 +-
> >  tools/perf/util/dump-insn.h                              | 2 +-
> >  tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c | 5 +++--
> >  4 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 37088cc0ff1b..b97f810ad00e 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1343,7 +1343,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
> >  	 * Due to pipeline delays the LBRs might be missing a branch
> >  	 * or two, which can result in very large or negative blocks
> >  	 * between final branch and sample. When this happens just
> > -	 * continue walking after the last TO until we hit a branch.
> > +	 * continue walking after the last TO.
> >  	 */
> >  	start = entries[0].to;
> >  	end = sample->ip;
> > @@ -1378,7 +1378,9 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
> >  		printed += fprintf(fp, "\n");
> >  		if (ilen == 0)
> >  			break;
> > -		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
> > +		if ((attr->branch_sample_type == 0 || attr->branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
> > +				&& arch_is_uncond_branch(buffer + off, len - off, x.is64bit)
> > +				&& start + off != sample->ip) {
> >  			/*
> >  			 * Hit a missing branch. Just stop.
> >  			 */
> > diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
> > index 2bd8585db93c..c1cc0ade48d0 100644
> > --- a/tools/perf/util/dump-insn.c
> > +++ b/tools/perf/util/dump-insn.c
> > @@ -15,7 +15,7 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
> >  }
> >  
> >  __weak
> > -int arch_is_branch(const unsigned char *buf __maybe_unused,
> > +int arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
> >  		   size_t len __maybe_unused,
> >  		   int x86_64 __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
> > index 650125061530..a5de239679d7 100644
> > --- a/tools/perf/util/dump-insn.h
> > +++ b/tools/perf/util/dump-insn.h
> > @@ -20,6 +20,6 @@ struct perf_insn {
> >  
> >  const char *dump_insn(struct perf_insn *x, u64 ip,
> >  		      u8 *inbuf, int inlen, int *lenp);
> > -int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
> > +int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64);
> >  
> >  #endif
> > diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> > index c5d57027ec23..292027a984a9 100644
> > --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> > +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> > @@ -200,12 +200,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
> >  	return 0;
> >  }
> >  
> > -int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
> > +int arch_is_uncond_branch(const unsigned char *buf, size_t len, int x86_64)
> >  {
> >  	struct intel_pt_insn in;
> >  	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
> >  		return -1;
> > -	return in.branch != INTEL_PT_BR_NO_BRANCH;
> > +	return in.branch == INTEL_PT_BR_UNCONDITIONAL ||
> > +	       in.branch == INTEL_PT_BR_INDIRECT;
> >  }
> >  
> >  const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
> > -- 
> > 2.43.0
> > 
