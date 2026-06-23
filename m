Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4D351C1E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204503; cv=pass; b=XNSx510FulyTNxZmj9Usy5wNr7/jb0oYxPC8gvPYsbVrfhMhWV8VBLMQt3mDQlMyZO1ivr/1l18lp/s4mXIBMIpYLd0P0dBSjxxIohTMc2+wfvat/W6s0tXZRrsCbftEKTxKCrqHhjMfEVg1rs5zx7BB4BJOCqDqs+Ri5s086WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204503; c=relaxed/simple;
	bh=MvTm1/V5cR0bYZKWXLWMsoWEngS9v10+JAMvkup0iDY=;
	h=References:In-Reply-To:From:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5Lo1o9bY3VfwIff6x6TrBBhf/LbbC4oGi+AL/eksQM0e+3Tgfn9x1CCojPTnWMEZXGI1npmNGAgHmOh9cSTLGVU0gq9iChVAfylz/OXAVgMjdArarQg3U5EzZ3fqelDrqiJr9nQUk6xTodWmBYy5Yk9aT0o9BAeybo/+gI7qss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iNz7e9RM; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iNz7e9RM"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so5280531e87.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204498; cv=none;
        d=google.com; s=arc-20240605;
        b=kszjEqEBlrh/1Kk4EDiUwi5bQEM8kE8d3KciVKr65zSQjZlTVP+sr5KokxxtsBquBd
         WnjH7PUu6GI2B5a1oTJscDiV9oGoRqx86gcqF2ckVEKg+oIgRyGjmqj/fHaOQY6X9cvH
         HWhkrb/Xo7v2hExQfHeZZ5/yJY5qef/GNcJOigKw4kRaM4Aq9tTZNLI1f1Sp/FCiRAmx
         3w0/cOY5qM+XmbJINVozb8RQ1t/oHBHiWjliKs6M7JkUBc6+DoVLmMzDxpcT8EKlhtw0
         FcvOJr7L2wLOApxyvQxWT7hzozWR7cFEnJW323DU48wOhySNavrGnIGhrHqcGCmxpg9O
         kXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :mime-version:from:in-reply-to:references:dkim-signature;
        bh=n5xBv4esraUDbm7myGlgVwoDL09rPZflhhewxMxljmo=;
        fh=wFCVIk1EsPUSfkSB2LB3t8kxUmLosCWf2TY/p8x2Vn8=;
        b=NzX8AgVq8dzbhPerZzsk6LHVkeTaJJfD5FzIuttiKzLsNtqbBSDUwRePuQwef6dX5W
         Lxoxg0oUfyqXPRuLvABBduypnfSzaClXdfSyE3u7odcb/0EPI7V/pHjEuc+YNubKGimp
         +EtMPgNc5aV5bm42+2mF5a6IhLR2mhLm4enqvXC2XhBY4iFLGrDlNIN0RwBPayAmWGIG
         BeiibJ8VQDWbDlEUZB0d1UsIRPhN2g05tvwP76XDBG0yYZ9aklPrJ0615MBfplTCPVbD
         HTXzG5T9jfEzul0uw0QUANnF2fLJNKz5DnhwXy7rjQpdSCEHm5vhTvWz3RkEpCEPHYgX
         ESxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782204498; x=1782809298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :mime-version:from:in-reply-to:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5xBv4esraUDbm7myGlgVwoDL09rPZflhhewxMxljmo=;
        b=iNz7e9RMfmm0djcfBtWFfutav1gE9bW4l9w+oycdPVE8gICY2K7TJ3z+esQkxpIMX3
         6CFMQKUNNUhNb02CMuKztYeiBsR/XatjRATEPAzNWcHz8b0HT50UMRDZUA4jTIjZQEHw
         aGonimvsCeJhDiSH4waSQbnZNYO9q8fmjdYsmLWgwkLk3GfnsvUXX8LsI/o75OmInBdU
         ICzwivB0mlPXXNGZ7vOvZygOBrqdBl84OKN7mT3YLwb4GnP3bWSKtEFCIw4aokF78Qcz
         I2GbfBSySI+XwTjTcmGpPOWjbR8IeUQVzgmQfKA+hWpJoXd4nkiXQ/UAeGQyhHFUllID
         lScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204498; x=1782809298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :mime-version:from:in-reply-to:references:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5xBv4esraUDbm7myGlgVwoDL09rPZflhhewxMxljmo=;
        b=X3QTuYesDfIIFnCHCLV5dYAGVHvHevVeFpN9ms/FxoLebvWLe10pUaGTgananqOHEl
         2Mxqw0EYBRNJPdQHhjLvY+prt9CGg0SDeSQqY0VQcVh3wgQ2MrhOYzyq9StWHjz8RmzL
         O/wxTwWQOM5QG/CuGj2DMRkSB/OsKF3rzV4RMSjpJd7pOfcn2IThwfkiMm0UHffgOzjY
         rJlK41ggwrDb8lTV/jBjYAX8BNHmbRc4esIEtTDJeEKZ8WArBkOF/b1jYpihB8c3U6+u
         2daBeG9VbHQSYHQkedjYH53SlYJh+BrUosbqjCvWxsZGoPgSFaGa8RmJgW4LZluHYu8f
         9j7w==
