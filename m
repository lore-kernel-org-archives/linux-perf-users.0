Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3125760
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776065; cv=none; b=B5TjMxlZNZzGt1XzjKIlSlxXoeJaLz2Xdy2UcO08F6HKVTusY0NDhD7Id0VJP2dLKzowM1hz72o8bT437Nt4WswHnul9Y4C+AOQ3It/EXtfkGPhvPFccaV6Vl9VpdfjPvX+C8dk47yogAbQvd4l2FzlSE0uUb6CSfVP+88MP1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776065; c=relaxed/simple;
	bh=+forq/4jMQxgwgyJ1Exi9aq4d/6/TnXqiOoAvPwvEGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJbPkpgjc6n79qQ4aIL+d2IF0AdB/zjsVRZeD2xmQBXlwS57i/Pucj34DVPJbF2enjVhFRjJYmiRax1fZCNLi45V6xefrfuX000pArvzKD4Cq0JjUKcQYVuDwpkvNkmCuEUrxrYnQPFO1nhpgzqOnjvDRxBbu0UiLBkr6rNcRxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOpPI3nI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOpPI3nI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447f8aa87bfso193201cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721776059; x=1722380859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C+fkFukNiGp5ISGUxgRcyilQiJzLpuodr5Eof9VBJg=;
        b=fOpPI3nIH9h7LuKh+VDilpnm9eckFMoGse3gCE0b5jk8nvavsmgRNklzObBYeGwHv7
         Pr7F4/2dJTc5vkm/s6jzWFu9Fh4sVBnHv0qoR8ritgsnvlUOFGOV6vhkr8TKnELHR9XX
         OhJCBfaz2L5AtnKjNE49lNhDeWXGzce2yYeiImz/5mJbe17BKU/Omp9Pl9FSiSAybCOe
         zLUvWfGT83FeNHzSGmv77kRxZeixX72PoxT0XVx3nIRW14M9XlDy5kEW0t9vhVvFuBx6
         BRKMgp50kGb0i8VJmBp2hpVmxVsPYzupPiPI3rGrk2Qa5mLzvQhcPAe5kKq51Qc8zWk/
         qeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776059; x=1722380859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C+fkFukNiGp5ISGUxgRcyilQiJzLpuodr5Eof9VBJg=;
        b=TMSrgzYzGvgOZsoeKPZg2hrBYpkyztbnOM/TeoajCn5IZ4VgOfjIMAUM1hqNK8dcoI
         cgTKMdo4KubejPxh64IKKcxzbXseptIR5p3TWpIX852ZjsGvs8YKAiskGemVJTPHtDVl
         VECheoUdsefSxVPvqE0oJ97jOIuEOzmoAgZPmFhjglELZHwhpp2giCOmxAWXh8OhLX83
         Fq4w77lvB32qdZL7YqLy/7Vh12lQfO3/eSdvmJrrk8FdplRlcnG38e5383PHPCALcRs3
         q+E81JNELHMTS5c2LZHWTh3OI6Z+kgFpJ5wiDquGJa3/V98NucrjiC2jcRuiTPb5nDPI
         O1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZIqvV3oqpGO4lJWBlg6n0CHZvQsg5mDDxrXmVLCG5X7MG6NEmeBPlHfHaM08u76ONndx9R34V823UwOyY6yy4rL/0ODg3SaUQdEFjygdx+A==
X-Gm-Message-State: AOJu0YzLa2uyA7Bf80+0hd4fgaBB5pYbhNje/IMxnH3w+cAHbkstYq1w
	jh1ksLRXVkmiaGSPdk0licgvzl4qbmFEMVprPQnvTunYw/QIToCkm+RqEQs1BK9VUPF2MVSePRl
	UZt2EffrCUdKL6RDCZ8G3vsw+N+7rlWBc3U7l
X-Google-Smtp-Source: AGHT+IFgGTZzHeugui0RzmvFiY7doQ86K2Y0h52nLIG0c9YpVHS5634BVNFZRzQv9vFzIFzEs6QM3K+ectPLd0aerco=
X-Received: by 2002:a05:622a:248:b0:444:ccc5:f4c0 with SMTP id
 d75a77b69052e-44fd4ac8c3dmr1983041cf.15.1721776058474; Tue, 23 Jul 2024
 16:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722210648.80892-1-lucas.demarchi@intel.com> <20240722210648.80892-2-lucas.demarchi@intel.com>
