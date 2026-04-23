Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C23A7F73
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965432; cv=pass; b=ZEyhDWfAtX67UWlwkkdJxX1qdxMur3sfyNt/6Aiq1s75rMdjB32p23jtFSW7IooKF8eovrj+ON8RboEKT6ug958odgmTLJrUIS73l65D6XxE6hASYVdkn0YthBgp6J8vAMyfdDfdhIP9lmkpx+1wgaZwLziMc7CeuCffBrlJ3U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965432; c=relaxed/simple;
	bh=OHxZOrHjriMxHjho2VJUv8h1fFH1e65QaiQENIiJcY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc71CSjcbExzarNZIrTgcqjT68GUqqoEpHqSVI/JlCfjQJljLtJ7FT5Oa643/qsfC+9EB8mf9giLU2fAsVCIWkqal9B1mGN5IG6BgMrQdxpT9CGxOhY1t6KwCMan+xEWIYKRsKzxaXdjW4mDusZZTmm3i8io0Z0lrbgJQxmyzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO9OHzlA; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO9OHzlA"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4670676ba03so2065544b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776965428; cv=none;
        d=google.com; s=arc-20240605;
        b=CAdlKTGiU4tywB+RZuLCVK5mkWD28nM9NsmP1HG2P+oezO8iq1RhO4pdbMTud9b3/q
         Bd6saVEchUXJsnrcjcm5RegXHOi6W/lAa6M8KFora/4YK/xM+2vLdGjiO8IOEUumCkHL
         JXVch+rDWLwMOpx4jSnX9ATaOhmucChwMS/ggIb+aRUUQX2e/kWvNf5CtK7v15i6LKt9
         ju7ObKqtAR7ndPt9WMf8SXEsDC1qi1EzNxer4nrEP0odwmE7lgPhw9GUFr5Ixqf9aKqE
         1ArQi5hGloVm/XBgzq/Gy0hA5pCymzVSWFlq5PxMxbyjx3I/Ry3D1x2n5BX0bj6D/diA
         o+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        fh=rPRoFL1/eXEdDvDOo6kM3LUC1Zxc2D7xT9HbRZ7ejnE=;
        b=O5x2TDDa50Jwaqsgr2Ssdo5lJtsnZ5D80A67h0MPbZzMau3T23RSYrBLa/sd8Om4Vj
         rGS27nEzWeWeX/H7uX/PDXqvndOBFmSrQYcsjS4y0ex2qsXI+yRYZjRDQBG7SwQD4wWO
         kQM3PGoIXT5X/O6vfp63QcmT7VYAA0SVvgNGvq1CT8msoqGTJGgE/uKEsrPxjL0yuLMz
         earUiOboTQfumWnb0H97VJE8f2PwemU0ITrVurS1wqPWzIVqYqmp6FrlklsQ/LZ1EX/F
         xvmepslIEEBw55O4lAR1yNx0NxRBmT506GcdZThThQjdCazy1dqkC9gDuyTuqJ7U22Gv
         BzXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965428; x=1777570228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        b=TO9OHzlA8K4NVB5rhoytTydVvshy9vKW/w3BPSSIcQDk3hgX2sBt845v2DG4SN79un
         pgquTvZ8h5hkgpmEZosWAQxcirUzMTozG98bibOyq5uWyP2IG6lq61RECLfPEsJNsXCD
         4k9mC/AQdPF7QvGEytzD6FZpQl9ryTZy39D2ZedW7i1FwrBecT3RkyGIGEQKon/gLEhJ
         ISL+8IBOkyOLvLxej4lVqg0iQ4KA8+9P6BFZCRavj6vq5TYUoJruX6biJKBEiqBr9YRW
         tFhWaohVyMvEVarnc2UrKcew4S/vUgw2VmrDs1RVPNG2qNEzL8AZdkGOdFrMcIFguCZG
         Hrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965428; x=1777570228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        b=fuX+W5Ib1vqlmZMnTsqdzaVt6/PZllNcMD/gDPG/Glq4XnWy+0YmhJwRfxGu75NnB3
         3SEvM7ASLlVX86DLGWhl+SrhSDKwydY9sTIH5N2WxQvnaD2RXgeG+kKrOpEvRZ61eCi6
         Tjz2p0O5ShsIH62sXgrSS5uNnbiGm3LszpKOM01xVGinc+hjkpAoeHNnhcbnba/FKn3D
         6lJgu/8IgLtM5IgAxyVxlPOYWB4UGnQrFkUGHAqvkfSojPYtIoHfF97XmuwpueN5e3lp
         Ym7VJ4VV9XfnHHsQ+9Cj9s8XdyEu4Vg3sTYL+Ca0WERTwQn1eJTcUSCbZSrwOKRHkFJ8
         +lXw==
