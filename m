Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD218C346;
	Fri, 25 Oct 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837093; cv=none; b=gLGwTGt54u/+HbvyZPa4b3zKUZMWhBcvgc3J84txWICfn2OM5VcDzkXoz4AA2h5lssGV6pT+lxC5we53hUAMrsw4+0mVJCyyQiNg5jz37spLCggs8tzI1imiACzNJzxD3Q/14jPzKM8qofotjD8HZd2TjEZoxVSasPBPyCDlCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837093; c=relaxed/simple;
	bh=2nyYr3pCSkfs9TcMjtrwxXmMYdE5WjKJFzBM7ud4rJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXUrItNqLYiA3HlKQOFfjOzHgK9JnxXeG6UZlP9rAC0cVlGGIYIy2TygsKAzIIBcLyJKjefJ6nuWN5gktIrI0Mp9789tWJuYBichNh7m1QTXEEUNhso8JU/5ST/eGRnTJd284GyuxodRh/yGM9ssdd5yxi2uWid/yoFgZDQogTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XDUWc2F8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XDUWc2F8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AYP4qbZ3o+CMsl4aAqLA3W1YHtZzQfPTOIWKI8N9y0c=;
	b=XDUWc2F8rrXOpgPRMEQp3adLb+kRbAseHGod+iQCA1DIyxDlKmxPrE4KkePL2b
	tqt9kTDPojO8z0dFMM/Ib0iB0dhoN+SovbCv7wbxlbHTPIRc4Qeyc2nK6ZbgqnKK
	FrKtAh3MdeOPHfvK5nuhBwwhk7LCi+PXpn1+bGY1lrHpY=
Received: from localhost (unknown [36.5.190.42])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCXBFYLOBtntrOeBQ--.18141S2;
	Fri, 25 Oct 2024 14:17:47 +0800 (CST)
Date: Fri, 25 Oct 2024 14:17:47 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/pt: Fix NULL pointer dereference in
 pt_buffer_reset_markers
Message-ID: <Zxs4C_oha56QcExV@mac.local>
References: <20241001082757.111385-2-qianqiang.liu@163.com>
 <87bjz9vjih.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjz9vjih.fsf@ubik.fi.intel.com>
X-CM-TRANSID:QCgvCgCXBFYLOBtntrOeBQ--.18141S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RLa9-UUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxiDamcbNrUd8wAAsP

> So no, not a bug. It might deserve a comment explaining the above logic,
> so that more versions of this patch don't get generated from static
> analyzers' reports.

Got it, thanks!

-- 
Best,
Qianqiang Liu

