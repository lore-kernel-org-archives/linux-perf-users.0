Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D852F88
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413838; cv=none; b=p9/V3xcKVFIgd3jZ/S6sGhkOOMQSiZ8kCiqeIj97niexYgnagF8LVZVcdJxPyrEP9jE7HWaoh0/P9URZt9sonyiBHyGP4EZlyXHOGiSyg8hIVEYYkyCyIyjtQFCZh2+Z6RRgDSQG2wOvTRWxOmlD+fZ33ISBzkFf4rWimPeMiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413838; c=relaxed/simple;
	bh=oQjNV3nG8vaw+snSrIHHo/J1LIGXeDOWug2Tq8StsRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aER2Eqxxxu148mwDgERO21v4FLHs5a/qisHsB1N8X8f0R/8Z7ouFXhpUqQ/nnffXhDTPyDZstie03Cf1bgVzv+DEU4cJrp+XFgtRjllggMyJMEmKyIKhTwU5E6i0Z+qOwhLc5AvG3kBhdSq3x84Dae/XT7LrHUoS+S7rt2pRjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCOKi5bs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCOKi5bs"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a2f2e5445so322786d6.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768413835; x=1769018635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBC7EbDgn9mNNA+l4J59dDPdCN4/rQjov20Wn1i5f4c=;
        b=aCOKi5bslfh8yNBs+EsUm29nc4PVNZjrtb5mZzJS4PHtB+fJi9BdVSUxp9Xj7/QT6L
         ac05jEh+WhPfIZSulz3603h+05HQjZBPM6G5bW52ysIb/9XvcRhiKulnK5yIDlp/DbmO
         9wljYxkqbFPUpZTqQjsjY7yNnbia7HbRGMScZE4JbUi17eq7OiU6Ya0chwSIDa9CoCHv
         9QcC07mFEn8OoYJZqFfMiXWILerKe9MQCqPsgs7DaxGsQj8rH+pF65JUKvRPylZnRGBn
         fX9yH7RpdMVQnhftsj8IjhDeaCd9lO52OcmBXsWg/iWl1gnbfrFWUWoCmO368VOf3Xn4
         3lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413835; x=1769018635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBC7EbDgn9mNNA+l4J59dDPdCN4/rQjov20Wn1i5f4c=;
        b=S5RiAWOW1XCreKXEUCpnbC1RGZydhn+HGhyJ+g948A1fIae2k3UyzSRYMmWRO2yn20
         LCt7RfCGBsDUaGAsx3I3YCQlxw9ygP7JBkS4Eh9dphjk0LhDsVUVQtqM6gb59Z85h/FX
         qkM4dqDLvNDkExf12VvOTImNl+Z6VLmwMnVHktCkphIapxg2rnYV8B7B5YDuYzXe2N0a
         m2z0cCB6eVA8WWuNpCxx7Xx0xpliuYIopOo6r0o0OYC68Hh1NnanlxCEu1cIz/zeD6Pu
         Wd3HWvEWDrTq53CHPDzNbk+N24+nQUs+W796xE6+Rnb6xEe8fxO5GykSE163GxRGj0DL
         7k5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQoyHL7g1rYKrxdyrHWwFyjRIyIYxm/FBHvYxyeUsMwbr2XvHt2ncVrOx6OFyM45/920b4l8HGf7SIT3i5L9Qd@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjRxwfGTTnZBGOORtNG4qsXnv3GQ7GHtLoOzmCEhSYNAXQCxE
	u3tIvVFkrJZKMVW2IBplt+QGT6XMaUdNJtFIoE3XWmleAX6jCX0Y7FkDNiqO2h9yT9AImdETRVW
	D7YO3I4RKkT85iVNFgmFFwj1G/BO8SJPwYujfz1Oq
