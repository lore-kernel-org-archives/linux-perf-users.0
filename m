Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BF3C08A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730017; cv=none; b=OVNyhkZ69oeSx5ujB8yIJBd6uuCWMFhaCcaZH+xN0g7giYsN1uQW145UqZe+dRuhZxhLryzeQmqy6uxYaCdD7Em9DF0dRNJTYKam44fc/WaMPZdXGJdD5alr4sE81ZmqVuZdAsW5LiSQ5hCZFv0tlx+0teU6dDNnOgyfh5bQyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730017; c=relaxed/simple;
	bh=7kExdWS6JDOGOnQqonzPxjgdDRbliiP1gCG3/ps6oXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgXYfOoZ4kD/2NT4zEy0fTJcZyt2fv7sO62rdONrrjrIhp7v9HnV+PhW9et83dIOFPlN19U8AnIzb5vI/5gCUGgqliS42/GgGc1n8KXTDRMK+mIAlqKJHYviYF21GWDVo9GelUG9CqgX1i1a7nMUINYqB2lgYmv3594ERkT08oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XEdcpDJw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XEdcpDJw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724730012; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2El5kH97/vTcCsB19TSPOMYImWN91Z0mKYkLKgWps8I=;
	b=XEdcpDJw3lu3I4x/EDALgq4A/436ZvGLbK5b8Wbw6DdXrB3h/6GJrDNjV/o1+EOe5oP2Dk2lF6+PRSxqK8LZbk9axFzwbMdqYM260l7qUxXy+TQ9HHVJShCLgKpByivCiWEM9pJqwkYSoIo2wv1hYf89xVIMfgNbWK94JC30sh0=
Received: from 30.221.148.118(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WDl5Fsa_1724730010)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 11:40:11 +0800
Message-ID: <f7af5fe9-35bd-4322-a474-a67529b06ac5@linux.alibaba.com>
Date: Tue, 27 Aug 2024 11:40:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Move Yitian 710 DDR PMU into
 T-Head directory
To: Lucas Stach <l.stach@pengutronix.de>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kernel@pengutronix.de, patchwork-lst@pengutronix.de
References: <20240701175735.485655-1-l.stach@pengutronix.de>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <20240701175735.485655-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2024/7/2 上午1:57, Lucas Stach 写道:
> The Yitian 710 is not a Freescale/NXP design and thus should
> be located in a separate T-Head vendor directory.
> 

You are right. Sorry, I made a mistake.

Reviewed-by: Jing Zhang <renyu.zj@linux.alibaba.com>

> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../arch/arm64/{freescale => thead}/yitian710/sys/ali_drw.json    | 0
>  .../arch/arm64/{freescale => thead}/yitian710/sys/metrics.json    | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/ali_drw.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/metrics.json (100%)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json b/tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
> rename to tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/metrics.json
> similarity index 100%
> rename from tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
> rename to tools/perf/pmu-events/arch/arm64/thead/yitian710/sys/metrics.json
