Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43619D090;
	Thu,  3 Apr 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658204; cv=none; b=WSe51gbxXdwi3D1jnoBcSlxcpDJfN1ln96gfa/BcwJsnWhgsSvUciqzMwt7gPsu6tttyt/ukR8IeK4pMVwQemOy9pfEcclkR/sCCnmobvhL6hsI14QnKbhAkZYdnSLKjPr0cX+UYyAUOCiUUxIRn+N19+Rv2GMjZ+VpxKvn/kpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658204; c=relaxed/simple;
	bh=/uspCOkOssOjUIDVMc4Y03wLPniMm6VVD8oIR4aLFdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnGLTm7Oaraiu+5mh9fU9RJio2XXIzS/RkR++ty2OGgMjKCPiFEx3l28v+XDhFTLcG3WoP3T36FemP/g9JQKpAo4p/CCKUWCRYedctd2O8sBwX1khfe2oBCFG+LT08i/9Kh4ToMjrNvxV86bdpP6zp77pVhvxbXDez4oCfxAioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd3+inEn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd3+inEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AF7C4CEE9;
	Thu,  3 Apr 2025 05:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743658204;
	bh=/uspCOkOssOjUIDVMc4Y03wLPniMm6VVD8oIR4aLFdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kd3+inEniTBuMl56XBbqpo1sryrItBu7Y3DEux34nnquR2TjRed3bNaF+gpcOIprQ
	 ZXhLU124QCKGGcm64YKUJcplubLHXZCkFFZv159WjD/5xZAyGzZP33oMSrWvgonFen
	 uXlJa+VsTfWUe55h13PeuZQSldP2/88Lxvcyg7zBsOT2JOUaJTEhKXZv9sCrW9y0K/
	 rrmAzjOhjeMeBwZM8zFV/eYsEowhn7LULrq30nwRO6HxTiPF1l2edebZfusOoMjgSF
	 yyI+zNACHbr5ldASHrZcrkm4+3ZM3tkke6Dh++ykok2mo41NEf28jEnttTxI7NvwZ0
	 7aJgelgomyC+A==
Date: Wed, 2 Apr 2025 22:30:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix some leaks of struct thread
Message-ID: <Z-4c2rZZzD59FFJn@google.com>
References: <20250331184638.3856982-1-namhyung@kernel.org>
 <CAH0uvohL4cFXukxhY6G4WfAWXqPOi3HbEHv=_KWixBQmgon2KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohL4cFXukxhY6G4WfAWXqPOi3HbEHv=_KWixBQmgon2KQ@mail.gmail.com>

Hello Howard,

On Tue, Apr 01, 2025 at 06:07:15PM -0700, Howard Chu wrote:
> Hello Namhyung,
> 
> On Mon, Mar 31, 2025 at 11:46 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I've found some leaks from 'perf trace -a'.  It seems there are more
> > leaks but this is what I can find for now.
> >
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-trace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 3d0c0076884d34cb..10cd99888a9a11b5 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2835,7 +2835,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
> >         e_machine = thread__e_machine(thread, trace->host);
> >         sc = trace__syscall_info(trace, evsel, e_machine, id);
> >         if (sc == NULL)
> > -               return -1;
> > +               goto out_put;
> >         ttrace = thread__trace(thread, trace);
> >         /*
> >          * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
> > @@ -4123,8 +4123,10 @@ static int trace__set_filter_loop_pids(struct trace *trace)
> >                         pids[nr++] = thread__tid(parent);
> 
> I suggest adding a:
> thread_put(parent);
> here, just before the break.

You're right, will add it.

Thanks,
Namhyung

> 
> >                         break;
> >                 }
> > +               thread__put(thread);
> >                 thread = parent;
> >         }
> > +       thread__put(thread);
> >
> >         err = evlist__append_tp_filter_pids(trace->evlist, nr, pids);
> >         if (!err && trace->filter_pids.map)
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >
> 
> Thanks,
> Howard
