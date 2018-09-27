From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3] perf report: use the offset address to find inline
 frames
Date: Thu, 27 Sep 2018 16:12:11 -0300
Message-ID: <20180927191211.GI25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-2-milian.wolff@kdab.com>
 <20180927160042.GA6916@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927160042.GA6916@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Sep 27, 2018 at 06:00:42PM +0200, Jiri Olsa escreveu:
> On Wed, Sep 26, 2018 at 03:52:06PM +0200, Milian Wolff wrote:
> > To correctly find inlined frames, we have to use the file offset
> > instead of the virtual memory address. This was already fixed for
> > displaying srcline information while displaying in commit
> > 2a9d5050dc84fa20 ("perf script: Show correct offsets for DWARF-based
> > unwinding"). We just need to use the same corrected address also when
> > trying to find inline frames.
> > 
> > This is another follow-up to commit 19610184693c ("perf script: Show
> > virtual addresses instead of offsets").
> > 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Sandipan Das <sandipan@linux.ibm.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