X-Forwarded-Encrypted: i=1; AFNElJ/VMwKc0cGrCd3oph7sOyIspTkFmKG36xFQd9wVJT6a1IeifZ3ADjXOrC7MPNZwmNZlPsNFHwjDSfQi+p+YFQsR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKckUBCi1MwdP7BCqqU511Dt84CmcRvgKxik4FE94ruryZ1nL
	qZ7mL+WnCkum0H4+aiSVrQDMHFRJHDAGN0EdW3H70HPwszxi4VIR5hoWxzEfZc7SmV0aAfyBITL
	Y76E40FVbWOT7k3JNiesUsYFvX6sM7x8=
X-Gm-Gg: AeBDieu2dYUd0FZ1PeapZm5VFg5u1CHFmpusV5ckhRcpD7Mqp/Md0Q8ludFQZeejAiM
	P1eTwNGziONuvSf7Fn4kGajPJXsutGq+S0XPU1dFe4GFrODd0hAPT8BDWqF2fgLZc8pyKAhzwXw
	JnW67zcixcUhJuZIueNxjjGRW49169dDSbqdQguatdhi50s0APsoppoMZ5rYCIrJ4Gm2Q6Nph7z
	NfsQiu7ArTf+6gQ94YX6e3KmQ4nnnV1JH3xpL9Zdvw3U0YgK0xn+RpIDWVwVUEtzUMLp8V+49el
	PPt3PRyPIZYIt5ar2JU=
X-Received: by 2002:a05:6808:e659:b0:479:e9d2:26a3 with SMTP id
 5614622812f47-479e9d23f66mr6239447b6e.19.1776965427827; Thu, 23 Apr 2026
 10:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
 <20260421004512.CDE13C19425@smtp.kernel.org> <CAO9wTFiFRSRjMRSAA+vV-AF1rJQGdoCK_p6TXvQ+V1ToaqMs0w@mail.gmail.com>
 <aelx3_VdT_PfsNjd@google.com>