X-Forwarded-Encrypted: i=1; AFNElJ9uHrqU3HCrfmf+eGqrndzKMPJD0+IuH3yIJAjPD/ot1zCVHylqJy3Aa/nZkHZMHCrAeR+4O7CKg9EvA4P/b8sK@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/vojXU9wWw5RYLQ3tcpQZKc9QY3KBTAIrFeqZNYc3HNwoK9N
	dPui1uHB/hZyHQ98Wfn5vXIOfDjK3+4kLRsR+yokUwaphaQyjXJCLIpQ2qfSfNBa5rwolajZ4EY
	i2m1CLFupox9ug3pq+c0xVWUj0yoFOx67T4+/xAD+aw==
X-Gm-Gg: AfdE7clHR5eluDoSXIiBURZnXct9iBGGEruxf/0HUASmSOmEgAm9XTfhr//ARwBy/Gn
	7yXgltGy57GhhLQblAp7fVkQDJeoKRXHPpkpoPRI7Lxa0O8tJplvwJMz8kukKmpnFkzmNsQbm/X
	L+OSvsSlaCS85BhpLIr1WPR27TpiP9XfhRifja9/NxJjbJuhvHhL7H6zSQEjSfQx9iDVuQavvby
	/ujLu7WOkKycLxRdET1yvWzND3G6dp9YdCoiZuN/7BZzGRYyys7Qw+VkryPrLhV/Dd4JLw=
X-Received: by 2002:a05:6512:b1f:b0:5aa:8822:f27f with SMTP id
 2adb3069b0e04-5ade474bd06mr549035e87.47.1782204497498; Tue, 23 Jun 2026
 01:48:17 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 23 Jun 2026 04:48:16 -0400
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 23 Jun 2026 04:48:16 -0400
References: <202606101206.65AC69UA050105@mse-fl1.zte.com.cn> <00786ddb6d626442879072851d455bbd8ef1181d.371854f5.6bc1.4985.842c.192c1a21a55b@bytedance.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <00786ddb6d626442879072851d455bbd8ef1181d.371854f5.6bc1.4985.842c.192c1a21a55b@bytedance.com>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Date: Tue, 23 Jun 2026 04:48:16 -0400
X-Gm-Features: AVVi8CdLiQEVbaQNPwVOBfdN74KeD0p_3evPQCHETqlHrPAPf-PWpcsG_I2fylc
Message-ID: <CACnXVndEZS_-ccYAgTYpj0Kf+p9OpY+RwchwR8WuK27zF0Tgkw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v9 4/5] perf: RISC-V: add support for SSE event
To: yang.susheng@zte.com.cn
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, conor@kernel.org, cleger@rivosinc.com, 
	himanshu@thechauhan.dev, will@kernel.org, mark.rutland@arm.com, 
	atish.patra@linux.dev, anup@brainfault.org, shuah@kernel.org, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com, liu.xuemei1@zte.com.cn, 
	zhang.anmeng@zte.com.cn, gao.rui@zte.com.cn, tan.hu@zte.com.cn, 
	jin.qi@zte.com.cn, li.zhichao@zte.com.cn, jia.yunxiang@zte.com.cn, 
	dai.hualiang@zte.com.cn, liu.qingtao2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Susheng,

