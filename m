Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AE3AAF5E
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479967; cv=none; b=IDyrh+zMcFd1EVQR3fPbtsZy/aHvb0LXJuSAltDzN8GEB4UTEG2i/Ep5ojMYHv/VTuLJNe4dKX+0/ls3DVZnK/kcZVdTEsquU5KcgnYwR/We0fqMQaOHzkb4gch52QnMuLdliOjKcM3SBkgxsD/Uq18Fp6tqgYlfILhiwcAenuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479967; c=relaxed/simple;
	bh=0I38r1qoy9pVNoZKmPGxJ6zwTHCN42sDXonmBLRds5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ay0g6/rZWZsrPk/9C2umv+cWHzIXEc2Aepf9pLbXx47xIM3W96nO+w57rsIir9Qb0Yfel16tygnMXlld/Qqcsqk7wZfLJFwEHnNWArCDYLjf5Mj7piMoITgWVc9e1RKYelarcDrktk4uhEPGe/rQ+yC2TFw7inTF+XZkIE+6NZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmvI8k2v; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmvI8k2v"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd3b9e70fa4so20429a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Oct 2026 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791479965; x=1792084765; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDkjT4B9eYvI+erTVIMtr9dU+8Qewz9oL0BLYFFG/GE=;
        b=hmvI8k2veK9l2qYj7+TriOXMVQyImISL5CZaScyx6QdPzgDURVMYw6RWMimLe5PoQM
         52uOwuMuU4grVq6hTZb2mNvBNEkNOqoGQIXogRGyVBOR8MuIt9zACcaJEuiloTDyDkCP
         Cd0L83QOXdOQWK3y7s76+b8vQDlSkEm0RCT0SILRaIpIvDVwM5iqEvP5ZERz1Ym0YX6W
         aL461jp7BZ0NgBKJ07aU6XLEVm5uJknhd/u15KEJhdKbtYpoXzWj1Awf4p5P7gyGFmyS
         8NAOkzqhKaKTg+DKd51omDxI9ZYv57NuBLlGnDzcnUE29hD9c1A55SnhInlSjrd+hoFt
         nRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479965; x=1792084765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDkjT4B9eYvI+erTVIMtr9dU+8Qewz9oL0BLYFFG/GE=;
        b=HSpnbTrLrvgm4UvRQGmDp27Et5YPxgOPu8uLlZM9rSxtLieZ8ANu7moLQOpOhuAT9I
         XGDRsRgWfuZEgG0O/NBgxspaVaHUxB12bi1ilioOn8BelCUUm1CFsIDRkCSDsKxKMRif
         mFYoamlZVOv0+Rc991PMVEZiAO1+8pHbBjANRvpi/HkCX1MVqWc6WCpi2Z8N1hDfV+jm
         07rD7t1GIPZLVGpNlOLbfiCDRH8XcRB77h/CEw7Hja4RppZIg7NLgqMas4JQlArUvt9M
         3SgvqcyZgTjMchRNDvXCaBuMWNolOaFDbEeU19K8XuVTLUtm5xU1ya1G4gtiUc4N54A1
         Tj3w==
X-Forwarded-Encrypted: i=1; AKwUvByIETmdy6HkwLTQrkWRckeEf5ki/zstb0Ti0V7s1J7dsbQZPBCRDa6Po9k84ZgIQvN+3EF4GSaI3YTYJ7zZK8x2@vger.kernel.org
X-Gm-Message-State: AFuF++lgo1p+8pxQyaNA/K8Gdwj6BCP8pIa3+4/1oxZAkVHEP8ZVZ6yh
	+ArIxgPboeNAqkB8RaCqvZHYNjJA7DWoq/xVHUPqpy/2XBrmmmH/DmIT2FmoIfz7V7rCzQj9atF
	NeK2bVJ03PW98KA==
X-Received: from pgbeq25.prod.google.com ([2002:a05:6a02:2699:b0:cc7:8db3:268c])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:48a:b0:3dd:ff70:1426 with SMTP id adf61e73a8af0-3e164acc607mr31406637.3.1791479964069;
 Thu, 08 Oct 2026 10:19:24 -0700 (PDT)
Date: Thu,  8 Oct 2026 10:19:18 -0700
In-Reply-To: <20260310060022.15120-2-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008171921.668587-1-jmattson@google.com>
Subject: Re: [PATCH v3 1/9] perf/amd/ibs: Fix race condition in IBS
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:13AM +0000, Manali Shukla wrote:
> Consider the following scenario,
>
> While scheduling out an IBS event from perf's core scheduling path,
> event_sched_out() disables the IBS event by clearing the IBS enable
> bit in perf_ibs_disable_event(). However, if a delayed IBS NMI is
> delivered after the IBS enable bit is cleared, the IBS NMI handler
> may still observe the valid bit set and incorrectly treat the sample
> as valid.

The sample is valid. It was collected while the event was active, and
it is correct to record it. The bug is only that the handler re-arms
the hardware after perf_ibs_stop() disables the event.

