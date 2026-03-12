Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A853C660A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344674; cv=pass; b=hn7nJ/bqG1cFVKc/9BayrSwUU0zvkv759gjwgeS9CBGZZ1joLzeFh3RO4Z+kd2Xh5Sw6JJRf3c7IN0Jy/+RogfAxJzd/50mzIlkfgD/4jbD6/60yQsMbSEvDBROj7Ys+X8dG/432hpMrrdoHKRsAlm3HEl/CSalcfwTh6ADUUZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344674; c=relaxed/simple;
	bh=A8wOGNheM1pdO2KvZVqMUKz1AIDJhJ0FbrcxnXQFhaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZlkayHWCgPLsutYICpqf24WJR4Ox5oj8X5YbbVP7s1OfIk0dwB8BaelMJcZZS3g1MKNTFlql74E6PE8hkzU+8n+s/DLNgoF81dRvSPAwGj0tiIZq2j8RctrURv0/qCeyi/0nQD4zQQtsHJOeBPDanVe22AZ7P4BHXtbNLAxTuJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuZh7ERc; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuZh7ERc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aea4ebb048so1325ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 12:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773344672; cv=none;
        d=google.com; s=arc-20240605;
        b=j7GgEUdKeZI90K+zOwNve1txvC2yxPOofJTs9/mgc8ZZ/h6IGPiJfQMHQttz2ngxTO
         mLsAFxf3P6zTjc8qOdXs4CnikJMeRDpGun/JwruxPARfFZM/v4gGiktAaq6wCHXtYdFR
         aI0FnecehkpBols5zfeWJQRJgjbTVyveVYvDmqvTxKs6ixR9svFPYlhhWbY6lVS1z9Wg
         ths5axwBjXPkjmbdDBjSx3RPxkbu4g+7nlSTK3khsYpOzPQ7+CwxRMAciscr2XjnbnUu
         A6KUZiT4D1PZTQeFQ43dkfncWyr6ctt79RVytXxffbEuw+95FkUFaHhP7FXSavDqeU+i
         ACRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FOs+jWiLdlUB9oFAPrKj+gNO3kL0vtxoAg3awJpi3z4=;
        fh=P1Gbbhpsi4eGNkz2FR8C6l5AHiVnhoUHoiMplu6XQsg=;
        b=NF7sBa5868yhpHEy3aYr683UBWxJnaSreHU6tGtQRI5ay/aAeg6ZJMzdWNjcmiaMl+
         Q2b+hmYliILBbru7SxTXQUTmIpoflYB9p5fTOppgzWjSsxqBIvSo51hTLBOU4TyQ2MpC
         reXiLa7/MzcNzhQJi4tuz07PeZbvTBpzU1BPVK7le6y29JOrTqnc8atAqAjUyCF5331y
         PbeF1DIuyvjiYe5lvJ4GWTJy5b2hgPsg0udRXue/Wrk2yTX6cPlD9ecOBMQqmVmTur21
         eXydh5qAnjffMI+146QlRckm/8wkTDMR1KSgvC7cw0IAm/TMz7ALoscZfuHzcjnssUpX
         sw7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773344672; x=1773949472; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOs+jWiLdlUB9oFAPrKj+gNO3kL0vtxoAg3awJpi3z4=;
        b=fuZh7ERcnJr0WUzgvT4MYmwYWKwSLdhKUraeU95k1a0DeXr+PXylG4vIy7V56ixik/
         VzctCq5IIxTzO6PQKNgSIOkyX6UfNz2tG1lDVKXoYDtrM16AwX7jqawZDKzfUt0Y+ZNT
         MtKBQQZSAuXz6fBZeQ6+zKoR36+ov7v0h5A4Cv35OgusDuejeQs6pMsfKjsO6lDeNo69
         RXC9CqQxNHq8Ldv7mMiGXZ6p9lLrlJtlv2XeIDZuM3ULUFS+zKV0Oz8qzCUX2iwlgSYn
         bJIxCbKuEmlB6lEUzqjk/K8vI23G1wWkwR3SlTd3YcLgRnl+6E2tBVxqapFr4Y8KQ30n
         wczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344672; x=1773949472;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOs+jWiLdlUB9oFAPrKj+gNO3kL0vtxoAg3awJpi3z4=;
        b=WVDE8gn2yWK+qF64xVk4wLc2xip+nGZpT+pOnlV1DSXMAZhU62tuZzWSoQJYwdTVsx
         foCN+Sry3fmhFZAAppDf42BUEmI37VpgYzPp6QgBEUXjvdbptx5wTDgGa86+c+V+X+0y
         x0FsV/AUaFDPuOCviu4OsVl0jE4OiEgK9YA63AmnoN2VT2lwo1gEo9AGPGnzS9X60bfa
         Iz0Ma6ahXLXp2lneuSp1Ikuk3oGZILTatBjC+r1IEX7TiUKCHinWUFD0mSKL9sVUd0rO
         zDCZR/DRyJQDqBYMjCqFeFOOW4JWPGRw9EKDdCK4SU3hCelfc/uxg4gSJw2eIENnkQrB
         PYjg==
