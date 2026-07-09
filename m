Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B66399360
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616999; cv=none; b=L+mGoTkuANRVe88tQC/DbX+su6yGbybKsxzEo0qbHSV4Wlip865CPo/GSzqM46v6u2PR4pPjNXMhMcFnU2UF5KJR9NVO+2QGcSHyoxzt4XYaGDVa3OxQfAgx6eBN6qqOK6AEXWDgV1XqQc11nnrj54d3NAgbi3vYmFcVPnanonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616999; c=relaxed/simple;
	bh=UvjBYqdtUCKuhuDcyr4WMno31MOA6IlpDIkFftW5S9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE4c8FT75nO25QDwjiZfu2JQkI7mtXe4QgRVqjW+yEiDw3xl70XpS/m9DVQveEd2IG97CEkUeut7dXuaN5DnN6BUxfrG1jAOLulOGo7DL4qSeKgbm3W7hivjuvhw4FQbW3jIAtNlSJB7hTWl4UZUjcJ5jtsH+xIdJSAHtSXkBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uXWwsPxG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uXWwsPxG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355DD26A4;
	Thu,  9 Jul 2026 10:09:52 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7343FC81;
	Thu,  9 Jul 2026 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783616996; bh=UvjBYqdtUCKuhuDcyr4WMno31MOA6IlpDIkFftW5S9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXWwsPxGlH7SnVogQrforXaYBysq1Cp1ew3FhWzYp2NFg/ZYp2Lmf0hfRozVwFl0c
	 9eKzXOmm6QKLKEd01LpF+/Es1/gXEePYKwVs5l9KpsFOV7x1hB89ze+ixvsqKXxpzz
	 SzTz6OyfbScsB4Vbk7q4i+KnTXe3bp6jH9QtI4lU=
Date: Thu, 9 Jul 2026 18:09:54 +0100
From: Leo Yan <leo.yan@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 5/5] perf/arm-cmn: Support CMN S3 r2
Message-ID: <20260709170954.GH1024232@e132581.arm.com>
References: <cover.1782830759.git.robin.murphy@arm.com>
 <1ce69a1cb72da220caa6bc83eb8ce74e295b595e.1782830759.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce69a1cb72da220caa6bc83eb8ce74e295b595e.1782830759.git.robin.murphy@arm.com>

On Tue, Jun 30, 2026 at 04:19:20PM +0100, Robin Murphy wrote:

[...]

> @@ -913,7 +956,12 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
>  	CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 3), \
>  	CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 4), \
>  	CMN_EVENT_ATTR(_model, _name##_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 5), \
> -	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6)
> +	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 9), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 10), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 11), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 12), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 13)

If these CMN_EVENT_ATTR(CMNS3R2, ...) entries are appended to
CMN_EVENT_HN_SNT(), they will extend the CMNS3R2 attributes for other
models as well. For example:

  CMN_EVENT_HNF_SNT(CMN700, sn_throttle, 0x2a),

This would also add the CMNS3R2 attributes to CMN700. Is this intended?

> +#define CMN_EVENT_HNS_OCC(_model, _name, _event)			\
> +	CMN_EVENT_HN_OCC(_model, hns_##_name, CMN_TYPE_HNS, _event),	\
> +	_CMN_EVENT_HNS(_model, _name##_rxsnp, _event, SEL_OCCUP1_ID, 5), \
> +	_CMN_EVENT_HNS(_model, _name##_lbt, _event, SEL_OCCUP1_ID, 6),	\
> +	_CMN_EVENT_HNS(_model, _name##_hbt, _event, SEL_OCCUP1_ID, 7),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rnf, _event, SEL_OCCUP1_ID, 8),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rni, _event, SEL_OCCUP1_ID, 9),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_OCCUP1_ID, 10), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_OCCUP1_ID, 11)

I have a similar question here. My impression is that this is mainly for
the convenience of appending CMNS3R2 specific attributes, but it doesn't
necessarily mean those attributes should be added for every model.

> @@ -1288,65 +1388,72 @@ static struct attribute *arm_cmn_event_attrs[] = {

> +	CMN_EVENT_HNS_HBT_ENHBT(cache_miss,		0x01),

I manually extend the macro and got the result:

  CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_all, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 0),
  CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_hbt, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 1),
  CMN_EVENT_ATTR(CMN700 | CMNS3R01, hns_cache_miss_lbt, CMN_TYPE_HNS, 0x1, SEL_HBT_LBT_SEL, 2),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_all, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 0),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_hbt, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 1),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_lbt, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 2),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_rnf, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 3),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_rni, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 4),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_ccglcn, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 5),
  CMN_EVENT_ATTR(CMNS3R2, hns_cache_miss_ccgrn, CMN_TYPE_HNS, 0x1, SEL_ENHANCED_HBT_LBT_SEL, 6),

CMNS3R2 has added items like rnf/rni/ccglcn/ccgrn, not sure if this is
purposed or not ...

> @@ -2431,21 +2538,33 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  	/*
>  	 * With the device isolation feature, if firmware has neglected to enable
>  	 * an XP port then we risk locking up if we try to access anything behind
> -	 * it; however we also have no way to tell from Non-Secure whether any
> -	 * given port is disabled or not, so the only way to win is not to play...
> +	 * it; however prior to CMN S3 r2p0 we also have no way to tell from
> +	 * Non-Secure whether any given port is disabled or not, so in that case
> +	 * the only way to win is not to play...
>  	 */
>  	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
> -	if (reg & CMN_INFO_DEVICE_ISO_ENABLE) {
> +	if (reg & CMN_INFO_DEVICE_ISO_ENABLE && model == CMNS3R01) {

As the comment claims "prior to CMN S3 r2p0", would here be:

  if (reg & CMN_INFO_DEVICE_ISO_ENABLE && model < CMNS3R2) {

>  		dev_err(cmn->dev, "Device isolation enabled, not continuing due to risk of lockup\n");
>  		return -ENODEV;
>  	}

Thanks,
Leo
