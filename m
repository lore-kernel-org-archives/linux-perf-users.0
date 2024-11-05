Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398491FF7A5
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840674; cv=none; b=l8uq7R5syaD45I7Xeg7q1n9WhObv4BkhvPHy951ZfbjJIW3u7tnNgKZRXaB3TJgG6DXOSvy+atsgI67GYLC9MyqI+E/4B4hv4rJYbAKJFXwqNDpnAgfXPTmfqyRPw4tledQWHZcJFZGq9tCvnFu0TXnr3ti90MINUW8S1MP7c6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840674; c=relaxed/simple;
	bh=wrj3/qazOSL4ZxdUB86WJNvmN/E0InLO7z8jdaftYp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH1l8ETGk7dHnfPf31o1mwzMVH7i7EsFRT9+Xo10LIUUZ0T+vAXOuhr4Cv6Nnn9YphXIqTxkvIOtlOMsJSc1xMFwF419fXkeXkmq0EdOmLzz3UDhieaLtjW5V7pZ5IITYt0GYKFQNyw5wxtM93cmhmUjT8OGIVDlTRoQKEAwJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsjnPvdT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsjnPvdT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c87b0332cso11015ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730840671; x=1731445471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1RcGRYjbH9Yzq2bfmv8M77Kn2OpXZRTF+Qu3sQqfSY=;
        b=MsjnPvdTIdb/wqYVg1K21b2Byp84ls3a1HIroB682A/yjM7iLerJfVbBMzH4EF1yDL
         qr/CeJ12/4FiBm2sTdWDXtIlLvHb28COw1F1QBI3fHH718rX4s6Vr44Ya3nzNEDoM8J4
         FQxl1Do8mLuIQnIDys1IeEFbEJHIv/6j/LoxPBBYxvepYWxt9/qv/t57kFz39RDcktkF
         2mpQG+QcN/NZVOx2cGZNMwVWtc6b8O9g3+J3djQprqH85bVbWY6RzB5pwmAQT6u+aDMe
         5JCvvD1ISm59oRoNUH/DBxiS8JPYvMi2PhXT0leWjRLTUJq0s8pmml//5YtW0RXKF6hI
         26Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840671; x=1731445471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1RcGRYjbH9Yzq2bfmv8M77Kn2OpXZRTF+Qu3sQqfSY=;
        b=OBXk6EF8LVXyy09bvja7rcpnJHU/LgegQFCmlBk9sCET7YDxVW18vezrL8NlfRFHCd
         o/BxcttasrJmtT2rkUWuuGjs9Pa6INav+ldiMM8KnY8tfarQaUCPQewzNZYTtS+Pv2TM
         9URC2WfoPMgywXf0O2qTiQYM0iHXJPrUrVeDhX6Qzuj04JqRjqFT6LKtSPkZmX+iJ3Kp
         MsAkX01HDApbQzwxAotxcOIYFANlRH5NgPUuBUVOiOPOjnAXE4D5LlX57fK2fF1MTnR6
         S1JGprYDKYSV7ORqE84l07GPsOxYUyJtA8lh3Uaah7CDrXpIeeHi33V3yhhC4g3Vn9n/
         6hcg==
X-Forwarded-Encrypted: i=1; AJvYcCVhq1eIPweAnK8Yy+3nj+RbxZjsK/j+mo89+3UK7wIeUiU4F1nFhZi2RWqdtg0PsUPHvMTCDaujMMfUXEhdNM7j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/btxQT+RyZja3JmNaqeiNjHS9KNU807BizCdMfJi4J3H5ea5R
	3QvIKeWbQMbqSE8+HEG3Lzsa3KyUlevHtMqHWHbDUA0ibNGo1NsdyvXDw1U0djA5ghGxHxbhhUC
	517rLxCYQOmmqc7w3jnFCbNPxO6p49oNDWKKH
X-Gm-Gg: ASbGncuud47aLnrDPeRpHlMeM8qU21ZFLZNIWHYDkwjIr1MprvRcakUE6yTAAOQIqP9
	Uv0AL+oDrRvT6sKe38KbrypSGLE5oiS3e
