Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D593F660F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663654; cv=pass; b=OmdwvwhehBFztECcEyDIzMbyxpf2QDlKDLSASP4wD6Rxo1DVd4Osz8yV6hrCRu7zESkjfnYspetn5pcmeTih472iSu2n5ZwdC75ZQf8tEYpIplM/vxdFqIMVsYx8s/+cOJloP76fisnx9n7OIHKT6Nb9ikDb+jExbjlU5kte9q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663654; c=relaxed/simple;
	bh=Qv3D0ifCoU1cVtll8Kt0HJNF9O5SOerLBS42AIsT0sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGnK9vAkcJVrTgN7Jt0hEnea5QPVAsDhaNsRMBta/XmuLbDXo6HwpMKoFkd184v/pRLE0aT3fVBiNKWEW8RuN8TEBOzpS80HQl3pUIyPFLpNLA/RPiCJ4dJU+0bybCrmDDgkN8sHvMbSQsrDuGoKojCW4uyi9Y0FaN02UrTjEjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pyu6VlIJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W84FNIqu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pyu6VlIJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W84FNIqu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PD7OSt3062824
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 13:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f5rJuoLCWO7KVfDNBoBfeBkBYsbNKNweb2IqmkGw9Bg=; b=pyu6VlIJDgoiFSrO
	uNnwDnUX4Lzccl9YZsw0xp9VrU2OJ29gP0L3sAbjy9OGmyp6eNEg8hkOw7JRdHn7
	iys6P229QtFBi18hf7B6LariH0HDFRCLekqVrp4BmXtaM98pkREZezaQqb82XMvM
	zXfE20rjgThbmRUnxwoXypC8ZaZyh/NJayKJblM+rxZuYC6dSW2LewzHtHtlgh2b
	TwtDivZAP5pOYt3S/IsJoRkxghCxwddUt35dKYU2BDUQeMh9/T6X8Prh2LtVBTul
	jyh6lpmb8yPClB7NOCPl/K8vyml4wNM2RsF2zSOwQvnmgP0IBaiAzvYS+RaAsioY
	TOe9SA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnj80xv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 13:14:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so7678893a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787663648; cv=none;
        d=google.com; s=arc-20260327;
        b=j9LV+xl/o3GtlzN3YbQFEE/NFn7wd1sjNfXxvPhZ/TSWPost8muakdNcE8ezEW1+8m
         PgmV88iTqTVUVnOFi+IZOVfzN/yFiOr7IG9Sxqxyqmo71BGr2Nf3pIfGsXSqLvWuN929
         i5kYG6kfn2DVwncIH+ZsDYl+sAPuwWMRgvLpI8aOcDFTQUvxfObEk6kNBPyavqmpjkhg
         s6h0JhKYKNqZWR55K6I+74RPPTNaizzXpr6ErwmD4IltianvbJCbgSxqdomP0N7F/Cb1
         AAL4DwRMazoC87LcsrdGtxHTbSDxAcB+UE3BChd1+KI4clGkKoh4onU2gcM+LNgu+vrg
         ax3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f5rJuoLCWO7KVfDNBoBfeBkBYsbNKNweb2IqmkGw9Bg=;
        fh=7/lVR4S2p2XULGeq+1vrL5zcnQRDUTtaMN5spV1rilw=;
        b=JrpchvkYQDDZl7du1g9whKKabTUxPOWGwk7Dd4GsfIW2kYlFq8f+/dKtevjCcnfL/M
         1M38oOqyTWWH5nwhMYz9LWz8XIXdBQMzBi68z0wgzF1Z02LSz6XaV+zqEQRV6rh03R12
         /j/CnFu/AIo9lkRFnS/YUmkSDVDsYLhm0nMMQAYHVYmqEPfAUrBzYxDhT04tNZFUY9DQ
         OGNLPUH/n3/fx3iYeQ+qaeqdF1122jQuVyI9Aex8h0smPoPdeO5jlpTFX+9pItiryHC2
         L+d6T6VA2lJ4z2KQbmrUCNTOIJe4C3HzP01/vfYgvtLwvjA+9kDSuGG8KaN2UN3Em8Ay
         8wtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787663648; x=1788268448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5rJuoLCWO7KVfDNBoBfeBkBYsbNKNweb2IqmkGw9Bg=;
        b=W84FNIquhK6jWkf0PH7QF/JcJHxcFK89Fg9L1Zt8vCqfc2WQq6eTCMPVEpsJi0Nzb+
         yiHXlj/JE29J5ej3Tz1dK6ngD5yiECbAiO+S1glkhCMB0Jjhg+oHOQpxjXUl+VFPSBzq
         9TKso3ncfiT8A4vo2W6+fbDGf+oedkZ5RV8uZykgIZcltSkAlUlKl4azZrFjGY8e+faa
         xdwZnqmJ1bxRVbBG2U6hYAQWcF7sHo9tks22nsme7h3T1Bk1IWooyRdNqndTpUPcf0R/
         ry1bo7mpZ1y6RnZXuz18/sm9QMaAhfVfZ2CVlWCvHJe602mCEpX1bkvz+On/lkwYTC0t
         kqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663648; x=1788268448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5rJuoLCWO7KVfDNBoBfeBkBYsbNKNweb2IqmkGw9Bg=;
        b=JOZjpbNaff9eQYJaZdmpdWQbXakgoFrUtwIW0u1A17MPvNgd0FO1Kc+cQuJCjEEFER
         46QZi9U6Snau6RCRarnR+uoog4FrGAwRwg68TS1lt8T4A9jaCY7jyEIchR3IQkBCqr3F
         dNWFjdB87ZgsKL0Qd7/ZdA9nCot2PN+5q6UlyUQtSPzYdAjts15ooUK276Dj/yCTdNi1
         DSbJQqbzpzqbgDy8YPeWEhbDaBD3kw4gN6VrAR0jqSvTQy7Ux/NiLqmairuQNT0k1uDc
         7kE/525isP01eWkdnZAxEt4d9CloJGauTccQMGULq9kLpF1/gY9b3DGYvDkR0U5vTFRR
         Dm2g==
