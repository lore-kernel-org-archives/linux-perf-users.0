Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E213C9AF;
	Fri,  7 Jun 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784779; cv=none; b=cV066NGPttEPW5DMY4M8R+4xyPtXGpUAW0Tt2/XCif1ta3Z68QM99uCBOm4fKY4uMG8hvasWhKshGh25y6PsAd8BEpz+pUzYGFiRX2ERMDhWR5ijOxL20Mrm5m4YV3KaKdLwsMm6RsWji2MAuUHuVNhuDHeYPxhtg64Mgm8duf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784779; c=relaxed/simple;
	bh=eIjPrHtkhexnQouMqjJ9A9DjDJn36HOn7SpPqhCt+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpETFrV0idunjzRg9lLRdr2EgIy5/Ehv2qLU9qx1sr6Nfn/NQ10HdNkbsGX2L35JyosJW4D3lhS4r6IOW2ZQ3C9DOdz2i0ckWtnwVX8JN8/4pzkuw2N/8gZ1bfRt5Cw1AwUqi3kyAdjuErhkfD9dmk8H4RNAJrJxV44lv4cCY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku0hvEiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku0hvEiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0C8C2BBFC;
	Fri,  7 Jun 2024 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717784778;
	bh=eIjPrHtkhexnQouMqjJ9A9DjDJn36HOn7SpPqhCt+20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ku0hvEiWKMz4MbicXYJ2p2xmgPQCrJ2oQsLZtv5O1bgigpR8xnQ3cv77m5jb0sLmB
	 NtJggY2RGn4ASTSYltZjVp9lpA2PpZm+grXOHbwdoDVOB8QpEYGdAUzErtntp3bPLl
	 A8D8kz9b0/fiT52cX6LmXTTiR/qP2VctW9COQEbTchVG4eK9EAZhAIjBALZFwkmBd4
	 z+eTHitVquDCRWE1buyYbfXE49dL7ekjWDqhW6FAVbrnb3IdWy8d1pU77iocsfTR5P
	 0Xm0sB0majqwXTw86ZayMEMSVz3MdxPNG0j5ukUX94niSeu0oKjoESl5hwlCCZCn//
	 LavHV+NkA8myA==
Date: Fri, 7 Jun 2024 11:26:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Milian Wolff <milian.wolff@kdab.com>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kenel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles +
 raw_syscalls
Message-ID: <ZmNQyBx6N1XEWbaw@google.com>
References: <23879991.0LEYPuXRzz@milian-workstation>
 <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1>
 <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
 <Zl9ksOlHJHnKM70p@x1>
 <ZmI2Gumx5yUwyFsT@google.com>
 <CAP-5=fWD+PPCVCvyBFfd3vZzUajM0HAEWzJe8XmB9p_bfT4ATQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWD+PPCVCvyBFfd3vZzUajM0HAEWzJe8XmB9p_bfT4ATQ@mail.gmail.com>

