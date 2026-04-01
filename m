Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91823191CE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022951; cv=pass; b=HBudLfEXCKwy3BMSb9SUGRON4LluLtLtHsGm6V4WEhoEsU7wDjH1ei64pgJV3FOdk2ndAGDVIKXWuna0EXEwWItoj0tAvnSAo6UlyDJFXo0dq09yhcgl3Ref/kW3bEqd7S1WUoS0GwymtGwP2X71lKWNncvZCowQeci/WIRT4Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022951; c=relaxed/simple;
	bh=fWsHl1D4rFzkyWoNQyQON3nxRwb6ZKP7ZO0KdADOZBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNwdolRQykKjZry3jHmQtavEKrWkd8j1nM4C5z2jgk6n+sYpy9/llDs5C8SShFypzcGVxiAaYfrm45I6SozTOpR7dNOBaRXrBM/nWKKiFYvTDFtnzkGtlivXI7ZRc4Od+pbuejqgzDuMtmAEYpYQ49rVJdEHju5KHrHNtB6nbnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLxDc4Rx; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLxDc4Rx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0b260d309so145855ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775022947; cv=none;
        d=google.com; s=arc-20240605;
        b=NnZAV2f0WIOkGTQvB2S7og7X4VSmWlQNV3L5BQ35CoiaVuepW2p7SJGlRsCgvcZGRu
         XHTQyAfzMXI3Wd2NA2T8cm+m7gHX4wsY5hiXEpez6PNIzcRn3FnKn2Nmn7NjyBDjI9rR
         8ZzoCu8hMCYBcLZJKxFXju2hgCz+jkwsdhX4TlyS+kd5XT5ZnvcAvGxTjAVbtPe7vAnR
         y8rKHMUm1dbexYjw1ps0s7fAAUMGjQ1h6qFuoTSNLZLxFeH+CjnOaT6ScDil48b51fgc
         q1it9+OYuqDF40pFbvN/EWMKJ3NyUml2XC1mc/9UtX1cJpYGsISSmtEP4b1YmtWBxKIA
         PlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SoXFrMunY/CapaxUvYgaLsFiZ+81VFhicWBf/2D3d40=;
        fh=eDrvBt5vQXvovYKFAFqFkaZbJuB60+5myFgSR/2Iacs=;
        b=DmRaR/p7s2laqOdXtyF6dJvHs/ONCCgo6FU0ptQviPNkHRv6LBR22AVMhzsTWsBUte
         OD+uZMtvXcMfFf5ctW+glYp6x603PlHJKapKLRrZQsXwfw1P82r3tYs6iizO+PYkAzUa
         ffH65v6jt8UM3Eb/LvpKqLlh0+HTmS95kgJ/NaJkbN+LycLl0jPzGBRAyGLA7sww7LNA
         D28mHmGxy2l5TY1vuyGdnYrPqARgvmkDS42oDLKL9DKjZGt8zZ/hpj71fts3lXW24YVS
         J5uI14F+ocGG1KdP/7TFm6IzCAqGbDwkN4H8Wz6ZdcCi7pOWj+3sE2FlleidkK1X5GO3
         t9Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022947; x=1775627747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoXFrMunY/CapaxUvYgaLsFiZ+81VFhicWBf/2D3d40=;
        b=OLxDc4RxyjsTmUNxHliAIOPXVRh91jSq2Hx/0jewwpsdOgAlM5dl6thAEaySyiccch
         ErT+LJJBc8SoTGRuAonUHheGMoeSWsgsjts3GJ8STt4WJhofQvtTcwunHw1p/l9ZykrE
         9iaZLuLnaTuJFA0i0wl8OeaW8GLTi0ih6KXCmt4dqqbx5Rx3lLmGQJR3GCPK1MFJD6se
         uYEDRDRGEVNTiLmW3zEJVzf2/Vy/AtniEmYQBfbKmiF4TnQ07326jhUlYJ2+YK09bJr3
         EVuQLKUzX3RHUS0l4w/KurKIBBZj4wdLgMUK2SLZZdL3shvS53CXIWAmhhnOPkNezmXo
         Iefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022947; x=1775627747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SoXFrMunY/CapaxUvYgaLsFiZ+81VFhicWBf/2D3d40=;
        b=J4dc+Q5+VzFRNYbm1RTAKM/xLKq/NgQLxyrAv+1v/V9sWES4MShImpq+OEy36+Dw85
         ha5PFL3ffR7mmqUyOoFaWhAhGgcQrtys1ySZazpxszyG+03NRCSKKLt8y/6ibKFJRUOO
         8qv0Lb9tVwC/9wyWr92VcKUFjwJKM7deYeQnL3WNDUhaO4912q1C1kDDrkxmRJzu7Qor
         R7dV7n4aXFeWQVzju0OX4sQ/EDY1sl1iRLJ0fp0XsVqatUAFrToDngJLfn36egJB/x+A
         hL42L70YQcum0c5H8ygFOO6UA0OkW8opbAACGovA8pCcx6OAEv7oG2KhK5HKQTyNcoJ+
         oQGw==
