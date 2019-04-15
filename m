From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf/report: [RFC] Handling OOM in perf report
Date: Mon, 15 Apr 2019 10:28:09 +0200
Message-ID: <20190415082809.GA13124@krava>
References: <20190401142000.17679-1-tmricht@linux.ibm.com>
 <20190409104205.GB29688@krava>
 <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06273b1f-faea-5d88-1696-eb686ef47a6c@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 10, 2019 at 09:17:30AM +0200, Thomas-Mich Richter wrote:

SNIP

> > 
> > 
> > ---
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index b17f1c9bc965..eea247a26ad8 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1933,7 +1933,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> >  		       file_offset + head, event->header.size,
> >  		       event->header.type);
> > -		err = -EINVAL;
> > +		err = skip;
> >  		goto out;
> >  	}
> >  
> > 
> 
> Above patch does not help, you simply return -ENOMEM instead of -EINVAL and processing
> stops with no indication that perf ran out of memory. Bailing out in this case is ok.
> 
> I am fine with your patch, as long as it gives a reason why processing stopped.
> In the GUI it shows on the bottom line the reason:
> 
>   0xf4198 [0x8]: failed to process type: 68 [Cannot allocate memory]

looks good, please post the full patch

thanks,
jirka

> 
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..e89716175588 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>         if (size < sizeof(struct perf_event_header) ||
>             (skip = rd->process(session, event, file_pos)) < 0) {
> -               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> +               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
>                        file_offset + head, event->header.size,
> -                      event->header.type);
> -               err = -EINVAL;
> +                      event->header.type, strerror(-skip));
> +               err = skip;
>                 goto out;
>         }
>  
> [root@m35lp76 perf]#
> -- 
> Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Matthias Hartmann
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