> As a result, it re-enables IBS by setting the enable bit,
> even though the event has already been scheduled out.
>
> This leads to a situation where IBS is re-enabled after being
> explicitly disabled, which is incorrect. Although this race does not
> have visible side effects, it violates the expected behavior of the
> perf subsystem.

This race does have visible side effects:

  1. When the delayed NMI arrives before perf_ibs_stop() clears
     IBS_STARTED, the handler takes the normal path (not the fail:
     path), leaves IBS_STOPPED set, and re-arms the hardware for one
     more period. When that extra period overflows after
     perf_ibs_stop() clears IBS_STARTED, a second NMI arrives. If an
     unrelated NMI arrives first, the IBS handler takes the fail:
     path, clears IBS_STOPPED, and claims that NMI. The second IBS
     NMI is then unhandled ("Uhhuh. NMI received for unknown
     reason").
  2. With VIBS enabled, on hardware without IBS_CAPS_DIS, if this
     race happens when perf schedules out a host IBS event before
     VMRUN, IbsFetchEn or IbsOpEn is 1 at VMRUN. APM vol. 2, section
     15.38, says that these bits must be 0 at VMRUN of an SEV-ES or
     SEV-SNP guest with IBS virtualization enabled.

> The race is particularly noticeable when userspace repeatedly disables
> and re-enables IBS using PERF_EVENT_IOC_DISABLE and
> PERF_EVENT_IOC_ENABLE ioctls in a loop.
>
> Fix this by checking the IBS_STOPPING bit in the IBS NMI handler before
> re-enabling the IBS event. If the IBS_STOPPING bit is set, it indicates
> that the event is either disabled or in the process of being disabled,
> and the NMI handler should not re-enable it.
>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>

I think this warrants a Fixes tag:

Fixes: 85dc600263c2 ("perf/x86/amd/ibs: Fix pmu::stop() nesting")

This fix does not depend on VIBS. It is probably better to send it
separately through tip/perf:core, so that it can go in before the
rest of this series.

> ---
>  arch/x86/events/amd/ibs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index eeb607b84dda..09b56bab510a 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1582,7 +1582,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		}
>  		new_config |= period >> 4;
>
> -		perf_ibs_enable_event(perf_ibs, hwc, new_config);
> +		if (!test_bit(IBS_STOPPING, pcpu->state))
> +			perf_ibs_enable_event(perf_ibs, hwc, new_config);

This stops the late re-arm. perf_ibs_stop() sets IBS_STOPPING first,
with test_and_set_bit(). An NMI before that point can re-arm the
hardware, but perf_ibs_stop() then disables the hardware. An NMI
after that point does not re-arm. Both sides run on the same CPU, so
a plain test_bit() in NMI context is sufficient.

However, the skipped re-arm causes three problems when an NMI arrives
after perf_ibs_stop() sets IBS_STOPPING and before it clears
IBS_STARTED.

First, the event count can increase twice for the same sample:

  1. The handler calls perf_ibs_event_update() for the sample and
     adds a full period. perf_ibs_set_period() sets prev_count to 0.
  2. Because of this patch, the handler does not re-arm. CTL (and
     perf_ibs_stop()'s local config copy, if already read) still
     holds the old sample with Val=1, and the handler does not set
     PERF_HES_UPTODATE.
  3. perf_ibs_stop() clears Val in its config copy and calls
     perf_ibs_event_update() again, because PERF_HES_UPTODATE is
     clear. Because prev_count is now 0, the delta is the whole
     count field: CurCnt (op) or FetchCnt (fetch) from the old
     sample, as if it were progress in a new period.

The amount added in step 3 depends on what the hardware leaves in the
count fields after a sample. For op, the comment in
get_ibs_op_count() says that the lower 7 bits of CurCnt are
randomized after a rollover, so the amount is in general not zero.

Second, IBS_STOPPED can stay set in pcpu->state. perf_ibs_stop() sets
IBS_STOPPED so that a late NMI can clear it at the fail: label. When
the NMI instead arrives before perf_ibs_stop() clears IBS_STARTED,
the handler takes the normal path and does not clear IBS_STOPPED.
Before this patch, the re-armed period gave a second NMI that cleared
it. Now that the handler does not re-arm, IBS_STOPPED can stay set
and falsely claim a later unrelated NMI.

Third, the same sample can be recorded twice. After the handler skips
the re-arm, CTL still holds the old sample with Val=1, and
IBS_STARTED is still set. This is true at least until
perf_ibs_stop() calls perf_ibs_disable_event(). With IBS_CAPS_DIS,
that call writes only CTL2, so it stays true until perf_ibs_stop()
clears IBS_STARTED. If an unrelated NMI arrives in this window, the
IBS handler takes the normal path again, records the same sample a
second time, and adds another full period, because prev_count is 0.
Before this patch, the re-arm cleared Val, so this could not happen.

The throttle path (throttle != 0, so the handler does not re-arm) has
the first two problems already, when perf_event_overflow() calls
pmu::stop() from the NMI. They are not caused by this patch, but they
may be worth a look at the same time.

>  	}
>
>  	perf_event_update_userpage(event);
