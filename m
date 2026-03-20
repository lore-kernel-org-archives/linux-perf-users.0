Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C43D090D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033112; cv=pass; b=l7K1IPGtjU5/vgYs0mN7XFZc4/y1OHQIUWfesh1OORUf7nd89pbHsdhJZIfeFvK1jgvJ88VUXRQiLcnPuq2TvQThwsLZnOIQOtNylcVLjmISdavrqCu7sRQeo33ZK/tlItcgFu2qQZV1Ge0MsNyNa4wm+5L+G2BIKNFo7PStuqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033112; c=relaxed/simple;
	bh=BD48L8bUYUCEZUND0AuPO65vnNfUThzTmh3j20/6oXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YN4GYsAfN+t0pDTDY1VTGt7lA9wv7tgE7baS+jgb+u0UjnUWaMXkPorW7EjlscRs8MxogO/xIs5Pz8opVUFajK5GyT+xoKRWcfT0q/TTRsuUb44JbcoUB3GTN8lbLmSSeT/dK9ltnX0ssJ0UxHzlsXluKUxLPt17GJi+HvznAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oqg5BDS+; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oqg5BDS+"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-667cde0fc88so1906a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 11:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774033109; cv=none;
        d=google.com; s=arc-20240605;
        b=DglnHTpM4ZedJFf71XvEi3BihrX2KEewvTHpwvDlVUjtkNz0ZV1yftrBEg2oFtKiat
         NGhJee3UJUGrsbvSeC7YPA8CWBxmR3UloYIa0cFxYL9mNJxzWHMr5svC/m5SO+uakBz/
         6jKHJTMcbsB8SWp+tlk13kMvbaC7K7eZMteSh+uuA0bszyKTetzxkOPOxOcvr22XViSe
         Q3/8/S0aD2ACDs5G2Naze7b6X63fpj3NSsZ+pkqpEqm8PeXQ9h+aeC7nDU9RBwl04YGh
         yD8HjhwCqQ+O+wduFNVpKeG8FzyQzfKe1uDsQcsCjtEs0VkSnOZqtP+XlD6K0LqbRq5d
         sbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBP9Tz0HfbRDrCCTFYxtZFLv1W3AZh/tRK2ZpkKwaso=;
        fh=UYmPDXt5nEi+5r+cvjqU1UQ80L2/v6F7XqN7HDhTPvw=;
        b=IZ1rBwrYoJ0Oc4o4sOTNMDbOnTH/Vs7PU7STKGgzbFY6zE8cdMegMDvg45oleiHzOA
         93FrFxXaIeeDaKCY6xm37eZmC7QrpFqmXEjRbNggoaBWJ3Uv3zHDtzgECj10FrPM1MGb
         g6tjulY89UeCz2aLrRLDCMML5fwlGuNNeid10sY7YVFTOfZmLPBCtiPV9AwW7eAoJk4k
         8o4NOSZdY3YN8MARKIWRRXuJ7AjqPNBICA3THZNdr2QZeUE8flUMnYcu+ulsRpnM7IMd
         a9CpbPG81CVG1SiY/HY6s+gQuiRBSOI4YokntlHhMrB8ozBwUOME4qGlh+mjJbY8YHuK
         +uRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774033109; x=1774637909; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBP9Tz0HfbRDrCCTFYxtZFLv1W3AZh/tRK2ZpkKwaso=;
        b=Oqg5BDS+CQUDLXZkmc/u+n03/bf7DwNL2R3l3oS71pssKDd2mGMX+NWZWH/gMWrCXC
         F6Kq/IeE+K8SSfszeTdZBz/Bflz3Vid4yT6Vz3cJDZsTbJzdZjKXJbIyXLrLjjDKAVCP
         r//cRjs3eF+3S+Ob8DqrZKlPjZNd6AMLTlPfrzeu8wVlrz0lLTTTyZqrB4Qehm4G4t1t
         L7s6Xb/+aKEF2n9Eyx2HcY4PTdK2tO8dDn02JMvRxYpGJAGhfpD2ooiptLfjEMe7dTe8
         jFQiVu2D3C8oeHz/Ss7Zpsf72jtrGN/HZI23081HAasX4LGmUAbEjOKJdpQfO9/gWGkx
         o3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033109; x=1774637909;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBP9Tz0HfbRDrCCTFYxtZFLv1W3AZh/tRK2ZpkKwaso=;
        b=MkiAug+0Bd/Ucthv8JbGflOEx1xUMNQsh5NWzmS3uvcucSnNWs3G99PDCwHhoYTufB
         Mtje2f6XR6sbE4G2DPiPq/Zd6xwFmuukV4HqAiNqdnvWsHPiOVnwTyhdtQij38eTFbCv
         tymQY/oNL2dgZtHMWd350NjTs2fV7H2uuFgI5e/A6D2ktxVCfY6hFgYn4LvgLIaBvpMJ
         y4Q8j0jS9ZStE/qoW+XH/CGpcXnnddYUGv38GJavqqPgwWcflbUcyi9Vnkc8eCHzZULe
         Uzm/UcIvljjKcC8Z+qDb2Z1TIv6kUkH0fnE1/pynDck2I7s/zhAhAMrsSx/WzCIwyS5s
         oVHA==
