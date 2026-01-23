Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE94279DC9
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192973; cv=pass; b=uQlI/ZseE7EXoSjoAR550VZ6hVdJcXjUcFcgeJMGQUP3Hs7Wd5oT33QjAkwpMeXY9IH2yLV+HKlTklxtJUKfDbnUR6FdGLOGeFLb4M0o1PhjQUvzy3lkrCFM9xDiwRGDgEA4G8z9hpv5EzpCf2CKCS3gnbirI8VGI/7UmFcNobA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192973; c=relaxed/simple;
	bh=388MZTXN9dKPO2yI5ldYeGxqgUsIgWVhPRcd0BaDQ8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHlJL1wk3zeEmJiu6NzKYXeAsj7+a//dYWvulF3h9Yz1ZAJjTWvbXSD7k5JpCx8ghU8hP5j4JN4OhFoYdrMqMF77mfTj8r1eofhMpRAPaZWpv6MtDiXnwp1zGowtGgHUdFUsHDXQZzWJQrfQZ10q/qpvRvcV6DjAye3gyl2Wra8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDbgdTDe; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDbgdTDe"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c69ffb226eso381536285a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 10:29:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192971; cv=none;
        d=google.com; s=arc-20240605;
        b=kiYfttJVYogUM+qOgSVZicyZsp8SwFSw5qn1pkHfBwYB7AqCPCc66gO0Lj8p5H/f5z
         dY3FYzAlqY0Xv5ljJVOdct2HgTzp+PxbzAw7tEPsbSLZTv7kY+e/JCB08wcfIrTR1/aU
         BHEnTbEfARHqbPW278ehd0TiRHttuLmZCqYKPvTxyU6ikX4e53kCm9hAt35VC202MsZ0
         UrrSokCWnX2TLrlJ//tCLroMDaKM63fHfiNSiq1eVjH8zH0IylPHlxh6hfb2WUbQ9a5F
         o2ybOkQ6CAPYseXNTMuWvW/cFJKQVt0i6IBu++l/0PuJvk1TO/+nIJGWSCxO6v3bCqVf
         kONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfpAEYhgrUVOVie9CvSjw2Gs4mQhhUAymGFIzIpwy7g=;
        fh=3AX0CDnb83TGduyhRmsAMIskWxKVDKYYhMZnqtWxpjE=;
        b=c04j6fsT10F8aFcPcwoXMzE3gchqAKhJAqn0HVfGQNrXEPHnzujMa0VykmEV18i8e6
         cqowgo9LnzygbVhmoN2oRbyA5EZBAIBdz5sO/IR6Tg8adKDDNXs4TUJ5cqTDPPUDSXCC
         IGxEg0wKBp4PuWA1xYsJ5bYGSdk6V0rrUJRnV5M/P9x+gJ7134fKtI2p7/9cSQy0Hjdy
         GnCacQsMekgzGYAV2sHVtq/ExEhht6zVD2/z1pebdWTCTf7SRtwEOq9HyYDreX1izwfM
         4oKoYtfIDZur0A5IiourVNTzP/I/8ZNG4jn4iioKeacdU4fhcMo2IwsVMzHgj2wcsWbq
         czKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769192971; x=1769797771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfpAEYhgrUVOVie9CvSjw2Gs4mQhhUAymGFIzIpwy7g=;
        b=qDbgdTDecEApaal9lCla+PiwwpprSTI2r4xyAXJ5P6V7ogdQozxwQbk3j7Iw2SxH8L
         P4a8aZIkg4KhfSLiQ+XWw38NUJYVQ1JxLXX7X2mPIpx5LT0eA5kyB/SvuMvhSdhZoXZh
         uDw7Yy6HZr3YuxHxRhWZSmCRW7zuHdLclGSdG3okukwOOdXE1r2jumnv7jw0+LdlsuLC
         7nNAwevC9ueswHgfDHvvRKN27MFjfQxooQdI5mwW8SOzXw89InY8EeJJu8DynwUCJRvr
         mxD5GDn4TCdmBi8BYfaX+F8GXekt/XjGskDCNXqq3rr/+jMTI9TyivYq5723+DUv+sX8
         XPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192971; x=1769797771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfpAEYhgrUVOVie9CvSjw2Gs4mQhhUAymGFIzIpwy7g=;
        b=p8ov4hkVhLP4ddCLVxxTMHpwPf/n9N9zAaKXo8hANYBp2yxMqzFQcBwjLQlCWEuwL0
         pagKOlv51dx/SWKnJsizDtdQFPbKToTt9hyfXOoIdt0HkoLvvggoUgCQXoUwTlxL7JSY
         dwqdnVgpoVB5MuM3jURK9JmTKuHPsOayZGrqGG8XUGmfkVcAxRqeuL+F6lI6aYCN7tle
         fgESKQcBLhyzkVK+Y3YOTpaiQMIPEbjnm6ibiikAv7ikw87RcOdbVisBeXwdliWSCAdp
         zIW5lvlIhnZsmiwcw3y+zBakxEcCjKORAbRvtBjRusjhiWpmxSEV6/GG9DxmZ3qHM+3Y
         kv1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/904UJnRMWQJk4PM/RJX79mmfTfwzXnDVq8v94fH4fOm9efvlDw9xmmHkn8cyjo0DPbRGm3FwVXzIYPSkjSDK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sU2CvBywP0ec9iWw1Snn/shV34hAbcdzbHokcVEn6PPeK9oh
	Ongn3bMAKYKJrJgWixhJdSFX6NUAFLdpMHjTzPJgKQdAGF9m/16gh85Aubys/kudRfFMCyfcIhG
	tAGafrQP9i5fLxlgGuuDfn+1l41VH6Q9yHKZMrFzp
X-Gm-Gg: AZuq6aLyFoPCwQaImue5CtFwKStlxvYwrI1cGsNOSnbxpZ6GIV6870ARGtWI5BIF5Mn
	Om5ONNMPwzOuBeLVoB44XAcQgAx+tYidxmKrKk1Q8yu8Q9ARRBRlSGTZZRpp8Jg7/dmgARRK/sb
	+a7+N0Om3niKXQ9+wYzNSaxAgt9uCRJgkP7JbRyur09ypfkUofTzVtnIxE2lT99Nd+9LKNEIsBK
	ZHjuKSHb0qY563287wCfyT7FkHBR3eM3vOQVgJyJrRJ77UZYwLdGwWHXXJC+EZLpPdbSA==
X-Received: by 2002:a05:620a:2685:b0:8b2:dfda:66c4 with SMTP id
 af79cd13be357-8c6e2d7b9afmr479608785a.8.1769192968844; Fri, 23 Jan 2026
 10:29:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108184430.1210223-1-ctshao@google.com> <CAP-5=fVLFVzitYZso2HB7dFgaNbJqW0pLE_AqMhc0ytW0PFvZw@mail.gmail.com>
 <CAJpZYjVadSgX6eSczFsqxJpMSq8q67CkA_WA+8jf+atgUScBNA@mail.gmail.com>
 <09ff8b36-eb35-425d-b36c-d33237f2623a@linux.intel.com> <85202bc5-4b50-458c-8ef8-be4d22e9d939@intel.com>
In-Reply-To: <85202bc5-4b50-458c-8ef8-be4d22e9d939@intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 23 Jan 2026 10:29:17 -0800
X-Gm-Features: AZwV_QgzCVNHw7OjFDgX1m8nqInNBJ2GEo0fubDApMgvb-rvRyT4EY7S-utmN-A
Message-ID: <CAJpZYjVDUQ=662uAnL71Pp4CmsUz+9toWmoMpNBjjcZOJUNv_w@mail.gmail.com>
Subject: Re: [PATCH] perf pmu intel: Adjust cpumaks for sub-NUMA clusters on Emeraldrapids
To: "Chen, Zide" <zide.chen@intel.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the confirmation, Zide. I will submit another patch to
split EMR and GNR SNC2 IMC map.

-CT

On Thu, Jan 22, 2026 at 2:06=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 1/18/2026 4:51 PM, Mi, Dapeng wrote:
> >
> > On 1/14/2026 2:06 AM, Chun-Tse Shao wrote:
> >> Ping.
> >>
> >> Thanks for your comment, Ian. To Intel team, can we get confirmation
> >> of the GNR SNR2 configuration?
> >>
> >> -CT
> >>
> >> On Thu, Jan 8, 2026 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>> On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Chun-Tse Shao <ctshao@google.=
com> wrote:
> >>>> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well=
.
> >>>> Adjust cpumasks as the logic for GNR in [1].
> >>>>
> >>>> Tested on Emeraldrapids with SNC2 enabled:
> >>>>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a=
 -- sleep 1
