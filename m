From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Fix crash on buildid-list with namespace
Date: Wed, 18 Oct 2017 09:07:21 +0900
Message-ID: <20171018000721.GA11621@danjae.aot.lge.com>
References: <20171017120132.GA4204@kernel.org>
 <20171017132900.11043-1-namhyung@kernel.org>
 <20171017140555.GE4204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171017140555.GE4204@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Oct 17, 2017 at 11:05:55AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 17, 2017 at 10:29:00PM +0900, Namhyung Kim escreveu:
> > Thomas reported that perf buildid-list gets a segfault due to NULL
> > pointer when he ran it on a data with namespace events.  It was because
> > the buildid_id__mark_dso_hit_ops lacks the namespace event handler and
> > perf_too__fill_default() didn't set it.
> 
> In these cases, next time I suggest you add a Fixes: tag, so that the
> stable@kernel.org guys can automatically figure out which kernels need
> this fix, in this case:
> 
> Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")

Ah right, will add next time.

> 
> The script I have for this even adds this CC line:
> 
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> 
> I'm adding it,

Thanks,
Namhyung
