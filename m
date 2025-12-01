Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B0288C34
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630723; cv=none; b=tr9poNrLcb2CdMeIPCnqedZmzoe3sTvu1zb95KtYRJVbOdhLfiwz0ze30CfTfZzqh5oqNkcfwKR3KGwnVBbm3Le3eeZnp8ZknL93qBo16JIbeovRyhUdH1gpX6MawNt2m6ZoOmx3PExj7WI/HPDeE/w0XghqrJnwyCJJeVH7dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630723; c=relaxed/simple;
	bh=J+kLpkIMy3513Bm09of6YHNMGo8AAMwx8rUXVBwzd2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk5MXHxQQKdTKmHKEUp7VhxQaQk8CgxaIRUDMQYBzQtYi4eaG2YovpOm1t2Vkx60WB7J6wXvbwJ5xBnWJv6A8/a5FssWVU8w/MCDiL/DxeSwL4aMzSzLvGxj3+HUiXHjhQj0vfRd2MO783oTLYKYmoCQg4IzpgmMF7N+Aez0Qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1fX+fXb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1fX+fXb"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4780206a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630721; x=1765235521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLM1EPntpvB3fDVLGw42FElIkaQKNx9U9DS+XMsl0fM=;
        b=r1fX+fXbEJlouqcyHm3JSiPgfdPmHqObRKzGGfTP+vyJ3nKoJtwz5YKpRg3V9YNauf
         LJC3PB/m6vlOtnd6FBQ4n0zTD9gxg9kknLe96Dm76uoed9/G8Kph4/zHm1y6bGlTra8J
         8VPPFd3SAwqJ40jYZeBJqtBxf/FlDLTzHB86+H5lmYzCJVbyujwfcpY9HB5Qz7wNzr+D
         81EJU6/vw5rzcH5msgJrtW3unzt/USSSFVzY85OBA5XNxoBwnTqSiSnOEJgRnlsKf2K2
         gcFXi0CAc65NbjnpYgVXpR0vsVmLLNpqZ8jF1Ajf2VfWvRi9UlC8z8fXVCtpRYMqWsrB
         8UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630721; x=1765235521;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLM1EPntpvB3fDVLGw42FElIkaQKNx9U9DS+XMsl0fM=;
        b=IREeDl99+phQ3q0mG3JdzDfjhWpr2mYL3dWXU11Svb4/R8YJ/3q+f+o0XEPgVK9LLU
         Y9b2j2QZrRH47HigLtovAiWj3YplntwXfwrvAkItZCKyh0G5adZnOoMuZ7/znhjLSPtY
         kK+cR0ZdimPOK9dhGizQ197HUmt4DFLW1gXiksx036hEJ+zf28ZzFZLjMhAOU6a81ijM
         3Ln4niFLstzpcPBc13cIumGUgTEiWx//OI6jS9eU1ei+SUQuvJXMQiTNq1RY6zpTkd0S
         VJdYLGTTYj74ofrEsNEeE6mDrxxN18smkNru+NhXFtqbC7riLHgpW1MykE+l3ZOGOz4c
         hjkg==
X-Forwarded-Encrypted: i=1; AJvYcCUnNN1NZqIGVzJ4Sb9m/tBw3UFY8imn95ezDCKdcy48vTC3Pcsmz33jWjPv5Cr0KzcydQpe+aMAaMBDswM9MjA/@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGUMq19CLRXOgOcSu2Y9sYcLvPx6oQ6K3MaVRlJM3X4vYH9pU
	aQguInagYi5jFoZHzBjFXCjw9XA4I0KHrMOLh5dF4lX0suwQ4AQTRNxSqlp/y9BDOLzmCoeSyTr
	RUQpV6zfpYA==
X-Google-Smtp-Source: AGHT+IE1+zlv+/Ra8/4fDxzAvPN8JlMMEIwYI0833qsjS+sqfkYoQe/VtqWugCSuUH/u1MaLnSztSAazoE5b
X-Received: from dlbcy37.prod.google.com ([2002:a05:7022:ba5:b0:11b:9bdf:e45c])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6898:b0:11b:ceee:a469
 with SMTP id a92af1059eb24-11c9d85feeemr24650965c88.22.1764630720912; Mon, 01
 Dec 2025 15:12:00 -0800 (PST)
Date: Mon, 01 Dec 2025 15:11:45 -0800
In-Reply-To: <20251201202437.3750901-3-wusamuel@google.com> (via kernel-team's
 message of "Mon, 1 Dec 2025 12:24:35 -0800")
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201202437.3750901-1-wusamuel@google.com> <20251201202437.3750901-3-wusamuel@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx88qflajbi.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v3 2/2] cpufreq: Documentation update for trace_policy_frequency
From: Tiffany Yang <ynaffit@google.com>
To: "'Samuel Wu' via kernel-team" <kernel-team@android.com>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Samuel Wu <wusamuel@google.com>, christian.loehle@arm.com, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Sam,

IMO this type of documentation should be in the same patch as the
related change because having a single commit makes it easier to track
(especially if/when these changes are cherry-picked to other
trees). There may be reasons to keep them separate that I'm not thinking
of, so if others disagree, defer to them!


"'Samuel Wu' via kernel-team" <kernel-team@android.com> writes:

> Documentation update corresponding to replace the cpu_frequency trace
> event with the policy_frequency trace event.

> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst   | 10 +++++-----
>   Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++++-------
>   Documentation/trace/events-power.rst          |  2 +-
>   3 files changed, 13 insertions(+), 13 deletions(-)
<snip>

>   A suspend event is used to indicate the system going in and out of the
>   suspend mode:

Otherwise, this change lgtm.

-- 
Tiffany Y. Yang
