Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFE2F7AA7
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049729; cv=none; b=iTkncZg+nDIrpzZtKKLp982vSjzJMkUkoEDtFNc0D4DvBP1FWE2U7+zatky5Pfm7NfjOMGpJRLcUSJ8fxQnLzDxjhFWnQe6wXdlCrORNXozCtjEYR8JjeN7+0UIQR502PY+SS5V9zyj2LmcVp6FSSpQGFzdE9iuhRhuVTUenuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049729; c=relaxed/simple;
	bh=nHpn1t5ceNIv/uJedoNZpxDlLGnoEkiRUprh6a9Zl3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR8T7SyNK1dyDv9nbpdNCgfvqgljKdbXW2MfJhb3n5lPPoLBKA0tNgcT2vF3wLL6xst/q5W6CJsYFdCYBrjXJQ7GjpSMt0VnyQwZ3vgJlFbe9xiP4errrzvAnTWjJCnhOYQXAyCjTldEGmSUUG5IDm0chizKLpeOeObeozMK52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/dChqOh; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/dChqOh"
Message-ID: <c41372ad-1591-4f2b-a786-bc0e19f8425c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763049725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHpn1t5ceNIv/uJedoNZpxDlLGnoEkiRUprh6a9Zl3Y=;
	b=j/dChqOhWFcOEKzssE4nHa9MiepW7VPaW2caSlwjSo0q+QyNtp7l560tC6ZGBHAKxYsspH
	S8ry6G3MYJpiTN3rGnKQThtd/lHfodvWIZJttxosRIVTaZeVtirH99WtbOd/QFbm+eEBfU
	+aQntCudQxtuP9LBfYLLoGA23wGnbU0=
Date: Thu, 13 Nov 2025 08:01:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251112163148.100949-1-chen.dylane@linux.dev>
 <20251112163148.100949-3-chen.dylane@linux.dev>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251112163148.100949-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/12/25 8:31 AM, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

