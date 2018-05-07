From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
Date: Mon, 7 May 2018 16:26:15 -0300
Message-ID: <20180507192615.GE13491@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
 <20180504160228.GA25229@krava>
 <87a7tdphyo.fsf@linux.intel.com>
 <20180507183749.GA2095@redhat.com>
 <20180507191653.GA1924@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507191653.GA1924@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

Em Mon, May 07, 2018 at 09:16:53PM +0200, Jiri Olsa escreveu:
> On Mon, May 07, 2018 at 03:37:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, May 05, 2018 at 08:43:11PM -0700, Andi Kleen escreveu:
> > > Jiri Olsa <jolsa@redhat.com> writes:
> > > 
> > > Please fix this quickly, PT is currently totally non functional in Linus
> > > mainline.
> > 
> > Ok, so I'm reverting this patch, the previous situation was just a
> > misleading error message, so it can wait for the discussion about the
> > parser fixes to come to a conclusion and a proper patch to be submitted.
> 
> ok, I was waiting for some feedback on the new patch.. I'll merge
> it with the one you reverted now

Ok!

- Arnaldo
