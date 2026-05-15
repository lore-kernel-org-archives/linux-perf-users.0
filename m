Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD83DE423
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866210; cv=pass; b=ADg43a3lKwuqw9gafkKfMNmR756vC7QBVGH8q8uYv3idKk0ZjPYNMAyDi2gt5uA7LuWJVVlrkZ3dAfUJZyl4qVj0f3BofacgyVP71nuk7Vj7KLM/nREEkqcyPX9AcCoK0u1UH0NeBeOlotc7fg12KLx7gm0uS2iCrQ+kHutBIHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866210; c=relaxed/simple;
	bh=GMKXCub2W43kcQHLRFAd85lxgUPIzPT4ARdPdsvb7OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMzB3GzFUwLIFFzuSt+F30Agzodp95seNWO/wb5W8gZ7M8jR6NmCTvDd+2XOSUAJnWPZ1/zqKRrItoSg/DmbmUeIq3EQNeT7D5X+/oN/gPAnwymNZHcmMDz1mS7k6iVzBS6wHYXnm/2qU+cI8Uvkhf3IuWhd/p7ugHiueiyYtnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E200R4hH; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E200R4hH"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so15686c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778866208; cv=none;
        d=google.com; s=arc-20240605;
        b=KTkEFhc8ffB8ehQUoKNsU3f//HFha+0s1hMYWUzRkiV8DMzLABuaB+TLH9ylYvzVUV
         VlAj+DJvbHKw8qXxrjllwIocMwjsCd/EZKrpJwiZ6mqQiznVYccq1F+niw1WgydEQ4W+
         jsWYSe/41ZbJi1jTHUIJEY3qqa6ldKttiESCJPeoGY76X8eEf+HLDiN0G8ezTpkRVQls
         AgMcbapzaDSFbJjSV+dH7lcTWubajDZq5k0vvdUj/m5V5LH+n85LhbFYsc1VgtYoZylP
         E3g2EgJlBGByVEOAHeVe/X6xdK14pdx/NVlf/poiGhL7Tbgb+aBXwv4j8ybJ2am0lJok
         6s5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rF95S2xZJUqInxw9xvtJrUyfM/tDUUeTT//vlt6fJXk=;
        fh=64/uEKNnvUGflngn+DgEp9RzZwmUoL+hUn3H7zVV/nU=;
        b=Jk/YFLHtH4Dq2JlES/Vh2nPpsrDeGPsBxmnR/0EsngO/DSyiZSnnu1nD5iE2GOzC5V
         Pvp3i5lIL0OVWpTXHeE/EpvQyf9mG6a+rqH0rzrLDS/BDvK4BkqxHr0Fd7SvWphL+Av9
         9kL7LsD5gU0JNK5ftsJyzFoY59FX4GSBWjrbxDgh4hSVWNUZWzAI9ITRsKZImmrXO/Fd
         cs4aR7lpmXDp7AOd7Vy1qVRT3oOs3gtLhqwpryRZMNBYkVznvL6IFLMRCP6ArRDwmdwz
         3xkUdiTpMxNlFtE3u0G9aUX6nlSfFOdUrjVNTxHkllodgLdJplCEdtwl2G1aLMRGJjSu
         kNCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866208; x=1779471008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF95S2xZJUqInxw9xvtJrUyfM/tDUUeTT//vlt6fJXk=;
        b=E200R4hHlahU2Vqwf4YhxTugEr1XXsj69ogAK03OHnR5KlGmdZOTRnymx5WIgNi+Tt
         zBci7Nv70E1mQCF03YvqdQPrU+aYsTiXNy7GixmNbx4CQxcl7znJUSNX49/gM57LhtfJ
         9xrr/5gAAHSK0ZlrNso9MvpefQl7Pl6nYaNiuIp4L4xEcRyrvqlfYGdSO8cdBl4DX//p
         ZdkW5+FUAvRafSZu1tEz6Ajvv4NWS6c30fMWWIWhZWiNXPPoduvMIja7sNJpwpJAFLhn
         qHGkL45L/okNfjW7fcg8zGqGYEDpbO35jFkSP0FgorULZCDk3toWFZSDZCiuQsVUS+HQ
         9a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866208; x=1779471008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rF95S2xZJUqInxw9xvtJrUyfM/tDUUeTT//vlt6fJXk=;
        b=Ap34u4WKAJFr50GEoGOuyqaX3br6WLAG2FlWIuq5BWz72EW+yRziyithzlV7xapooo
         P0/WZEjTW4J5CtRliGWZhJ9qf7u/ui8CmGskccohH1kKk6RypWk8qzmKHCWbNe4dclxX
         KRnqBGbAW2PyQmugo2QJPnchtF6w5zPEaO1GOfeyPCqospWCN92ML1HGAuszTAq+90H1
         F8b2mvE80itfuiRy/omz+Lcpa9j5nbOekplSCKzWOMBrLcx0pCjzULuNErLc42W5A/dq
         RiZTNL71ySQjaqR44mmrK5Qgh1D+0+j1QMpz8xNwiba7c9b1pcnaaklJt3SjgnqltamH
         W5Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/QOuyGBi1xFNHsOLSdsQEtDD8Kbbg9FzeifbtmzyDc1W+ubKZDk18cq45cPYYMWqIj3jApASCtV+QGF4y97Te/@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkFZOwrutOocSzUJV2JXgF3YWkPiP1cjvIWTLnop0OSW3CI7F
	c9iATTjVstG0qQX6Wl7j2ndC9fzNfr3Ko9NnYI+q+Qjh50uHU+jrfSF+wCUY1MOjT21xHcBYLi8
	FtOKA9yFoxyBEKrK00yRPSUfxa8V8m4prwCTM1Qw0