X-Forwarded-Encrypted: i=1; AHgh+RpVeHEkD/cKT5Lf4O0iLxhMR45ZS4pUQzUlQt7qrqJgevptB62WKdXYGcuVi2RpEGxsCK/9Az6ZH8atPnJC4lsq@vger.kernel.org
X-Gm-Message-State: AFuF++lt2ptU2THPZ2UkNMgwjuLDbe83w+IYP60h0PFqK7QfYQ9s/1Su
	WrsiW3ow674cCjgVaeclWhjFVpStvRh1L/pe0vg5/IzAR5VMJWSwgrkvhy2P8OudGpNNE3c6v1K
	NDgJrYaQFZiXvoAggqVdmv0IUuQSSHlQUW08jcOIIMb21fULJOKxW6Hear860+Bj2aF8za7YIdO
	HZc7Kb3BeNM7ArSFTSFNOrL/rQFgHx+LT+F9HDhwG1SfCpUM0=
X-Gm-Gg: AR+sD10h6Zoql8Y8+xT2crAkN7SKUsd3Gi2gBkH4rdrSeYG+eNMXOuLCXQB7GOBrQzQ
	LH9+pz3rSoIxOn946pH0AKXqyizazBTRxlT6jQbrpYPBZFaHmm2FRmh8nMOTXA/dGFvTqp6L43j
	o5sdNYwLbSMiwULKm4Rvc3uzaJm6+s/QdyPiuLxoRyRVGvUKmOIr2JJ4sJm58=
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-395c33d786amr67081335a91.2.1787663648405;
        Tue, 25 Aug 2026 06:14:08 -0700 (PDT)
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-395c33d786amr67081169a91.2.1787663647756; Tue, 25 Aug 2026
 06:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
 <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com> <c30e91d3-514a-4fef-8b61-e1744f577d35@amd.com>
In-Reply-To: <c30e91d3-514a-4fef-8b61-e1744f577d35@amd.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 18:43:54 +0530
X-Gm-Features: AcwNN1XGeK3kKeeesL0CAGDbwc6gJUoKnhOVO6Mm-4cXkc72U05QOEit2B_T6As
Message-ID: <CAHuiULC-Z+pqKsMKMPX8emnN4tz9Div7_9c-QGZ9-L_Ef21dEg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] perf/riscv: Use Sspesa for precise sample attribution
To: Sandipan Das <sandipan.das@amd.com>
Cc: Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ZNadH8Guh_w7fvey3uG15J1lyjwtwGeP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExMSBTYWx0ZWRfX+nlyD3hNndek
 imEKwGPxlhwHoh6szZXqJoE6xywTPeAN4K6mu9gFax8ZkLixzkd9pKIO7ZnOJPhc0wocGwRAkeK
 BVyL/JzbUIgI4BoOIzy4h3v1G+Lk6aoqLTuE1ydxtzqvkmOTQVEIYWay6el0eOzF448TVKUk7XI
 fcKBrAOs8CGbaRC4iHsCAg1P97QdNiyvJYWHogdJ39TX5kBLC1Y6SDzKAZWgbJkuHgu1MnwKD9c
 H96qzkmtfdsnfWE6MazrDbdgluoWcf7t7k2Qi158YIXFRpMrp64hjFlkhGWKgyOeSCO7sPIpDmm
 buJEpwI9B7ywRJKDhfT5BWNO2JfKDYclUJFBgeN+d+Eus/ol9NkHVczgkzsPd6IjYLbOooWJa0c
 56bCMt9gB8+3e/sopG1DmHiGjjX5IuQL/BZhdBIs44sEz1D2/uvjv9fCqHh6umeUsilCkkp+1Nr
 E7bgGWwNAsGN/smXAnQ==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8d9521 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=8lNz-84GcgrwCALWT8sA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExMSBTYWx0ZWRfX8/lmY8u8K6bH
 Ah4JhbvvrskL0qrALoxJ9nexUOVA7KGkPDMLndPll3mwKH+uWKfWP7TmFF7rMgNTM37DEu38zM2
 /G7hF5k048oDLPGz8wkdB+vWhuDxaJQ=
X-Proofpoint-ORIG-GUID: ZNadH8Guh_w7fvey3uG15J1lyjwtwGeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250111

On Thu, Aug 20, 2026 at 3:51=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> On 17-08-2026 21:32, Mayuresh Chitale wrote:
> > When the Sspesa (Precise Event Sample Attribution) extension is
> > available and a counter overflows, the hardware records a sample PC in
> > shpmspc register and the counter ID and additional implementation-defin=
ed
> > data in shpmsdata register.
> >
> > In the SBI PMU overflow handler, use shpmspc to report sample PC via
> > PERF_SAMPLE_IP for the counter that caused the overflow. Shpmsdata is
> > exported as raw data to userspace when events request PERF_SAMPLE_RAW
> > sample type and it assists in deriving the sample PC from shpmspc if
> > precise attribution is not supported for the event.
> >
> > If sspesa is not available or for counters that don't match
> > shpmsdata.CNTRID, fallback to epc for PERF_SAMPLE_IP.
> >
> > Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index dfc886dee5ad..1b0b1cc612de 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -63,6 +63,8 @@ PMU_FORMAT_ATTR(firmware, "config:62-63");
> >
> >  static bool sbi_v2_available;
> >  static bool sbi_v3_available;
> > +static bool sspesa_available;
> > +
> >  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> >  #define sbi_pmu_snapshot_available() \
> >       static_branch_unlikely(&sbi_pmu_snapshot_available)
> > @@ -1051,6 +1053,11 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, =
void *dev)
> >       struct cpu_hw_events *cpu_hw_evt =3D dev;
> >       u64 start_clock =3D sched_clock();
> >       struct riscv_pmu_snapshot_data *sdata =3D cpu_hw_evt->snapshot_ad=
dr;
> > +     unsigned long sample_pc =3D 0;
> > +     unsigned long sample_data =3D 0;
> > +     int sample_cntrid =3D -1;
> > +     u64 raw_sample;
> > +     struct perf_raw_record raw =3D { 0 };
> >
> >       if (WARN_ON_ONCE(!cpu_hw_evt))
> >               return IRQ_NONE;
> > @@ -1088,6 +1095,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, =
void *dev)
> >               return IRQ_NONE;
> >
> >       regs =3D get_irq_regs();
> > +     /*
> > +      * Sspesa records the PC and metadata of the overflowing counter =
in
> > +      * hardware. The PC is precise only for events that support preci=
se
> > +      * attribution; otherwise it is best-effort.
> > +      */
> > +     if (sspesa_available) {
> > +             sample_pc =3D csr_read(CSR_SHPMSPC);
> > +             sample_data =3D csr_read(CSR_SHPMSDATA);
> > +             sample_cntrid =3D sample_data & SHPMSDATA_CNTRID;
> > +     }
> >
> >       for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTE=
RS) {
> >               struct perf_event *event =3D cpu_hw_evt->events[lidx];
> > @@ -1123,6 +1140,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, =
void *dev)
> >               riscv_pmu_event_update(event);
> >               hw_evt->state |=3D PERF_HES_UPTODATE;
> >               perf_sample_data_init(&data, 0, hw_evt->last_period);
> > +             if (sspesa_available && hidx =3D=3D sample_cntrid) {
> > +                     data.ip =3D sample_pc;
>
> Does this need to be tied to event->attr.precise_ip?
I think there is no need to tie usage of sample_pc itself to
precise_ip as the sample_pc obtained from shpmspc is more precise than
epc. But yes, we need to tie the setting of PERF_RECORD_MISC_EXACT_IP
flag to precise_ip =3D=3D 3 and ssplcofi extension being available. I will
do it in v2.
>
> > +                     data.sample_flags |=3D PERF_SAMPLE_IP;
> > +
> > +                     raw_sample =3D sample_data;
> > +                     raw.frag.size =3D sizeof(raw_sample);
> > +                     raw.frag.data =3D &raw_sample;
> > +                     perf_sample_save_raw_data(&data, event, &raw);
> > +             }
> >               if (riscv_pmu_event_set_period(event)) {
> >                       /*
> >                        * Unlike other ISAs, RISC-V don't have to disabl=
e interrupts
> > @@ -1194,6 +1220,9 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *p=
mu, struct platform_device *pde
> >       struct cpu_hw_events __percpu *hw_events =3D pmu->hw_events;
> >       struct irq_domain *domain =3D NULL;
> >
> > +     if (riscv_isa_extension_available(NULL, SSPESA))
> > +             sspesa_available =3D true;
> > +
> >       if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
> >               riscv_pmu_irq_num =3D RV_IRQ_PMU;
> >               riscv_pmu_use_irq =3D true;
>