In-Reply-To: <aelx3_VdT_PfsNjd@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 23 Apr 2026 23:00:16 +0530
X-Gm-Features: AQROBzCPMzU5pdTXIwzSBgqZUjnJDYTQmeSHfacHJvSFBm0vWjNwGE6EVqX6rAU
Message-ID: <CAO9wTFhoZ5MR4Gv_mgnqSLYz_bemtd3DYusg8OQp_+i_PA3atQ@mail.gmail.com>
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup aggregation
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Apr 2026 at 06:42, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 01:59:00PM +0530, Suchit Karunakaran wrote:
> > On Tue, 21 Apr 2026 at 06:15, <sashiko-bot@kernel.org> wrote:
> > >
> > > Sashiko AI review found 2 potential issue(s):
> > > - [High] Incomplete spinlock and rwlock contentions are silently drop=
ped for LOCK_AGGR_CGROUP because account_end_timestamp() skips the per-CPU =
tstamp map.
> > > - [Medium] Inconsistent cgroup attribution between complete and incom=
plete lock contentions when a task migrates cgroups.
> > > --
> > >
> > > commit 7ba25dc647534f97eb1ae9f34c6c8d38e7fef074
> > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > >
> > > perf/lock: enable end-timestamp accounting for cgroup aggregation
> > >
> > > This commit adds a cgroup_id field to struct tstamp_data to properly =
account
> > > for incomplete lock contention events when aggregating by cgroup. It =
records
> > > the cgroup ID at contention_begin and uses it to build the aggregatio=
n key
> > > in userspace.
> > >
> > > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/uti=
l/bpf_lock_contention.c
> > > > index cbd7435579fea..1a5bd2ff8ee4c 100644
> > > > --- a/tools/perf/util/bpf_lock_contention.c
> > > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > > @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pi=
d, u64 end_ts,
> > > >               stat_key.lock_addr_or_cgroup =3D ts_data->lock;
> > > >               break;
> > > >       case LOCK_AGGR_CGROUP:
> > > > -             /* TODO */
> > > > -             return;
> > > > +             stat_key.lock_addr_or_cgroup =3D ts_data->cgroup_id;
> > > > +             break;
> > >
> > > Does this fully enable end-timestamp accounting for cgroup aggregatio=
n
> > > on per-CPU locks like spinlocks and rwlocks?
> > >
> > > Looking at account_end_timestamp() in tools/perf/util/bpf_lock_conten=
tion.c,
> > > there is an early return that skips the per-CPU tstamp map:
> > >
> > > static void account_end_timestamp(struct lock_contention *con)
> > > {
> > >         ...
> > >         /* Now it'll check per-cpu tstamp map which doesn't have TID.=
 */
> > >         if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_=
AGGR_CGROUP)
> > >                 return;
> > >
> > >         total_cpus =3D cpu__max_cpu().cpu;
> > >         ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
> > >         ...
> > > }
> > >
> > > Since account_end_timestamp() skips iterating over skel->maps.tstamp_=
cpu
> > > when aggr_mode is LOCK_AGGR_CGROUP, are all incomplete contentions fo=
r
> > > spinlocks and rwlocks still silently dropped?
> > >
> >
> > As per my understanding the tstamp_cpu map stores per-cpu entries
> > without a TID, so there is no current task context available to derive
> > a cgroup ID. Unlike the per-task tstamp map where cgroup_id is
> > captured at contention_begin time, per-cpu entries represent
> > spinlock/rwlock contentions that are inherently CPU-bound and not
> > attributed to a single task at contention_end time either. The
> > original LOCK_AGGR_TASK mode has the same early return for the same
> > reason, cgroup attribution without a task context is not meaningful.
> > This patch addresses only the per-task straggler case.
>
> Right, it'll miss spinlocks and rwlocks but I think it's ok.
>
> >
> > > [ ... ]
> > >
> > > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools=
/perf/util/bpf_skel/lock_contention.bpf.c
> > > > index 96e7d853b9edf..d0e2cad02fa36 100644
> > > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
> > > >       pelem->timestamp =3D bpf_ktime_get_ns();
> > > >       pelem->lock =3D (__u64)ctx[0];
> > > >       pelem->flags =3D (__u32)ctx[1];
> > > > +     if (aggr_mode =3D=3D LOCK_AGGR_CGROUP)
> > > > +             pelem->cgroup_id =3D get_current_cgroup_id();
> > >
> > > If a task migrates to a different cgroup while blocked on a lock, cou=
ld this
> > > lead to inconsistent attribution between complete and incomplete cont=
entions?
> > >
> > > The cgroup ID is statically recorded here at contention_begin() and u=
sed by
> > > userspace for incomplete events.
> > >
> > > However, contention_end() continues to dynamically resolve the cgroup=
 ID:
> > >
> > > SEC("tp_btf/contention_end")
> > > int contention_end(u64 *ctx)
> > > {
> > >         ...
> > >         case LOCK_AGGR_CGROUP:
> > >                 key.lock_addr_or_cgroup =3D get_current_cgroup_id();
> > >                 break;
> > >         ...
> > > }
> > >
> > > Would it be more consistent for contention_end() to also use the stat=
ically
> > > recorded pelem->cgroup_id, ensuring that both completed and incomplet=
e events
> > > attribute the contention time to the exact same cgroup?
> > >
> >
> > I think the fix should go in the opposite direction. Instead of
> > calling get_current_cgroup_id() at contention_end, I think we should
> > be using pelem->cgroup_id. Semantically, the cost of lock contention
> > is incurred by the task that had to wait for the lock. So it makes
> > more sense to attribute that cost based on the cgroup at the time the
> > wait started (contention_begin), rather than whatever happens to be
> > current at the end.
> > I=E2=80=99m not entirely certain about this, so I=E2=80=99d really appr=
eciate any
> > input from maintainers and reviewers on whether this attribution makes
> > sense.
>
> Agreed, as I replied earlier we should use pelem->cgroup_id.
>
> The tstamp_data is saved per-thread so it doesn't matter which thread is
> calling this.  I think the concern is when - IIRC I put it at _end()
> because it may reduce the overhead when we have some filters.
>
> But it seems it's already after checking the filters.  Then it should be
> ok to do in _begin().  Maybe it's a better choice doing it in _begin()
> since the thread is about to go to wait for the lock and doing nothing
> critical.  While at the _end(), it'll start the critical section soon.
>
> Thanks,
> Namhyung
>

Hi Namhyung. Thanks for reviewing the patch. I'll send a v2 patch
shortly for using pelem->cgroup_id instead of get_current_cgroup_id()
in contention_end() as well.
