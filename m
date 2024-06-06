Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6A26292
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715882; cv=none; b=tia0rS0XNTxJya4d77T/uhoAOM711pnFASl9ZiGVNTFhcDOQom4uaH2vCaEV/i8Z2x0AjkI0IHPy1fWzqnlN4uoP1GLNKgUjxbosPrWQ4SWZZJHWIi9rIxOyrTwihU6/8rsiYKmdgwS38ns3h8d4mkv1Udh91s2F/IPn4vsUqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715882; c=relaxed/simple;
	bh=19XaacNp8Kcu5Ti2DS4m8MBq16yvs29OoTKcO5yHFZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuCxbN7HS+OrzgVVoDFGfPVz3NGk17GF+mrXD4rDrNk51Vt9r/tLiQoPfanzpqq98sxKoV16ZCw8Qhm7Chcp2wUjBtvsQhA6FxdkBL2sxQdoy+t1H65IL3cmNXeDJHxcnjR9pnMlCysWVnFjBsmrZNiQdbJ3qoRG/5cNG7dwGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkKj34xj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkKj34xj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f61742a024so72325ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jun 2024 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717715880; x=1718320680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l8SdZWscT50XIJXXqQu2Ls5LcDQtk8S/Jn0vt/xS74=;
        b=fkKj34xjV9BWbH0TkcoOid8vVLH1XEVLg1jbH+vC9BYDXfZNGHk/PTZgtsz+x4GPyX
         V2BUHD+qvyw86hEbYr/7ojPSM8bc4Fnj05M5bQEYdQNoaA1If0/ZGavFLqR4VkxJ5YNn
         VlOdqL5FcTuzHHd2ic4k0L+XtQL2dPfVxxc10I0OOksF0tonpF8nx1Vl7nlw82butn9f
         dFItW+nufFjZiLnhUk+xGIsEFHpNqkNQqOMaJ7gwboM/eVMrTZWAHfdNTdthAsjm/uOR
         bw+wSVNNa7lPi5XJ7QZ5LQIjYKQGHjB9PDKR6ESwHthTtB84iul9rcVwL+gaecZ7JXWO
         TnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715880; x=1718320680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l8SdZWscT50XIJXXqQu2Ls5LcDQtk8S/Jn0vt/xS74=;
        b=PazHBwZXTOcmCLjbETiM5QuNwa0RR6Lp1iZRQ+nJGDRUzZgK7ivAP4PMWWzX7k6uwz
         lbZabic69gEAE0phToqGlAxwGgefCmNLdwSFsicHjpglwJxooYxKaqxsflAfiOa4dH5I
         Lc101BNU/GXM9Ey4fmLoD1dxJG8CgcrawoiZ8iRQcOBdu2hdrljRmBFt1tW0cJcniNZ6
         aw4jzL4YTFB6vmbnO1DGkpAecJtcKHC62sHPT/4ms98Y1u6czH7vsk63jMl7qwqzpe7B
         WdOygBWcIQJdHS5xBVQ3HKraSWDY0NOTn/Cxg8gfkahLnRwCtnl8BA3RIOspfTBzNNcR
         sPgA==
X-Forwarded-Encrypted: i=1; AJvYcCXxHDoNCow1VWWhvfByV1trxlAShBobzrEJB3bNXl1+0mZEO4kr1O4vuHjsM9Nf/24MqgSV+YATopFl3OX0tclxsGamRveRNjvAx6rTFkBoWA==
X-Gm-Message-State: AOJu0YwY/kk78IYXJi2WuSDmh/VVfdBgV6jWSy65xQF31fPto13i6xV0
	KTBnaM5F/7Ma4CAAhOhX/F8UBYZo1MgMLfujxKIoS/4w+k0b4DXnti1pv6iEmiWzI3dmRJEHlCN
	A/ZwvWP7f5JjBqp4ZNqOiEYw5JiA5veyibXG9
X-Google-Smtp-Source: AGHT+IH/xutXin8rqxWXABdip1JdHkR2hPTycF2hrEcY74OusUk2w+OhuEuyNKB3wiyM50A4wOlHuBU9pnXbR9oSs0U=
X-Received: by 2002:a17:902:dac2:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1f6bd339c13mr4741225ad.3.1717715875849; Thu, 06 Jun 2024
 16:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23879991.0LEYPuXRzz@milian-workstation> <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1> <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
 <Zl9ksOlHJHnKM70p@x1> <ZmI2Gumx5yUwyFsT@google.com>
