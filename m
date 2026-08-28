Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED5395AFA;
	Fri, 28 Aug 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936404; cv=none; b=nQrfWO2TnTLEWTl/QpyMfqVHpC01SoLy+fy143dfxbg6O1rxn1Sb0y6SFgjMteTCcx4VMF76gBHuABnjTJbmSXrsA/vX7dB1iASY+MU1jI2EpSxgtcB6ehVRu7NRUb9FLtAFnFHBiLd22XTsW9SlTY9fAGi2qzaahY0LKBIJLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936404; c=relaxed/simple;
	bh=suWv59rvKXQeQo8RaEzBuUekmM2zOJJjz72hfpTOsKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT8Y84kL6K56fFjhk/LTPuP3KeQw54SMhL5ogi6LfeAxbOdJabLT0V28AGBT5HMppNm6J7gxPPW1LTHjzL5vwrypy8sL1UD8G89zpQ46o+hPHM2nGdMbJ6W4SGY1tcTEsW5jpBcWw7biaKxwUSPY52uzgijHg/nzu4vUW7Sh2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4kmCwSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4kmCwSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCAD1F000E9;
	Fri, 28 Aug 2026 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787936396;
	bh=xvp3sRTDT3WERQY/AFWHdsCQL/yLtI9fiADG9eGBQDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X4kmCwSB1HiGRZm6oZz78lDAGVJOiYf9pdhz8uPSSv5lNjalnqd+r0h2K5ApY5cBx
	 voWXg1F/Ta8zAyd73myJp0wCo3IGdmbKURd6oObmnuXQHVhrTK9AYwjz53rrVSuPA/
	 Fgze1lhujZxj25gAEZAfP4XaD+HISGZAlNOkUaHg8pZjs2UIIjyPR+NXNoxdawDo2D
	 CWx79H3hUnlrC7CzdoiJ2AA/XQX1MbM4ZLhZGhulw+I5jjcd2Fd35QZdIGahX0S6z2
	 fcrresKyka7idI5/u58Bu9GoN6h7a2lIOC44UTooA8bIfj5soobXO5Z6RvkJ0f16N+
	 ZudD72ElCpBPg==
Date: Fri, 28 Aug 2026 09:59:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf ftrace latency: Do not read trace files when BPF is
 used
Message-ID: <apG-ij-tYyK9cBSj@google.com>
References: <20260826185815.280451-1-namhyung@kernel.org>
 <CAP-5=fVfmWQaE45Y=pA1rE5JxQLKhfN82+yfRqQE7Hjrb8=aOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVfmWQaE45Y=pA1rE5JxQLKhfN82+yfRqQE7Hjrb8=aOQ@mail.gmail.com>

Hi Ian,

On Wed, Aug 26, 2026 at 02:36:27PM -0700, Ian Rogers wrote:
> On Wed, Aug 26, 2026 at 11:58 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I've realized that it didn't set up the tracing files when BPF is used
> > so poll() just returns immediately.  It ends up with calling poll()
> > unnecessarily in a loop.
> >
> > BPF still needs the loop to wait for the target process exiting or a
> > signal from users.  Let's sleep for 1 msec and check that.
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-ftrace.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 4f881a40c311ae52..e61b9de11e1e41c7 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -1146,6 +1146,11 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
> >
> >         line[0] = '\0';
> >         while (!done) {
> > +               if (ftrace->target.use_bpf) {
> > +                       usleep(1000);
> > +                       continue;
> > +               }
> > +
> 
> To avoid the busy waiting could we:
> ```
> // Globaly:
> sem_t sig_sem;
> ...
> // Prior to setting up the signal handler:
> sem_init(&sig_sem, 0, 0);
> ...
> // Here:
> if (ftrace->target.use_bpf) {
>    sem_wait(&sig_sem);
> } else {
>    while (!done) {
> ...
> }
> // In the signal handler:
> if (ftrace->target.use_bpf) {
>    sem_post(&sig_sem);
> }
> ...
> // After removing the signal handler:
> sem_destroy(&sig_sem);
> ```

Looks better, will check.

Thanks,
Namhyung

