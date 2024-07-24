Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369C629
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779561; cv=none; b=KxFpSY8YZqi+HHHlVLKxEGkOHiah49xVZ2yEWzSI2tKvkSZjb9KXbCIRH/x9ziThWZJLJLmieoWELmGWEQiPHgU8FiV/Vlc5X4XkqLAiOx30vO2MfinhlQ/eGVv6jvsm1aGxozBvL+HnL848Uaz6Bshfhhuk9PyRymvanqiGhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779561; c=relaxed/simple;
	bh=Rn3AcKdJyP+fPeBH0alY470bqpaiUSqzMwGEO0+GrFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRXxzKly0ks4uRaKQQ2MEQgQzScIHaI/GTWIpIMbZOm3dOjJJVUZ9j20ta25xQAIP0RmmASXYWFnYitf8hKl8zPNs/1AOugFDJIbhApkYaUdwWsvlrp1crPUtsPjkpZvQixxXgaNn0+Dbtk6rKB/cdmHE0s+ZiqpKD8tpThf2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSeTYbje; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSeTYbje"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447f8aa87bfso208321cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721779558; x=1722384358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1831yKxdGktKE/BM3FRoqGZZXvP8ihIMJ27cMH9VSGw=;
        b=qSeTYbje49JvWnG40x7JQ3538vbYlBhEKXXX65v4fEyddcB2pbwc4eUVzzaZ+wGcm/
         YHV+Hj2+tjM33gbkDU46YcBYwXG7Lr9rBmIL6Rlg+p0NlqZ2edZWsy89XHx5UoI+hQAH
         h3GoGK5bmYwu5cUC9/ocvkwyjF5MH+JOHfSvJbTjNgwqawlqf4ljy3f8BSPU/m5ftHCo
         iDmQxRIyy8n6qDzmcDYGBenShjvenquQehZgedd+uinM8eFVJQe/lFnlVrI9LckdcAwv
         tODlR31DxzWYXpLI7ZBKN8Q/tF6slFgKbItA7JS7ItGNrpjaXee30y7rwNZWDHxjqkfa
         me+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779558; x=1722384358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1831yKxdGktKE/BM3FRoqGZZXvP8ihIMJ27cMH9VSGw=;
        b=VnWiZw31mtYbLyzmDdoCYAu6tnu8O+0PWa/3Ur1/kIUATAwMfaHGJTx5OKtbEZAbEa
         aukq6KWBF3col2y7PEefKqwdQaO3UOoTo5D7bv8IWqxEGHlaMrtkQm9ymfjABnZhgGOp
         t7Mpt+HtxAI29uNNHVdPEzrrp62RLZxzabYUWPTiDXhnNlKOpVTbj+o4xovhNsUMAucF
         FFFfe6lIxM3mbMLMmB1hF0rElRyWqChNRbUJ39LMD5HN76m/qTTZ4gZGlp8bc53TNrjy
         xrOaHJ2+9pn2ZZ3f0sI3FK4zxrDVxL91nPu7/aWTh6h2us8OciYHmTUqX0tY7FddbEjq
         U6Ow==
X-Gm-Message-State: AOJu0YxT47dPl7zPsHKrMmZ+/xwqBA88YBWX4a/dOzF/Bfr6W3hisj+G
	FxtlueUZWALRbN7JW0s/CcpNiAk+JihBGPg562y3px4XU6StWki/RsDxcCZQErlreuVvAL+/P84
	8Jp7xV4KFFWuc41NMchY5zTPUkQVNmHM7d5Sh9cxH1auJZM5UZdrmuAM=
X-Google-Smtp-Source: AGHT+IGTAJ/XkZQeytkWb2SBUWLeZOyrs7LoXwobErxVB5joH4n+/Bu0gyoVaPmPn4JHd+Yj8WnXxhq826V+0Jelr1M=
X-Received: by 2002:ac8:5916:0:b0:447:e497:95d0 with SMTP id
 d75a77b69052e-44fd4ace204mr1914881cf.17.1721779557974; Tue, 23 Jul 2024
 17:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723204834.3617647-1-ak@linux.intel.com> <20240723204834.3617647-3-ak@linux.intel.com>
 <CAP-5=fU8=gTatcHkvN8jv72_dJvaAb3FE+pnWB2LSN=SM0dRxw@mail.gmail.com> <ZqA88FMUcDFwrobi@tassilo>
In-Reply-To: <ZqA88FMUcDFwrobi@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 17:05:46 -0700
Message-ID: <CAP-5=fUrw3W-v53zi4xo9NVh=-fjXrNr3FC=KQFWj1E+ckZN9A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] perf script: Fix perf script -F +metric
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:29=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> On Tue, Jul 23, 2024 at 02:32:33PM -0700, Ian Rogers wrote:
> > On Tue, Jul 23, 2024 at 1:48=E2=80=AFPM Andi Kleen <ak@linux.intel.com>=
 wrote:
