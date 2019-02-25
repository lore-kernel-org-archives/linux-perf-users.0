From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 01/11] perf tools script: Handle missing fields with -F
 +..
Date: Mon, 25 Feb 2019 10:49:05 -0300
Message-ID: <20190225134905.GB31136@kernel.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-2-andi@firstfloor.org>
 <20190225125642.GM19795@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225125642.GM19795@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 25, 2019 at 01:56:42PM +0100, Jiri Olsa escreveu:
> On Sun, Feb 24, 2019 at 07:37:12AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > When using -F + syntax to add a field the existing defaults
> > are currently all marked user_set. This can cause errors when
> > some field is missing in the perf.data
> > 
> > This patch tracks the actually user set fields separately,
> > so that we don't error out in this case.
> > 
> > Before:
> > 
> > % perf record true
> > % perf script -F +metric
> > Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
> > %
> > 
> > After
> > 
> > 5 perf record true
> > % perf script -F +metric
> >             perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
> > ...
> > %
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> nice, that one was annoying
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.

- Arnaldo
