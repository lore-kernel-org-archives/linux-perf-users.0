Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162024EF69;
	Wed, 12 Mar 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809234; cv=none; b=ryQr1RSzOzbmM2jG+Oh1va9iz1Unl73RZPfrI6evdud02k50OTcRjMWSaDeKW8AiG/z6tu4xzy3gkK03FIclfYSU4ZbyLNBoCc5e/BjnIcq90NMsHsdBW4aVdpdm6MJ2DfLp68Ad+ZsyUzuUMQaPqY0TbBjmVoOmUCW0WRp8Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809234; c=relaxed/simple;
	bh=OpgZID7IQwVEI64fNCB22xzLqhUprej3EXHz74ZpxLQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lS2PIYqst+m7VndZX4Jmex/DMrsmjEyFmp7NpRDDVIFALTrt78KeNFJcU1jcCNvRqBNx/7gQYiqx22aJRC6DHQa5ENCNiRite1LMKMKEUpuTkqdTB0O4JNKeyilOvO8tzrHl+R7dtBEF6tqKKOe0dhvLzlx68LuJoVVdMKH0/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqvHV28N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqvHV28N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA6C4CEED;
	Wed, 12 Mar 2025 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741809233;
	bh=OpgZID7IQwVEI64fNCB22xzLqhUprej3EXHz74ZpxLQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JqvHV28NTQxkkOYUwmQ4SUtD2I978GCLlzAChEGr77CcJqR4H3ieeZAsVCZbCLiF/
	 xf1eAVPbBZ8ta05RxmzJFQofi7WPc/ewOLd1grnPNlY7nxuMQouDgiLvjzpQKmtKrl
	 XQYspSFq7AfI+wwwDamariqj5eBzcRt1SLJwvKyDkMrpBaT50m3twG+29LmgQZmijM
	 z+gfLSx+c+aZ/rsFxd/7Yd0OMnV5WBtkNr386BG3H8jzLg1IudOO9jex2KlsALz/Ri
	 LHzGfjiKuuEMewbpehVsKsjUC3Net5l3oRuZCMWuwcle+GPCAOj0p/taGkJVw77xZx
	 NbH9pp1F14Tww==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
References: <20250307023906.1135613-1-irogers@google.com>
Subject: Re: [PATCH v2 1/5] perf tools: Improve handling of hybrid PMUs in
 perf_event_attr__fprintf
Message-Id: <174180923280.2923844.4550428583496571868.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 12:53:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 06 Mar 2025 18:39:02 -0800, Ian Rogers wrote:
> Support the PMU name from the legacy hardware and hw_cache PMU
> extended types.  Remove some macros and make variables more intention
> revealing, rather than just being called "value".
> 
> Before:
> ```
> $ perf stat -vv -e instructions true
> ...
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0xa00000001
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0x400000001
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 6
> ...
> ```
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