In-Reply-To: <20240722210648.80892-2-lucas.demarchi@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jul 2024 16:07:27 -0700
Message-ID: <CAP-5=fUgxQB-pzxNHZXGzFh1B3yL=ui0izM-dp_K7oubh8UOOg@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf/core: Add pmu get/put
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:07=E2=80=AFPM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> If a pmu is unregistered while there's an active event, perf will still
> access the pmu via event->pmu, even after the event is destroyed. This
> makes it difficult for drivers like i915 that take a reference on the
> device when the event is created and put it when it's destroyed.
> Currently the following use-after-free happens just after destroying the
> event:
>
>         BUG: KASAN: use-after-free in exclusive_event_destroy+0xd8/0xf0
>         Read of size 4 at addr ffff88816e2bb63c by task perf/7748
>
> Whenever and event is created, get a pmu reference to use in event->pmu
> and just before calling module_put(), drop the reference..
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/linux/perf_event.h |  3 +++
>  kernel/events/core.c       | 32 ++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index a5304ae8c654..7048a505e93c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -540,6 +540,9 @@ struct pmu {
>          * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
>          */
>         int (*check_period)             (struct perf_event *event, u64 va=
lue); /* optional */
> +
> +       struct pmu *(*get)              (struct pmu *pmu); /* optional: g=
et a reference */
> +       void (*put)                     (struct pmu *pmu); /* optional: p=
ut a reference */
>  };
>
>  enum perf_addr_filter_action_t {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1b6f5dc7ed32..cc7541b644b0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5208,6 +5208,8 @@ static void perf_addr_filters_splice(struct perf_ev=
ent *event,
>
>  static void _free_event(struct perf_event *event)
>  {
> +       struct module *module;
> +
>         irq_work_sync(&event->pending_irq);
>
>         unaccount_event(event);
> @@ -5259,7 +5261,13 @@ static void _free_event(struct perf_event *event)
>                 put_ctx(event->ctx);
>
>         exclusive_event_destroy(event);
> -       module_put(event->pmu->module);
> +
> +       module =3D event->pmu->module;
> +       event->pmu->put(event->pmu);
> +       /* can't touch pmu anymore */
> +       event->pmu =3D NULL;
> +
> +       module_put(module);
>
>         call_rcu(&event->rcu_head, free_event_rcu);
>  }
> @@ -11331,6 +11339,11 @@ static int perf_pmu_nop_int(struct pmu *pmu)
>         return 0;
>  }
>
> +static struct pmu *perf_pmu_nop_pmu(struct pmu *pmu)
> +{
> +       return pmu;
> +}
> +
>  static int perf_event_nop_int(struct perf_event *event, u64 value)
>  {
>         return 0;
> @@ -11617,6 +11630,12 @@ int perf_pmu_register(struct pmu *pmu, const cha=
r *name, int type)
>         if (!pmu->event_idx)
>                 pmu->event_idx =3D perf_event_idx_default;
>
> +       if (!pmu->get)
> +               pmu->get =3D perf_pmu_nop_pmu;
> +
> +       if (!pmu->put)
> +               pmu->put =3D perf_pmu_nop_void;
> +
>         list_add_rcu(&pmu->entry, &pmus);
>         atomic_set(&pmu->exclusive_cnt, 0);
>         ret =3D 0;
> @@ -11695,7 +11714,8 @@ static int perf_try_init_event(struct pmu *pmu, s=
truct perf_event *event)
>                 BUG_ON(!ctx);
>         }
>
> -       event->pmu =3D pmu;
> +       event->pmu =3D pmu->get(pmu);
> +
>         ret =3D pmu->event_init(event);
>
>         if (ctx)
> @@ -11714,8 +11734,12 @@ static int perf_try_init_event(struct pmu *pmu, =
struct perf_event *event)
>                         event->destroy(event);
>         }
>
> -       if (ret)
> -               module_put(pmu->module);
> +       if (ret) {
> +               struct module *module =3D pmu->module;
> +
> +               pmu->put(pmu);

I think this is a great fix, a nit here, wouldn't it be good to do:

event->pmu =3D NULL;

Thanks,
Ian

> +               module_put(module);
> +       }
>
>         return ret;
>  }
> --
> 2.43.0
>
>