X-Forwarded-Encrypted: i=1; AJvYcCWcz8I/NbjKs41/1jYQrpICNJZohpFB9VkybWaV4A3fZuaGmPOJArxPaPBo7PM6do1BYZXdoCif8xoyG8AqimzA@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKqaw3fyOcXyQy2hPdHyzjY1YPGhQhmtNtHP+8/8wtCsVaTJt
	pwxvQhIyR4yYjYjMi9PJBVxyLMvY0lbAAWoFCy57i3CuBm/72y1lXAVawoqsKPfRgNCgE6BmmBu
	O14A5EkGUo7v1ZUgCVxz8qVHsmGxmymdZyh+ymKRv
X-Gm-Gg: ATEYQzxEckTfGxDk3x8FGsFSkDUUKYt6h4m7PZ8TwtXTkyhkdft4kMrshXrkLcACuKQ
	W4M04MoabPVK6t5/ryhFngi7fcYQo9ZbIjOQv8/57j9mFAiJ/9j1vWbQaIn+hOw6RMs0rOxuHqq
	Hgki1s0KVESUOsGpOawGkVzZcR7WA3ilbEC4rU342i3DHhv05OszNE2KQZXxWdZfOIH0JBMre2Y
	PRhrQR8Vt/9Cv0gdyMXZtF/sC8Br0m1P1GiDp4rpRZWKiz/zN1vD15OKjU1nImFxlvSW9gCOBi0
	8/hGAHqs13J4oO0/Fg6BKlgkdye4GfavswhI
X-Received: by 2002:a17:902:f68f:b0:2ae:bf32:20e8 with SMTP id
 d9443c01a7336-2aecb6c1addmr609885ad.18.1773344671595; Thu, 12 Mar 2026
 12:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194305.1834035-1-irogers@google.com>
In-Reply-To: <20260312194305.1834035-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 12:44:20 -0700
X-Gm-Features: AaiRm5092lXprHyshPKEwkOFeo1jYTiH-tKhnBkNHVJGFsv2_fKvtM6O7KhrXFg
Message-ID: <CAP-5=fWSsnwMPOokv75Bzs06ohkX3JSZhHRqRP82NVdq=F9HFw@mail.gmail.com>
Subject: Re: [PATCH v1] perf/x86: Fix potential bad container_of in intel_pmu_hw_config
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 12:43=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Auto counter reload may have a group of events with software events
> present within it. The software event PMU isn't the x86_hybrid_pmu and
> a container_of operation in intel_pmu_set_acr_caused_constr (via the
> hybrid helper) could cause out of bound memory reads. Avoid this by
> guarding the call to intel_pmu_set_acr_caused_constr with an
> is_x86_event check.
>
> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
> Signed-off-by: Ian Rogers <irogers@google.com>

+Thomas Falcon

Thanks,
Ian

