Received: from mta0.migadu.com (out-218.mta0.migadu.com [91.218.175.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F50592214
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890495; cv=none; b=Tj9qll51dl15wV4TGQl5ob/Rnuw6gFYZs2zlRzPHYGsUUJ+Ev3MZvF4XQ7n5q8Zm8jp2IIR/G5EvQigqoktJIi2Pw5ZbahXXtZzoGBlDkdibQcFu98QZd2dvSJMRdmy+ISGjxpiFWUcrwqUcS41tjDy/NxUX6QamfFXL5rIZhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890495; c=relaxed/simple;
	bh=352NuZKJC4ABMe7epkEOWfjaeOUDqtU+5Mor+KAL2J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msNQx4JMvjl/chlhzpcWdw4m2YhNw+5IuM8NJ/QxB/D9ryq69AVVHPqprfB1+VPXizWpclhkgWT39biPBr/j8ioS64chPywCJ4wvYDBYNM45H36glR9BWeKD/YSPiTjb76mgJXkKDriDPUKGr0feabDbjFaIdxrLQa8dsvYkjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j2705VGR; arc=none smtp.client-ip=91.218.175.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j2705VGR"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=352NuZKJC4ABMe7epkEOWfjaeOUDqtU+5Mor+KAL2J4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788890491; v=1; x=1789495291;
 b=j2705VGR/DjGY8TOcx5oZ0TDZ+dEyatF/na9tiSK5EsEoscfE3Kwr6HfDngv3GVaxZ3fLVw0
 uCE+oKPEjWNhfW3pcdsTmQ/537lRijZKCzu/O177PCbYO0WCnB3hXJSPTWtL14jNpKVqcFiTJkI
 RtP2iYHJoqNVWe9QySRkYg3g=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 780d75177a0e07fd;
	Tue, 08 Sep 2026 18:01:30 +0000
X-Mizu-Trace-ID: 780d75177a0e07fd
X-Migadu-Flow: FLOW_OUT
Message-ID: <0db57143-430e-4f45-92aa-03b6034b90f0@linux.dev>
Date: Tue, 8 Sep 2026 11:01:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] bpftool: Improve perf counter reporting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 7:27 AM, Mykyta Yatsenko wrote:
> Track valid snapshots that have a zero counter value. Scale each per-CPU
> counter before aggregation. Report cycles per included program run.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
> Changes in v3:
> - Keep the JSON value field raw. Add value_scaled and run_cnt_valid.
> - Use the same CPU set for all metrics.
> - Move snapshot state tracking to a separate patch.
> - Link to v2: https://patch.msgid.link/20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com
> 
> Changes in v2:
> - Scale all counters.
> - Use an enum for metric indexes.
> - Link to v1: https://patch.msgid.link/20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com
> 
> ---
> Mykyta Yatsenko (3):
>       bpftool: Track perf counter snapshot state
>       perf bpf_counter: Track valid BPF counter snapshots
>       bpftool: Scale counters and report cycles per run

For the series:

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

> 
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
>  tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++------
>  tools/bpf/bpftool/skeleton/profiler.bpf.c        |  25 ++--
>  tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c |  26 ++--
>  4 files changed, 168 insertions(+), 55 deletions(-)
> ---
> base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
> 
> Best regards,
> --  
> Mykyta Yatsenko <yatsenko@meta.com>
> 

