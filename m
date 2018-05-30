From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: heads up: moving intel-pt-decoder/Build header checks to
 check_headers.sh
Date: Wed, 30 May 2018 09:59:26 -0300
Message-ID: <20180530125926.GC20886@kernel.org>
References: <20180529134809.GB20886@kernel.org>
 <a090016e-1cb9-2d49-fc47-40dcd6374451@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a090016e-1cb9-2d49-fc47-40dcd6374451@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, May 30, 2018 at 09:30:50AM +0300, Adrian Hunter escreveu:
> On 29/05/18 16:48, Arnaldo Carvalho de Melo wrote:
> > 	We've made tools/perf/check-headers.sh the mechanism to check
> > for drift on kernel file copies we have in tools/, and it assumes that
> > if we have tools/a/b/c/d, then it came from a/b/c/d in the kernel
> > sources, e.g. a copy of the kernel's arch/x86/lib/x86-opcode-map.txt
> > would be in tools/arch/x86/lib/x86-opcode-map.txt.

> > 	That is not the case with the intel-pt-decoder, so I'm thinking
> > about moving those files to comply with the model used for other copies,
> > as having it in util/intel-pt-decoder/ isn't strictly required, i.e.
> > those files could conceivably be used for other purposes besides
> > decoding intel-pt traces, say for disassembly/annotate, that albeit not
> > planned (at least by me) for the near future, would be something
> > interesting to investigate doing.

> > 	IIRC Ingo was the one to point me out this, and now I saw the
> > warning about it being different flying by in the middle of the build,
> > differently from what is done by check-headers.sh, that is to show
> > everything that drifted in one single block, at the start of the build.

> > 	So unless you have a strong objection to this, I'll continue
> > investigation about how do do it with tools/perf/check-headers.sh,
 
> I have no objection but currently it is (theoretically) possible to compile
> Intel PT decoding support into perf script and perf report for any
> architecture. i.e. decoding Intel PT from a perf.data file does not depend
> on the build architecture.

Right, being on the tools/arch/ will not preclude it from being built
and linked in the other arches, I'll make sure it continues being built
there as well.

Thanks!

- Arnaldo
