Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E7824B0;
	Fri, 31 May 2024 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191604; cv=none; b=QQ2PcrNTxvQ0QWYQdMFCLoHMUJKajzFnU05vlKb0zsv9LtLl0Mhxq+cAmGI8YQq5+4qb6kxRv/fLqV9cWKPLe9CrDe81ZW/7TYNRb3VbrX2E87L0RSAb68vHd0xzNxJ+lCmDfDOzS9lpw0jOlRIX//GRfPd0iDgifKXUBgbW6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191604; c=relaxed/simple;
	bh=PS1Zb3Ua1t3vKzQK0lFelDKo1TPa4JWNWk6dhN0bg38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHHHNNDYu8VZMJNQ4IwdvclYNhZPk/k1s0KYxwmGJj2xibkFweozyNd4oqGlP55GcSG5v1P51pBPw8Q8npb3gGGRBNc3mg7kxDYg8t3bl3LPH/1ClG2xC0m4OKmTYr5zBzeAUoAhHukCJzgUOBHJ5MJd/JCOpFFkumkKklU1oHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso853998a12.1;
        Fri, 31 May 2024 14:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191602; x=1717796402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVNjkBJYVeKrZqddtj398UOYP5tbEGwouSvGlhcZZio=;
        b=MJJ87aEUAoyRsqd+rlEByeKFEg7O6u+rlOBkXWr2nYf98oXaOkrtlC/z2O4D2YZWiK
         x5uYTOKuYq6urNBNsoo8LKOpwVoYCh0rPnbHDj4atM6RNrrBidVdFRyBoJJqj1so2QW2
         rg/hAP6S+hpmUevssBRW+u/ZQEMA1MH8/6Ra+HVvW1h8Msr2P9KCLMvRS0qaXIEZ4DJi
         ggE8uaDZ4r40BSxEGsdK2H0xOb5d0e0FXkjs3lcXs8bJZBI7saHuApInei0qdNGyDGVq
         Q8vwMqblvJCxgEeSmrFCR5E8tEDXHuuaUGa4tzxzhHVBZvURn+GbYGuqTyvBjwUZRfez
         uG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXR+8CM1c5VvSPN2MHqQfPZOKCD0Cr8mbMvE8Qlxo3Xv1lWMJhWo9501zvj3b9q9e1F8D3eSeZWm1p3/SqaPWsWFnXqgf35dAReRPe65SoEzNb9nwgIy4V1Am0ivD6Spg5FSK9r+Bz8tBI2WKiSCw==
X-Gm-Message-State: AOJu0YyuLfdK1fabFAv3qQnHk/ReKus1DoNvwwdBntnYraxq02WGwF51
	0pv0aOndAMQNxPPkYSmSui5bg7p7b/YljDk6C+1X04YkA5+yR4dXJf4cgxI3pvqTs+hq037CKoP
	aY38LTOS3+EeVQWb/cFApkgsRTt8=
X-Google-Smtp-Source: AGHT+IHjEMrd91ew9ydEyMI88OAA9SfOhVfmgsVB9MjlgDo85yYO43yH9Pa6fHKWW8HhG/nkRFAB0Ybg75dBbw83M0A=
X-Received: by 2002:a17:90a:c284:b0:2c1:b88a:3a22 with SMTP id
 98e67ed59e1d1-2c1dc5cd779mr2636876a91.45.1717191601678; Fri, 31 May 2024
 14:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com> <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 31 May 2024 14:39:50 -0700
Message-ID: <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
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

On Thu, May 30, 2024 at 11:46=E2=80=AFPM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Thursday, May 30, 2024 11:41 PM
> > To: Wang, Weilin <weilin.wang@intel.com>
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
> > Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record=
 when
> > perf stat needs to get retire latency value for a metric.
> >
> > On Tue, May 28, 2024 at 11:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > When retire_latency value is used in a metric formula, evsel would fo=
rk a perf
> > > record process with "-e" and "-W" options. Perf record will collect r=
equired
> > > retire_latency values in parallel while perf stat is collecting count=
ing values.
> > >
> > > At the point of time that perf stat stops counting, evsel would stop =
perf
> > record
> > > by sending sigterm signal to perf record process. Sampled data will b=
e
> > process
> > > to get retire latency value.
> > >
> > > Another thread is required to synchronize between perf stat and perf =
record
> > > when we pass data through pipe.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > [SNIP]
> > > +int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread=
)
> > > +{
> > > +       struct perf_counts_values *count;
> > > +       struct tpebs_retire_lat *t;
> > > +       bool found =3D false;
> > > +       __u64 val;
> > > +       int ret;
> > > +
> > > +       /* Non reitre_latency evsel should never enter this function.=
 */
> > > +       if (!evsel__is_retire_lat(evsel))
> > > +               return -1;
> > > +
> > > +       ret =3D tpebs_stop();
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > > +
> > > +       list_for_each_entry(t, &tpebs_results, nd) {
> > > +               if (!strcmp(t->tpebs_name, evsel->name) || !strcmp(t-
> > >tpebs_name, evsel->metric_id)) {
> > > +                       found =3D true;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       /* Set ena and run to non-zero */
> > > +       count->ena =3D count->run =3D 1;
> > > +       count->lost =3D 0;
> > > +
> > > +       if (!found) {
> > > +               /*
> > > +                * Set default value or 0 when retire_latency for thi=
s event is
> > > +                * not found from sampling data (enable_tpebs_recordi=
ng not set
> > > +                * or 0 sample recorded).
> > > +                */
> > > +               val =3D 0;
> > > +               return 0;
> > > +       }
> > > +
> > > +       /*
> > > +        * Only set retire_latency value to the first CPU and thread.
> > > +        */
> > > +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
> > > +       /* Lost precision when casting from double to __u64. Any
> > improvement? */
> >
> > As I said before I think you can set t->val * 1000 and then
> > set the evsel->scale to 1e3 or 1e-3.
>
> Hi Namhyung,
>
> Sorry if this is a repeated message. I thought I replied to your suggesti=
on
> on this last time. I'm thinking we should keep it like this for now and m=
ake
> this change unless we find the precision loss is critical. Because I thou=
ght
> we don't want to add special code to handle the calculation and final pri=
nt
> to keep code simple.
>
> I kept this comment here so that we don't forget about it. Please let me
> know if you'd like me to remove it.

Please see print_counter_aggrdata().  It's the generic code to print
the event value and it'll display the value multiplied by the scale
(default to 1.0).  So you can keep precision as long as you set the
scale properly (1e-3).

Thanks,
Namhyung
