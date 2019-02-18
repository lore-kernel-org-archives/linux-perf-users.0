From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: update perf.data file format documentation
Date: Mon, 18 Feb 2019 09:46:48 -0300
Message-ID: <20190218124648.GN31177@kernel.org>
References: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190217232246.GB26460@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217232246.GB26460@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Feb 18, 2019 at 12:22:46AM +0100, Jiri Olsa escreveu:
> On Fri, Feb 15, 2019 at 07:28:23PM +0100, Jonas Rabenstein wrote:
> > I found that the documentation of the flags section is some how
> > different from the actual format used and expected by the perf
> > tools. In this patch the according section of the file format
> > documentation is updated to conform to the expectations of the
> > perf tool suite.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> >  .../perf/Documentation/perf.data-file-format.txt  | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index dfb218feaad9..6ea199f28330 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -43,13 +43,10 @@ struct perf_file_section {
> >  
> >  Flags section:
> >  
> > -The header is followed by different optional headers, described by the bits set
> > -in flags. Only headers for which the bit is set are included. Each header
> > -consists of a perf_file_section located after the initial header.
> > -The respective perf_file_section points to the data of the additional
> > -header and defines its size.
> > -
> > -Some headers consist of strings, which are defined like this:
> > +The Flags section is placed directly after the data section and consists of a
> > +variable amount of information described by the flags-bitset in the perf_header.
> > +A lot of the headers in the Flags section are simple strings and are represented
> > +like this:
> 
> some how I find this more confusing.. please describe
> what's actualy wrong with the current wording
> 
> >  
> >  struct perf_header_string {
> >         uint32_t len;
> > @@ -82,7 +79,7 @@ assigned by the linker to an executable.
> >  struct build_id_event {
> >  	struct perf_event_header header;
> >  	pid_t			 pid;
> > -	uint8_t			 build_id[24];
> > +	uint8_t			 build_id[PERF_ALIGN(24, sizeof(u64))];
> 
> isn't that always 24? I guess u meant:
> 
>   build_id[PERF_ALIGN(20, sizeof(u64))];
> 
> 
> >  	char			 filename[header.size - offsetof(struct build_id_event, filename)];
> >  };
> >  
> > @@ -131,7 +128,7 @@ An uint64_t with the total memory in bytes.
> >  
> >  	HEADER_CMDLINE = 11,
> >  
> > -A perf_header_string with the perf command line used to collect the data.
> > +A perf_header_string_list with the perf arg-vector used to collect the data.
> 
> nice catch

This is why patch granularity is important, this part is unrelated to
the other fixes, so should be in a separate patch, had it been like
that I'd already process this part that got Jiri's Acked-by (in the form
of a positive comment).

- Arnaldo
