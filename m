Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A628DC7
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540924; cv=none; b=C+0pOCNb8N85X4vuykVQ1FR6Lcy4JI3wk19fKXzTJaW8wVKSIhV045Vzz7pXxXofmsN2NFQPClOeeSNkB6aczawKlUffD1QeGE5zgMjHiIKbd4paUuqhp0AZNdO8VNVKpVAWhvkmlR29cCn4ALXgJAzwx+k+cuDRPuXREsVw/mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540924; c=relaxed/simple;
	bh=RVJ4j4cMnToo44h4/Z5RpEHyocI7BKeltHV6TedRuMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwE8lvl0nx4iR3uL+MnX5Gc7EMBDvopn3qacS3JrBUwaMllAvXA/e0oxqD3Ays1rjKy5LJALiC1/ouE9odUJdvxtRJGtSG1zI7B3WPdbF0SX45x5Q/SGYxUaLOgWMj0hvsW11t+AvLm7nZhtFEak1Yf7G00BdP8IuP9//fXrmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKVUfW5/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKVUfW5/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f66ad03847so35765ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jun 2024 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717540922; x=1718145722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxpHTd5BZykqrVKTAmTFLY0ccrzh8pYj5w+W6cIXXW4=;
        b=YKVUfW5/0oiRZTH6NICPCFNahbZoopPB/m75XTy/cVc9eQFFa6KIGbbf2n+dwB4Rt5
         pPZ9899gjhv32Nfwj1z9xP5AxcOH+gr3sbkzNKfnm41mQNyDEHC6MBhbUmlXUfsFJYH6
         0MykcoY9zGQ4mcjQCv/wlmw25VUx5/Le/NVfMSX5Nk+pU8aQ1GVEx7p23XK+P6kOXLA6
         Am/v8C4cd+U1+IoQ8aipdZN1Nvt61jnu39ObdgEgiDQSAQauBOYJ+pdDMh8P+/DZXi0J
         YJ3FW/DV3b3ZBVxcRbNPzzgdAzx5zxdAlg1SHiIhLsGv12fEnjgyPSUmQwPcdU8QOdkR
         aNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717540922; x=1718145722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxpHTd5BZykqrVKTAmTFLY0ccrzh8pYj5w+W6cIXXW4=;
        b=V0r055oYitMtQNh76QrI3jR8ot7oadGBCDjJzGSpzebHc/v8lBLS9ay2jG/P9/MA82
         46NAosCLPJd5v5GSJx2aPhKXGn9zhLu6OArM5TSLiNMOLTGDcXmb+d7D5qIpTY2YS5F3
         DoE+OsoGExoaZ6zvm0XebAlmcNiUjwcBgJRSIMpWo+QQfn/0lTxxVXU1ns6lxUNWksVF
         b4tCR0sBd5Oa3duRVGglJnEWTSEeS7lBcsi/wrAY832fUxDdDJvfOyb01Utrpwn6zWk3
         UVI0hT+rPTrOodIKNcmVMwpQFaOB+1bsTZER6EnrMmfzavMuUMIWvvCF1fm9YSEFWfKN
         WwSA==
X-Forwarded-Encrypted: i=1; AJvYcCVl6qP9SWLqDTYXcVRKXdIdVUfgZFxm5l58sYT4LSLHjE7qDxi6WP8bcber/rr534XzfFhcMrB/pxCuYceNcybdCRpa+vsSbZlTP1KA5+ZevA==
X-Gm-Message-State: AOJu0Yz7RkLelTySHgSMsPcXGOZIw1oIrek+ti2/T6tmsRecj+e3AWu8
	Igs1igf9M095dWiqoYRi9NWzJjQT7l6M6ob0CZgkbwh0MNn1jp3guzDMZ1m+hXt701G/whOs9t0
	TeqACbyCB4Fqgjxz09l2nuZWFq84JIM6UOzfw
X-Google-Smtp-Source: AGHT+IEv+dGkXehFDxrAJs9OVMPrLMqlvskSpYNvwbIIRv8bVNJS78j2sX3r56V0EyjAfuI5/+Fx/EY3RwWIVIwxtaU=
X-Received: by 2002:a17:903:8c8:b0:1f6:92be:2c9c with SMTP id
 d9443c01a7336-1f6a64bdc8fmr1186625ad.6.1717540922141; Tue, 04 Jun 2024
 15:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com> <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
 <CO6PR11MB563511F1A6165F0F4B30C4DFEEF82@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Zl-WCEhhxBtiGGhn@google.com>
In-Reply-To: <Zl-WCEhhxBtiGGhn@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Jun 2024 15:41:50 -0700
Message-ID: <CAP-5=fW41UxUDO-FSymMX_R5nEJDnV7FOjfhW5=XGCVj=TSYKQ@mail.gmail.com>
Subject: Re: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Wang, Weilin" <weilin.wang@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 04, 2024 at 08:00:26PM +0000, Wang, Weilin wrote:
>
> > > On Thu, May 30, 2024 at 11:46=E2=80=AFPM Wang, Weilin <weilin.wang@in=
tel.com>
> > > > > > +       /*
> > > > > > +        * Only set retire_latency value to the first CPU and t=
hread.
> > > > > > +        */
> > > > > > +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0) {
> > > > > > +       /* Lost precision when casting from double to __u64. An=
y
> > > > > improvement? */
> > > > >
> > > > > As I said before I think you can set t->val * 1000 and then
> > > > > set the evsel->scale to 1e3 or 1e-3.
> > > >
> > > > Hi Namhyung,
> > > >
> > > > Sorry if this is a repeated message. I thought I replied to your su=
ggestion
> > > > on this last time. I'm thinking we should keep it like this for now=
 and make
> > > > this change unless we find the precision loss is critical. Because =
I thought
> > > > we don't want to add special code to handle the calculation and fin=
al print
> > > > to keep code simple.
> > > >
> > > > I kept this comment here so that we don't forget about it. Please l=
et me
> > > > know if you'd like me to remove it.
> > >
> > > Please see print_counter_aggrdata().  It's the generic code to print
> > > the event value and it'll display the value multiplied by the scale
> > > (default to 1.0).  So you can keep precision as long as you set the
> > > scale properly (1e-3).
> >
> > I could see the retire_latency is printed correctly after set the evsel=
->scale to 1e-3
> > and multiply the t->val * 1000. However, this scale is not used in metr=
ic calculations.
> > We need to add code in metric calculation or display part to scale it a=
s well. Is that
> > acceptable or do you have other suggestions?
>
> Hmm.. I don't know if other metric already dealt with the scale like with
> RAPL events.. If not, I think it's reasonable to add that to the metric
> calculation.
>
> Ian, what do you think?

Tbh, I don't understand the conversation and it looks like we're in
the weeds. In metrics the scale/unit from the event aren't used - that
is all events in a metric are the unscaled quantities unless something
is broken.

Thanks,
Ian

> Thanks,
> Namhyung
>
