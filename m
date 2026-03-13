Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB1390213
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419326; cv=pass; b=Yo7x7isonzXyvBsIKnWa+K6ckNPwIIo/4O8BaznYoOI/npkHhW8RM2aOX/joDEdbqXDBDPbDxQ7YiGGbdwPcGan2FPpUx/Bq1yThxRkhxFmPZH8Y0K1EXUE0hgsjQah4kfbfTqIIla7iThoR8+SA+/fdtNVCujt4jYb4c+7pIVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419326; c=relaxed/simple;
	bh=haWNfVarm8ZoV6XuFzVO0AEDwTOJEJXTzMQaOkfLrTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mnGk9SOe/nZaqu0h1e7M8zu0jw6+WVJCSiWLtQizNKNDRO/eogbLAlfJNXVhbGBg/w3zOpc9n3HE2x/VAuULNr6zPORi2slW6sYRfotywfJLm4kxy7ycsuBcJ9kEBRxrUm3M5k1GIoo4n6iSWQFxoAX34Bazi+RA0x/Y0n0UsGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kII2b/j3; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kII2b/j3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae3f822163so111965ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 09:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773419324; cv=none;
        d=google.com; s=arc-20240605;
        b=FUFjCNFWbMcB7RrCXsYByuAqUib4gE7mvbnpD37P9SxUoPBW1c9UyS63EEcxVANgXU
         8iN7Uj5HVIKC9tT5xFuZ2xuKD0g8xG1y3DDBCbN9mM2kBwAN6zN5/VolGsJWNRbbZwaz
         WR8bHAA2JUTSggb+9bLZbM0zcV9418pkWCeOOt0//ndCn3QyXVE+wjau28IbMPGVdrrW
         fypZomjsjuV0Sta7+y7CV2v/dpfa6Pssqo00++7VS4GJXOH5oCm5hbRcs3fauhWDWl+U
         3CV+DJCusO0rbC258nPjipRiEC4lILAiIf96FAObKcliM1h3mFIaTIaKduPIt3wVBEA8
         uo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RW6L61QTVyil8CfZELR58uOZXUzypQNtck2JSHNlUNo=;
        fh=L8OyKYk5dLns4n2s/TzBpTdJilOYTqi718gdP2L8/CY=;
        b=WtAVMyi8TEYBObxdZNEJHE7bx7weeVT9h7w2xgyE7IYaLHLJUbeIO56I13xVH2DqLQ
         40nDffZeAg4amooB8aJUFCrf55GrhbB9AIuKK/cubIAzLcVPIcLQsMHJCLC+lwaX9hjf
         7GUtzwxZ5OlfEiebFpWcybzpoOYtFveCdK0y5/G/osQggEhfuiCckXdf7DCt9yNM3QNg
         AnfFltmosXJStez96dNlk13ZJDWd8llRvOC/9BlCBmb1vLqLgEQSick9x1brIdWRMo23
         t9bpiUmHMEwJ58E+/JAdCUI+/WLcw35aqeG3aC25DiuvkHvZ/uxgq1vcD+b1Jq8nUY9J
         6fLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773419324; x=1774024124; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RW6L61QTVyil8CfZELR58uOZXUzypQNtck2JSHNlUNo=;
        b=kII2b/j3qM0neiFq3AkNPh3DrmvdnNF6GtVuAtRl/JpzVjfrnrkU+bq2QFRo5ZWqBz
         RRFkDo94tTcFcswJW4hE1RN4UUOlJmug4CFd/aB6GUTMMn6sUfv8JOMVxxYiyD7sAeIj
         gLCEADW9TzPBSxzcDRKZD4fQ8461WTMZhljouRbmwNik2YYCZ6NsmYT83Sz7SckLTzfU
         HBiUF7iwi0HDtN0XkUs+oMfxpmAPmX7BcFEM0P615353e42WXZI41PQWM/8bpduxnlwN
         1qgX/CqzsncrpLNaaz4gyn6f+r2LmhL0TJ0cyGQX75kXoShB29L78FQlBB458F4qndvM
         BGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419324; x=1774024124;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RW6L61QTVyil8CfZELR58uOZXUzypQNtck2JSHNlUNo=;
        b=IJTxDJuLwfEkS+zLpqgOCMMljlxSJi3eGUR8cRZWkcgozdtbDu+FuuUGiaRSCnNLih
         NDOJcID3l0zDTV0Y32hFy7B6WJWu32HzoY0AWJVfJZi9hXHZTQqBzYJPad39eXOOPsNR
         tNE5HP8IkXtzTbVv6xbOU7S3FaYdC3skfrz4aCapMil7QQ0807QG5KYQeUO4aOp2yyL+
         e+mfGQRfNeKKjXVh072VC2dalzALQi9fW9GIuCpvumrLZA1R1Q5VmxnkWpwBoq6kzUM7
         4aJ7I4TDDZ2JJYIyLFvNAKGAOgIOlgDI6pp9oZV9inbK1TfNONOEl+Z7VspPl5DskKrw
         GaXA==