> > >
> > > This fixes a regression with perf script -F +metric originally caused=
 by :
> > >
> > > commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Sun Feb 19 01:28:46 2023 -0800
> > >
> > >     perf metric: Directly use counts rather than saved_value
> > >
> > > In the perf script environment the evsel wouldn't allocate an aggr
> > > values array, which led to a -1 reference because the metric
> > > evaluation would try to reference NULL - 1 (for aggr_idx)
> > >
> > > Give the perf script evsels a single CPU aggr setup. That's
> > > enough because the groups are always contiguous, so no need
> > > to store more than one CPU's worth of values.
> >
> > I don't follow this. Samples have CPUs but you're associating all
> > values with CPU0. Why not just use counts and aggregation properly?
>
> Why use something that is not needed?

The main reason would be so that perf_stat_process_counter could work
and update the aggregation accordingly. Then you can dump out the
aggregation, be it per CPU, per core, per socket, per cache-level,
etc. as appropriate. If you follow the perf stat convention you are
also much less likely to be broken in the future, as perf stat would
also get broken. It is complicated spaghetti to work out how this
stuff works, but that's why I fixed in the patch I sent out.

> It's not needed because the CPUs are not interleaved because the code
> is just processing a single group which only has counts from
> a single CPU. And there is no need to output an extra index for the
> count because the sample already has all the context.
>
> If it was extended to multiple groups it would be needed, but it's not
> clear how useful it is. The benefit of the feature is that you
> can get the metric at a very fine grained level -- only for the time inte=
rval
> since the last sample.
>
> Doing it for multiple groups means you would do some level of
> aggregation over longer time periods.. You could handle more complex metr=
ics,
> but would lose this very fine grain benefit. If you want that it's probab=
ly
> better use perf report's time slicing feature instead of perf script.
> That one currently doesn't support metrics though, but probably it
> should.
>
> > > @@ -2325,6 +2330,20 @@ static void process_event(struct perf_script *=
script,
> > >                 fflush(fp);
> > >  }
> > >
> > > +static void check_metric_conflict(void)
> > > +{
> > > +       int i;
> > > +       /*
> > > +        * Avoid conflict with the aggregation mode used for the metr=
ic printing.
> > > +        */
> > > +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > > +               if (output[i].fields & PERF_OUTPUT_METRIC) {
> > > +                       fprintf(stderr, "perf stat record files are n=
ot supported with -F metric\n");
> > > +                       exit(1);
> > > +               }
> > > +       }
> > > +}
> > > +
> >
> > No idea what this is doing. What's conflicting with what?
>
> The conflict is between the -F +metric setup and processing STAT*
> records in the perf.data (as generated by perf stat record)
> The later uses AGGR_NONE which is a conflict.

Or let it set the aggregation mode and just let the aggregation code
handle it when computing metrics? I think getting the STAT events
isn't typical, so this is an academic argument. I'm just thinking
about future me, wondering why on earth this exists.

Thanks,
Ian

> > >
> > > @@ -3785,6 +3810,8 @@ int process_cpu_map_event(struct perf_session *=
session,
> > >         if (dump_trace)
> > >                 perf_event__fprintf_cpu_map(event, stdout);
> > >
> > > +       check_metric_conflict();
> > > +
> > >         if (script->cpus) {
> > >                 pr_warning("Extra cpu map event, ignoring.\n");
> > >                 return 0;
> > > @@ -4088,6 +4115,10 @@ int cmd_script(int argc, const char **argv)
> > >
> > >         argc =3D parse_options_subcommand(argc, argv, options, script=
_subcommands, script_usage,
> > >                              PARSE_OPT_STOP_AT_NON_OPTION);
> > > +       for (i =3D 0; i < OUTPUT_TYPE_MAX; i++) {
> > > +               if (output[i].fields & PERF_OUTPUT_METRIC)
> > > +                       stat_config.aggr_map =3D &(struct cpu_aggr_ma=
p){ .nr =3D 1 };
> >
> > Assigning the address a temporary rval to a global variable seems
> > wrong to the point I'm surprised it compiles. Accessing
>
> AFAIK gcc keeps the local around for the function, but you're right
> it's not good code, especially with the buffer overrun.
>
>
> > stat_config.aggr_map->map[0] will lead to reading beyond the end of
> > the value and presumably read uninitialized memory.  Compiling with
> > EXTRA_CFLAGS=3D"-fsanitize=3Daddress" should complain about all of this=
.
>
> Good point, but I doubt the address sanitizer would have caught
> it because it doesn't really track the stack.
>
> -Andi
