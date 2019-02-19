From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: fix HEADER_CMDLINE description in perf.data
 documentation
Date: Tue, 19 Feb 2019 12:24:13 -0300
Message-ID: <20190219152413.GB31177@kernel.org>
References: <20190218124648.GN31177@kernel.org>
 <20190218140203.1982-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190219140409.GD6435@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219140409.GD6435@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Feb 19, 2019 at 03:04:09PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 18, 2019 at 03:02:03PM +0100, Jonas Rabenstein wrote:
> > The content of this feature header is a perf_header_string_list of
> > the argument vector and not a perf_header_string of the commandline.
> 
> missing your Signed-off-by

Please provide for both and I'll apply.

In such a case you could repost with what is missing (your
Signed-off-by: your-email) and collect the Acked-by from whoever
provides them, Jiri in this case, so just add these two lines to the
changeset log:

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Thanks,

- Arnaldo
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/Documentation/perf.data-file-format.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index dfb218feaad9..5f9a3924830b 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -131,7 +131,7 @@ An uint64_t with the total memory in bytes.
> >  
> >  	HEADER_CMDLINE = 11,
> >  
> > -A perf_header_string with the perf command line used to collect the data.
> > +A perf_header_string_list with the perf arg-vector used to collect the data.
> >  
> >  	HEADER_EVENT_DESC = 12,
> >  
> > -- 
> > 2.19.2
> > 

-- 

- Arnaldo