X-Forwarded-Encrypted: i=1; AJvYcCV+V/8K5AZGMQhfFuDwDgkOZhgou07E75LkpIlj+uD3l+da3GBgZ5wtirbVC80KRCjFBDDpOYICn5cI3LlDN4ua@vger.kernel.org
X-Gm-Message-State: AOJu0Yyend5ak4Q/C2R9jEH42e+P4lNNiUk4zU2eEkQGjJh3vvtrFYg7
	ctXJkyUR3wBgRr9g/m2C1sErKpZ8ILgbqaYBh9JIDCnYCdbaNaJfdPD0FDDq2p0gzvp2TQf0ryH
	BSxIEuDw4PESf+zcwL5uE46ru6FaDJrjEPsfFpo6q
X-Gm-Gg: ATEYQzxWyccbFlN2wKnc0Kas88FW/tmRtngmJj34a6QSiaAu1dbSavubyq60F1N+O9A
	ylgn3UOccTwKKgsKTSWyCZb/te8hwUzlvLro95rHd6STHJZZdfYe/kzEr1XxGB+i9tSTFObx3Ud
	g15XGOvqPiD1AMr2uWoogsuFJRNZ4CmworoqldOgxxSci3YMSUyklRPqJIOxu6+V/RYeFUamUyJ
	Iz0WVYz84wcmYihbf+sQ64vdfZcstzFJEwVyhpHOPuX4PSA64JUrMBFCmatq7PYmXtJ/5XQ6mmp
	oOt1uQuW
X-Received: by 2002:a17:903:984:b0:2ae:80a3:98a9 with SMTP id
 d9443c01a7336-2b26b2aeee2mr1300075ad.11.1775022946333; Tue, 31 Mar 2026
 22:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
 <20260319010103.834106-1-irogers@google.com>
In-Reply-To: <20260319010103.834106-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 22:55:35 -0700
X-Gm-Features: AQROBzAkubzWTVI5CBDCfWDyir9ND-pzG5pYoLTmEUFXRov1OPkLDQ9flML9-E4
Message-ID: <CAP-5=fWQD20J_qQJCmuvmWAzo6BZCOQM7uE7wqiaRk4oCPs9rg@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Make common stalled metrics conditional
 on having the event