> ---
> This fix was prompted by failure to get a BUG_ON in this series:
> https://lore.kernel.org/lkml/a61eae6d-7a6d-40bd-83ec-bd4ea7657b9d@linux.i=
ntel.com/
> and so I ran an AI analysis to see if there were similar bad casts as
> spotted in:
> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.in=
tel.com/
> The AI analysis found this issue and its much more verbose
> description is below:
>
> I have evaluated all callers of the hybrid_pmu function within the
> arch/x86/events directory. The vast majority of usages are safe
> because they operate on an event that is currently being initialized
> by the x86 PMU subsystem, which guarantees that event->pmu is
> inherently an x86 PMU.
>
> However, there is a distinct bug where a non-x86 PMU (e.g., a software
> PMU) can be inadvertently passed into the hybrid_pmu function.
>
> This issue occurs during group event validation and configuration in
> intel_pmu_hw_config.
>
> The Vulnerability Flow
>
>  1. The Context:
>
> Inside intel_pmu_hw_config (located in arch/x86/events/intel/core.c),
> there is logic to handle Automatic Counter Reload (ACR) capabilities
> for event groups. The code needs to identify siblings that cause other
> events to reload and apply constraints to them.
>
>  2. The Missing Check:
>
> In the first pass through the sibling events, the code correctly
> checks if each sibling is an x86 event via !is_x86_event(sibling)
> before building a cause_mask.  However, in the second pass to apply
> the constraints, the code iterates over all siblings again but omits
> the is_x86_event(sibling) check: arch/x86/events/intel/core.c#n4847
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/x86/events/intel/core.c#n4847)
>
>  1            if (leader->nr_siblings) {
>  2                for_each_sibling_event(sibling, leader)
>  3                    intel_pmu_set_acr_caused_constr(sibling, idx++, cau=
se_mask); // <-- Missing is_x86_event() check!
>  4            }
>
>  3. The Invalid Cast:
>
> The intel_pmu_set_acr_caused_constr function takes this sibling event
> (which could be a software event) and executes the hybrid macro over
> its pmu pointer: arch/x86/events/intel/core.c#n4624
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/x86/events/intel/core.c#n4624)
>
>  1    static inline void intel_pmu_set_acr_caused_constr(struct perf_even=
t *event,
>  2                               int idx, u64 cause_mask)
>  3    {
>  4        if (test_bit(idx, (unsigned long *)&cause_mask))
>  5            event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_cause_=
mask64);
>  6    }
>
>  4. The Root Cause:
>
> The hybrid macro expands and passes the event->pmu to hybrid_pmu:
> arch/x86/events/perf_event.h#n788
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/x86/events/perf_event.h#n788)
>
>  1    #define hybrid(_pmu, _field)                \
>  2    ...
>  3        if (is_hybrid() && (_pmu))            \
>  4            __Fp =3D &hybrid_pmu(_pmu)->_field;    \
>
> Which subsequently results in a blind container_of on a non-x86 PMU
> pointer: arch/x86/events/perf_event.h#n780
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/x86/events/perf_event.h#n780)
>
>  1    static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu=
 *pmu)
>  2    {
>  3        return container_of(pmu, struct x86_hybrid_pmu, pmu);
>  4    }
>
>  Conclusion
>
> If a user creates an event group led by an x86 ACR event but includes
> a non-x86 sibling event (like a software event), the second traversal
> in intel_pmu_hw_config will blindly pass the software PMU to
> hybrid_pmu. Because container_of assumes the PMU is embedded inside an
> x86_hybrid_pmu struct, the resulting pointer becomes invalid, leading
> to memory corruption or an out-of-bounds access when attempting to
> read the acr_cause_mask64 property.
> ---
>  arch/x86/events/intel/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cf3a4fe06ff2..26e829b8a882 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4844,8 +4844,10 @@ static int intel_pmu_hw_config(struct perf_event *=
event)
>                 intel_pmu_set_acr_caused_constr(leader, idx++, cause_mask=
);
>
>                 if (leader->nr_siblings) {
> -                       for_each_sibling_event(sibling, leader)
> -                               intel_pmu_set_acr_caused_constr(sibling, =
idx++, cause_mask);
> +                       for_each_sibling_event(sibling, leader) {
> +                               if (is_x86_event(sibling))
> +                                       intel_pmu_set_acr_caused_constr(s=
ibling, idx++, cause_mask);
> +                       }
>                 }
>
>                 if (leader !=3D event)
> --
> 2.53.0.851.ga537e3e6e9-goog
>
