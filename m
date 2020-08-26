From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf stat: Fix s390x compile error on F32
 utils/stat-display.c
Date: Wed, 26 Aug 2020 10:00:03 -0300
Message-ID: <20200826130003.GE1059382@kernel.org>
References: <20200825063304.77733-1-tmricht@linux.ibm.com>
 <20200825071442.GB631468@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200825071442.GB631468@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Aug 25, 2020 at 09:14:42AM +0200, Jiri Olsa escreveu:
> On Tue, Aug 25, 2020 at 08:33:04AM +0200, Thomas Richter wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 57d0706e1330..cbe836649f84 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
> >  				cpu_map__id_to_die(id),
> >  				config->csv_output ? 0 : -3,
> >  				cpu_map__id_to_cpu(id), config->csv_sep);
> > -		} else {
> > +		} else if (id > -1)
> >  			fprintf(config->output, "CPU%*d%s",
> >  				config->csv_output ? 0 : -7,
> >  				evsel__cpus(evsel)->map[id],
> >  				config->csv_sep);
> > -		}
 
> I think we want multiple if lines within  { } but
> scripts/checkpatch.pl does not scream about this, so leaving this to
> Arnaldo ;-)

Yeah, I removed the removal of the {} for a multiline else block, added
your Acked-by, thanks,

- Analdo
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
> >  		break;
> >  	case AGGR_THREAD:
> >  		fprintf(config->output, "%*s-%*d%s",
> > -- 
> > 2.26.2
> > 
> 

-- 

- Arnaldo
