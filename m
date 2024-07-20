Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16923D7;
	Sat, 20 Jul 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435253; cv=none; b=s80bkIijY5t6iBKHBzVZIPCpa7c7HNhpksJMXQDUdZ1rb5PWwpgpOXSMnhj98ikkTlcZf/kEpXzOHWwVti+jQ9w8A/IeOSWy6DgQgk3tG5PbMZctHA8fU12REpJQEJdROShVp5FXj+zcHCgy6d5yexy8P6VvsycykZiRJa3qZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435253; c=relaxed/simple;
	bh=+HK1b/ZAcZqQ6KzQ15HRy8VjgKKJWKX+HCGhFeN3BSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJtug6HL6eqPegOo6sUHGS2GOAhdc+rJaUGlrAPE/sHqI3Ogdprz0YJw/vZp//5JEp1wVacwRjBJn+kg5MzWW7pp3KFW57F70HYYYqXZ6YMhFF4hg3jZIV57xwqRPAJ1GLvq59O6v7nsifTpemtd+VBhBHsXfoswyPFWSM2cxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso1311637a91.3;
        Fri, 19 Jul 2024 17:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721435250; x=1722040050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj+zq4rK+k2N/qmVRsbjZg9nlvF3mdqujb9x4y/9kmg=;
        b=kzDIPML341UfZO28EjsCpgEzVfwoQDSbunJ8U5ASVcoSTYS/pxkspB9pJM58EhMLi0
         zKBqfsDM2Wf+YZfPDDfgDN/JQnLxlBvskrmYMVfnPiNK5ODbWT9nchQIXbqyh46UJ0FW
         69s1/oTT14gihR36rW7Oo6yTFSLWnACILsS38Q5lP+bCAdBNp2Jq6ssiqyhxtGTuAq7B
         N+zQhQDNX1bGC9dotR+0ePsdqIjfVnZQuZTm+sYdZNHZfnqO0AVy9s389TwV4A4NkP3n
         1AukYELsWc1AtNmhXpoUr8OIqEuNO+VI4/mtuQkLDERBY/MQEGcLr8bS3MMa+2jDsjT5
         V83A==
X-Forwarded-Encrypted: i=1; AJvYcCXU603fXEjR3heE6A1o6GgSycS90oaEnjqq5JDyDZQ9WlujcjHsCQjJ/qPdYrDf0Ta8s/tCDlIGqR2kEd/f0k8aW9a7pLdVYrSUntrzJwLlr4F9CLc0k2XATEnN5aHT2+RtjLMb9ltiLwz8suQsMQ==
X-Gm-Message-State: AOJu0Yzr309mCG/CJZ6yVizf2t4tjwLSfpNcEx3dutviso/YGhnmprks
	zi7kn72FCaA+PNqLeDFHdSBTN9iikVGRDYe0F/EBt67avIZDbXTnpQWxlC8UOmz0+bLi7nwZgP5
	p5DGP4RZvzD04Wm75y5BuFO3hMrk=
X-Google-Smtp-Source: AGHT+IGmDuImzzG9GaW7HP1cBT7mKber2gNnbyKmwqC8w0DNWcxI/Vgqt/dd9h0OOOV+c3n0aWfDc0JEWMmlAjOLOHg=
X-Received: by 2002:a17:90a:734b:b0:2c2:5f25:5490 with SMTP id
 98e67ed59e1d1-2cd274f1c9bmr53413a91.34.1721435250152; Fri, 19 Jul 2024
 17:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712190932.417531-1-weilin.wang@intel.com>
 <20240712190932.417531-4-weilin.wang@intel.com> <Zpiub22McUCTUuXj@google.com>
 <DM8PR11MB5637C3E2F618A5734B65BB4FEEAC2@DM8PR11MB5637.namprd11.prod.outlook.com>
 <CO6PR11MB563588E1D93E96C5A09B54C2EEAC2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563588E1D93E96C5A09B54C2EEAC2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jul 2024 17:27:18 -0700
