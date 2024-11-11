Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40AC15D5C5;
	Mon, 11 Nov 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348497; cv=none; b=dWFt7/FlbEvman60VYlwm0vFeID+cJ2Z1lGPz9DZu+54I5A3ZnLD5+244w927GXSsJN8VKFO2CD6Bwk2h1NtDisYfEusSe7WPyjFdgHeeazmXVNF0CCgk2kHa/gsOuGqztTmVB1sAlZNEsRZ7s54qVw/l/vHLoXSV2Jdaqo/kEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348497; c=relaxed/simple;
	bh=y5iMvf/4S+stnGMBQDra4kM7g4r4/MchdWRgR3GZ/IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuOccxuxmPdmMv0kCT683Sy/YBiU+shG4E82AWD6teQHNy1ZwKjGhwVRbd+m5xnHmvbmDy1rq7Kt2zUJNZT1BcjUlfit26GpaKBO8F2SNNxpDfaEKZIz44s8pW7evFemY37zbGNNp77cgD+NEhyLY6qmHI4xzEqSCUddLWEPXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+rX673a; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+rX673a"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e6005781c0so2827485b6e.3;
        Mon, 11 Nov 2024 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348495; x=1731953295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIIw8COZ4qGRV5piskJJQw93/eMz7AU4LzzjWnY9cLs=;
        b=d+rX673aSEa0diFEKs3Dk+QgrgIe98N2ijTQ0hrXIMyd9JwZjkfSeKTyKTX4nELKwF
         Xwyg3982Gp2mwmxjakwcp6ZAm4y0rJqNXl+ZLydnbyyZsjRE1+Gq44Wx05NY7NBm32lf
         hRcdtatnCl0cyUr2e97B1+eow/A2qA4GWniK98o4U+Ep8Yl3iVPap32tKv4cZEx8tALW
         5Biam7wbIGjFRW3hp/H8x2hMseqQowweq8GKvmPHjuT9KNx8DTBRtY3DIEYbhYrH8+Yd
         RJIl/F3Kwybg3dzax/bD3zQ2yWJPWdcxTUum1YF2ektLdOE95oXpERpvO9hMA0jpWPd6
         /8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348495; x=1731953295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIIw8COZ4qGRV5piskJJQw93/eMz7AU4LzzjWnY9cLs=;
        b=jxn5lY6yIKJ5MwOQN+leAIFa9nDH2kLFOJqynQrxkirhmfXkmgmNi52i9xsTJTrF9O
         iGV9VTxTIr0ud+G770cfZhJiyN/7KNSoc6E84KAPyULmR813ohPnGc3WOETN2lMcLNya
         4FYjUkSfurUQcPE3uD6zu+oyY7NYoK+hIMHLpqnhnu+sTskI2H7zQUtRY69nAsG7PIWd
         zen83yklmFGRUeER4Sd5GT5HX7HyVbKp6KrB7VefvOu0y08AudMQwNFETiDmB643ZTtb
         QlpSSOYVHkVUxUaP7+aQ5yikWq5+44Xl6LDL/Bolet31ZRbrdVp/WnXIWDicYyetlFbU
         +zGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYPVkB6Q8XF44XHNPo4w1oEqmfbH4TNEK1Kf0yrnZEj0YJ2+w6LB3suQeSACg+++SXdIjPdzVuDn3IokQ6NWDeZA==@vger.kernel.org, AJvYcCWQfNAL9l9FHp9zMUC8r0wriJqQzh0IEnuP9vXl17nzde/OK5zzo2H6j/nBsJk67VGqV8l/iAtdmu9SwDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOASLqIorh3tPDjjnUseD9ylMFQglNZYKtg+/f2TZdePPv6Ax
	w2YastPNEDBlccl/oRUfh/yrdRgdJyWpAhkfiznwzc4AlJWB3ikm6Wr7fPn1zgJBWyY1LoeheMs
	trsHqq7FAyoxBpoyLGZIVHXZhRrY=
X-Google-Smtp-Source: AGHT+IFxQV//xr4nFb8zAKndk3eGjv43kUYYuIGwaqWrE52AdsOUkUFvVEprjDC4xGxFvda47ZJ0Y+TlGt2SpbLi4kc=
X-Received: by 2002:a05:6808:14ca:b0:3e6:773:c99e with SMTP id
 5614622812f47-3e7945c7ddbmr11748872b6e.21.1731348495032; Mon, 11 Nov 2024
 10:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com>
 <20241108204137.2444151-5-howardchu95@gmail.com> <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
In-Reply-To: <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 11 Nov 2024 10:08:04 -0800
Message-ID: <CAH0uvoh_qeOqrU+52SqUfaFJY5eCMvr5gKNkn8N4iEt_KS3jVg@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Nov 11, 2024 at 9:47=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Set the perf_event map in BPF for dumping off-cpu samples.
> >
> > Set the offcpu_thresh to specify the threshold.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/bpf_off_cpu.c          | 20 ++++++++++++++++++++
> >  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 558c5e5c2dc3..cfe5b17393e9 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -13,6 +13,7 @@
> >  #include "util/cgroup.h"
> >  #include "util/strlist.h"
> >  #include <bpf/bpf.h>
> > +#include <internal/xyarray.h>
> >
> >  #include "bpf_skel/off_cpu.skel.h"
> >
> > @@ -73,6 +74,23 @@ static void off_cpu_start(void *arg)
> >                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
> >         }
> >
> > +       /* update BPF perf_event map */
> > +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> > +       if (evsel =3D=3D NULL) {
> > +               pr_err("%s evsel not found\n", OFFCPU_EVENT);
> > +               return;
> > +       }
> > +
> > +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> > +               err =3D bpf_map__update_elem(skel->maps.offcpu_output, =
&pcpu.cpu, sizeof(__u32),
> > +                                          xyarray__entry(evsel->core.f=
d, i, 0),
> > +                                          sizeof(__u32), BPF_ANY);
> > +               if (err) {
> > +                       pr_err("Failed to update perf event map for dir=
ect off-cpu dumping\n");
> > +                       return;
> > +               }
> > +       }
> > +
> >         skel->bss->enabled =3D 1;
> >  }
> >
> > @@ -261,6 +279,8 @@ int off_cpu_prepare(struct evlist *evlist, struct t=
arget *target,
> >                 }
> >         }
> >
> > +       skel->bss->offcpu_thresh =3D opts->off_cpu_thresh * 1000;
> > +
> >         err =3D off_cpu_bpf__attach(skel);
> >         if (err) {
> >                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> > diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/b=
pf_skel/off_cpu.bpf.c
> > index c152116df72f..dc6acafb9353 100644
> > --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> > @@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 =3D false;
> >
> >  int perf_subsys_id =3D -1;
> >
> > +__u64 offcpu_thresh;
>
> nit: would be nice to include the unit in the variable name, ie
> offcpu_thresh_us.

Sure I will, thanks.

>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
> > +
> >  /*
> >   * Old kernel used to call it task_struct->state and now it's '__state=
'.
> >   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> > --
> > 2.43.0
> >

Thanks,
Howard