X-Forwarded-Encrypted: i=1; AJvYcCWDH2iBvBsygocd17D8XyzLfXELj4DBZtaEMG5ZV18r4nblJunQjQj1c6leBgi4I82JO15JzaOMSfnsVBvK2GQk@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlzOVndow2ia0m1dooR87/f6Qv366lkH0vB3LFGSwKYQ2WOhn
	9LpleyffH9llWjFI57pmplzrmfDQ+5O4ZpYTUNYulnl6vEt7OlO80sqADY1EHmgBh/ocZxvNWJE
	jb9tkoUrLkWaWJkg2VLk/dcfXB2V7SjR+X64/6rDT
X-Gm-Gg: ATEYQzzAZ5dik2VPyAtgyv7+roZ1kgS5mZy2FRQb5r35V94lyd4tWC+BEYTVALvoh5D
	vXSx8Ki1PKXHe3wWvKtkEc1k9bLmb/pA99QS+9mnsEhbvwu9R0kEwyTkNXkiE0zQGPuLaiJsbNe
	wb1Xi+rTNioqeyQtReLY8ZYthmgKLWMtFtxmpp8DwhuhWkTjOEf5sd56WEe0qE5vPAZqycyXs2K
	Fz4zOHlbqEdr5DKg4VhaPgOSGzXtgN+hN/1++Ehf4XeoXIpZyUBPPCUBENJ5ZWDMtygzLTSNHLn
	gy6HQaQ=
X-Received: by 2002:a05:6402:268e:b0:664:dff9:8165 with SMTP id
 4fb4d7f45d1cf-6694b1f303amr6413a12.15.1774033108461; Fri, 20 Mar 2026
 11:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320152928.1916447-1-jmattson@google.com>