X-Gm-Gg: Acq92OEwNPPEgdR1jQkaicchcdspMO/TZOSSI3aqejSnAtDIFJDBTZssz6ZvUjE+vQi
	TbGv30hv/L2QItI/dxEhQm6iiaCOXYe4ONwAHfmyjmGrOf0oaKcSTXpUMzQay5fxOsDlkW5tZnt
	lC5krAG0R8UsnIRTcPPifo5cShVJUglUOLLRDNFsLdzfJw+mMG6TYMv3JXN+CEgFBvXfQcqwahT
	NynPLKbJsz4NblQTEWQwntRcWeYNnjqkxvFkKI6EpzpRcj9SBB1C9u6AGdx7xRPWJ0qS1JMt1Ch
	VLsRvsT/vOqJMpVc
X-Received: by 2002:a05:7022:6621:b0:130:73ed:215 with SMTP id
 a92af1059eb24-1350451b48bmr2038954c88.16.1778866207366; Fri, 15 May 2026
 10:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407203918.3178481-1-ctshao@google.com> <20260407203918.3178481-2-ctshao@google.com>
 <adh_5WvH10yQrIRw@google.com>
In-Reply-To: <adh_5WvH10yQrIRw@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 15 May 2026 10:29:55 -0700
X-Gm-Features: AVHnY4JYNNDHWsu0xtbyd2Yuzu303eBdbGK8Ydrzv6jTh1lJfN7S8itUOoeYOfc
Message-ID: <CAJpZYjU5UqahRkH0n8Qd3pO0_3YR5J-6u-yi=bEHEJCyEq4sPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] perf pmu intel: Adjust cpumaks for sub-NUMA
 clusters on Emeraldrapids
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Ian Rogers <irogers@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, submitted v6 patch:
lore.kernel.org/20260515172710.428474-1-ctshao@google.com
I also added SPR into SNC2 in that patch.

-CT

On Thu, Apr 9, 2026 at 9:43=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Apr 07, 2026 at 01:38:43PM -0700, Chun-Tse Shao wrote:
> > Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> > Adjust cpumasks as the logic for GNR in [1].
> >
> > Tested on Emeraldrapids with SNC2 enabled:
> >   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a --=
 sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   N0       30        72125876670      UNC_CHA_CLOCKTICKS
