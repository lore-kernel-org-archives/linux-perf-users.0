Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE39268FF4;
	Thu, 13 Mar 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883375; cv=none; b=pACmlff4fAxuU8fvVSy2MEP6rbEDnmTAHXqCHlZYYZ0CQTqCYjA5EM0oJ8mt4vmJHgxiPf0V+TzEh1VttskDvdQY0LDmHWobAG0rtYnJod1ZmnIhEFjHOXDjD4kjxZL6wzYehxymqQ78bjAZVOhJWLXJ6IIinXOU53C1keLtdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883375; c=relaxed/simple;
	bh=DQfXMum8mpZt66Bp4G/LZ5KcI5ew75D08L2qiKCxHPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KF8WN08bdQSH8+uOLanY4l+35F03IxBjwEzfpDJ2nP8VWUlDHrVXJzHbHY/pxvtx9QKHWLX9/rw/5AmcAH/rh3mg3fnsY55pZow1w2GAxAuMQXB18JKT5K7qwvGfPUnjxDdnTOThcRZUf48xnOzCENCGTyxx3LwAW58Ei0QX93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH3CNShR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH3CNShR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CA6C4CEDD;
	Thu, 13 Mar 2025 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883375;
	bh=DQfXMum8mpZt66Bp4G/LZ5KcI5ew75D08L2qiKCxHPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SH3CNShRFTHTcO/pLF2qSzhtHxL/So8zdnhmhrlydRNsfEMAjNZcFPBalrcu/0Yra
	 yi1xsOWba99Ew5EsBY33Hgm07KhfJWBbMEgZdp11Z3CBiVs4KMt5cT06tIZf9NfjmQ
	 cndTQryAzQPH7Ru9lCoThiVeYIoRbq5VTogIAvWsQQkJ2irKWnUQUujrb1f5NuTO6q
	 eMv+429mxwdnDF0WQpEWZVEhAVQZN9RwY8PIYnUbgSTuditWccBkEesSxeBQPmG/+q
	 xKFQ7YwYX61XUJQbfxNwYUprWj0w4CpTx6u2mgQPPFKQcw4BVED1YPP4/n1ryNtqXF
	 lxsNrr5BjJ1vw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>
In-Reply-To: <20250227191223.1288473-1-namhyung@kernel.org>
References: <20250227191223.1288473-1-namhyung@kernel.org>
Subject: Re: [PATCH 1/3] perf ftrace: Fix latency stats with BPF
Message-Id: <174188337460.3466761.2196877504904331124.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 09:29:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 27 Feb 2025 11:12:21 -0800, Namhyung Kim wrote:
> When BPF collects the stats for the latency in usec, it first divides
> the time by 1000.  But that means it would have 0 if the delta is small
> and won't update the total time properly.
> 
> Let's keep the stats in nsec always and adjust to usec before printing.
> 
> Before:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