X-Gm-Gg: AY/fxX5XiJEsZSe4feaNgffcIepKbw+nPa8TMRvHZWV4W1B4EtWlrhRqQ4F5k0QdICh
	thrln5+9sl1ox4WFY+FJmMC6DXe4TTBQ5bDFvv+ZcX9ZF3vddmLISEBdP2ATIWWsPtXG8MHDzun
	rgyj7hR0R/iqGVkbSWKzwxabPbmE9Gcsg7D2h6uByTQ7iuqYvod8ojbXVWAU0GbqTVxCRP5En5X
	tL70tNbYPm6PB6hMYKSdVU1y4DOiOt1EmPYPiTuPM6LJ8f7HvV2w4vV0WdRfG5F3FZmXdQxB4iU
	MwuOyWue+otxYPjWkX4yNj0cBA==
X-Received: by 2002:a05:6214:240b:b0:890:90e9:c7c1 with SMTP id
 6a1803df08f44-8927431aaa5mr46962156d6.14.1768413834917; Wed, 14 Jan 2026
 10:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108184430.1210223-1-ctshao@google.com> <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
 <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com> <76406086-7175-43ac-90bc-3b268186ebbc@linux.intel.com>
In-Reply-To: <76406086-7175-43ac-90bc-3b268186ebbc@linux.intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 14 Jan 2026 10:03:43 -0800
X-Gm-Features: AZwV_QjUK268Q7oZXuxFjx1VHciwv1PU2nAwY4btHt7bZE-87Pm2QVGGeI8SIzc
Message-ID: <CAJpZYjVREv324c7SXDK2m+Tb0FKXnWaAfYREetZTWZ05zo1HYw@mail.gmail.com>
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dapeng,

I set the SNC2 config to {0, 0, 1, 1} because that is how my EMR
testing machine shows with SNC2 enabled. If that is true, I wonder if
the SNC2 map for GNR is still {1, 1, 0, 0}.

Thanks,
CT