> >>>>
> >>>>    Performance counter stats for 'system wide':
> >>>>
> >>>>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> >>>>   N0        4         8815163648      UNC_M_CLOCKTICKS
> >>>>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> >>>>   N1        4         8815014974      UNC_M_CLOCKTICKS
> >>>>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> >>>>   N2        4         8814592626      UNC_M_CLOCKTICKS
> >>>>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> >>>>   N3        4         8814012840      UNC_M_CLOCKTICKS
> >>>>
> >>>>          1.001574118 seconds time elapsed
> >>>>
> >>>> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> >>>>
> >>>> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >>>> ---
> >>>>  tools/perf/arch/x86/util/pmu.c | 45 +++++++++++++++++++++----------=
---
> >>>>  1 file changed, 28 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/ut=
il/pmu.c
> >>>> index a3f96221758d..fad68a0f7b5d 100644
> >>>> --- a/tools/perf/arch/x86/util/pmu.c
> >>>> +++ b/tools/perf/arch/x86/util/pmu.c
> >>>> @@ -22,20 +22,29 @@
> >>>>  #include "util/env.h"
> >>>>  #include "util/header.h"
> >>>>
> >>>> -static bool x86__is_intel_graniterapids(void)
> >>>> +static bool x86__is_snc_supported(void)
> >>>>  {
> >>>> -       static bool checked_if_graniterapids;
> >>>> -       static bool is_graniterapids;
> >>>> +       static bool checked_if_snc_supported;
> >>>> +       static bool is_supported;
> >>>>
> >>>> -       if (!checked_if_graniterapids) {
> >>>> -               const char *graniterapids_cpuid =3D "GenuineIntel-6-=
A[DE]";
> >>>> +       if (!checked_if_snc_supported) {
> >>>> +
> >>>> +               /* Emeraldrapids and Graniterapids support SNC confi=
guration. */
> >>>> +               static const char *const supported_cpuids[] =3D {
> >>>> +                       "GenuineIntel-6-CF", /* Emeraldrapids */
> >>>> +                       "GenuineIntel-6-A[DE]", /* Graniterapids */
> >>>> +               };
> >>>>                 char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> >>>>
> >>>> -               is_graniterapids =3D cpuid && strcmp_cpuid_str(grani=
terapids_cpuid, cpuid) =3D=3D 0;
> >>>> +               for (size_t i =3D 0; i < ARRAY_SIZE(supported_cpuids=
); i++) {
> >>>> +                       is_supported =3D cpuid && strcmp_cpuid_str(s=
upported_cpuids[i], cpuid) =3D=3D 0;
> >>>> +                       if (is_supported)
> >>>> +                               break;
> >>>> +               }
> >>>>                 free(cpuid);
> >>>> -               checked_if_graniterapids =3D true;
> >>>> +               checked_if_snc_supported =3D true;
> >>>>         }
> >>>> -       return is_graniterapids;
> >>>> +       return checked_if_snc_supported;
> >>>>  }
> >>>>
> >>>>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_pa=
th)
> >>>> @@ -64,6 +73,7 @@ static int snc_nodes_per_l3_cache(void)
> >>>>                         read_sysfs_cpu_map("devices/system/cpu/cpu0/=
cache/index3/shared_cpu_list");
> >>>>
> >>>>                 snc_nodes =3D perf_cpu_map__nr(cache_cpus) / perf_cp=
u_map__nr(node_cpus);
> >>>> +
> >>>>                 perf_cpu_map__put(cache_cpus);
> >>>>                 perf_cpu_map__put(node_cpus);
> >>>>                 checked_snc =3D true;
> >>>> @@ -137,8 +147,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >>>>         // Compute the IMC SNC using lookup tables.
> >>>>         unsigned int imc_num;
> >>>>         int snc_nodes =3D snc_nodes_per_l3_cache();
> >>>> -       const u8 snc2_map[] =3D {1, 1, 0, 0, 1, 1, 0, 0};
> >>>> -       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2}=
;
> >>>> +       const u8 snc2_map[] =3D {0, 0, 1, 1};
> >>> Does this alter the behavior on GNR? ie 1,1,0,0 vs 0,0,1,1.
>
> It appears to break GNR SNC2. While it works for the --per-node test, it
> fails the following affinity test. Testing on EMR shows that it follows
> the new lookup table. Should we use a model-specific lookup table here?
>
> # Running workload on CPU0
> $ taskset -c CPU0 stress-ng --vm 1 --vm-bytes 2G --vm-method all
> --timeout 30s
>
> # Profiling UNC_M_PRE_COUNT.ALL on all IMC boxes.
> $ perf stat \
>         -e uncore_imc_0/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_1/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_2/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_3/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_4/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_5/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_6/event=3D0x03,umask=3D0xFF/ \
>         -e uncore_imc_7/event=3D0x03,umask=3D0xFF/ \
>         -a -I 1000
>
> This shows that the uncore_imc_[2|3|6|7] boxes are affinitized to CPU0.
>
>      5.013638757          1,635,470      uncore_imc_0/event=3D0x03,umask=
=3D0xFF/
>      5.013638757          1,638,157      uncore_imc_1/event=3D0x03,umask=
=3D0xFF/
>      5.013638757         27,093,922      uncore_imc_2/event=3D0x03,umask=
=3D0xFF/
>      5.013638757         27,025,980      uncore_imc_3/event=3D0x03,umask=
=3D0xFF/
>      5.013638757          1,616,974      uncore_imc_4/event=3D0x03,umask=
=3D0xFF/
>      5.013638757          1,627,251      uncore_imc_5/event=3D0x03,umask=
=3D0xFF/
>      5.013638757         26,854,588      uncore_imc_6/event=3D0x03,umask=
=3D0xFF/
>      5.013638757         26,974,506      uncore_imc_7/event=3D0x03,umask=
=3D0xFF/
>
> Testing with additional CPUs confirms that the original GNR SNC2 lookup
> table is correct.
>
>                         CPU                     uncore_imc box
> NUMA node0 CPU(s):      0-42,344-386            2 3 6 7
> NUMA node1 CPU(s):      43-85,387-429           0 1 4 5
> NUMA node2 CPU(s):      86-128,430-472          2 3 6 7
> NUMA node3 CPU(s):      129-171,473-515         0 1 4 5
> NUMA node4 CPU(s):      172-214,516-558         2 3 6 7
> NUMA node5 CPU(s):      215-257,559-601         0 1 4 5
> NUMA node6 CPU(s):      258-300,602-644         2 3 6 7
> NUMA node7 CPU(s):      301-343,645-687         0 1 4 5
>
>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> +       const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2};
> >>>>         const u8 *snc_map;
> >>>>         size_t snc_map_len;
> >>>>
> >>>> @@ -161,11 +171,11 @@ static int uncore_imc_snc(struct perf_pmu *pmu=
)
> >>>>                 pr_warning("Unexpected: unable to compute IMC number=
 '%s'\n", pmu->name);
> >>>>                 return 0;
> >>>>         }
> >>>> -       if (imc_num >=3D snc_map_len) {
> >>>> +       if (imc_num >=3D snc_map_len * perf_cpu_map__nr(pmu->cpus)) =
{
> >>>>                 pr_warning("Unexpected IMC %d for SNC%d mapping\n", =
imc_num, snc_nodes);
> >>>>                 return 0;
> >>>>         }
> >>>> -       return snc_map[imc_num];
> >>>> +       return snc_map[imc_num % snc_map_len];
> >>>>  }
> >>>>
> >>>>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> >>>> @@ -205,7 +215,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int=
 pmu_snc)