To: acme@kernel.org
Cc: japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 6:01=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The metric code uses the event parsing code but it generally assumes
> all events are supported. Arnaldo reported AMD supporting
> stalled-cycles-frontend but not stalled-cycles-backend [1]. An issue
> with this is that before parsing happens the metric code tries to
> share events within groups to reduce the number of events and
> multiplexing. If the group has some supported and not supported
> events, the whole group will become broken. To avoid this situation
> add has_event tests to the metrics for stalled-cycles-frontend and
> stalled-cycles-backend. has_events is evaluated when parsing the
> metric and its result constant propagated (with if-elses) to reduce
> the number of events. This means when the metric code considers
> sharing the events, only supported events will be shared.
>
> Note for backporting. This change updates
> tools/perf/pmu-events/empty-pmu-events.c a convenience file for builds
> on systems without python present. While the metrics.json code should
> backport easily there can be conflicts on empty-pmu-events.c. In this
> case the build will have left a file test-empty-pmu-events.c that can
> be copied over empty-pmu-events.c to resolve issues and make an
> appropriate empty-pmu-events.c for the json in the source tree at the
> time of the build.
>
> [1] https://lore.kernel.org/lkml/abm1nR-2xjOUBroD@x1/
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/lkml/abm1nR-2xjOUBroD@x1/
> Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on de=
fault ones")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  .../arch/common/common/metrics.json           |   6 +-
>  tools/perf/pmu-events/empty-pmu-events.c      | 108 +++++++++---------
>  2 files changed, 57 insertions(+), 57 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/tool=
s/perf/pmu-events/arch/common/common/metrics.json
> index 0d010b3ebc6d..cefc8bfe7830 100644
> --- a/tools/perf/pmu-events/arch/common/common/metrics.json
> +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> @@ -46,14 +46,14 @@
>      },
>      {
>          "BriefDescription": "Max front or backend stalls per instruction=
",
> -        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycles=
\\-backend) / instructions",
> +        "MetricExpr": "(max(stalled\\-cycles\\-frontend, stalled\\-cycle=
s\\-backend) / instructions) if (has_event(stalled\\-cycles\\-frontend) & h=
as_event(stalled\\-cycles\\-backend)) else ((stalled\\-cycles\\-frontend / =
instructions) if has_event(stalled\\-cycles\\-frontend) else ((stalled\\-cy=
cles\\-backend / instructions) if has_event(stalled\\-cycles\\-backend) els=
e 0))",
>          "MetricGroup": "Default",
>          "MetricName": "stalled_cycles_per_instruction",
>          "DefaultShowEvents": "1"
>      },
>      {
>          "BriefDescription": "Frontend stalls per cycle",
> -        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> +        "MetricExpr": "(stalled\\-cycles\\-frontend / cpu\\-cycles) if h=
as_event(stalled\\-cycles\\-frontend) else 0",
>          "MetricGroup": "Default",
>          "MetricName": "frontend_cycles_idle",
>          "MetricThreshold": "frontend_cycles_idle > 0.1",
> @@ -61,7 +61,7 @@
>      },
>      {
>          "BriefDescription": "Backend stalls per cycle",
> -        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> +        "MetricExpr": "(stalled\\-cycles\\-backend / cpu\\-cycles) if ha=
s_event(stalled\\-cycles\\-backend) else 0",
>          "MetricGroup": "Default",
>          "MetricName": "backend_cycles_idle",
>          "MetricThreshold": "backend_cycles_idle > 0.2",
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index 76c395cf513c..a92dd0424f79 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -1310,33 +1310,33 @@ static const char *const big_c_string =3D
>  /* offset=3D128375 */ "migrations_per_second\000Default\000software@cpu\=
\-migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,n=
ame\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dt=
ask\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\000=
1migrations/sec\000\000\000\000011"
>  /* offset=3D128635 */ "page_faults_per_second\000Default\000software@pag=
e\\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
00011"
>  /* offset=3D128866 */ "insn_per_cycle\000Default\000instructions / cpu\\=
-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instruction=
s\000\000\000\000001"
> -/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000max(=
stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000=
\000Max front or backend stalls per instruction\000\000\000\000\000\000001"
> -/* offset=3D129143 */ "frontend_cycles_idle\000Default\000stalled\\-cycl=
es\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stal=
ls per cycle\000\000\000\000\000\000001"
> -/* offset=3D129273 */ "backend_cycles_idle\000Default\000stalled\\-cycle=
s\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls p=
er cycle\000\000\000\000\000\000001"
> -/* offset=3D129399 */ "cycles_frequency\000Default\000cpu\\-cycles / (so=
ftware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@tas=
k\\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GH=
z\000\000\000\000011"
> -/* offset=3D129575 */ "branch_frequency\000Default\000branches / (softwa=
re@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-=
clock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M=
/sec\000\000\000\000011"
> -/* offset=3D129755 */ "branch_miss_rate\000Default\000branch\\-misses / =
branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000=
\000\000001"
> -/* offset=3D129859 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\=
-misses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000=
\000100%\000\000\000\000001"
> -/* offset=3D129975 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses =
/ LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\=
000\000001"
> -/* offset=3D130076 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\=
-misses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\=
000100%\000\000\000\000001"
> -/* offset=3D130191 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misse=
s / dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000=
\000\000\000001"
> -/* offset=3D130297 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misse=
s / iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000=
\000\000\000001"
> -/* offset=3D130403 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\=
\-prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0=
.05\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
> -/* offset=3D130551 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
0000"
> -/* offset=3D130574 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\000000"
> -/* offset=3D130638 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
> -/* offset=3D130805 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\000000"
> -/* offset=3D130870 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\000000"
> -/* offset=3D130938 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\000000"
> -/* offset=3D131010 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
0"
> -/* offset=3D131105 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\000000"
> -/* offset=3D131240 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\000000"
> -/* offset=3D131305 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
> -/* offset=3D131374 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\000000"
> -/* offset=3D131445 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
0000"
> -/* offset=3D131468 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
0000"
> -/* offset=3D131491 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
00"
> -/* offset=3D131512 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\000000"
> +/* offset=3D128979 */ "stalled_cycles_per_instruction\000Default\000(max=
(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if=
 has_event(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-back=
end) else (stalled\\-cycles\\-frontend / instructions if has_event(stalled\=
\-cycles\\-frontend) else (stalled\\-cycles\\-backend / instructions if has=
_event(stalled\\-cycles\\-backend) else 0)))\000\000Max front or backend st=
alls per instruction\000\000\000\000\000\000001"
> +/* offset=3D129404 */ "frontend_cycles_idle\000Default\000(stalled\\-cyc=
les\\-frontend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) els=
e 0)\000frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000=
\000\000\000001"
> +/* offset=3D129583 */ "backend_cycles_idle\000Default\000(stalled\\-cycl=
es\\-backend / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0=
)\000backend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\=
000\000001"
> +/* offset=3D129757 */ "cycles_frequency\000Default\000cpu\\-cycles / (so=
ftware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@tas=
k\\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GH=
z\000\000\000\000011"
> +/* offset=3D129933 */ "branch_frequency\000Default\000branches / (softwa=
re@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-=
clock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M=
/sec\000\000\000\000011"
> +/* offset=3D130113 */ "branch_miss_rate\000Default\000branch\\-misses / =
branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000=
\000\000001"
> +/* offset=3D130217 */ "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\=
-misses / L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000=
\000100%\000\000\000\000001"
> +/* offset=3D130333 */ "llc_miss_rate\000Default2\000LLC\\-load\\-misses =
/ LLC\\-loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\=
000\000001"
> +/* offset=3D130434 */ "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\=
-misses / L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\=
000100%\000\000\000\000001"
> +/* offset=3D130549 */ "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misse=
s / dTLB\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000=
\000\000\000001"
> +/* offset=3D130655 */ "itlb_miss_rate\000Default3\000iTLB\\-load\\-misse=
s / iTLB\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000=
\000\000\000001"
> +/* offset=3D130761 */ "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\=
\-prefetch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0=
.05\000L1 prefetch miss rate\000\000100%\000\000\000\000001"
> +/* offset=3D130909 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
0000"
> +/* offset=3D130932 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\000000"
> +/* offset=3D130996 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000"
> +/* offset=3D131163 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\000000"
> +/* offset=3D131228 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\000000"
> +/* offset=3D131296 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\000000"
> +/* offset=3D131368 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
0"
> +/* offset=3D131463 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\000000"
> +/* offset=3D131598 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\000000"
> +/* offset=3D131663 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\000000"
> +/* offset=3D131732 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\000000"
> +/* offset=3D131803 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
0000"
> +/* offset=3D131826 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
0000"
> +/* offset=3D131849 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
00"
> +/* offset=3D131870 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\000000"
>  ;
>
>  static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
> @@ -2626,22 +2626,22 @@ static const struct pmu_table_entry pmu_events__c=
ommon[] =3D {
>
>  static const struct compact_pmu_event pmu_metrics__common_default_core[]=
 =3D {
>  { 127956 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\=
\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\=
\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CP=
Us\000\000\000\000011 */
> -{ 129273 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-back=
end / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle=
\000\000\000\000\000\000001 */
> -{ 129575 }, /* branch_frequency\000Default\000branches / (software@cpu\\=
-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,=
name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000=
\000\000\000011 */
> -{ 129755 }, /* branch_miss_rate\000Default\000branch\\-misses / branches=
\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000=
001 */
> +{ 129583 }, /* backend_cycles_idle\000Default\000(stalled\\-cycles\\-bac=
kend / cpu\\-cycles if has_event(stalled\\-cycles\\-backend) else 0)\000bac=
kend_cycles_idle > 0.2\000Backend stalls per cycle\000\000\000\000\000\0000=
01 */
> +{ 129933 }, /* branch_frequency\000Default\000branches / (software@cpu\\=
-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,=
name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\000=
\000\000\000011 */
> +{ 130113 }, /* branch_miss_rate\000Default\000branch\\-misses / branches=
\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000=
001 */
>  { 128142 }, /* cs_per_second\000Default\000software@context\\-switches\\=
,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\=
\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@=
)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\000011 =
*/
> -{ 129399 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@c=
pu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cloc=
k\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\00=
0\000\000011 */
> -{ 130191 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB=
\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000=
\000001 */
> -{ 129143 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-fro=
ntend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per c=
ycle\000\000\000\000\000\000001 */
> +{ 129757 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@c=
pu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cloc=
k\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\00=
0\000\000011 */
> +{ 130549 }, /* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB=
\\-loads\000dtlb_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000=
\000001 */
> +{ 129404 }, /* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-fr=
ontend / cpu\\-cycles if has_event(stalled\\-cycles\\-frontend) else 0)\000=
frontend_cycles_idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000=
\000001 */
>  { 128866 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\=
000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\00=
0\000\000001 */
> -{ 130297 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB=
\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000=
\000001 */
> -{ 130403 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefet=
ch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L=
1 prefetch miss rate\000\000100%\000\000\000\000001 */
> -{ 129859 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses =
/ L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%=
\000\000\000\000001 */
> -{ 130076 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses =
/ L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\=
000\000\000\000001 */
> -{ 129975 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-=
loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\0000=
01 */
> +{ 130655 }, /* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB=
\\-loads\000itlb_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000=
\000001 */
> +{ 130761 }, /* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefet=
ch\\-misses / L1\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L=
1 prefetch miss rate\000\000100%\000\000\000\000001 */
> +{ 130217 }, /* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses =
/ L1\\-dcache\\-loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%=
\000\000\000\000001 */
> +{ 130434 }, /* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses =
/ L1\\-icache\\-loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\=
000\000\000\000001 */
> +{ 130333 }, /* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-=
loads\000llc_miss_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\0000=
01 */
>  { 128375 }, /* migrations_per_second\000Default\000software@cpu\\-migrat=
ions\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3D=
cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cl=
ock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrati=
ons/sec\000\000\000\000011 */
>  { 128635 }, /* page_faults_per_second\000Default\000software@page\\-faul=
ts\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\=
-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)=
\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\000011 */
> -{ 128979 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\=
\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max =
front or backend stalls per instruction\000\000\000\000\000\000001 */
> +{ 128979 }, /* stalled_cycles_per_instruction\000Default\000(max(stalled=
\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions if has_eve=
nt(stalled\\-cycles\\-frontend) & has_event(stalled\\-cycles\\-backend) els=
e (stalled\\-cycles\\-frontend / instructions if has_event(stalled\\-cycles=
\\-frontend) else (stalled\\-cycles\\-backend / instructions if has_event(s=
talled\\-cycles\\-backend) else 0)))\000\000Max front or backend stalls per=
 instruction\000\000\000\000\000\000001 */
>
>  };
>
> @@ -2714,21 +2714,21 @@ static const struct pmu_table_entry pmu_events__t=
est_soc_cpu[] =3D {
>  };
>
>  static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_=
core[] =3D {
> -{ 130551 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
> -{ 131240 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\000000 */
> -{ 131010 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
> -{ 131105 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\000000 */
> -{ 131305 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
> -{ 131374 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\000000 */
> -{ 130638 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
> -{ 130574 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\000000 */
> -{ 131512 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\000000 */
> -{ 131445 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
> -{ 131468 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
> -{ 131491 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
> -{ 130938 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\000000 */
> -{ 130805 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\000000 */
> -{ 130870 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\000000 */
> +{ 130909 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */
> +{ 131598 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\000000 */
> +{ 131368 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000 */
> +{ 131463 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\000000 */
> +{ 131663 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\000000 */
> +{ 131732 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\000000 */
> +{ 130996 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\000000 */
> +{ 130932 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\000000 */
> +{ 131870 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\000000 */
> +{ 131803 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */
> +{ 131826 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */
> +{ 131849 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */
> +{ 131296 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\000000 */
> +{ 131163 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\000000 */
> +{ 131228 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\000000 */
>
>  };
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>
