Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0995364934;
	Thu,  4 Jun 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564909; cv=none; b=QRCDBYAr7ji5LJimRNXFOwOQEphYQd6B4MzmEOsD5ZCu+jfv6/t0YE8KbQN7vTipBx+GcHYreWQFnAGBg3K0PWwR3nOHnNCozxX7hdy4DxwyJ4qdFf5i2N218eJRqmDvANidmeITTTBY/lUoA6dVQcKmbjwLD4DUNq/ncTu+0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564909; c=relaxed/simple;
	bh=00iyJ6VkOVP/q1njnA2gA3zh/0HSFrHb8WMHa38FfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8NE/30nNy7Ls57S7bu3rq8uX236EMKyk867+7xW2x0wIrIWF83+2wHdK5d/sVWRfJdO22jg8QAt5LCwDGCsEYkM/6Z1QCmZQL+Z0AojoUNAIUkpmRa28/mmYtqPgJV7oN7bFjy1G9Nm6Mzwidrl/xJa3KFE8VsdHobPoHDtWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OYCSWeQB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYCSWeQB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Oo1Wm4RQBhoT1TAASWUxZM6ts2NaXeKKtIOrDa/nEQ=; b=OYCSWeQBU75X7CExwAyKZmLiiF
	2L8FccmqKYQcNVeGSYZ3iDg3dxBuIyUya5V/4EIFKxrtaU5R7CTapKxHuRr2jwf4/FyhP/BtNzaXY
	d5rbI7r3VXPLQsequTgbc3Gkvp13zZcwpU3rCeVl473/Io94wJJGjkUQ/ijjMUTgbiqV8usdfFn9f
	7Be55RaJG9Fkdciue1fyBdEiuQdaYnDh9zSzk/v7z3fTBWO8vFGTn/TSN7pzCA3ptguIjTPWMhyeY
	jp1pdo/hXTWx/bDH/vRZQZh3on9V9AyaM290ZMhrqu7VhA1sw8APTG3WuIjuR2n4cUYNXSQe3rU3D
	RulIjIGQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4Gj-0000000E85E-3nvB;
	Thu, 04 Jun 2026 09:21:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7779A3001FD; Thu, 04 Jun 2026 11:21:40 +0200 (CEST)
Date: Thu, 4 Jun 2026 11:21:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 1/2] perf: Reveal PMU type in fdinfo
Message-ID: <20260604092140.GE3126523@noisy.programming.kicks-ass.net>
References: <20260602181349.3969429-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602181349.3969429-1-ctshao@google.com>

On Tue, Jun 02, 2026 at 11:13:48AM -0700, Chun-Tse Shao wrote:
> It gives useful info on knowing which PMUs are reserved by this process.
> Also add config which would be useful.
> Testing cycles:
> 
>   $ ./perf stat -e cycles &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    3081
>   perf_event_attr.type:   0
>   perf_event_attr.config: 0x0
>   perf_event_attr.config1:        0x0
>   perf_event_attr.config2:        0x0
>   perf_event_attr.config3:        0x0
>   perf_event_attr.config4:        0x0
> 
> Testing L1-dcache-load-misses:
> 
>   $ ./perf stat -e L1-dcache-load-misses &
>   $ cat /proc/`pidof perf`/fdinfo/3
>   pos:    0
>   flags:  02000002
>   mnt_id: 16
>   ino:    1072
>   perf_event_attr.type:   3
>   perf_event_attr.config: 0x10000
>   perf_event_attr.config1:        0x0
>   perf_event_attr.config2:        0x0
>   perf_event_attr.config3:        0x0
>   perf_event_attr.config4:        0x0
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> ---

Yeah, I suppose I'll take this. But I'm not sure about the wording here.
PMUs aren't really reserved as such.