I have reproduced the panic locally and have a fix for it.

The root cause is that PMU-SSE delivers the PMU overflow through an SSE
handler entered with a synthetic supervisor context. That context is
good enough for running the SSE handler, but it is not the context
interrupted by the PMU overflow. Therefore, the perf callchain unwinder
must not treat the SSE handler frame as the sampled frame; it needs to
start from the SSE-interrupted context.

My current prototype does that. With a matching OpenSBI change, Linux
reads the interrupted PC/SP/FP/RA/privilege state from SSE attributes
and uses this context as the callchain starting point. With this change,
the reproducer no longer panics in my setup. I used hackbench as the
workload, which I believe is complex enough for this panic reproducer:

   perf record -g -F 999 hackbench

This version is indeed not compliant with the current SBI SSE spec.
However, I think the information currently exposed by SBI SSE is not
sufficient for Linux to complete perf callchain unwinding. My current
approach needs SBI to provide the interrupted context, at least the
interrupted PC, SP, frame pointer (s0), RA, and privilege mode. For
future perf's host/guest attribution, we may also need a virt-mode flag.

I will keep looking for a better implementation and try to find an
approach that is acceptable for the SBI specification. Comments and
discussion are very welcome.

On 6/11/26 2:25 PM, Zhanpeng Zhang wrote:
> Hi Susheng,
>
> Thanks a lot for the bug report and the detailed logs.
>
>> From: yang.susheng@zte.com.cn
>> Date:=C2=A0 Wed, Jun 10, 2026, 20:06
>> Subject:=C2=A0 [External] Re: [PATCH v9 4/5] perf: RISC-V: add support f=
or SSE event
>> To: <zhangzhanpeng.jasper@bytedance.com>
>> Cc: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, =
<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>, <kvm-riscv@lists.=
infradead.org>, <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.=
edu>, <alex@ghiti.fr>, <conor@kernel.org>, <cleger@rivosinc.com>, <himanshu=
@thechauhan.dev>, <will@kernel.org>, <mark.rutland@arm.com>, <atish.patra@l=
inux.dev>, <anup@brainfault.org>, <shuah@kernel.org>, <cuiyunhui@bytedance.=
com>, <yuanzhu@bytedance.com>, <zhangzhanpeng.jasper@bytedance.com>, <liu.x=
uemei1@zte.com.cn>, <zhang.anmeng@zte.com.cn>, <gao.rui@zte.com.cn>, <tan.h=
u@zte.com.cn>, <jin.qi@zte.com.cn>, <li.zhichao@zte.com.cn>, <jia.yunxiang@=
zte.com.cn>, <dai.hualiang@zte.com.cn>, <liu.qingtao2@zte.com.cn>
>> Hi Zhanpeng,
>>
>>>
>>> In order to use SSE within PMU drivers, register an SSE handler for the
>>> local PMU event. Reuse the existing overflow IRQ handler and pass
>>> appropriate pt_regs. Add a config option RISCV_PMU_SBI_SSE to select ev=
ent
>>> delivery via SSE events.
>>>
>>> When the SSE path is used, also honor the return value from
>>> perf_event_overflow(). If perf core throttles or disables an event, do =
not
>>> immediately restart the overflowed counters from the SSE handler.
>>>
>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>>> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>>> ---
>>>  =C2=A0drivers/perf/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +++=
++
>>>  =C2=A0drivers/perf/riscv_pmu.c =C2=A0 =C2=A0 =C2=A0 | 23 +++++++++++
>>>  =C2=A0drivers/perf/riscv_pmu_sbi.c =C2=A0 | 78 +++++++++++++++++++++++=
+++++++++-----
>>>  =C2=A0include/linux/perf/riscv_pmu.h | =C2=A05 +++
>>>  =C2=A04 files changed, 104 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>> index ab90932fc2d0..b6c58475091c 100644
>>> --- a/drivers/perf/Kconfig
>>> +++ b/drivers/perf/Kconfig
>>> @@ -105,6 +105,16 @@ config RISCV_PMU_SBI
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0full perf feature support i.e=
. counter overflow, privilege mode
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filtering, counter configurat=
ion.
>>>
>>> +config RISCV_PMU_SBI_SSE
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on RISCV_PMU && RISCV_SBI_SSE
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "RISC-V PMU SSE events"
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0default n
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0help
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say y if you want to use SSE events=
 to deliver PMU interrupts. This
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provides a way to profile the kerne=
l at any level by using NMI-like
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SSE events. Since SSE events can be=
 intrusive, this option allows
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selecting them only when needed.
>>> +
>>>  =C2=A0config STARFIVE_STARLINK_PMU
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_STARFIVE || COMPILE_=
TEST
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on 64BIT
>>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>>> index 8e3cd0f35336..a48e286d9394 100644
>>> --- a/drivers/perf/riscv_pmu.c
>>> +++ b/drivers/perf/riscv_pmu.c
>>> @@ -13,6 +13,7 @@
>>>  =C2=A0#include <linux/irqdesc.h>
>>>  =C2=A0#include <linux/perf/riscv_pmu.h>
>>>  =C2=A0#include <linux/printk.h>
>>> +#include <linux/riscv_sbi_sse.h>
>>>  =C2=A0#include <linux/smp.h>
>>>  =C2=A0#include <linux/sched_clock.h>
>>>
>>> @@ -254,6 +255,24 @@ void riscv_pmu_start(struct perf_event *event, int=
 flags)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf_event_update_userpage(event);
