Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92E3E022B;
	Fri, 29 May 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057506; cv=none; b=kOiyF7YcVb8nDFQbOA6sqZyC6xCu7iybfFETLHGTzmn+f2xOpUciBBELxdmrqjoHXcew2W+rAS7KDieLB8xSnTxQammVYmOeL7rtFFdWQR5nB6TbhWqqlq9Cp2Qobj9dsnWkkwQ0zi/AT8jtM1NtyB8lAEbBAIHwZUUXlBngb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057506; c=relaxed/simple;
	bh=N2PakYI96VQg8KYhYYVU1+Th7zmL4F2SwO1LRfnOR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCDwsg59nvRb7DgG71QGL82X6OaZ00J226bOVG8pdwi0Z/f4UESGcgppf3FDO8iT9FKbfcrt6MA/vQhT6uxCW/OE80C4JxgBORxlweiB/X4ULAQPAS33mcrUtlYMethkzmXDQqsU3Q2/+KfEFd1Wakudm5lspXs+Ivji5erHW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGN+bjr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGN+bjr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4F1F00893;
	Fri, 29 May 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780057504;
	bh=m9mUR3le714/u85AzSSz58yESU35XgeJg3ZdaUmZzHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RGN+bjr/xi+tEF3u/E8jfeaAu6RX9plSn26pB7KNarSOqmHCKo4XAsmb42PzEk5xd
	 eEy8sWCkSA1B/a8iqO9ryA1m6xfZ0TwVQ+aCkmvT/FInXahdbpDJYqxxWwMgwFNPBZ
	 gTKBqTy23dMsOIR3VqS4VQVa2lnAFM7ZlCRKHh9aTFJEnupUXyvz+fo70drbM8BqQj
	 ne2rQUATZlQSfQn1gLlZJh9zOsAfHHsWD7N5y8EmlffLhd6OfmX2/i93olI3hIe/d3
	 TD8f6RlugzGIA8PdM1fg0U2GJS96RwbqkPXYNSmb+PoXc01ammyehnCdbSOcVv9J9Y
	 DwYsyavjTAOdw==
Date: Fri, 29 May 2026 09:25:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Make leafloop workload immune to compiler
 options
Message-ID: <ahmFnY9zT5hRGbAs@x1>
References: <20260511-james-perf-leafloop-stack-v2-1-79f7383f545e@linaro.org>
 <CAP-5=fXtzHw2c_Er0WPpfFo1cfng46VXKvShb+kbdnSoxL1rmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXtzHw2c_Er0WPpfFo1cfng46VXKvShb+kbdnSoxL1rmw@mail.gmail.com>

On Mon, May 11, 2026 at 08:38:48AM -0700, Ian Rogers wrote:
> On Mon, May 11, 2026 at 2:19 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Since the leafloop test program was moved into the main Perf binary as a
> > workload, it inherited the same compiler options as Perf. In this case
> > the -fstack-protector option broke the assumption that simple leaf
> > frames don't have a stack frame on Arm. This causes
> > test_arm_callgraph_fp.sh to pass even if the stack isn't augmented with
> > the link register, making the test useless.
> >
> > Fix it by rewriting the leaf function in assembly seeing as it's so
> > simple. Adding -fno-stack-protector would also work, but wouldn't be
> > robust against other future compiler option additions.
> >
> > The local variables and 'a' variable were never needed so remove them to
> > simplify.
> >
> > Assisted-by: GitHub-Copilot:GPT-5.5
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> > Changes in v2:
> > - Push and pop asm sections - (Sashiko)
> > - Add .size directive - (Sashiko)
> > - Add asm label for done and test with LTO enabled - (Sashiko)
> > - Link to v1: https://lore.kernel.org/r/20260508-james-perf-leafloop-stack-v1-1-637c260b2da8@linaro.org
> > ---
> >  tools/perf/tests/workloads/leafloop.c | 40 +++++++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> > index f7561767e32c..c20c75f7ba49 100644
> > --- a/tools/perf/tests/workloads/leafloop.c
> > +++ b/tools/perf/tests/workloads/leafloop.c
> > @@ -6,26 +6,48 @@
> >  #include "../tests.h"
> >
> >  /* We want to check these symbols in perf script */
> > -noinline void leaf(volatile int b);
> > -noinline void parent(volatile int b);
> > +noinline void leaf(void);
> > +noinline void parent(void);
> >
> > -static volatile int a;
> > -static volatile sig_atomic_t done;
> > +static volatile sig_atomic_t done asm("leafloop_done");
> >
> >  static void sighandler(int sig __maybe_unused)
> >  {
> >         done = 1;
> >  }
> >
> > -noinline void leaf(volatile int b)
> > +#if defined(__aarch64__)
> > +/*
> > + * Write leaf() in assembly so it stays as a minimal leaf function with no
> > + * stack frame and won't get silently broken in the future by any Perf wide
> > + * compilation options like -fstack-protector-all.
> > + */
> > +asm(
> > +       ".pushsection .text,\"ax\",%progbits\n"
> > +       ".global leaf\n"
> > +       ".type leaf, %function\n"
> > +       "leaf:\n"
> > +       "       adrp    x1, leafloop_done\n"
> > +       "       ldr     w2, [x1, #:lo12:leafloop_done]\n"
> > +       "       cbz     w2, leaf\n"
> > +       "       ret\n"
> > +       ".size leaf, .-leaf\n"
> > +       ".popsection\n"
> > +);
> 
> On reading this I thought, why can't we just use an asm block in a
> function, but I get it, you want specific function entry/exit to test
> the leaf unwinding feature.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
