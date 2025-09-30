Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EE223DDF
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221225; cv=none; b=hdJDgCkOLq1OGde9nEVcfGAs/CmCujarQRj/xPyg/jWwA32HVkikEQlh9zk3OszvvY5V+RX1tCtOQzCwhN9Rk8mlpoddzxDTWFYzsB+X8m+sdfUBoF7S0NluLwJdxtL7Z13RdKhMHfKR5Af8R3t/H2LaNypPGOA8UfafyXK/zQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221225; c=relaxed/simple;
	bh=b84z4sLj6OipiU/LDADQxD4tH4RaTd5fv3amUZ6N038=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=makm+9y1VmfIUg5U9ypPx1t5Md5F65/473SJveCHN5JnexCJ0inYLCXiLgS0UKadgxPCHuIxLzXkLpnF3+wzBiewZlz/GVro4spv93xER34TgdiuMZNlRLuK58QY0907TrVfJi3IZMudDYp2XjD1WyWZ2I6oEV3uCAwvUJHfAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH0BfA7p; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH0BfA7p"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-72ce9790acdso63893037b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759221223; x=1759826023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBOPU6N+QlAarzu9LlqnD6xE/6f1CWCmb96507SlQ5Q=;
        b=jH0BfA7pDo+pX7Z+tkcD8+wAy9cVudilMudXZukkQ2bgWYdPTHjDwiE0aFeVDWeXuy
         OsIfUnhzVXpL+wZUYsn6bTKdYAOJOrH5b/TP4fGJWmcL/URvY1RxlixYIKxAd0dz+JmJ
         V/svmB8CJAtAnFGFxcdoo9SEJLdW5eyTaPqP+yCEuweVPs+ZvXGrMJLDfYvj1WsqiT8P
         X6Vf1esS5qkzi7kgvV5OFGboqEyVQImNjLMIk1EojLiJl2DOjpvXo44WbXdgPL9d9I67
         REA9W9K2suAWQqA4wwMxhUM/JY+/h1M5SKMKB94tZ4FypM5+Xg895Jw0VqQicGHGNwDB
         fmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221223; x=1759826023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBOPU6N+QlAarzu9LlqnD6xE/6f1CWCmb96507SlQ5Q=;
        b=TtMcf6dxs2pflgM8eov+PYZc4+w9oRtqo6GIfWuJIUFZQ8uAgBzQ2W+l8yn1BKWHIX
         eowAzG+3nHRM6+gbaDB6GLUms1m9UmVlBC4vV7l3BFovWm+niKCTBvtR0lHO0ZJ2eRUr
         EpL2GaeNCIOmLsStbwp40o97DWE+V1YCjxQJ8yAjb3BLCN9kBoQMIWxuLCEemtmJBdGJ
         KU48hwbxHcnQwndqe0dIftIeJjEj8qI9TLpB+LXRlj9KQK1O4BCJ04HbizwBaEigCbBb
         R3Hd/7n1V2iw1PxyCv4xrrCa6jz8iluLb1acz4nTLKco0wWL7/XVkSzp4vhjp9fq2uWP
         4QJw==
X-Forwarded-Encrypted: i=1; AJvYcCV8zSvTQ/s9gD/Ydl0IYLM1UxQfyTx4Cn8Fa/9lxCmuyT0irBGsG05pntU3TgkzESEJdtv4Gp84MUgP9hyw5zy7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8XfRujfKdPkp3ZrKbMeetbP6QheZ92edH/0g2RytKoCkGcpq
	o01GhTCSarXbKMK+9JlT2aXEe3qO63udOAqmGFZU+UEP7RGUJShuY3IT
X-Gm-Gg: ASbGncthxKCfT5bDHW48nD//+bo7P1DFbMRcpOktYG4JObbAs7E0EHz0KmUnZPMecRa
	38o0bTpW6GPHc9xTDx/EMvWgRF6HiAQqx3hgjAJZByjNse4q8ZEihe2rlfVc+rOCzHRhgptcHgf
	WetQuF7y06gLxINR4ksognrXS1hPqDFuK9VSye0KVuLTCgls0y6Zkee/BI3w8EWrHrW1JGc+xI4
	y94Fzlbzosq28jVdEcrbozTSrNU8XpgwK5LrIj8FSqvCIaE/4kDcmkAEdWgZyan/OyKdAHNXWBp
	YwV0b/7/bFCbY00Iqcc9x+KY9xm/gmujb7ixDS46L66BxFjJL8onmPbagU5N5SpcgGZd35827f7
	06qQ5N36XRQfJBIc8wa/5PVhZbibdLgVAxNHw0z8C9HFw4zsyau2FD50DNJhuBISHOqJN
X-Google-Smtp-Source: AGHT+IGdR0AHEeCd0GI8ArsMTXFyr2HmyKLRFM1XYpy12MOYMkBlzY/X5jDZtYeuuUkt/8DMB9hqmQ==
X-Received: by 2002:a53:d015:0:b0:635:4ecf:bdd1 with SMTP id 956f58d0204a3-6361a8d4824mr21581008d50.51.1759221222864;
        Tue, 30 Sep 2025 01:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d875sm3280311d50.10.2025.09.30.01.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:33:42 -0700 (PDT)
Message-ID: <7530d25c-f4ef-40bc-9ac8-40de4abe3960@gmail.com>
Date: Tue, 30 Sep 2025 16:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/23] tools/ksw: add test script
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Potapenko <glider@google.com>, Randy Dunlap
 <rdunlap@infradead.org>, Marco Elver <elver@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sami Tolvanen <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
 Naveen N Rao <naveen@kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Nam Cao <namcao@linutronix.de>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
 <20250930024402.1043776-22-wangjinchao600@gmail.com>
 <3ed8a6a5-9983-4b9e-bae1-4c433568de16@redhat.com>
Content-Language: en-CA
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <3ed8a6a5-9983-4b9e-bae1-4c433568de16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 14:49, David Hildenbrand wrote:
> On 30.09.25 04:43, Jinchao Wang wrote:
>> Provide a shell script to trigger test cases.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
> 
> Do you think there could be a way to convert this into an automated 
> selftests, living in tool/testing/selftests/TBD ?
> 
kstackwatch_test includes 6 cases. Because KStackWatch is aimed at
debugging stack corruption, several of the cases intentionally trigger
kernel panic. kselftest is designed for tests that exit cleanly with a
status code, so these panic cases do not map well to it.

-- 
Jinchao
