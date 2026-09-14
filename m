Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCA49C4AD
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408968; cv=none; b=Y5+Ay6bw7dVFHuJRmVjcN83lrrzRwDq9oLvW9B80x/uojR3Ss3dK1M1SqkbclJz8CftWNL1mzcBWEW5psZZaChnaxkyEIfSMmSWZkr+9dTDsEsqU5OJLS/MD0UKmIFL8gKbnCP7HiAPANY9oG5xxZa0yVLH3jM+5kndDVtgw/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408968; c=relaxed/simple;
	bh=Eun3S0vj00XErBU/dF1hMB0S3ALYliogK+HZAFfwHks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpmRTlkSHM4LRYWHTZkLMUb1z6pa/lhAmpJPrtXZKZuFDpyNgrZ+6csT7Wd9arttFV3/h6cXbP/M3z9wp0ytFPs/QnRtVpRfX7K8oIE7+orHqRjdO97JuT08J0LqMcV1SLbOhCCIODblbDoEOGbi0jTMxav1qQojl3P5vSOgSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns7fR8LR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns7fR8LR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A2E1F00893;
	Mon, 14 Sep 2026 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789408965;
	bh=t3fTZPD/ZwLbsdaRuh3OTkKab0Y9NbtTTqMcPnN0LqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ns7fR8LRUp2G95DcpcIpvua6fS/mOpdfYl/HLsnRIeVyJVqRaGI+VFXOBoQTVLCRM
	 HJySLVgwin69rrG2QLgXY3Cn8j20dwZ+RawcEZf7oR1DvojXyU80t4EHLHej3zbW1o
	 VP6bSn3C/4xJlPaGQcsbaZNPf4wLaSK7noZVz5lYlI1DcZD9GRcUFAtUzT33Nfrel2
	 9Gzfccp6rFQ6h8zNEUAmp3C72wyZzWxMhM1J5peES4XotTnIlsV74qgq0nl1vCJDFr
	 sArb0yAB9AvVJ+DMXmw00rDbN3nGBiAbAtzB4QmKZDRH5IxXe5hykz3rZkCwlsU91B
	 deJfmqJ237yEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix multi-filter encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <03f15158e4c0a036f41cb4ab34c138a265c0730c.1789408253.git.robin.murphy@arm.com>
References: <03f15158e4c0a036f41cb4ab34c138a265c0730c.1789408253.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:02:45 +0000
Message-Id: <20260914180245.71A2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Broken Multi-Filter Detection / Dead Code
- [High] Error Handling / Reference Count Corruption
--

commit fec40d747e8bd7f98185ffd85e0e2e426200c368
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Mon Sep 14 17:50:53 2026 +0000

    perf/arm-cmn: Fix multi-filter encoding

This patch reorders the programming of multi-filters for EVICT_STATE_SEL
events so that they match the logical order based on their bitfield
positions, updating the UABI to align with the CMN S3 r2 TRM.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 33ee2be9b3864..b1eabd1ac0d61 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -1014,13 +1018,9 @@ static umode_t arm_cmn_event_attr_is_visible(struc=
t kobject *kobj,
>  	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_ENHANCED_HBT_LBT_SE=
L, 5), \
>  	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_ENHANCED_HBT_LBT_SEL=
, 6)
>  #define CMN_EVENT_HNS_EVICT(_model, _name, _event)			\
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_all, _event, SEL_EVICT_STATE_SEL, 0=
), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_eu, _event, SEL_EVICT_STATE_SEL, 1)=
, \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_en, _event, SEL_EVICT_STATE_SEL, 2)=
, \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_su, _event, SEL_EVICT_STATE_SEL, 3)=
, \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_sn, _event, SEL_EVICT_STATE_SEL, 4)=
, \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_mu, _event, SEL_EVICT_STATE_SEL, 5)=
, \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_mn, _event, SEL_EVICT_STATE_SEL, 6)
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_all, _event, SEL_HBT_LBT_SEL, 0), \
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_hbt, _event, SEL_HBT_LBT_SEL, 1), \
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_lbt, _event, SEL_HBT_LBT_SEL, 2)

[Severity: High]
Does this change effectively make the dual-filter logic unreachable?

By passing SEL_HBT_LBT_SEL as the primary filter selector here, it becomes
assigned to hw->filter_sel during event initialization.

The internal validation and configuration logic across arm_cmn_val_add_even=
t(),
arm_cmn_validate_group(), and arm_cmn_set_event_filter() all check if the
selector is SEL_EVICT_STATE_SEL to configure the secondary filter:

    if (sel =3D=3D SEL_EVICT_STATE_SEL) {
        val->filter[dtm][sel] =3D CMN_EVENT_FILTER2(event) + 1;
        sel =3D SEL_HBT_LBT_SEL;
    }

Since the primary selector is now SEL_HBT_LBT_SEL, these checks will always
evaluate to false, meaning the driver will treat these as standard
single-filter events and the secondary filter will never be validated or
programmed to the hardware.

[ ... ]

> @@ -2081,16 +2086,19 @@ static void arm_cmn_event_clear(struct arm_cmn *c=
mn, struct perf_event *event,
>  static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf=
_event *event)
>  {
>  	enum cmn_filter_select fsel =3D to_cmn_hw(event)->filter_sel;
> +	bool evict_state =3D fsel =3D=3D SEL_EVICT_STATE_SEL;
>  	int ret =3D 0;
> =20
> +	if (evict_state) {
> +		ret =3D arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER2(event));
> +		fsel =3D SEL_HBT_LBT_SEL;
> +	}
>  	if (fsel)
>  		ret =3D arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
> =20
> -	if (fsel =3D=3D SEL_EVICT_STATE_SEL && !ret) {
> -		ret =3D arm_cmn_set_event_sel_hi(dn, SEL_HBT_LBT_SEL, CMN_EVENT_FILTER=
2(event));
> -		if (ret)
> -			dn->filter[fsel].count--;
> -	}
> +	if (ret && evict_state)
> +		dn->filter[SEL_EVICT_STATE_SEL].count--;
> +
>  	return ret;
>  }

[Severity: High]
If we assume the macro bug above is fixed and evict_state can be true,
does the error handling here mask failures or corrupt the reference count?

If the first arm_cmn_set_event_sel_hi() call fails (e.g. returning -EBUSY),
it does not increment the count for SEL_EVICT_STATE_SEL.

The code then unconditionally proceeds to the second call of
arm_cmn_set_event_sel_hi() since fsel is now SEL_HBT_LBT_SEL. If this
second call succeeds, it will overwrite the error in ret with 0, silently
ignoring the first failure.

If the second call also fails, ret remains non-zero. The rollback block then
decrements dn->filter[SEL_EVICT_STATE_SEL].count. Since the first call fail=
ed
and never incremented this count, could this decrement an unrelated active
event's reference or cause this unsigned bitfield to underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/03f15158e4c0a036f41=
cb4ab34c138a265c0730c.1789408253.git.robin.murphy@arm.com?part=3D1