>>>  =C2=A0}
>>>
>>> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
>>> +static void riscv_pmu_disable(struct pmu *pmu)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_pmu *rvpmu =3D to_riscv_pmu(p=
mu);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rvpmu->sse_evt)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_disa=
ble_local(rvpmu->sse_evt);
>>> +}
>>> +
>>> +static void riscv_pmu_enable(struct pmu *pmu)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_pmu *rvpmu =3D to_riscv_pmu(p=
mu);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rvpmu->sse_evt)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_enab=
le_local(rvpmu->sse_evt);
>>> +}
>>> +#endif
>>> +
>>>  =C2=A0static int riscv_pmu_add(struct perf_event *event, int flags)
>>>  =C2=A0{
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_pmu *rvpmu =3D to_riscv=
_pmu(event->pmu);
>>> @@ -411,6 +430,10 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.event_m=
apped =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_event_mapped,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.event_u=
nmapped =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_event_unmapped,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.event_i=
dx =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_event_idx,
>>> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pmu_enable =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_enable,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pmu_disable =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_disable,
>>> +#endif
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.add =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_add,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.del =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_del,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.start =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D riscv_pmu_start,
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
>>> index 385af5e6e6d0..ac10ebd73c7c 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -17,6 +17,7 @@
>>>  =C2=A0#include <linux/irqdomain.h>
>>>  =C2=A0#include <linux/of_irq.h>
>>>  =C2=A0#include <linux/of.h>
>>> +#include <linux/riscv_sbi_sse.h>
>>>  =C2=A0#include <linux/cpu_pm.h>
>>>  =C2=A0#include <linux/sched/clock.h>
>>>  =C2=A0#include <linux/soc/andes/irq.h>
>>> @@ -1038,10 +1039,10 @@ static void pmu_sbi_start_overflow_mask(struct =
riscv_pmu *pmu,
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmu_sbi_=
start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>>>  =C2=A0}
>>>
>>> -static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>> +static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_ev=
t,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pt_r=
egs *regs, bool from_sse)
>>>  =C2=A0{
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct perf_sample_data data;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pt_regs *regs;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hw_perf_event *hw_evt;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0union sbi_pmu_ctr_info *info;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int lidx, hidx, fidx;
>>> @@ -1049,7 +1050,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, v=
oid *dev)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct perf_event *event;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ev_overflow =3D 0;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 overflow;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 overflowed_ctrs =3D 0;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpu_hw_events *cpu_hw_evt =3D dev;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 start_clock =3D sched_clock();
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_pmu_snapshot_data *sdat=
a =3D cpu_hw_evt->snapshot_addr;
>>>
>>> @@ -1059,13 +1059,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq,=
 void *dev)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Firmware counter don't support ov=
