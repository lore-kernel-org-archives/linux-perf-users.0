Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FD74040;
	Tue, 18 Feb 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842996; cv=none; b=NLgNa/1qEFXw8fxU+3SPCt2sEmyPeDDIi88RV36eP+RNleSpBHuxB3nJ4tMqzLmArIhoE8z6TnJi/VZhP81Tm8FdODAGEoed5cwP+ut3DwWy/OzS8soAywZ9JehfuiEuKlammCSoaIh+ZtboFqh9xk/jHU+H+jUPDiC0PeMF2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842996; c=relaxed/simple;
	bh=x43yfrV3Y3BPFuYAwIld6hy3WQQ9zhsC8vO04KfAlNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVfPf0Q9lFjgaG5AvCFCZ7pw7/xN5HrOFwPE2o2NAgVwqyiC1BAz9hiek87UHlQGV41Gcm2eC5tgIg1FfAQGAgqjJFj6v6DjkyZQn9cnk3zArAA/2+Q4k2YWJHMVLPzymRLCt0arrpcFUJEsrj6/JDEHLG97pPPacVdhs6cnz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EPhuhbZ3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EPhuhbZ3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739842984; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=U/wiVg/zVTmmdVAuSQhntXuT5npvM1Nuq/OCCNwlVXw=;
	b=EPhuhbZ3Q08BA6HLjcPMiUaaf2fMWh5zeVCub/boQe3v9fiumOv90wAWHaNCmU2ia9AoRhelJZP3tarhRr+CJMLnEB9NT48STbQEsTmGt8c2vYKMufQJeTpFQ+ClviY0feEo8FBzzLDH2TbM7p5QGZj2+QoCTJeMHolSxuhpBks=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WPjtOnc_1739842982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 09:43:03 +0800
Date: Tue, 18 Feb 2025 09:43:02 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: robin.murphy@arm.com, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jie.li.linux@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: don't claim resource during ioremap() for
 CMN700 with ACPI
Message-ID: <Z7Plpr3e3hdQJieG@U-V2QX163P-2032.local>
References: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218012111.30068-1-fengwei_yin@linux.alibaba.com>

On Tue, Feb 18, 2025 at 09:21:11AM +0800, Yin Fengwei wrote:
> Currently, arm-cmn PMU driver assumes ACPI claim resource
> for CMN600 + ACPI. But with CMN700 + ACPI, the device probe
> failed because of resource claim failes when ioremap() is
> called:
> [   10.837300] arm-cmn ARMHC700:00: error -EBUSY: can't request region for resource [mem 0x40000000-0x4fffffff]
> [   10.847310] arm-cmn ARMHC700:00: probe with driver arm-cmn failed with error -16
> [   10.854726] arm-cmn ARMHC700:02: error -EBUSY: can't request region for resource [mem 0x40040000000-0x4004fffffff]
> [   10.865085] arm-cmn ARMHC700:02: probe with driver arm-cmn failed with error -16
> 
> Let CMN700 + ACPI do same as CMN600 + ACPI to allow CMN700
> work in ACPI env.
> 
> Signed-off-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> ---
> I am also wondering whether we could just drop the CMN600 part id
> check here if ACPI companion device claimed the resource?
> 
Sorry. Just saw the link
https://lore.kernel.org/all/1676535470-120560-1-git-send-email-renyu.zj@linux.alibaba.com/
after I hit send button. May continue the discussion there. Thanks.


Regards
Yin, Fengwei