In-Reply-To: <ZmI2Gumx5yUwyFsT@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 16:17:43 -0700
Message-ID: <CAP-5=fWD+PPCVCvyBFfd3vZzUajM0HAEWzJe8XmB9p_bfT4ATQ@mail.gmail.com>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles + raw_syscalls
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kenel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 04, 2024 at 04:02:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 11:48:09AM -0700, Ian Rogers wrote:
> > > On Tue, Jun 4, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > > Can you please try with the attached and perhaps provide your Teste=
d-by?
> >
> > > > From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Tue, 4 Jun 2024 11:00:22 -0300
> > > > Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recordi=
ng
> > > >  PERF_RECORD_LOST_SAMPLES event"
> >
> > > > This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.
> >
> > > I think we should try to fight back reverts when possible. Reverts ar=
e
> > > removing something somebody poured time and attention into. When a
> >
> > While in the development phase, yeah, but when we find a regression and
> > the revert makes it go away, that is the way to go.
> >
> > The person who poured time on the development gets notified and can
> > decide if/when to try again.
> >
> > Millian had to pour time to figure out why something stopped working,
> > was kind enough to provide the output from multiple tools to help in
> > fixing the problem and I had to do the bisect to figure out when the
> > problem happened and to check if reverting it we would have the tool
> > working again.
> >
> > If we try to fix this for v6.10 we may end up adding yet another bug, s=
o
> > the safe thing to do at this point is to do the revert.
> >
> > We can try improving this once again for v6.11.
>
> I think I found a couple of problems with this issue. :(
>
>  1. perf_session__set_id_hdr_size() uses the first evsel in the session
>     But I think it should pick the tracking event.  I guess we assume
>     all events have the same set of sample_type wrt the sample_id_all
>     but I'm not sure if it's correct.
>
>  2. With --call-graph dwarf, it seems to set unrelated sample type bits
>     in the attr like ADDR and DATA_SRC.
>
>  3. For tracepoint events, evsel__newtp_idx() sets a couple of sample
>     type regardless of the configuration.  This includes RAW, TIME and
>     CPU.  This one changes the format of the id headers.
>
>  4. PERF_RECORD_LOST_SAMPLES is for the sampling event, so it should
>     use the event's sample_type.  But the event parsing looks up the
>     event using evlist->is_pos which is set for the first event.
>
>  5. I think we can remove some sample type (i.e. TID and CPU) from the
>     tracking event in most cases.  ID(ENTIFIER) will be used for LOST_
>     SAMPLES and TIME is needed anyway.  TID is might be used for SWITCH
>     but others already contain necessary information in the type.  I
>     wish we could add id field to PERF_RECORD_LOST_SAMPLES and tid/pid
>     to PERF_RECORD_SWITCH.

Right, this is good. To clear up the immediate error we just need to
increase the memory allocation size by 48 bytes to account for the
sample ID being written. Here is a change doing that and removing the
memory allocation altogether:
```
diff --git a/tools/lib/perf/include/perf/event.h
b/tools/lib/perf/include/perf/event.h
index ae64090184d3..a2dfaff26fb7 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -77,6 +77,8 @@ struct perf_record_lost_samples {
       __u64                    lost;
};

+#define PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE \
+       (sizeof(struct perf_record_lost_samples) + 6 * sizeof(__u64))
/*
 * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT=
_LOST
 */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..1615a1723fb9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1926,7 +1926,10 @@ static void __record__save_lost_samples(struct
record *rec, struct evsel *evs
el,
static void record__read_lost_samples(struct record *rec)
{
       struct perf_session *session =3D rec->session;
-       struct perf_record_lost_samples *lost =3D NULL;
+       union {
+               struct perf_record_lost_samples lost;
+               char
lost_and_sample_id[PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE];
+       } lost;
       struct evsel *evsel;

       /* there was an error during record__open */
@@ -1951,20 +1954,13 @@ static void record__read_lost_samples(struct
record *rec)

                               if (perf_evsel__read(&evsel->core, x,
y, &count) < 0) {
                                       pr_debug("read LOST count failed\n")=
;
-                                       goto out;
+                                       return;
                               }

                               if (count.lost) {
-                                       if (!lost) {
-                                               lost =3D zalloc(sizeof(*los=
t) +
-
session->machines.host.id_hdr_size);
-                                               if (!lost) {
-
pr_debug("Memory allocation failed\n");
-                                                       return;
-                                               }
-                                               lost->header.type =3D
PERF_RECORD_LOST_SAMPLES;
-                                       }
-
__record__save_lost_samples(rec, evsel, lost,
+                                       memset(&lost, 0, sizeof(lost));
+                                       lost.lost.header.type =3D
PERF_RECORD_LOST_SAMPLES;
+
__record__save_lost_samples(rec, evsel, &lost.lost,
                                                                   x,
y, count.lost, 0);
                               }
                       }
@@ -1972,21 +1968,12 @@ static void record__read_lost_samples(struct
record *rec)

               lost_count =3D perf_bpf_filter__lost_count(evsel);
               if (lost_count) {
-                       if (!lost) {
-                               lost =3D zalloc(sizeof(*lost) +
-
session->machines.host.id_hdr_size);
-                               if (!lost) {
-                                       pr_debug("Memory allocation failed\=
n");
-                                       return;
-                               }
-                               lost->header.type =3D PERF_RECORD_LOST_SAMP=
LES;
-                       }
-                       __record__save_lost_samples(rec, evsel, lost,
0, 0, lost_count,
+                       memset(&lost, 0, sizeof(lost));
+                       lost.lost.header.type =3D PERF_RECORD_LOST_SAMPLES;
+                       __record__save_lost_samples(rec, evsel,
&lost.lost, 0, 0, lost_count,

PERF_RECORD_MISC_LOST_SAMPLES_BPF);
               }
       }
-out:
-       free(lost);
}

static volatile sig_atomic_t workload_exec_errno;
```

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > regression has occurred then I think we should add the regression cas=
e
> > > as a test.
> >
> > Sure, I thought about that as well, will try and have one shell test
> > with that, referring to this case, for v6.11.
> >
> > - Arnaldo