erflow yet */
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fidx =3D find_first_bit(cpu_hw_evt->=
used_hw_ctrs, RISCV_MAX_COUNTERS);
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fidx =3D=3D RISCV_MAX_COUNTERS) =
{
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csr_clear(CSR_=
SIP, BIT(riscv_pmu_irq_num));
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!from_sse)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return I=
RQ_NONE;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event =3D cpu_hw_evt->events[fidx];
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!event) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALT_SBI_PMU_OV=
F_CLEAR_PENDING(riscv_pmu_irq_mask);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!from_sse)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return I=
RQ_NONE;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>> @@ -1080,16 +1082,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq,=
 void *dev)
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Overflow interrupt pending bit sh=
ould only be cleared after stopping
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * all the counters to avoid any race cond=
ition.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * all the counters to avoid any race cond=
ition. When using SSE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * interrupt is cleared when stopping coun=
ters.
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_ir=
q_mask);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!from_sse)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALT_SBI_PMU_OV=
F_CLEAR_PENDING(riscv_pmu_irq_mask);
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No overflow bit is set */
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!overflow)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return I=
RQ_NONE;
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0regs =3D get_irq_regs();
>>> -
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_set_bit(lidx, cpu_hw_evt->u=
sed_hw_ctrs, RISCV_MAX_COUNTERS) {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct p=
erf_event *event =3D cpu_hw_evt->events[lidx];
>>>
>>> @@ -1133,18 +1136,65 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq,=
 void *dev)
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * TODO: We will need to stop the guest counters once
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * virtualization support is added.
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 */
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0perf_event_overflow(event, &data, regs);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ev_overflow |=3D perf_event_overflow(event, &data, regs);
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reset=
 the state as we are going to start the counter after the loop */
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_evt->=
state =3D 0;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0pmu_sbi_start_overflow_mask(pmu, overflowe=
d_ctrs);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ev_overflow || !from_sse)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmu_sbi_start_=
overflow_mask(pmu, overflowed_ctrs);
>>> +
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf_sample_event_took(sched_clock()=
 - start_clock);
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;
>>>  =C2=A0}
>>>
>>> +static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return pmu_sbi_ovf_handler(dev, get_irq_re=
gs(), false);
>>> +}
>>> +
>>> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
>>> +static int pmu_sbi_ovf_sse_handler(u32 evt, void *arg, struct pt_regs =
*regs)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpu_hw_events __percpu *hw_events =
=3D arg;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpu_hw_events *hw_event =3D raw_cpu=
_ptr(hw_events);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0pmu_sbi_ovf_handler(hw_event, regs, true);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>> +}
>>> +
>>> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sse_event *evt;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpu_hw_events __percpu *hw_events =
=3D pmu->hw_events;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0evt =3D sse_event_register(SBI_SSE_EVENT_L=
OCAL_PMU_OVERFLOW, 0,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmu_sbi_ovf_sse_handler, hw_even=
ts);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(evt))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR=
(evt);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sse_event_enable(evt);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sse_event_unre=
gister(evt);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info("using SSE for PMU event delivery\=
n");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0pmu->sse_evt =3D evt;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>>> +}
>>> +#else
>>> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;
>>> +}
>>> +#endif
>>> +
>>>  =C2=A0static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_n=
ode *node)
>>>  =C2=A0{
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_pmu *pmu =3D hlist_entr=
y_safe(node, struct riscv_pmu, node);
>>> @@ -1195,6 +1242,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *=
pmu, struct platform_device *pde
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpu_hw_events __percpu *hw_ev=
ents =3D pmu->hw_events;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct irq_domain *domain =3D NULL;
>>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pmu_sbi_setup_sse(pmu);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>> +
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (riscv_isa_extension_available(NU=
LL, SSCOFPMF)) {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_pm=
u_irq_num =3D RV_IRQ_PMU;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_pm=
u_use_irq =3D true;
>>> @@ -1229,7 +1280,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *p=
mu, struct platform_device *pde
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
ENODEV;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_percpu_irq(riscv_pmu_irq, =
pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D request_percpu_irq(riscv_pmu_irq, =
pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("=
registering percpu irq failed [%d]\n", ret);
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r=
et;
>>> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_=
pmu.h
>>> index f82a28040594..08fdcf6baf4e 100644
>>> --- a/include/linux/perf/riscv_pmu.h
>>> +++ b/include/linux/perf/riscv_pmu.h
>>> @@ -28,6 +28,8 @@
>>>
>>>  =C2=A0#define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
>>>
>>> +struct sse_event;
>>> +
>>>  =C2=A0struct cpu_hw_events {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* currently enabled events */
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n_events;
>>> @@ -54,6 +56,9 @@ struct riscv_pmu {
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*name;
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irqreturn_t =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(*handle_irq)(int irq_num, void *dev);
>>> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sse_event *sse_evt;
>>> +#endif
>>>
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cmask;
>>>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(*ctr_read)(struct perf_event *event);
>>> --
>>> 2.50.1 (Apple Git-155)
>>
>> We found that if RISCV_PMU_SBI_SSE is enabled, executing 'perf record -g
>> -F 999 ls' may occasionally fail. If the program is more complex, the
>> error occurs 100% of the time. After disabling RISCV_PMU_SBI_SSE, the
>> program runs normally. Therefore, we suspect there may be an issue with
>> the PMU_SBI_SSE functionality. Have you encountered this phenomenon? Do
>> you have any troubleshooting suggestions?
>
> I can reproduce the issue locally with PMU-SSE enabled, using
> `perf record -g -F 999`. This does look like a PMU-SSE issue. I am
> investigating the root cause now, and will follow up once I have a clear
> answer and a proper fix.
>
>> Below are some fault information=EF=BC=9A
>> [root@localhost ~]# perf record -g -F 999 ls
>> [ 9478.867438] BUG: spinlock bad magic on CPU#2, ls/1046
>> [ 9478.871534] Unable to handle kernel paging request at virtual address=
 ffffffc6004940d0
>> [ 9478.872804] Oops [#1]
>> [ 9478.873359] Modules linked in: xt_MASQUERADE xfrm_user xfrm_algo ipta=
ble_nat xt_addrtype
>> iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4
>> libcrc32c br_netfilter bridge stp llc overlay virtio_gpu virtio_dma_buf =
drm_shmem_helper
>> drm_client_lib drm_kms_helper nls_iso8859_1 drm drm_panel_orientation_qu=
irks backlight configfs efivarfs
>> [ 9478.877513] CPU: 2 UID: 0 PID: 1046 Comm: ls Not tainted 6.13.0-00006=
-ge94d0b11d044-dirty #7
>> [ 9478.878544] Hardware name: QEMU QEMU Virtual Machine, BIOS 2.7 2/2/20=
22
>> [ 9478.879324] epc : string+0x48/0xe6
>> [ 9478.880100] =C2=A0ra : vsnprintf+0xea/0x3b4
>> [ 9478.880697] epc : ffffffff809e39ae ra : ffffffff809e656e sp : ffffffc=
600493360
>> [ 9478.881331] =C2=A0gp : ffffffff81516480 tp : ffffffd68d280000 t0 : ff=
ffffc600493312
>> [ 9478.881952] =C2=A0t1 : ffffffffffffffff t2 : 6e697073203a4755 s0 : ff=
ffffc6004933a0
>> [ 9478.882557] =C2=A0s1 : ffffffffffffffff a0 : ffffffc6004934d7 a1 : 00=
00000000000000
>> [ 9478.883355] =C2=A0a2 : ffffffc6004934a8 a3 : ffffffc6004930d0 a4 : ff=
ffffc6004940d0
>> [ 9478.883988] =C2=A0a5 : ffffffc7004934d6 a6 : ffffffffffffe000 a7 : 00=
00000000000004
>> [ 9478.884600] =C2=A0s2 : ffffffc6004934d7 s3 : ffffffc6004934a8 s4 : ff=
ffffff80f24ea4
>> [ 9478.885420] =C2=A0s5 : ffffffff000000ff s6 : ffffffff8100153e s7 : 00=
00000000ffffff
>> [ 9478.886056] =C2=A0s8 : ffffffff8100153c s9 : 0000000000000007 s10: 00=
00000000000002
>> [ 9478.886859] =C2=A0s11: ffffffc6004935f0 t3 : 0000000000000004 t4 : ff=
ffffff80e592d8
>> [ 9478.887493] =C2=A0t5 : ffffffff8152cb20 t6 : ffffffc60049307a
>> [ 9478.887946] status: 0000000200000100 badaddr: ffffffc6004940d0 cause:=
 000000000000000d
>> [ 9478.888886] [<ffffffff809e39ae>] string+0x48/0xe6
>> [ 9478.889342] [<ffffffff809e656e>] vsnprintf+0xea/0x3b4
>> [ 9478.889795] [<ffffffff8007c2ce>] vprintk_store+0x108/0x3d2
>> [ 9478.890459] [<ffffffff8007d0ce>] vprintk_emit+0x82/0x218
>> [ 9478.890932] [<ffffffff8007d27a>] vprintk_default+0x16/0x1e
>> [ 9478.891416] [<ffffffff8007e270>] vprintk+0x1e/0x3c
>> [ 9478.892011] [<ffffffff8000332a>] _printk+0x32/0x50
>> [ 9478.892441] [<ffffffff80002f84>] spin_dump+0x5e/0x6e
>> [ 9478.892865] [<ffffffff80077bf4>] do_raw_spin_unlock+0x130/0x132
>> [ 9478.893542] [<ffffffff809f50e0>] _raw_spin_unlock+0x10/0x22
>> [ 9478.894031] [<ffffffff80166118>] filemap_map_pages+0x314/0x434
>> [ 9478.894541] [<ffffffff8019f6ea>] __handle_mm_fault+0x9ac/0xd50
>> [ 9478.895556] Code: 97aa a809 7463 00c5 0023 00d5 0505 2585 0663 00f5 (=
4683) 0007
>> [ 9478.896729] ---[ end trace 0000000000000000 ]---
>> [ 9478.897637] note: ls[1046] exited with irqs disabled
>> [ 9478.898653] note: ls[1046] exited with preempt_count 4
>>
>> [root@localhost x264]# perf record -g -F 999 ./x264 -o output_static.mkv=
 ./Kimono_1920x1080_24.yuv
>> --input-res 1920x1080 --fps 24 --preset faster --vbv-maxrate 2400 --vbv-=
bufsize 4800 --ref 1
>> --aq-mode 2 --aq-strength 1.2 --qcomp 0.8 --lookahead-threads 12 --iprat=
io 1.0 --bframes 3
>> --rc-lookahead 6 --crf 28 --keyint 60 --scenecut 0 --frames 200
>> [ =C2=A0 63.382672] Unable to handle kernel paging request at virtual ad=
dress 0000003feb0ff5d8
>> [ =C2=A0 63.383325] Oops [#1]
>> [ =C2=A0 63.383395] Modules linked in: xt_MASQUERADE xfrm_user xfrm_algo=
 iptable_nat xt_addrtype
>> iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4
>> libcrc32c br_netfilter bridge stp llc overlay virtio_gpu virtio_dma_buf =
drm_shmem_helper
>> drm_client_lib drm_kms_helper nls_iso8859_1 drm configfs drm_panel_orien=
tation_quirks
>> backlight efivarfs
>> [ =C2=A0 63.385401] CPU: 3 UID: 0 PID: 580 Comm: x264 Not tainted 6.13.0=
-00006-ge94d0b11d044-dirty #7
>> [ =C2=A0 63.385521] Hardware name: QEMU QEMU Virtual Machine, BIOS 2.7 2=
/2/2022
>> [ =C2=A0 63.385732] epc : walk_stackframe+0x5c/0x11a
>> [ =C2=A0 63.386470] =C2=A0ra : walk_stackframe+0xda/0x11a
>> [ =C2=A0 63.386537] epc : ffffffff80013b5c ra : ffffffff80013bda sp : ff=
ffffc600493a40
>> [ =C2=A0 63.386579] =C2=A0gp : ffffffff81516480 tp : ffffffd684b33300 t0=
 : ffffffd7febf9c20
>> [ =C2=A0 63.386617] =C2=A0t1 : 000000003b9aca00 t2 : ffffffd7febe8080 s0=
 : ffffffc600493a90
>> [ =C2=A0 63.386654] =C2=A0s1 : ffffffc600493ee0 a0 : 0000000000000001 a1=
 : ffffffff809f5a48
>> [ =C2=A0 63.386692] =C2=A0a2 : 0000000000000002 a3 : 0000003feb0ff5d0 a4=
 : ffffffffffffc000
>> [ =C2=A0 63.386729] =C2=A0a5 : 0000000000003fff a6 : ffffffff81552558 a7=
 : ffffffd698fb8000
>> [ =C2=A0 63.386769] =C2=A0s2 : 0000003feb100000 s3 : 0000003feb0ff5e0 s4=
 : ffffffff8001886a
>> [ =C2=A0 63.386806] =C2=A0s5 : ffffffc600493ac0 s6 : ffffffff809f5a48 s7=
 : 0000000000000000
>> [ =C2=A0 63.386844] =C2=A0s8 : ffffffc600493ac0 s9 : 0000000000000000 s1=
0: 000000000007fff8
>> [ =C2=A0 63.386886] =C2=A0s11: ffffffd698fb8000 t3 : 0000000000000015 t4=
 : 00000000000003e7
>> [ =C2=A0 63.386932] =C2=A0t5 : 0000000000452bf5 t6 : ffffffc600493f70
>> [ =C2=A0 63.386965] status: 0000000200000100 badaddr: 0000003feb0ff5d8 c=
ause: 000000000000000d
>> [ =C2=A0 63.387069] [<ffffffff80013b5c>] walk_stackframe+0x5c/0x11a
>> [ =C2=A0 63.387122] [<ffffffff80018902>] perf_callchain_kernel+0x28/0x34
>> [ =C2=A0 63.387154] [<ffffffff80160294>] get_perf_callchain+0x88/0x18e
>> [ =C2=A0 63.387189] [<ffffffff8015bcf2>] perf_callchain+0x52/0x6e
>> [ =C2=A0 63.387219] [<ffffffff8015c0f4>] perf_prepare_sample+0x3e6/0x730
>> [ =C2=A0 63.387249] [<ffffffff8015c8d6>] perf_event_output_forward+0x56/=
0xb8
>> [ =C2=A0 63.387280] [<ffffffff8015c51a>] __perf_event_overflow+0xdc/0x2e=
2
>> [ =C2=A0 63.387310] [<ffffffff8015d954>] perf_event_overflow+0x12/0x1a
>> [ =C2=A0 63.387341] [<ffffffff807e15e0>] pmu_sbi_ovf_handler+0x684/0x736
>> [ =C2=A0 63.387383] [<ffffffff807e16ee>] pmu_sbi_ovf_sse_handler+0x26/0x=
30
>> [ =C2=A0 63.387417] [<ffffffff807b73a0>] sse_handle_event+0x16/0x48
>> [ =C2=A0 63.387449] [<ffffffff8001933a>] do_sse+0x76/0xa8
>> [ =C2=A0 63.387478] [<ffffffff800195ac>] handle_sse+0xc0/0x162
>> [ =C2=A0 63.387748] Code: 7933 00e9 6463 0539 f693 0079 e2a1 e062 8693 f=
f09 (bc03) 0086
>> [ =C2=A0 63.388072] ---[ end trace 0000000000000000 ]---
>> [ =C2=A0 63.388547] Kernel panic - not syncing: Fatal exception in inter=
rupt
>> [ =C2=A0 63.388870] SMP: stopping secondary CPUs
>>
>> Regards
>> Yangsusheng
>>
>
> Thanks,
> Zhanpeng

Regards,
Zhanpeng