In-Reply-To: <20260320152928.1916447-1-jmattson@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 20 Mar 2026 11:58:16 -0700
X-Gm-Features: AaiRm51W6LBnQ_NqVo0elt_y6gHMMqH2ta-RPEVC7WSDujVM1f6sIonK87d2Xu4
Message-ID: <CALMp9eQh37Mxb3qvFWnYNTUiUBdSnRMsPdqgMdQD3XpC1HOs+w@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Don't update PEBS_ENABLE MSR in NMI context
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:29=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> Writing MSR_IA32_PEBS_ENABLE in handle_pmi_common() when a PEBS event is
> throttled is problematic for KVM, which may have an older value for the M=
SR
> (previously obtained via perf_guest_get_msrs()) stored in the VM-exit
> MSR-load list.
>
> It isn't necessary to update the MSR in the PMI handler, because the
> throttled counter's PerfEvtSel ENABLE bit has been cleared, so its
> PEBS_ENABLE bit is irrelevant. However, the MSR must be updated before th=
e
> stale bit becomes relevant again (i.e. when the PMC starts counting a new
> perf event).
>
> When the PEBS_ENABLE MSR is rendered stale in the PMI handler, just recor=
d
> that fact in a new cpu_hw_events boolean, pebs_stale.  Extend
> intel_pmu_pebs_enable_all() to write MSR_IA32_PEBS_ENABLE when pebs_stale
> is set and to clear pebs_stale.  This ensures stale bits are cleared
> during the normal PMU enable path, before PERF_GLOBAL_CTRL is restored an=
d
> any new event can start counting.
>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/events/intel/core.c | 28 ++++++++++++++++++++++------
>  arch/x86/events/intel/ds.c   |  4 +++-
>  arch/x86/events/perf_event.h |  1 +
>  3 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cf3a4fe06ff2..3b0173d25232 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3548,14 +3548,26 @@ static int handle_pmi_common(struct pt_regs *regs=
, u64 status)
>                 static_call(x86_pmu_drain_pebs)(regs, &data);
>
>                 /*
> -                * PMI throttle may be triggered, which stops the PEBS ev=
ent.
> -                * Although cpuc->pebs_enabled is updated accordingly, th=
e
> -                * MSR_IA32_PEBS_ENABLE is not updated. Because the
> -                * cpuc->enabled has been forced to 0 in PMI.
> -                * Update the MSR if pebs_enabled is changed.
> +                * PMI throttling may be triggered, which stops the PEBS
> +                * event.  Although cpuc->pebs_enabled was updated
> +                * accordingly, MSR_IA32_PEBS_ENABLE has not been updated=
.
> +                *
> +                * The MSR must not be updated in NMI context, because KV=
M
> +                * may be in a critical region on its way to VM-entry, wi=
th
> +                * the now-stale MSR value stored in the VM-exit MSR-load
> +                * list.  On VM-exit, the CPU will restore the stale valu=
e.
> +                *
> +                * Deferring the MSR update is harmless because the
> +                * throttled event's PerfEvtSel ENABLE bit has been
> +                * cleared, so the stale PEBS_ENABLE bit is irrelevant fo=
r
> +                * now.
> +                *
> +                * Track when MSR_IA32_PEBS_ENABLE is stale, so that
> +                * pebs_enable_all() will write cpuc->pebs_enabled to the
> +                * MSR, even when cpuc->pebs_enabled is 0.
>                  */
>                 if (pebs_enabled !=3D cpuc->pebs_enabled)
> -                       wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +                       cpuc->pebs_stale =3D true;
>
>                 /*
>                  * Above PEBS handler (PEBS counters snapshotting) has up=
dated fixed
> @@ -4978,6 +4990,10 @@ static int intel_pmu_hw_config(struct perf_event *=
event)
>   * These values have nothing to do with the emulated values the guest se=
es
>   * when it uses {RD,WR}MSR, which should be handled by the KVM context,
>   * specifically in the intel_pmu_{get,set}_msr().
> + *
> + * Note that MSRs returned from this function must not be modified in NM=
I
> + * context. Doing so could result in a stale host value being restored a=
t
> + * the next VM-exit.
>   */
>  static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void =
*data)
>  {
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 5027afc97b65..852baf6a05e9 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1982,8 +1982,10 @@ void intel_pmu_pebs_enable_all(void)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>
> -       if (cpuc->pebs_enabled)
> +       if (cpuc->pebs_enabled || cpuc->pebs_stale)
>                 wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +
> +       cpuc->pebs_stale =3D false;
>  }
>
>  void intel_pmu_pebs_disable_all(void)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..22102296e31b 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -298,6 +298,7 @@ struct cpu_hw_events {
>         /* DS based PEBS or arch-PEBS buffer address */
>         void                    *pebs_vaddr;
>         u64                     pebs_enabled;
> +       bool                    pebs_stale;
>         int                     n_pebs;
>         int                     n_large_pebs;
>         int                     n_pebs_via_pt;
> --
> 2.53.0.959.g497ff81fa9-goog
>

Apologies. Resend to fix Peter Zijlstra's address.