On Thu, Jun 06, 2024 at 04:17:43PM -0700, Ian Rogers wrote:
> On Thu, Jun 6, 2024 at 3:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Jun 04, 2024 at 04:02:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Tue, Jun 04, 2024 at 11:48:09AM -0700, Ian Rogers wrote:
> > > > On Tue, Jun 4, 2024 at 7:12 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > Can you please try with the attached and perhaps provide your Tested-by?
> > >
> > > > > From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Tue, 4 Jun 2024 11:00:22 -0300
> > > > > Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recording
> > > > >  PERF_RECORD_LOST_SAMPLES event"
> > >
> > > > > This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.
> > >
> > > > I think we should try to fight back reverts when possible. Reverts are
> > > > removing something somebody poured time and attention into. When a
> > >
> > > While in the development phase, yeah, but when we find a regression and
> > > the revert makes it go away, that is the way to go.
> > >
> > > The person who poured time on the development gets notified and can
> > > decide if/when to try again.
> > >
> > > Millian had to pour time to figure out why something stopped working,
> > > was kind enough to provide the output from multiple tools to help in
> > > fixing the problem and I had to do the bisect to figure out when the
> > > problem happened and to check if reverting it we would have the tool
> > > working again.
> > >
> > > If we try to fix this for v6.10 we may end up adding yet another bug, so
> > > the safe thing to do at this point is to do the revert.
> > >
> > > We can try improving this once again for v6.11.
> >
> > I think I found a couple of problems with this issue. :(
> >
> >  1. perf_session__set_id_hdr_size() uses the first evsel in the session
> >     But I think it should pick the tracking event.  I guess we assume
> >     all events have the same set of sample_type wrt the sample_id_all
> >     but I'm not sure if it's correct.
> >
> >  2. With --call-graph dwarf, it seems to set unrelated sample type bits
> >     in the attr like ADDR and DATA_SRC.
> >
> >  3. For tracepoint events, evsel__newtp_idx() sets a couple of sample
> >     type regardless of the configuration.  This includes RAW, TIME and
> >     CPU.  This one changes the format of the id headers.
> >
> >  4. PERF_RECORD_LOST_SAMPLES is for the sampling event, so it should
> >     use the event's sample_type.  But the event parsing looks up the
> >     event using evlist->is_pos which is set for the first event.
> >
> >  5. I think we can remove some sample type (i.e. TID and CPU) from the
> >     tracking event in most cases.  ID(ENTIFIER) will be used for LOST_
> >     SAMPLES and TIME is needed anyway.  TID is might be used for SWITCH
> >     but others already contain necessary information in the type.  I
> >     wish we could add id field to PERF_RECORD_LOST_SAMPLES and tid/pid
> >     to PERF_RECORD_SWITCH.
> 
> Right, this is good. To clear up the immediate error we just need to
> increase the memory allocation size by 48 bytes to account for the
> sample ID being written. Here is a change doing that and removing the
> memory allocation altogether:

Looks ok.  I think we can have this as a quick fix and I can work on the
above issues separately.  Can you please send a formal patch?

> ```
> diff --git a/tools/lib/perf/include/perf/event.h
> b/tools/lib/perf/include/perf/event.h
> index ae64090184d3..a2dfaff26fb7 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -77,6 +77,8 @@ struct perf_record_lost_samples {
>        __u64                    lost;
> };
> 
> +#define PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE \
> +       (sizeof(struct perf_record_lost_samples) + 6 * sizeof(__u64))

For possible other uses, I'd suggest to add

  #define MAX_ID_HDR_ENTRIES  6

Thanks,
Namhyung

> /*
>  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
>  */
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 66a3de8ac661..1615a1723fb9 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1926,7 +1926,10 @@ static void __record__save_lost_samples(struct
> record *rec, struct evsel *evs
> el,
> static void record__read_lost_samples(struct record *rec)
> {
>        struct perf_session *session = rec->session;
> -       struct perf_record_lost_samples *lost = NULL;
> +       union {
> +               struct perf_record_lost_samples lost;
> +               char
> lost_and_sample_id[PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE];
> +       } lost;
>        struct evsel *evsel;
> 
>        /* there was an error during record__open */
> @@ -1951,20 +1954,13 @@ static void record__read_lost_samples(struct
> record *rec)
> 
>                                if (perf_evsel__read(&evsel->core, x,
> y, &count) < 0) {
>                                        pr_debug("read LOST count failed\n");
> -                                       goto out;
> +                                       return;
>                                }
> 
>                                if (count.lost) {
> -                                       if (!lost) {
> -                                               lost = zalloc(sizeof(*lost) +
> -
> session->machines.host.id_hdr_size);
> -                                               if (!lost) {
> -
> pr_debug("Memory allocation failed\n");
> -                                                       return;
> -                                               }
> -                                               lost->header.type =
> PERF_RECORD_LOST_SAMPLES;
> -                                       }
> -
> __record__save_lost_samples(rec, evsel, lost,
> +                                       memset(&lost, 0, sizeof(lost));
> +                                       lost.lost.header.type =
> PERF_RECORD_LOST_SAMPLES;
> +
> __record__save_lost_samples(rec, evsel, &lost.lost,
>                                                                    x,
> y, count.lost, 0);
>                                }
>                        }
> @@ -1972,21 +1968,12 @@ static void record__read_lost_samples(struct
> record *rec)
> 
>                lost_count = perf_bpf_filter__lost_count(evsel);
>                if (lost_count) {
> -                       if (!lost) {
> -                               lost = zalloc(sizeof(*lost) +
> -
> session->machines.host.id_hdr_size);
> -                               if (!lost) {
> -                                       pr_debug("Memory allocation failed\n");
> -                                       return;
> -                               }
> -                               lost->header.type = PERF_RECORD_LOST_SAMPLES;
> -                       }
> -                       __record__save_lost_samples(rec, evsel, lost,
> 0, 0, lost_count,
> +                       memset(&lost, 0, sizeof(lost));
> +                       lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
> +                       __record__save_lost_samples(rec, evsel,
> &lost.lost, 0, 0, lost_count,
> 
> PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>                }
>        }
> -out:
> -       free(lost);
> }
> 
> static volatile sig_atomic_t workload_exec_errno;
> ```
> 
> Thanks,
> Ian
> 
> > Thanks,
> > Namhyung
> >
> > >
> > > > regression has occurred then I think we should add the regression case
> > > > as a test.
> > >
> > > Sure, I thought about that as well, will try and have one shell test
> > > with that, referring to this case, for v6.11.
> > >
> > > - Arnaldo
