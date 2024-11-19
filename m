Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00B1D1F56;
	Tue, 19 Nov 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035606; cv=none; b=cIdRGN10X3yEIrMWea+igoeM7G1Yibl568QL136CVrtHKa9nQb07osAERwAOmoqzCZzVzYceyGToAJ+VJXiUX0IcTTLx5bJ0s5VVQACeCKxVbRMyWFIX1OR13lKgz+w8n485/Q5y3kmLQiLXfzINVmZuhjsctUbTYQz+ZGSaJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035606; c=relaxed/simple;
	bh=nUKampE6m1Pc/cw92xoigRyF6ZA7CefrzrLuE5I65ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFnTXR4CbrFVWY67nVBpiBWE2IHGOTxej/bOWYPOfxcfwRrN7q5x0kW3RPww8SfmiXADIi1Qkiq9pqyeqLFD+gnmKBP7DYERd2tVPcZocOH6a+n2jtHBSRvNt2yVYoxE6uJfT7bb7CVMcoq5ao0pIgxprhC181Z/6PNl4q6A5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnfjGVqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnfjGVqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E12C4CECF;
	Tue, 19 Nov 2024 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035606;
	bh=nUKampE6m1Pc/cw92xoigRyF6ZA7CefrzrLuE5I65ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnfjGVqtLUnglyQYOpMNi8Ywk63ZEZrg2wN8WMQs0ugvxrgnSrvCZQ1Y74cGlPBwC
	 x766ZFEqnGrj4INHVto8hZyzHMxuIfDMDNoKmYDexAOb0NPXNbcDmFPw/KXhWuktlM
	 uLGZKBxNg377UHGnP+SaHhrMW4XeqHz4Bg6blkIuB5RdVembYSq8Kuy+an09QbrOJI
	 vbf9BDlJh8/SeXMv+1VIUc0gM2PxRoAEv8998SnMxu6uSw+Imk7ukEhvYHXDt4SXyh
	 sVyJ/sFEpfF0VVvxCdU/mFtmpiHp/cAME5ZfEbAcQsjXW97poarU4JErHiiFiTfVER
	 cW1EjER9GpbZQ==
Date: Tue, 19 Nov 2024 09:00:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 15/22] perf lock: Move common lock contention code to
 new file
Message-ID: <ZzzEE_kAjmXnvwtj@google.com>
References: <20241109061809.811922-1-irogers@google.com>
 <20241109061809.811922-16-irogers@google.com>
 <Zzvac4IeX9nDDitm@google.com>
 <CAP-5=fUPksNCJ-NqUbJMDpfS7kkmXGsCVhvALkts8HDv42NUyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUPksNCJ-NqUbJMDpfS7kkmXGsCVhvALkts8HDv42NUyg@mail.gmail.com>

On Mon, Nov 18, 2024 at 05:03:41PM -0800, Ian Rogers wrote:
> On Mon, Nov 18, 2024 at 4:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
[SNIP]
> > On Fri, Nov 08, 2024 at 10:18:02PM -0800, Ian Rogers wrote:
> > > +#ifndef HAVE_BPF_SKEL
> > > +int lock_contention_prepare(struct lock_contention *con __maybe_unused)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +int lock_contention_start(void)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +int lock_contention_stop(void)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +int lock_contention_finish(struct lock_contention *con __maybe_unused)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +int lock_contention_read(struct lock_contention *con __maybe_unused)
> > > +{
> > > +     return 0;
> > > +}
> > > +#endif  /* !HAVE_BPF_SKEL */
> >
> > I still think it's the convention to have them in a header file as
> > static inline functions and reduce the #ifdef in the .c file.
> 
> Shouldn't minimizing ifdefs, and associated cognitive load, in header
> files be the priority given they are #included many times while the .c
> file is only compiled once?
> Shouldn't a goal of the header file be to abstract away things like
> HAVE_BPF_SKEL?
> I'm not clear what the goal of having the functions in the header
> files is, performance? The code isn't going to run anyway. I feel
> lock_contention.h is smaller and easier to read like this but I also
> don't care enough to fight. I did this change here as
> lock_contention.h was being brought into python.c for the sake of
> stubbing out functions that the header file was also subbing out for
> !BPF_HAVE_SKEL. A single stub felt like progress.

I think it may have the empty functions in the binary if we keep the
functions in the .c file whereas compilers would optimize away them if
they are static inline functions.

Thanks,
Namhyung