> >   N0        4         8815163648      UNC_M_CLOCKTICKS
> >   N1       30        72124958844      UNC_CHA_CLOCKTICKS
> >   N1        4         8815014974      UNC_M_CLOCKTICKS
> >   N2       30        72121049022      UNC_CHA_CLOCKTICKS
> >   N2        4         8814592626      UNC_M_CLOCKTICKS
> >   N3       30        72117133854      UNC_CHA_CLOCKTICKS
> >   N3        4         8814012840      UNC_M_CLOCKTICKS
> >
> >          1.001574118 seconds time elapsed
> >
> > [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> >
> > Reviewed-by: Zide Chen <zide.chen@intel.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/arch/x86/util/pmu.c | 56 +++++++++++++++++++++++-----------
> >  1 file changed, 38 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index 938be36ec0f7..3743f5145505 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -30,8 +30,9 @@ static bool x86__is_snc_supported(void)
> >
> >       if (!checked_if_snc_supported) {
> >
> > -             /* Graniterapids supports SNC configuration. */
> > +             /* Emeraldrapids Graniterapids support SNC configuration.=
 */
> >               static const char *const supported_cpuids[] =3D {
> > +                     "GenuineIntel-6-CF", /* Emeraldrapids */
> >                       "GenuineIntel-6-A[DE]", /* Graniterapids */
>
> It'd be great if we can share these string literals..
>
>
> >               };
> >               char *cpuid =3D get_cpuid_str((struct perf_cpu){0});
> > @@ -141,23 +142,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
> >       // Compute the IMC SNC using lookup tables.
> >       unsigned int imc_num;
> >       int snc_nodes =3D snc_nodes_per_l3_cache();
> > -     const u8 snc2_map[] =3D {1, 1, 0, 0};
> > -     const u8 snc3_map[] =3D {1, 1, 0, 0, 2, 2};
> > -     const u8 *snc_map;
> > -     size_t snc_map_len;
> > -
> > -     switch (snc_nodes) {
> > -     case 2:
> > -             snc_map =3D snc2_map;
> > -             snc_map_len =3D ARRAY_SIZE(snc2_map);
> > -             break;
> > -     case 3:
> > -             snc_map =3D snc3_map;
> > -             snc_map_len =3D ARRAY_SIZE(snc3_map);
> > -             break;
> > -     default:
> > -             /* Error or no lookup support for SNC with >3 nodes. */
> > -             return 0;
> > +     char *cpuid;
> > +     static const u8 emr_snc2_map[] =3D { 0, 0, 1, 1 };
> > +     static const u8 gnr_snc2_map[] =3D { 1, 1, 0, 0 };
> > +     static const u8 snc3_map[] =3D { 1, 1, 0, 0, 2, 2 };
> > +     static const u8 *snc_map;
> > +     static size_t snc_map_len;
> > +
> > +     /* snc_map is not inited yet. We only look up once to avoid expen=
sive operations. */
> > +     if (!snc_map) {
> > +             switch (snc_nodes) {
> > +             case 2:
> > +                     cpuid =3D get_cpuid_str((struct perf_cpu){ 0 });
> > +                     if (cpuid) {
> > +                             if (strcmp_cpuid_str("GenuineIntel-6-CF",=
 cpuid) =3D=3D 0) {
> > +                                     snc_map =3D emr_snc2_map;
> > +                                     snc_map_len =3D ARRAY_SIZE(emr_sn=
c2_map);
> > +                             } else if (strcmp_cpuid_str("GenuineIntel=
-6-A[DE]", cpuid) =3D=3D 0) {
> > +                                     snc_map =3D gnr_snc2_map;
> > +                                     snc_map_len =3D ARRAY_SIZE(gnr_sn=
c2_map);
>
> ... in here as well.
>
> Thanks,
> Namhyung
>
>
> > +                             }
> > +                             free(cpuid);
> > +                     }
> > +                     break;
> > +             case 3:
> > +                     snc_map =3D snc3_map;
> > +                     snc_map_len =3D ARRAY_SIZE(snc3_map);
> > +                     break;
> > +             default:
> > +                     /* Error or no lookup support for SNC with >3 nod=
es. */
> > +                     return 0;
> > +             }
> > +
> > +             if (!snc_map) {
> > +                     pr_warning("Unexpected: can not find snc map conf=
ig");
> > +                     return 0;
> > +             }
> >       }
> >
> >       /* Compute SNC for PMU. */
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >
