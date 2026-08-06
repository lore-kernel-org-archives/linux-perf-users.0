Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA122FDE6
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018755; cv=none; b=C2uGSoudCR1MFXL/bDCY2UqyPceMQKEUBNy2jJkm8RMp21UohT8+UXkNu57+ZYJLs0yiRG3FBwySzQj2y+zLsiBSO9RAacJI+u6wc6ctVl7nNPB9bFFOBk2ulsSghFNNi3sW1d2cFePRLwFVbDGPXxqYNUiMmP/FUeSfUS2L6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018755; c=relaxed/simple;
	bh=fpArT6Kgkxs5eEj0qt6j9pTxpHESxl+X0uNDPHcaFGw=;
	h=Subject:Date:Message-Id:References:Content-Type:Cc:From:To:
	 In-Reply-To:Mime-Version; b=lq7TXCIZ3KZlft/+hOHNOO4z5OY2XeIWdGnl1mWme+6ghGWkrd1tXYSDsRkh/hbUWgWJ3YmflMEBGlSlEJlIf/4TzjJxyhCb8nNDrGazlqRojgHla2mRz63TbODUZOs6dO7FTFH+46ZQ7E6yLs1RfuVFrK/42ckxPi0AcEnbB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=qVF72ceJ; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="qVF72ceJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1786018622; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fpArT6Kgkxs5eEj0qt6j9pTxpHESxl+X0uNDPHcaFGw=;
 b=qVF72ceJ+cSkh2bvQAZjJB5uYyoxnM/laD6eJ6NjLqtk+XTFimQlez0BDG+DM9wgQ/KGbW
 26uEEKPeYV/ySgJTti60Ywi0P5dANDgTN0sj1couMKoJL+OCIUGs6QBWETmue7AaP1HeDu
 u/Og+1a16BQ/fkaKNWmIQGpW/Fm26wp2wjkYt7FKG63BKh2ye/anQqviXiA6vkgZrUEdvZ
 0uE54q3JAbj9XBw7Tgjm7FJv8Hj/POWSZCOUw7/nxwHhfM7IbyrjBCk2YlDIEnacL3W9fA
 Fp7/V+0OHFDpDwCNnvin4LCQ7QzgnmXFLeg9YPVJZg09yZANwX37D+w1ssvBOg==
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 14/22] RISC-V: perf: Implement supervisor counter delegation support
Date: Thu, 6 Aug 2026 20:16:57 +0800
Message-Id: <15b63bb1-ea29-42cd-905c-fbecc8423118@picoheart.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-14-7909f863a645@meta.com> <46cc0a87-a6cf-44d0-87d0-187ae8f6791e@picoheart.com> <12675382-8ef2-4dcb-9e12-bc9cf8cc46ab@linux.dev>
Content-Type: text/plain; charset=UTF-8
Received: from [100.86.222.180] ([61.141.241.101]) by smtp.feishu.cn with ESMTPS; Thu, 06 Aug 2026 20:16:59 +0800
Cc: <yang.yicong@picoheart.com>, "Jiri Olsa" <jolsa@kernel.org>, 
	"Paul Walmsley" <pjw@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, 
	"Rob Herring" <robh@kernel.org>, "Anup Patel" <anup@brainfault.org>, 
	"Namhyung Kim" <namhyung@kernel.org>, 
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Ian Rogers" <irogers@google.com>, "Will Deacon" <will@kernel.org>, 
	"James Clark" <james.clark@linaro.org>, 
	<linux-arm-kernel@lists.infradead.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<devicetree@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	"Conor Dooley" <conor@kernel.org>
From: "Yicong Yang" <yang.yicong@picoheart.com>
To: "Atish Patra" <atish.patra@linux.dev>
In-Reply-To: <12675382-8ef2-4dcb-9e12-bc9cf8cc46ab@linux.dev>
X-Lms-Return-Path: <lba+26a747b3c+502fb1+vger.kernel.org+yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird

On 8/6/26 10:00 AM, Atish Patra wrote:
>=20
> On 7/7/26 1:24 AM, Yicong Yang wrote:
>> On 7/1/26 4:47 PM, Atish Patra wrote:
>>> From: Atish Patra <atishp@rivosinc.com>
>>>
>>> There are few new RISC-V ISA exensions (ssccfg, sscsrind, smcntrpmf) wh=
ich
>>> allows the hpmcounter/hpmevents to be programmed directly from S-mode. =
The
>>> implementation detects the ISA extension at runtime and uses them if
>>> available instead of SBI PMU extension. SBI PMU extension will still be
>>> used for firmware counters if the user requests it.
>>>
>>> The current linux driver relies on event encoding defined by SBI PMU
>>> specification for standard perf events. However, there are no standard
>>> event encoding available in the ISA. In the future, we may want to
>>> decouple the counter delegation and SBI PMU completely. In that case,
>>> counter delegation supported platforms must rely on the event encoding
>>> defined in the perf json file or in the pmu driver.
>>>
>>> For firmware events, it will continue to use the SBI PMU encoding as
>>> one can not support firmware event without SBI PMU.
>>>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>> =C2=A0 arch/riscv/include/asm/csr.h=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 drivers/perf/riscv_pmu_sbi.c=C2=A0=C2=A0 | 578 +++++++++++++++++=
++++++++++++++++--------
>>> =C2=A0 include/linux/perf/riscv_pmu.h |=C2=A0=C2=A0 3 +
>>> =C2=A0 3 files changed, 478 insertions(+), 104 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
>>> index a3b24b88e401..cd22b5168689 100644
>>> --- a/arch/riscv/include/asm/csr.h
>>> +++ b/arch/riscv/include/asm/csr.h
>>> @@ -258,6 +258,7 @@
>>> =C2=A0 #endif
>>> =C2=A0 =C2=A0 #define SISELECT_SSCCFG_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x40
>>> +#define HPMEVENT_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 GENMASK_ULL(63, 56)
>>> =C2=A0 =C2=A0 /* mseccfg bits */
>>> =C2=A0 #define MSECCFG_PMM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ENVCFG_PMM
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
>>> index 2568c6808f5d..7995da4a98a1 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -28,6 +28,8 @@
>>> =C2=A0 #include <asm/cpufeature.h>
>>> =C2=A0 #include <asm/vendor_extensions.h>
>>> =C2=A0 #include <asm/vendor_extensions/andes.h>
>>> +#include <asm/hwcap.h>
>>> +#include <asm/csr_ind.h>
>>> =C2=A0 =C2=A0 #define ALT_SBI_PMU_OVERFLOW(__ovl)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0 asm volatile(ALTERNATIVE_2(=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> @@ -60,7 +62,20 @@ asm volatile(ALTERNATIVE(=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0 #define PERF_EVENT_FLAG_USER_ACCESS=C2=A0=C2=A0=C2=A0 BIT(SYSCTL=
_USER_ACCESS)
>>> =C2=A0 #define PERF_EVENT_FLAG_LEGACY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BIT(SYSCTL_LEGACY)
>>> =C2=A0 -PMU_FORMAT_ATTR(event, "config:0-55");
>>> +#define RVPMU_SBI_PMU_FORMAT_ATTR=C2=A0=C2=A0=C2=A0 "config:0-47"
>>> +#define RVPMU_CDELEG_PMU_FORMAT_ATTR=C2=A0=C2=A0=C2=A0 "config:0-55"
>>> +
>>> +static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, st=
ruct device_attribute *attr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char =
*buf);
>>> +
>>> +#define RVPMU_ATTR_ENTRY(_name, _func, _config)=C2=A0=C2=A0=C2=A0 (=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 &((struct dev_ext_attribute[]) {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { __ATTR(_name, 0444, _func=
, NULL), (void *)_config }=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 })[0].attr.attr)
>>> +
>>> +#define RVPMU_FORMAT_ATTR_ENTRY(_name, _config) \
>>> +=C2=A0=C2=A0=C2=A0 RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)=
_config)
>>> +
>>> =C2=A0 PMU_FORMAT_ATTR(firmware, "config:62-63");
>>> =C2=A0 =C2=A0 static bool sbi_v2_available;
>>> @@ -68,7 +83,11 @@ static bool sbi_v3_available;
>>> =C2=A0 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
>>> =C2=A0 #define sbi_pmu_snapshot_available() \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_branch_unlikely(&sbi_pmu_snapshot=
_available)
>>> +
>>> =C2=A0 static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
>>> +#define riscv_pmu_sbi_available() \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_branch_likely(&riscv=
_pmu_sbi_available)
>>> +
>>> =C2=A0 static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
>>> =C2=A0 =C2=A0 /* Avoid unnecessary code patching in the one time bootin=
g path*/
>>> @@ -83,19 +102,35 @@ static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_av=
ailable);
>>> =C2=A0 #define riscv_pmu_sbi_available() \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_branch_li=
kely(&riscv_pmu_sbi_available)
>>> =C2=A0 -static struct attribute *riscv_arch_formats_attr[] =3D {
>>> -=C2=A0=C2=A0=C2=A0 &format_attr_event.attr,
>>> +static struct attribute *riscv_sbi_pmu_formats_attr[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_SBI_PMU_FORMAT=
_ATTR),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &format_attr_firmware.attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
>>> =C2=A0 };
>>> =C2=A0 -static struct attribute_group riscv_pmu_format_group =3D {
>>> +static struct attribute_group riscv_sbi_pmu_format_group =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "format",
>>> -=C2=A0=C2=A0=C2=A0 .attrs =3D riscv_arch_formats_attr,
>>> +=C2=A0=C2=A0=C2=A0 .attrs =3D riscv_sbi_pmu_formats_attr,
>>> =C2=A0 };
>>> =C2=A0 -static const struct attribute_group *riscv_pmu_attr_groups[] =
=3D {
>>> -=C2=A0=C2=A0=C2=A0 &riscv_pmu_format_group,
>>> +static const struct attribute_group *riscv_sbi_pmu_attr_groups[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 &riscv_sbi_pmu_format_group,
>>> +=C2=A0=C2=A0=C2=A0 NULL,
>>> +};
>>> +
>>> +static struct attribute *riscv_cdeleg_pmu_formats_attr[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FOR=
MAT_ATTR),
>>> +=C2=A0=C2=A0=C2=A0 &format_attr_firmware.attr,
>>> +=C2=A0=C2=A0=C2=A0 NULL,
>>> +};
>>> +
>>> +static struct attribute_group riscv_cdeleg_pmu_format_group =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "format",
>>> +=C2=A0=C2=A0=C2=A0 .attrs =3D riscv_cdeleg_pmu_formats_attr,
>>> +};
>>> +
>>> +static const struct attribute_group *riscv_cdeleg_pmu_attr_groups[] =
=3D {
>>> +=C2=A0=C2=A0=C2=A0 &riscv_cdeleg_pmu_format_group,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
>>> =C2=A0 };
>>> =C2=A0 @@ -482,6 +517,14 @@ static void rvpmu_sbi_check_std_events(stru=
ct work_struct *work)
>>> =C2=A0 =C2=A0 static DECLARE_WORK(check_std_events_work, rvpmu_sbi_chec=
k_std_events);
>>> =C2=A0 +static ssize_t rvpmu_format_show(struct device *dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct dev_ext_attribute *eattr =3D container_of(at=
tr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct dev_ext_attribute, attr);
>>> +=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%s\n", (char *)eattr->var);
>>> +}
>>> +
>>> =C2=A0 static int rvpmu_ctr_get_width(int idx)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pmu_ctr_list[idx].width;
>>> @@ -599,6 +642,38 @@ static uint8_t rvpmu_csr_index(struct perf_event *=
event)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pmu_ctr_list[event->hw.idx].csr -=
 CSR_CYCLE;
>>> =C2=A0 }
>>> =C2=A0 +static uint64_t get_deleg_priv_filter_bits(struct perf_event *e=
vent)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 u64 priv_filter_bits =3D 0;
>> could we explicitly initialize the priv_filter_bits to MINH? though this=
 bit
>> is S-mode read-only and won't have any effects, but considering the sema=
ntic
>> is to inhibit counting at certain privilege mode, initialize it to MINH =
will
>> make it clear.
>=20
> Wouldn't that be confusing ? I feel we need a comment there as well to ex=
plain why
> are setting MINH in S-mode if we need that.
>=20

sounds reasonable. let's keep it as is.

>=20
>>> +=C2=A0=C2=A0=C2=A0 bool guest_events =3D false;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_E=
VENTS)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guest_events =3D true;
>> use attr::config1 to distinguish the KVM events looks incorrect. it's a =
user
>> visible interface and could be set explicitly by the user and break the
>> logic here.. e.g. perf stat -e cycles/config1=3D0x1/
>=20
> Reusing config1 for kvm guest events are already in upstream. As KVM is j=
ust another user of host perf driver, it is used. The config is event speci=
fic so a user specific event vs kvm initiated event would be separate anywa=
ys.
>=20
> But we can harden the interface with additional check using this which wa=
s exclusive to perf_event_create_kernel_counter which
> kvm invokes[1].
>=20
> event->owner =3D TASK_TOMBSTONE;
>=20
> [1] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L1=
4324
>=20

makes sense. there's a is_kernel_event() wrapper but currently is local
there in the event core (so is TASK_TOMBSTONE).

but yes it's not introduced by this patch.

>>> +=C2=A0=C2=A0=C2=A0 if (event->attr.exclude_kernel)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv_filter_bits |=3D guest=
_events ? HPMEVENT_VSINH : HPMEVENT_SINH;
>>> +=C2=A0=C2=A0=C2=A0 if (event->attr.exclude_user)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv_filter_bits |=3D guest=
_events ? HPMEVENT_VUINH : HPMEVENT_UINH;
>>> +=C2=A0=C2=A0=C2=A0 if (guest_events && event->attr.exclude_hv)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv_filter_bits |=3D HPMEV=
ENT_SINH;
>>> +=C2=A0=C2=A0=C2=A0 if (event->attr.exclude_host)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv_filter_bits |=3D HPMEV=
ENT_UINH | HPMEVENT_SINH;
>>> +=C2=A0=C2=A0=C2=A0 if (event->attr.exclude_guest)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv_filter_bits |=3D HPMEV=
ENT_VSINH | HPMEVENT_VUINH;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return priv_filter_bits;
>>> +}
>>> +

[...]

>>> +static void rvpmu_deleg_ctr_enable_irq(struct perf_event *event)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long hpmevent_curr;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long of_mask;
>>> +=C2=A0=C2=A0=C2=A0 struct hw_perf_event *hwc =3D &event->hw;
>>> +=C2=A0=C2=A0=C2=A0 int counter_idx =3D hwc->idx;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long sip_val =3D csr_read(CSR_SIP);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!is_sampling_event(event) || (sip_val & SIP_LCO=
FIP))
>> we should also consider overflow for counters of non-sampling events..
>=20
> This is intentional. As per the sscofpmf, OF bits as a interrupt disable =
and overflow indicator.
> So we need to clear the bit if you need the interrupt for the sampled eve=
nts.
>=20
> For non sampled events, that is not necessary. But If it overflows, it sh=
ouldn't raise an interrupt.
>=20

okay I see the existing interrupt handler skip the non-sample events as wel=
l
so it's the current policy of the driver. but generally we should handle
the overflow of non sampled events as well to avoid count lost if the count=
er
is implemened less than 64bit. in such case it's possible to overflow
several times for a long counting period.

it's also another thing not introduced by this patch so we may keep the han=
dling
here as is.

thanks.