On Tue, Jan 13, 2026 at 4:42=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/14/2026 2:06 AM, Chun-Tse Shao wrote:
> > Ping.
> >
> > Thanks for your comment, Ian. To Intel team, can we get confirmation
> > of the GNR SNR2 configuration?
>
> It seems you missed Ian's comments.
>
> I have same question with Ian, the snc map for uncore IMC is changed. It
> may not change the total count of uncore_imc events, but it would change
> the count of the uncore_imc events for a specific SNC node. What's the
> reason you did the change?
>
> I have no GNR/EMR on my hand, I can't check how the SNC nodes are mapped =
on
> these 2 machines.
>
>
> >
> > -CT
> >
> > On Thu, Jan 8, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> >> On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Chun-Tse Shao <ctshao@google.c=
om> wrote:
> >>> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> >>> Adjust cpumasks as the logic for GNR in [1].
> >>>
> >>> Tested on Emeraldrapids with SNC2 enabled:
> >>>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a =
-- sleep 1
> >>>
> >>>    Performance counter stats for 'system wide':
> >>>
> >>>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> >>>   N0        4         8815163648      UNC_M_CLOCKTICKS
> >>>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> >>>   N1        4         8815014974      UNC_M_CLOCKTICKS
> >>>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> >>>   N2        4         8814592626      UNC_M_CLOCKTICKS
> >>>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> >>>   N3        4         8814012840      UNC_M_CLOCKTICKS
> >>>
> >>>          1.001574118 seconds time elapsed
> >>>
> >>> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> >>>
> >>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >>> ---
> >>>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++-----------=
--
> >>>  1 file changed, 28 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/uti=
l/pmu.c
> >>> index a3f96221758d..fad68a0f7b5d 100644
> >>> --- a/tools/perf/arch/x86/util/pmu.c
> >>> +++ b/tools/perf/arch/x86/util/pmu.c
> >>> @@ -22,20 +22,29 @@
> >>>  #include "util/env.h"
> >>>  #include "util/header.h"
> >>>
> >>> -static bool x86__is_intel_graniterapids(void)
> >>> +static bool x86__is_snc_supported(void)
> >>>  {
> >>> -       static bool checked_if_graniterapids;
> >>> -       static bool is_graniterapids;
> >>> +       static bool checked_if_snc_supported;
> >>> +       static bool is_supported;
> >>>
> >>> -       if (!checked_if_graniterapids) {
> >>> -               const char *graniterapids_cpuid =3D "GenuineIntel-6-A=
[DE]";
> >>> +       if (!checked_if_snc_supported) {
> >>> +
> >>> +               /* Emeraldrapids and Graniterapids support SNC config=
uration. */
> >>> +               static const char *const supported_cpuids[] =3D {
> >>> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
> >>> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
> >>> +               };
> >>>                 char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> >>>
> >>> -               is_graniterapids =3D cpuid && strcmp_cpuid_str(granit=
erapids_cpuid, cpuid) =3D=3D 0;
> >>> +               for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids)=
; i++) {
> >>> +                       is_supported =3D cpuid && strcmp_cpuid_str(su=
pported_cpuids[i], cpuid) =3D=3D 0;
> >>> +                       if (is_supported)
> >>> +                               break;
> >>> +               }
> >>>                 free(cpuid);
> >>> -               checked_if_graniterapids =3D true;
> >>> +               checked_if_snc_supported =3D true;
> >>>         }
> >>> -       return is_graniterapids;
> >>> +       return checked_if_snc_supported;
> >>>  }
> >>>
> >>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_pat=
h)
> >>> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
> >>>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/c=
ache/index3/shared_cpu_list");
> >>>
> >>>                 snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cpu=
_map__nr(node_cpus);
> >>> +
> >>>                 perf_cpu_map__put(cache_cpus);
> >>>                 perf_cpu_map__put(node_cpus);
> >>>                 checked_snc =3D true;
> >>> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >>>         // Compute the IMC SNC using lookup tables.
> >>>         unsigned int imc_num;
> >>>         int snc_nodes =3D snc_nodes_per_l3_cache();
> >>> -       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> >>> -       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> >>> +       const u8 snc2_map[] =3D {0, 0, 1, 1};
> >> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.
> >>
> >> Thanks,
> >> Ian
> >>
> >>> +       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2};
> >>>         const u8 *snc_map;
> >>>         size_t snc_map_len;
> >>>
> >>> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >>>                 pr_warning("Unexpected: unable to compute IMC number =
'%s'\n", pmu->name);
> >>>                 return 0;
> >>>         }
> >>> -       if (imc_num >=3D snc_map_len) {
> >>> +       if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
> >>>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", i=
mc_num, snc_nodes);
> >>>                 return 0;
> >>>         }
> >>> -       return snc_map[imc_num];
> >>> +       return snc_map[imc_num % snc_map_len];
> >>>  }
> >>>
> >>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> >>> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int =
pmu_snc)
> >>>         return cpu_adjust[pmu_snc];
> >>>  }
> >>>
> >>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pm=
u *pmu, bool cha)
> >>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *p=
mu, bool cha)
> >>>  {
> >>>         // With sub-NUMA clustering (SNC) there is a NUMA node per SN=
C in the
> >>>         // topology. For example, a two socket graniterapids machine =
may be set
> >>> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
> >>>                                 pmu->mem_events =3D perf_mem_events_i=
ntel_aux;
> >>>                         else
> >>>                                 pmu->mem_events =3D perf_mem_events_i=
ntel;
> >>> -               } else if (x86__is_intel_graniterapids()) {
> >>> +               } else if (x86__is_snc_supported()) {
> >>>                         if (starts_with(pmu->name, "uncore_cha_"))
> >>> -                               gnr_uncore_cha_imc_adjust_cpumask_for=
_snc(pmu, /*cha=3D*/true);
> >>> -                       else if (starts_with(pmu->name, "uncore_imc_"=
))
> >>> -                               gnr_uncore_cha_imc_adjust_cpumask_for=
_snc(pmu, /*cha=3D*/false);
> >>> +                               uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/true);
> >>> +                       else if (starts_with(pmu->name, "uncore_imc_"=
) &&
> >>> +                                !starts_with(pmu->name, "uncore_imc_=
free_running"))
> >>> +                               uncore_cha_imc_adjust_cpumask_for_snc=
(pmu, /*cha=3D*/false);
> >>>                 }
> >>>         }
> >>>  }
> >>> --
> >>> 2.52.0.457.g6b5491de43-goog
> >>>