> >>>>         return cpu_adjust[pmu_snc];
> >>>>  }
> >>>>
> >>>> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_p=
mu *pmu, bool cha)
> >>>> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *=
pmu, bool cha)
> >>>>  {
> >>>>         // With sub-NUMA clustering (SNC) there is a NUMA node per S=
NC in the
> >>>>         // topology. For example, a two socket graniterapids machine=
 may be set
> >>>> @@ -304,11 +314,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
> >>>>                                 pmu->mem_events =3D perf_mem_events_=
intel_aux;
> >>>>                         else
> >>>>                                 pmu->mem_events =3D perf_mem_events_=
intel;
> >>>> -               } else if (x86__is_intel_graniterapids()) {
> >>>> +               } else if (x86__is_snc_supported()) {
> >>>>                         if (starts_with(pmu->name, "uncore_cha_"))
> >>>> -                               gnr_uncore_cha_imc_adjust_cpumask_fo=
r_snc(pmu, /*cha=3D*/true);
> >>>> -                       else if (starts_with(pmu->name, "uncore_imc_=
"))
> >>>> -                               gnr_uncore_cha_imc_adjust_cpumask_fo=
r_snc(pmu, /*cha=3D*/false);
> >>>> +                               uncore_cha_imc_adjust_cpumask_for_sn=
c(pmu, /*cha=3D*/true);
> >>>> +                       else if (starts_with(pmu->name, "uncore_imc_=
") &&
> >>>> +                                !starts_with(pmu->name, "uncore_imc=
_free_running"))
> >>>> +                               uncore_cha_imc_adjust_cpumask_for_sn=
c(pmu, /*cha=3D*/false);
> >>>>                 }
> >>>>         }
> >>>>  }
> >>>> --
> >>>> 2.52.0.457.g6b5491de43-goog
> >>>>
>
