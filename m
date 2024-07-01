Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485D3D3BC;
	Mon,  1 Jul 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843750; cv=none; b=n9NlXrmkywy1khHEv3RhxpG+UOgYwXIC6vcs3oFauNKlAwitHV0RHiLz9TpxWmtfRsfktLnQahsv2W4e2qtDT/RW+gUAGOgP4fqhvtlosEV3uB05qyYx9ASABboQInp79Su4Crec4f9WdxbnhYgFuG6P+3XVfIoKmoflK9oAy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843750; c=relaxed/simple;
	bh=eROdfnaAt0I1lw6qi3i+9FPGXr4ZyqLymMFA3Dp2S20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNhzE63O2EdVcTsMfzOETf/yN3I4rOwATn702cIr2NL8Z2XBKJW3zrDC80bgKRo8Mgrl1vAIwaxhzPsd4N5WW7cK9ThNRoLKaJCTnAUbTevGVrbjHk9s7yiRJCsXqbyRrQYYWFaHcsdcw4+gQyrgCOPakyViC3TmfZ68fUJkudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Np0kiw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Np0kiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98439C116B1;
	Mon,  1 Jul 2024 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843749;
	bh=eROdfnaAt0I1lw6qi3i+9FPGXr4ZyqLymMFA3Dp2S20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2Np0kiwPfQiwXvzGNJlmcPmZ1/GHOcJHhjnfEQwhABH1VrapDa37MJTxJM8e6zP6
	 mgv/rRiqb8R/HNcrKP7vcORZ530T/XVQXwszxMidBYQnLeWncWBzs3ihlcxGcZr4Sh
	 CA+iKRl+w2PfNEhm39u2cwDsK6Vor9QByI79LkhKGkumGjKV0Xjbo5QN6lq5n1SeyO
	 VcE0yh1cw0Ma3jONw6DRIqpWoEOgQ4BfxBbT0mUH30VKDn0Du9b/KbjulG8AGbZFte
	 QqhZKlP/IvihTgXq7wCFqujgnq1XK01b/carQluHLITjZS9MgTmDUrJdI/gJm4cO9i
	 xNYfqUFKqoVrQ==
Date: Mon, 1 Jul 2024 15:22:23 +0100
From: Will Deacon <will@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, acme@kernel.org, namhyung@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, james.clark@arm.com, dongli.zhang@oracle.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
Message-ID: <20240701142222.GA2691@willie-the-truck>
References: <20240603092812.46616-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603092812.46616-1-yangyicong@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 03, 2024 at 05:28:09PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> If user doesn't specify the CPUs, perf will try to open events on CPUs
> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysfs
> attributes if provided. But we doesn't check whether the CPUs provided
> by the PMU are all online. So we may open events on offline CPUs if PMU
> driver provide offline CPUs and then we'll be rejected by the kernel:
> 
> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --timeout 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.

I still don't see the value in this. CPUs can come and go asynchronously,
so this is all horribly racy. Furthermore, there are other (racy) ways
to find out which CPUs are online and whatever we do in the kernel now
isn't going to help userspace running on older kernels.

Will