Message-ID: <CAM9d7ciYxZ0Fw8FhCP64qzCNYKMrV-L6npWeNjkMnY64196MQg@mail.gmail.com>
Subject: Re: [RFC PATCH v17 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:55=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Wang, Weilin
> > Sent: Wednesday, July 17, 2024 11:28 PM
> > To: Namhyung Kim <namhyung@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: RE: [RFC PATCH v17 3/8] perf stat: Fork and launch perf record=
 when
> > perf stat needs to get retire latency value for a metric.
> >
> >
> >
> > > -----Original Message-----
> > > From: Namhyung Kim <namhyung@kernel.org>
> > > Sent: Wednesday, July 17, 2024 10:56 PM
> > > To: Wang, Weilin <weilin.wang@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > <mingo@redhat.com>; Alexander Shishkin
> > > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; H=
unter,
> > > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.co=
m>;
> > > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylo=
r, Perry
> > > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
> > Biggers,
> > > Caleb <caleb.biggers@intel.com>
> > > Subject: Re: [RFC PATCH v17 3/8] perf stat: Fork and launch perf reco=
rd
> > when
> > > perf stat needs to get retire latency value for a metric.
> > >
> > > On Fri, Jul 12, 2024 at 03:09:25PM -0400, weilin.wang@intel.com wrote=
:
> > > > From: Weilin Wang <weilin.wang@intel.com>
> > > >
> > > > When retire_latency value is used in a metric formula, evsel would =
fork a
> > perf
> > > > record process with "-e" and "-W" options. Perf record will collect=
 required
> > > > retire_latency values in parallel while perf stat is collecting cou=
nting values.
> > > >
> > > > At the point of time that perf stat stops counting, evsel would sto=
p perf
> > > record
> > > > by sending sigterm signal to perf record process. Sampled data will=
 be
> > > process
> > > > to get retire latency value. Another thread is required to synchron=
ize
> > > between
> > > > perf stat and perf record when we pass data through pipe.
> > > >
> > > > Retire_latency evsel is not opened for perf stat so that there is n=
o counter
> > > > wasted on it. This commit includes code suggested by Namhyung to ad=
just
> > > reading
> > > > size for groups that include retire_latency evsels.
> > > >
> > > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
[SNIP]
> > > > + /*
> > > > +  * Prepare perf record for sampling event retire_latency before f=
ork
> > > and
> > > > +  * prepare workload
> > > > +  */
> > > > + evlist__for_each_entry(evsel_list, evsel) {
> > > > +         int i;
> > > > +         char *name;
> > > > +         struct tpebs_retire_lat *new;
> > > > +
> > > > +         if (!evsel->retire_lat)
> > > > +                 continue;
> > > > +
> > > > +         pr_debug("tpebs: Retire_latency of event %s is required\n=
",
> > > evsel->name);
> > > > +         for (i =3D strlen(evsel->name) - 1; i > 0; i--) {
> > > > +                 if (evsel->name[i] =3D=3D 'R')
> > > > +                         break;
> > > > +         }
> > > > +         if (i <=3D 0 || evsel->name[i] !=3D 'R') {
> > > > +                 ret =3D -1;
> > > > +                 goto err;
> > > > +         }
> > > > +
> > > > +         name =3D strdup(evsel->name);
> > > > +         if (!name) {
> > > > +                 ret =3D -ENOMEM;
> > > > +                 goto err;
> > > > +         }
> > > > +         name[i] =3D 'p';
> > > > +
> > > > +         new =3D zalloc(sizeof(*new));
> > > > +         if (!new) {
> > > > +                 ret =3D -1;
> > > > +                 zfree(name);
> > > > +                 goto err;
> > > > +         }
> > > > +         new->name =3D name;
> > > > +         new->tpebs_name =3D evsel->name;
> > > > +         list_add_tail(&new->nd, &tpebs_results);
> > > > +         tpebs_event_size +=3D 1;
> > > > + }
> > > > +
> > > > + if (tpebs_event_size > 0) {
> > > > +         struct pollfd pollfd =3D { .events =3D POLLIN, };
> > > > +         int control_fd[2], ack_fd[2], len;
> > > > +         char ack_buf[8];
> > > > +
> > > > +         /*Create control and ack fd for --control*/
> > > > +         if (pipe(control_fd) < 0) {
> > > > +                 pr_err("tpebs: Failed to create control fifo");
> > > > +                 ret =3D -1;
> > > > +                 goto out;
> > > > +         }
> > > > +         if (pipe(ack_fd) < 0) {
> > > > +                 pr_err("tpebs: Failed to create control fifo");
> > > > +                 ret =3D -1;
> > > > +                 goto out;
> > > > +         }
> > > > +
> > > > +         ret =3D start_perf_record(control_fd, ack_fd, cpumap_buf)=
;
> > > > +         if (ret)
> > > > +                 goto out;
> > > > +         tpebs_pid =3D tpebs_cmd->pid;
> > > > +         if (pthread_create(&tpebs_reader_thread, NULL,
> > > __sample_reader, tpebs_cmd)) {
> > > > +                 kill(tpebs_cmd->pid, SIGTERM);
> > > > +                 close(tpebs_cmd->out);
> > > > +                 pr_err("Could not create thread to process sample
> > > data.\n");
> > > > +                 ret =3D -1;
> > > > +                 goto out;
> > > > +         }
> > > > +         /* Wait for perf record initialization.*/
> > > > +         len =3D strlen("enable");
> > > > +         ret =3D write(control_fd[1], "enable", len);
> > >
> > > Can we use EVLIST_CTL_CMD_ENABLE_TAG instead?
> > >
> > >
> > > > +         if (ret !=3D len) {
> > > > +                 pr_err("perf record control write control message
> > > failed\n");
> > > > +                 goto out;
> > > > +         }
> > > > +
> > > > +         /* wait for an ack */
> > > > +         pollfd.fd =3D ack_fd[0];
> > > > +
> > > > +         /*
> > > > +          * We need this poll to ensure the ack_fd PIPE will not h=
ang
> > > > +          * when perf record failed for any reason. The timeout va=
lue
> > > > +          * 3000ms is an empirical selection.
> > > > +          */
> > >
> > > Oh, you changed it to 3 sec.  But I think it's ok as we don't wait fo=
r
> > > that long for the normal cases.
> >
> > Hi Namhyung,
> >
> > I found it's more reliable to use 3 secs because in some of my test cas=
es 2 secs
> > are not enough for perf record reach the point of sending ACK back.
>
> Does this 3sec wait looks good to you? Please let me know if you have oth=
er suggestions.

I have no idea or preference.  It'd be ok if it works for you..
But I'm just curious in what situation 2 seconds was not enough.

Thanks,
Namhyung

> > >
> > > > +         if (!poll(&pollfd, 1, 3000)) {
> > > > +                 pr_err("tpebs failed: perf record ack timeout\n")=
;
> > > > +                 ret =3D -1;
> > > > +                 goto out;
> > > > +         }
> > > > +
> > > > +         if (!(pollfd.revents & POLLIN)) {
> > > > +                 pr_err("tpebs failed: did not received an ack\n")=
;
> > > > +                 ret =3D -1;
> > > > +                 goto out;
> > > > +         }
> > > > +
> > > > +         ret =3D read(ack_fd[0], ack_buf, sizeof(ack_buf));
> > > > +         if (ret > 0)
> > > > +                 ret =3D strcmp(ack_buf, "ack\n");
> > >
> > > Same for EVLIST_CTL_CMD_ACK_TAG.
> > >
> > >
> > > > +         else {
> > > > +                 pr_err("tpebs: perf record control ack failed\n")=
;
> > > > +                 goto out;
> > > > +         }
> > > > +out:
> > > > +         close(control_fd[0]);
> > > > +         close(control_fd[1]);
> > > > +         close(ack_fd[0]);
> > > > +         close(ack_fd[1]);
> > > > + }
> > > > +err:
> > > > + if (ret)
> > > > +         tpebs_delete();
> > > > + return ret;
> > > > +}
> > > > +
> > > > +
> > > > +int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thre=
ad)
> > > > +{
> > > > + __u64 val;
> > > > + bool found =3D false;
> > > > + struct tpebs_retire_lat *t;
> > > > + struct perf_counts_values *count;
> > > > +
> > > > + /* Non reitre_latency evsel should never enter this function. */
> > > > + if (!evsel__is_retire_lat(evsel))
> > > > +         return -1;
> > > > +
> > > > + /*
> > > > +  * Need to stop the forked record to ensure get sampled data from=
 the
> > > > +  * PIPE to process and get non-zero retire_lat value for hybrid.
> > > > +  */
> > > > + tpebs_stop();
> > > > + count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > > > +
> > > > + list_for_each_entry(t, &tpebs_results, nd) {
> > > > +         if (t->tpebs_name =3D=3D evsel->name || (evsel->metric_id
> > > && !strcmp(t->tpebs_name, evsel->metric_id))) {
> > >
> > > This line is too long, please break.
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > > +                 found =3D true;
> > > > +                 break;
> > > > +         }
> > > > + }
> > > > +
> > > > + /* Set ena and run to non-zero */
> > > > + count->ena =3D count->run =3D 1;
> > > > + count->lost =3D 0;
> > > > +
> > > > + if (!found) {
> > > > +         /*
> > > > +          * Set default value or 0 when retire_latency for this ev=
ent is
> > > > +          * not found from sampling data (record_tpebs not set or =
0
> > > > +          * sample recorded).
> > > > +          */
> > > > +         count->val =3D 0;
> > > > +         return 0;
> > > > + }
> > > > +
> > > > + /*
> > > > +  * Only set retire_latency value to the first CPU and thread.
> > > > +  */
> > > > + if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > > > +         val =3D rint(t->val);
> > > > + else
> > > > +         val =3D 0;
> > > > +
> > > > + count->val =3D val;
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> > > > +{
> > > > + zfree(&r->name);
> > > > + free(r);
> > > > +}
> > > > +
> > > > +
> > > > +/*
> > > > + * tpebs_delete - delete tpebs related data and stop the created t=
hread
> > and
> > > > + * process by calling tpebs_stop().
> > > > + *
> > > > + * This function is called from evlist_delete() and also from buil=
tin-stat
> > > > + * stat_handle_error(). If tpebs_start() is called from places oth=
er then
> > perf
> > > > + * stat, need to ensure tpebs_delete() is also called to safely fr=
ee mem and
> > > > + * close the data read thread and the forked perf record process.
> > > > + *
> > > > + * This function is also called in evsel__close() to be symmetric =
with
> > > > + * tpebs_start() being called in evsel__open(). We will update thi=
s call site
> > > > + * when move tpebs_start() to evlist level.
> > > > + */
> > > > +void tpebs_delete(void)
> > > > +{
> > > > + struct tpebs_retire_lat *r, *rtmp;
> > > > +
> > > > + if (tpebs_pid =3D=3D -1)
> > > > +         return;
> > > > +
> > > > + tpebs_stop();
> > > > +
> > > > + list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
> > > > +         list_del_init(&r->nd);
> > > > +         tpebs_retire_lat__delete(r);
> > > > + }
> > > > +
> > > > + if (tpebs_cmd) {
> > > > +         free(tpebs_cmd);
> > > > +         tpebs_cmd =3D NULL;
> > > > + }
> > > > +}
> > > > diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-=
tpebs.h
> > > > new file mode 100644
> > > > index 000000000000..766b3fbd79f1
> > > > --- /dev/null
> > > > +++ b/tools/perf/util/intel-tpebs.h
> > > > @@ -0,0 +1,35 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * intel_tpebs.h: Intel TEPBS support
> > > > + */
> > > > +#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
> > > > +#define INCLUDE__PERF_INTEL_TPEBS_H__
> > > > +
> > > > +#include "stat.h"
> > > > +#include "evsel.h"
> > > > +
> > > > +#ifdef HAVE_ARCH_X86_64_SUPPORT
> > > > +
> > > > +extern bool tpebs_recording;
> > > > +int tpebs_start(struct evlist *evsel_list);
> > > > +void tpebs_delete(void);
> > > > +int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thre=
ad);
> > > > +
> > > > +#else
> > > > +
> > > > +static inline int tpebs_start(struct evlist *evsel_list __maybe_un=
used)
> > > > +{
> > > > + return 0;
> > > > +}
> > > > +
> > > > +static inline void tpebs_delete(void) {};
> > > > +
> > > > +static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unu=
sed,
> > > > +                         int cpu_map_idx  __maybe_unused,
> > > > +                         int thread  __maybe_unused)
> > > > +{
> > > > + return 0;
> > > > +}
> > > > +
> > > > +#endif
> > > > +#endif
> > > > --
> > > > 2.43.0
> > > >