X-Forwarded-Encrypted: i=1; AJvYcCWa+oW/TuH7ck+GU72DeOBEuatZTMAARrqacNuk6u1kWnAYmIIRtASVhUn+W2pB9WCFTXQCE8UQLW+3uYMzuorO@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfu3hEfzT2AZ7A7B1ekO1sH8jihANx42oFM3Hn7jJAFFhSaXP
	h2d/Wg8TB/xPD1Pa8EFiET7JbjgblEMmtcc445aJVod0B52JWk2V41VpCJ6o1i0QWljliupaoCZ
	NEJIF5+FO3cYz0R5wiF6Rvc9gpxzjXuKyF+dPkVLE
X-Gm-Gg: ATEYQzz9xb3u5Z+9Ie25OH9rxuVDAacyy4bZqeKvF3syoJudYPNWu+xjWeJ9sm9sg7h
	80wDzCQtOMsGTnhEBaGKp/oBPB09DyWr/mi0MMWy68xsVkLtAtZLLH4awoPJZT+SEo+P7nNHquf
	vMc5G7EKfTqiql54GDFB9uOdtptf4gpdm/E4xhhe+u96Azz1tNhNtltFNe7KJ5wepwsemRaa1M/
	eHqT7QzoE1lGkHO1lD/X4aS9U3678Exyko/5T6mvJTLXzi9MkLP75ZPJpwd6Rsyup9SRLExOcyc
	9jk6hiU0aLxiI3Qm32AzSwr2vN/qu6CIzc/v
X-Received: by 2002:a17:902:cf08:b0:2ae:4453:3674 with SMTP id
 d9443c01a7336-2aecb5a7fc2mr3040825ad.4.1773419323876; Fri, 13 Mar 2026
 09:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194305.1834035-1-irogers@google.com> <CAP-5=fWSsnwMPOokv75Bzs06ohkX3JSZhHRqRP82NVdq=F9HFw@mail.gmail.com>
In-Reply-To: <CAP-5=fWSsnwMPOokv75Bzs06ohkX3JSZhHRqRP82NVdq=F9HFw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Mar 2026 09:28:32 -0700
X-Gm-Features: AaiRm525YRubxFOKpHnqHt6WA_rOxRjixYOynUa8wsJAPT___SPUEt3tfQc-jl8
Message-ID: <CAP-5=fVwCy8=Z_2y=ppCavcY4oAJoLM72KxJKPeafhVBw9w7eQ@mail.gmail.com>
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

On Thu, Mar 12, 2026 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 12:43=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Auto counter reload may have a group of events with software events
> > present within it. The software event PMU isn't the x86_hybrid_pmu and
> > a container_of operation in intel_pmu_set_acr_caused_constr (via the
> > hybrid helper) could cause out of bound memory reads. Avoid this by
> > guarding the call to intel_pmu_set_acr_caused_constr with an
> > is_x86_event check.
> >
> > Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> +Thomas Falcon
>
> Thanks,
> Ian
>
> > ---
> > This fix was prompted by failure to get a BUG_ON in this series:
> > https://lore.kernel.org/lkml/a61eae6d-7a6d-40bd-83ec-bd4ea7657b9d@linux=
.intel.com/
> > and so I ran an AI analysis to see if there were similar bad casts as
> > spotted in:
> > https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.=
intel.com/
> > The AI analysis found this issue and its much more verbose
> > description is below:
> >
> > I have evaluated all callers of the hybrid_pmu function within the
> > arch/x86/events directory. The vast majority of usages are safe
> > because they operate on an event that is currently being initialized
> > by the x86 PMU subsystem, which guarantees that event->pmu is
> > inherently an x86 PMU.
> >
> > However, there is a distinct bug where a non-x86 PMU (e.g., a software
> > PMU) can be inadvertently passed into the hybrid_pmu function.
> >
> > This issue occurs during group event validation and configuration in
> > intel_pmu_hw_config.
> >
> > The Vulnerability Flow
> >
> >  1. The Context:
> >
> > Inside intel_pmu_hw_config (located in arch/x86/events/intel/core.c),
> > there is logic to handle Automatic Counter Reload (ACR) capabilities
> > for event groups. The code needs to identify siblings that cause other
> > events to reload and apply constraints to them.
> >
> >  2. The Missing Check:
> >
> > In the first pass through the sibling events, the code correctly
> > checks if each sibling is an x86 event via !is_x86_event(sibling)
> > before building a cause_mask.  However, in the second pass to apply
> > the constraints, the code iterates over all siblings again but omits
> > the is_x86_event(sibling) check: arch/x86/events/intel/core.c#n4847
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/x86/events/intel/core.c#n4847)
> >
> >  1            if (leader->nr_siblings) {
> >  2                for_each_sibling_event(sibling, leader)
> >  3                    intel_pmu_set_acr_caused_constr(sibling, idx++, c=
ause_mask); // <-- Missing is_x86_event() check!
> >  4            }
> >
> >  3. The Invalid Cast:
> >
> > The intel_pmu_set_acr_caused_constr function takes this sibling event
> > (which could be a software event) and executes the hybrid macro over
> > its pmu pointer: arch/x86/events/intel/core.c#n4624
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/x86/events/intel/core.c#n4624)
> >
> >  1    static inline void intel_pmu_set_acr_caused_constr(struct perf_ev=
ent *event,
> >  2                               int idx, u64 cause_mask)
> >  3    {
> >  4        if (test_bit(idx, (unsigned long *)&cause_mask))
> >  5            event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_caus=
e_mask64);
> >  6    }
> >
> >  4. The Root Cause:
> >
> > The hybrid macro expands and passes the event->pmu to hybrid_pmu:
> > arch/x86/events/perf_event.h#n788
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/x86/events/perf_event.h#n788)
> >
> >  1    #define hybrid(_pmu, _field)                \
> >  2    ...
> >  3        if (is_hybrid() && (_pmu))            \
> >  4            __Fp =3D &hybrid_pmu(_pmu)->_field;    \
> >
> > Which subsequently results in a blind container_of on a non-x86 PMU
> > pointer: arch/x86/events/perf_event.h#n780
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/x86/events/perf_event.h#n780)
> >
> >  1    static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct p=
mu *pmu)
> >  2    {
> >  3        return container_of(pmu, struct x86_hybrid_pmu, pmu);
> >  4    }
> >
> >  Conclusion
> >
> > If a user creates an event group led by an x86 ACR event but includes
> > a non-x86 sibling event (like a software event), the second traversal
> > in intel_pmu_hw_config will blindly pass the software PMU to
> > hybrid_pmu. Because container_of assumes the PMU is embedded inside an
> > x86_hybrid_pmu struct, the resulting pointer becomes invalid, leading
> > to memory corruption or an out-of-bounds access when attempting to
> > read the acr_cause_mask64 property.
> > ---
> >  arch/x86/events/intel/core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.=
c
> > index cf3a4fe06ff2..26e829b8a882 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4844,8 +4844,10 @@ static int intel_pmu_hw_config(struct perf_event=
 *event)
