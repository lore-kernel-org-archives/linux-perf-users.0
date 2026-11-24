Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512539;
	b=a3nNn/UCoOF75ULlVla1QGveOMJzo2c0d+XZLLGkXIkUhGfJ4UHb5HQ72CHFZgidgea4
	 WD7wQREO6TOPgy7BDvu43gaycK+kHOGj5QmxpqThkmtklW+ArGL/xKn7Z0Muz2HKIJX5T
	 5PZXbQRQ2j3w9gFDhQiZ2VCm9mHiMve0Kh9IneEJ7lYAMp1Vx57gUTh4nQArvMb6c9J09
	 3CvdpMmNlf2g+biI22KzDxMAMB+6Li5TCU/UPdP8bIS2XPFObzUFuwezbj6XFGsRY01mz
	 wKViba6n2juzZTQdVk5//+CiVgoh+IAn7VEese5fPyC+WQoghC/svZfn8qLIN7+l9Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512539;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=68s8dF643W4r8o01kq7u0OHFeheAszVMDFW0VzZCIP8=;
	b=CLxum4lIrFUYKXWBTAxUYEG8wQv6SHucqXbZPPtOw9PCj3O5fcDUrgwNx9SF0jYf4bAC
	 uVEgrDTU3hfbHF6GzI0zaOhrV7aJeedJCs5UW+J+UQpJcLXK8oGr08tIKbLv+E9FWri9F
	 KMp3mO+UXWDXH8AAW9Wfqi+wCELgIoV/tp8dym9uFkt5dv5h7MlqiciQZj0OwUt+uelUq
	 V2IAmwb78XoNRBg9eUZDwI9uE6AcBM7bIWr9dqS/6VEkPDI2CBX8I9exDQtqr21LDnc3/
	 6A0NnTaw/EDmUVCTof6NZH9QMfq/8rn1f0oB0/G008170uE3UoekXex0OijHS3tULRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KEWXWVbH;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBB606A31E;
	Tue, 24 Nov 2026 09:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFEBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KEWXWVbH
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E497339;
	Tue, 24 Nov 2026 01:28:49 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EFEC3F86F;
	Tue, 24 Nov 2026 01:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795512532; bh=KmBsWytUnf1WwuD/N2D/GAHKXq3lrlOH7DiAXeXeCh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEWXWVbHbe0tVeC51l5S9VkRC0+G0K1LrphX3FMsAM814zGsbdqxxB1dU4m0il041
	 slx0SH1YsTfybof/RafJh9woWYh3Ra21MGy6RmlW8U7zrm6i1uxjUb/N39NAtNyd4L
	 TiXF5VROsnlj+e9jMVIeU5Xp6ibj5EgjIv5km+E8=
Date: Tue, 24 Nov 2026 09:28:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: Song Liu <song@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/25] coresight: perf: End AUX output when an event is
 throttled
Message-ID: <20261124092849.GF9176@e132581.arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-4-35cf6f297d20@arm.com>
 <CAPhsuW665wcpXxE8pfzRMfdxZwh9ogGsvd1aEBFREq61cz4Y5w@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW665wcpXxE8pfzRMfdxZwh9ogGsvd1aEBFREq61cz4Y5w@mail.gmail.com>

Hi Song,

On Mon, Nov 23, 2026 at 11:07:37AM -0800, Song Liu wrote:
> Hi Leo,
> 
> On Tue, Sep 15, 2026 at 8:49 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Since commit 9734e25fbf5a ("perf: Fix the throttle logic for a
> > group"), the perf core stops every event in a throttled group by calling
> > the PMU stop callback with flags set to zero:
> >
> >   perf_event_throttle()
> >     `> event->pmu->stop(event, 0)
> >
> > The ETM perf stop callback only ends the AUX output handle when
> > PERF_EF_UPDATE was set. For throttling with mode is zero, it skips to
> > end the AUX handle. When the event is later unthrottled and ETM tracing
> > is started again, perf_aux_output_begin() sees the perf handle is nest
> > enabled and triggers a warning:
> 
> While testing this patch, we found a crash:

> [20123.449766] Call trace:
> [20123.454671]  arm_trbe_irq_handler+0x58/0x4d8 [coresight_trbe] (P)
> [20123.466920]  handle_percpu_devid_irq+0x80/0x1b0
> [20123.476029]  generic_handle_domain_irq+0x3c/0x80
> [20123.485308]  gic_handle_irq+0x174/0x328

...

> LLM suggests the following change should fix it. Does this make
> sense to you?

Yes, the change below looks reasonable to me overall. I have a patch
series to refactor the TRBE driver [1], and patches 05 and 09 make
similar changes.

Do you mind to test the series (or apply patches 01 ~ 09) to check
if issue can be fixed?

Thanks,
Leo

[1] https://lore.kernel.org/linux-arm-kernel/20261016-trbe_enable_disable_irq_handle_refactor-v2-0-3f57cf3199b1@arm.com/
