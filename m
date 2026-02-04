Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE2285CA8
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Feb 2026 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176536; cv=none; b=HmEHbv4U+ee3x89u+OE0YUWzhY8xqgU+M/xwq5ugcpdqyfvUFDsaNiLUG+amkdtIzObXorrjq8i6DBlvm2Pn0dOB/kH+PZzlYqa+GmGM6qJBjunEDUqKevPfE7PREC920uO0UrmbJNOYL8h3Y4ZaDySPMqqlj9tfjWSxwfnz3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176536; c=relaxed/simple;
	bh=360Rcy6dePifZPSzcxt7hGQPUguGtAHisH7DTa8ImUE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=PvP3s2NckyXEtaClSixAYixH8ZZBC/pzwf2chuBms7vIDtmYR4zk+uk1BuzUfXd6KwuD2UaEdOgfs/b/ydYU7Y47nGUZzpE2T3JowRJwO67TupwZJJNOD4g1BmmpPj6bTbCc9QGxFjNhkacQLv6NQnWV+TwPKzbufto9M9xNyrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/2Y3N7s; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/2Y3N7s"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a929245b6aso13217415ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 19:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770176534; x=1770781334; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxaGgiCs5zBYpfLxe5C7ES0aKYY8NFq6Tb6uEQsWDRI=;
        b=L/2Y3N7sJeTJgylC+a9IOulTcsAvdfJzyBDS/DBD/zOtgUJuU8ZSn1VbCluALH19aj
         sf2ePAxToCTXjyrT0mGnay777qQmzvIi/nICdHjEMFSz/t9Mu09cL9twp6V8J2IBGSCu
         o19ZheXP/f8kmy2AAq/1PpAFr3AxAjEtQKmWw6p7IyTKYrlOuBVX9ena4Av5Ud4Y3Hgv
         Q70gFKn+l5qSpJhDuPNW40XQXFAOeFwqONy1qKpMl6+dYKgbBWmWS0w6/sa8pKGINhLL
         yBvTLQiabOJxUy/nIWps/gNaTFDknILxzM7RnAf7PLTk5wDBOO++IF+IpSMvIFn+qLTE
         pKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770176534; x=1770781334;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uxaGgiCs5zBYpfLxe5C7ES0aKYY8NFq6Tb6uEQsWDRI=;
        b=s0OXWJyFOctemsSIdNqAXnVmhXf7hVvg6xi4g19iEuGO+wuLAoucf9qssJC7VTe9Gh
         dmT3kd6fkjb6e8DEwnYgA3eNXY5Xvf0FlBi/oDB9NaRR8/9nNzeYa0iBe9jxSWuP5Rde
         tgiD3dH/jpTfDMTJ+qw3ueX38eYA0d3o+DZMpaVxC5hErZPSedbBarbIY6biPXz7bkGH
         aS+jA96wh+uwwasQQGnT7vMlCttD303VuXLECgMG4TAfp0F4RnN1Zc4lqmSrMK57Jq86
         1VHY97R+z752JmeCoisLTcfKZu8Tt+6dwg6/lUFskuEL8fx4Sx5dlRzI14wJDUuaAljb
         z5NA==
X-Forwarded-Encrypted: i=1; AJvYcCXttjlG0kcKiCMlhJlYcKRbLOcCN8euO44PhQovYgTKdrKSWl+MujhUZrbSNCyON9GJIYg+ToBlaXRrTOrBA0Il@vger.kernel.org
X-Gm-Message-State: AOJu0YwvkaGix4s9Aoyw/55ovAktxZoWqQoj/elDRNpVHITibZ+RSANl
	bMGapoPWPNrMTm16D+RErvvbUma36Fap2NQNShL23plSFgZ4tKLGpIQ3
