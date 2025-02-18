Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B223AE6D;
	Tue, 18 Feb 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874938; cv=none; b=OHFK3xjoyBdvmNuN1E4UOCCTbV2NY0RFM8jzD200SGStLBVeEBEjyExqTAKPmDhnYdo5CLwQ3wBdzqLjBoAc4NoTuWRdKjSKFz+z3P60HSMkaNTMBYHdWEq913X6JqEoxgqS+6suoZiD8LhvQV7pWcedrF/vTA4kKxNNHxCzsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874938; c=relaxed/simple;
	bh=c3BrpkDhqaCEjA27I1wRsonwAHEWi+LulnErGrPlMtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ1+sZ4pHF31T48wGC6b7lDHvqwy9w/HqrKv6K2ATmL2fNOwp/Lw/CvPzmBG+4/JwpPAA3zY8kDvoKs7IqC+iKC/Q/Z34vk0heyShKi/Uc7nTEsFZITFUAEpd/99Bp5FrZSl/hMA0787wiby/uUtr4jLbUaJoHLW80Oc4RWfg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IctaxFc7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IctaxFc7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739874931; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=5NAxMiATQ8LZrAb8v9xhHjtPlZqc6/HzlLdhP76SDgU=;
	b=IctaxFc7U28wlFifSGELnvwMI/YkbppROenPu6Sq4NhSZgX6INFCkykbAXM0Uj4Bh+mJwzplGRWuIhNPY7DpyUkGC/mDF6C9iejCobBoApZXwSnOzlvtA1f/XSpYPsxCnMOF66sn9KvsPjuP2CHNKro7x4MAsqwe0VU2kU+Lv2M=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPldaSl_1739874930 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 18:35:30 +0800
Date: Tue, 18 Feb 2025 18:35:29 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jie.li.linux@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for
 CMN700 with ACPI
Message-ID: <cji4nqc6etzggg7hannvdg5jos4dr4mhujetviuhs3sl36bh6g@xde5izlywsei>
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com_quarantine>
 <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5040b5c-564d-4abf-be22-d2aa1183b633@arm.com>

On Tue, Feb 18, 2025 at 10:31:42AM +0800, Robin Murphy wrote:
> On 2025-02-18 1:21 am, Yin Fengwei wrote:
> > Currently, arm-cmn PMU driver assumes ACPI claim resource
> > for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
> > failed because of resource claim failes when ioremap() is
> > called:
> > [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
> > [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
> > [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> > [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
> > 
> > Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
> > work in ACPI env.
> 
> No, the CMN-600 routine is a special case for CMN-600 having two nested
> memory resources of its own. CMN-700 and everything else only have one
> memory resource, so that is not appropriate. What else is claiming the
> region to cause a conflict?
You are right. I just saw the discussion after I sent this patch. :(.
I proposed new fix in that thread which align with the spec.

Could you please take a look? Thanks.


Regards
Yin, Fengwei

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> > ---
> > I am also wondering whether we could just drop the CMN600 part id
> > check here if ACPI companion device claimed the resource?
> > 
> >   drivers/perf/arm-cmn.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> > index ef959e66db7c..8b5322a2aa6e 100644
> > --- a/drivers/perf/arm-cmn.c
> > +++ b/drivers/perf/arm-cmn.c
> > @@ -2559,7 +2559,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
> >   	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
> >   	platform_set_drvdata(pdev, cmn);
> > -	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
> > +	if (((cmn->part == PART_CMN600) || (cmn->part == PART_CMN700)) &&
> > +			has_acpi_companion(cmn->dev)) {
> >   		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
> >   	} else {
> >   		rootnode = 0;
> > @@ -2649,7 +2650,7 @@ MODULE_DEVICE_TABLE(of, arm_cmn_of_match);
> >   static const struct acpi_device_id arm_cmn_acpi_match[] = {
> >   	{ "ARMHC600", PART_CMN600 },
> >   	{ "ARMHC650" },
> > -	{ "ARMHC700" },
> > +	{ "ARMHC700", PART_CMN700 },
> >   	{}
> >   };
> >   MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
