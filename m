From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH] perf: update perf.data file format documentation
Date: Mon, 18 Feb 2019 10:04:41 +0100
Message-ID: <20190218090441.nutpvfpsjz5oxwes@studium.uni-erlangen.de>
References: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190217232246.GB26460@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217232246.GB26460@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 18, 2019 at 12:22:46AM +0100, Jiri Olsa wrote:
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
The difference is that the current wording states "The header is
followed by different optional headers" but the actual placement
of those headers of the flags section is after the data section
(see perf_file_header__read at util/header.c:3108 in v4.20). But
I admit that I shouldn't have removed the perf_file_section's...
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
You are right that this should always be 24. I just went over the diff
of my codebase to generate the perf.data file and tried to extract the
relevant format changes. I think I just stumbled across the definition
of build_id_event in util/event.h:229 and added that (irrelevant) change
which finally - also useless - worked as soon as I adjusted the flags
section.
The other way round this is the actual definition in the code base so
I'm not sure whether it should be the same. But as it is useless perhaps
change the definition in the source?
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
> 
> thanks,
> jirka
> 
> >  
> >  	HEADER_EVENT_DESC = 12,
> >  
> > -- 
> > 2.17.1
> > 