X-Gm-Gg: AZuq6aJTCWvpTsTlFI/Oo7XIG3r8EKRdlzHhHFq10o0dpzPSTvU/A1CSNJXeJziTVId
	NzwKAB1YBk4Nh7WNulhz0zEL/BH6cUJW8X+cQg+cFTblrc3m4JAuWIC/wXY5kWFBvy7o4jwLcyU
	jaNZWEiFF+v0bzEGRwqR6O17ywBfhoJ2OngueVdXF6noiewyMymuHqPG784iiwCDzkTht+r3xdS
	kB8Fk/fCbYCWnJjcizDCefjHDy5irapJLnMHYruRyvqqTl9/ZBZ0GqW161UfJBXlfevfegCEvGP
	HHFxJe5vxHcP5hirA9Kne6JlCmXT/qiIeu13MZdpx6bFOuMH4M3Knoi62AciO8a/rCqyuemvB43
	Wa4LzmVDgOWdG6p09EhppVqaCUsudTsc2LBq+DeJfDOI9JU2jBbn+D/rRE7HU2ZEyJGCU75FYA8
	uYULXkcZl7rlJvFsa25VWgieAU1zaUAwQ/I4UveVXDqDPCXKY=
X-Received: by 2002:a17:903:228e:b0:2a7:5dbc:ed69 with SMTP id d9443c01a7336-2a933e42981mr16684595ad.27.1770176534174;
        Tue, 03 Feb 2026 19:42:14 -0800 (PST)
Received: from smtpclient.apple ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397cb23sm8257695ad.93.2026.02.03.19.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 19:42:13 -0800 (PST)
From: qingwei hu <huqingwei.kernel@gmail.com>
X-Google-Original-From: qingwei hu <qingwei.hu@bytedance.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] RISC-V: Skip stopping cycle counter
Message-Id: <5A50DBFA-261B-4C12-9291-4FA0190FCC13@bytedance.com>
Date: Wed, 4 Feb 2026 11:41:59 +0800
Cc: alex@ghiti.fr,
 anup@brainfault.org,
 aou@eecs.berkeley.edu,
 atish.patra@linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 mark.rutland@arm.com,
 palmer@dabbelt.com,
 pjw@kernel.org,
 qingwei.hu@bytedance.com,
 will@kernel.org
To: andrew.jones@oss.qualcomm.com
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hi Drew,

Thanks for the heads-up.

Yes, Chen Pei=E2=80=99s patch got there first, and I noticed it also =
avoids stopping
`TIME` and `INSTRET`. I=E2=80=99ll follow up there if I have any =
comments or test
results to share.

Thanks,
Qingwei

On Wed, Feb 4, 2026 at 8:38=E2=80=AFAM Andrew Jones =
<andrew.jones@oss.qualcomm.com> wrote:
>=20
> On Mon, Feb 02, 2026 at 07:17:28PM +0800, qingwei.hu wrote:
>> From: Qingwei Hu <qingwei.hu@bytedance.com>
>>=20
>> In the riscv_pmu_sbi driver, pmu_sbi_stop_all() is intended to stop
>> all available counters. However, counter 0 (the cycle counter) should
>> be excluded from this operation because the counter may be used in
>> user mode by rdcycle.
>=20
> Hi Qingwei,
>=20
> It looks like Chen Pei beat you to this[1], but that patch also avoids
> stopping TIME and INSTRET.
>=20
> [1] =
https://lore.kernel.org/all/20260131112440.2915-1-cp0613@linux.alibaba.com=
/
>=20
> Thanks,
> drew
>=20
>>=20
>> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
>> ---
>> drivers/perf/riscv_pmu_sbi.c | 10 +++++++---
>> 1 file changed, 7 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/perf/riscv_pmu_sbi.c =
b/drivers/perf/riscv_pmu_sbi.c
>> index 7dd282da67ce..2bc0050dabd2 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -900,11 +900,15 @@ static int pmu_sbi_get_ctrinfo(int nctr, =
unsigned long *mask)
>> static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
>> {
>>     /*
>> -      * No need to check the error because we are disabling all the =
counters
>> -      * which may include counters that are not enabled yet.
>> +      * No need to check the error because we are disabling all =
available
>> +      * counters (except the cycle counter) which may include =
counters
>> +      * that are not enabled yet.
>> +      *
>> +      * Cycle counter is excluded because it might be accessed by =
user
>> +      * mode via rdcycle.
>>      */
>>     sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
>> -               0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
>> +               0, pmu->cmask & ~BIT(0), SBI_PMU_STOP_FLAG_RESET, 0, =
0, 0);
>> }
>>=20
>> static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
>> --
>> 2.39.5
>>=20
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