> >                 intel_pmu_set_acr_caused_constr(leader, idx++, cause_ma=
sk);
> >
> >                 if (leader->nr_siblings) {
> > -                       for_each_sibling_event(sibling, leader)
> > -                               intel_pmu_set_acr_caused_constr(sibling=
, idx++, cause_mask);
> > +                       for_each_sibling_event(sibling, leader) {

So, the fix appears functional, but my AI overlord is spotting more
issues with the ACR code that I'll relay below:

Since intel_pmu_hw_config() is called during perf_event_alloc() ->
perf_init_event() in sys_perf_event_open(), it appears sys_perf_event_open(=
)
has not yet acquired the required ctx->mutex for the group leader's context=
.

Could a concurrent thread modify the sibling_list (e.g., by closing a
sibling's file descriptor, triggering perf_event_release_kernel() and
removing the sibling from the list) and cause list corruption or a
use-after-free?

Additionally, for_each_sibling_event() explicitly asserts
lockdep_assert_event_ctx(leader).

Will this predictably trigger a kernel warning when CONFIG_PROVE_LOCKING is
enabled?

> > +                               if (is_x86_event(sibling))
> > +                                       intel_pmu_set_acr_caused_constr=
(sibling, idx++, cause_mask);

When adding a new event to an existing ACR group, the existing leader and
siblings might be actively scheduled on the PMU by another CPU.

Modifying their dynamic constraints via a non-atomic bitwise AND update
(event->hw.dyn_constraint &=3D hybrid(event->pmu, acr_cause_mask64)) withou=
t
holding ctx->lock or using the PMU event update protocol might allow the
PMU scheduler to read a stale or torn dyn_constraint value.

Could this unsynchronized call to intel_pmu_set_acr_caused_constr()
result in a data race?

Also, cause_mask is defined as a local 8-byte u64 stack variable. Since
perf_event_validate_size() allows event groups to contain several hundred
siblings, a user could construct a group with over 64 x86 siblings where
attr.config2 =3D=3D 0 to bypass the num constraints.
(Ian note: the config2 sounds off here, but if the events are disabled
I think you can put as many as you like in a group)

When idx exceeds 63, the call to intel_pmu_set_acr_caused_constr() executes
test_bit(idx, (unsigned long *)&cause_mask).

Since cause_mask is passed by value and its address is taken in the inline
function, this will read memory past the bounds of the 8-byte variable,
accessing adjacent kernel stack data.

Can an attacker observe the resulting scheduling success or failure to
reliably infer the bits of the adjacent kernel stack memory?

Thanks,
Ian

> > +                       }
> >                 }
> >
> >                 if (leader !=3D event)
> > --
> > 2.53.0.851.ga537e3e6e9-goog
> >