X-Google-Smtp-Source: AGHT+IE855ArudYnCrY4QSJqhQp74GNCQ29IcUWQTYuwgMe+uqg3o440Yjtg+mxKDAr0dAZfFQQQpaZi2gIEZFuP2ek=
X-Received: by 2002:a17:902:e804:b0:201:e2db:7be3 with SMTP id
 d9443c01a7336-2116b973e24mr456135ad.21.1730840671232; Tue, 05 Nov 2024
 13:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com> <20241102165400.75785-5-irogers@google.com>
 <ZypXmtlqQUxABhMI@x1> <CAP-5=fUNR_t8R33enM1WHzR1-ZzZMUDM1hTLohPdefbKfhMSXA@mail.gmail.com>
 <Zyp3jeLz4ympxfHv@x1>
In-Reply-To: <Zyp3jeLz4ympxfHv@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 13:04:20 -0800
Message-ID: <CAP-5=fVGr5bq5MAnWvfyOKT0ggC0pjZ3uNHKtW2HP3pHHVYEVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf evsel: Add/use accessor for tp_format
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Nov 05, 2024 at 11:33:09AM -0800, Ian Rogers wrote:
> > On Tue, Nov 5, 2024 at 9:36=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > > On Sat, Nov 02, 2024 at 09:53:58AM -0700, Ian Rogers wrote:
> > > > Add an accessor function for tp_format. Rather than search+replace
> > > > uses try to use a variable and reuse it. Add additional NULL checks
> > > > when accessing/using the value. Make sure the PTR_ERR is nulled out=
 on
> > > > error path in evsel__newtp_idx.
>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> > > > +++ b/tools/perf/builtin-kmem.c
> > > > @@ -772,8 +773,9 @@ static int parse_gfp_flags(struct evsel *evsel,=
 struct perf_sample *sample,
> > > >       }
> > > >
> > > >       trace_seq_init(&seq);
> > > > -     tep_print_event(evsel->tp_format->tep,
> > > > -                     &seq, &record, "%s", TEP_PRINT_INFO);
> > > > +     tp_format =3D evsel__tp_format(evsel);
> > > > +     if (tp_format)
> > > > +             tep_print_event(tp_format->tep, &seq, &record, "%s", =
TEP_PRINT_INFO);
> > > >
> > > >       str =3D strtok_r(seq.buffer, " ", &pos);
> > > >       while (str) {
> > > > @@ -2011,14 +2013,15 @@ int cmd_kmem(int argc, const char **argv)
> > > >       }
> > > >
> > > >       if (kmem_page) {
> > > > -             struct evsel *evsel =3D evlist__find_tracepoint_by_na=
me(session->evlist, "kmem:mm_page_alloc");
> > > > +             struct evsel *evsel =3D evlist__find_tracepoint_by_na=
me(session->evlist,
> > > > +                                                                  =
 "kmem:mm_page_alloc");
> > >
> > > Try to avoid these reflows to reduce patch size, please.
> >
> > Agreed, in this case check `checkpatch.pl` is complaining that the
> > line length is 109 columns.
>
> Ok, but it was like that before, your patch is not touching that line
> for some other reason, so it is unrelated to what you're doing, causing
> a distraction.
>
> Besides, even the documentation for checkpatch mentions that that is:
>
>   **LONG_LINE**
>     The line has exceeded the specified maximum length.
>     To use a different maximum line length, the --max-line-length=3Dn opt=
ion
>     may be added while invoking checkpatch.
>
>     Earlier, the default line length was 80 columns.  Commit bdc48fa11e46
>     ("checkpatch/coding-style: deprecate 80-column warning") increased th=
e
>     limit to 100 columns.  This is not a hard limit either and it's
>     preferable to stay within 80 columns whenever possible.
>
>     See: https://www.kernel.org/doc/html/latest/process/coding-style.html=
#breaking-long-lines-and-strings
>
> ----------------
>
> So if it was there already, meaning the original author preferred it
> that way, its not touched by the feature that is being worked on in this
> patch, ends up being an extra hunk, just reflowing, a distraction.

Wow, respecting the author's preferences, sounds like a good thing to
be doing :-) Like I say it came up from checkpatch.pl as I changed the
next line and it was over by quite a way so I felt it was innocuous to
fix it. The variable on this line is used on the next line (the one I
changed) so it isn't as if they are entirely unrelated. I agreed to
put it back. Often reviews like this feel like you are saying
arbitrary changes were made for no reason, which I have a long
experience of avoiding doing. I also try to make sure I don't send
patches upstream that checkpath.pl warns about, its a shame whoever
authored the line didn't think similarly.

Thanks,
Ian
