Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F92BB04
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653142; cv=none; b=Vfiq4BiNILsiIE1tNOQ9hUjhiTdGQExKAcOQc2ROiThMdMDUG+HT5cbjLA4yWSFnaILgv+zATv5Fc+nqNfvFnkdW1xfDTDYHjQPU+ngWFwhSW2LdcCQ+BfRojoLutTKjm1ClgJKq+GOAguA4my4incf2pDnvJCCuG25wNTtAuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653142; c=relaxed/simple;
	bh=SRXJc+/v+1LIkdE07fyxzRSfvp00XTj8LyVYf5274DY=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YgUzDjEj2zetzoa+x00S4fDkNgCabl9A2LrfWw/+NGCB0Fn2APsKlN/fK7uZ+JQWWokyL8JW+3afJL1mTSWTR/Ovx+B4kh6hZFtMGiloxX4iS49o5u80GZ3D/CP2BnF522A5nWQfUgCIu1FcZafgElbNObjllJGGvTHkE2jO+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=QtaXUq93; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="QtaXUq93"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d3939ecb7dso334719185a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1749653139; x=1750257939; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfbJyQPrMZeDp78Rg2T4zqF8WJjcnPAUY6gfdhylnlE=;
        b=QtaXUq93ytXVI6m4XomHL0m/8uib1RIR4XFMVGMUtU2ZHYVITRlC8JH50NfhZJTrxS
         c9wbxf2UhMpMtLHTE676Jg7/OY0KKUtYUa59OdLMw23U8bNUv083RUZn3thLhLNqFEhN
         9kNqSO9+v/eS1nlY8vGnW3B2fp2Stg6lAgHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653139; x=1750257939;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfbJyQPrMZeDp78Rg2T4zqF8WJjcnPAUY6gfdhylnlE=;
        b=ooQgczeWa/Ozx4PdLFJbXBi19T3kyznfyz/sZ1veAA0YSrfhz3s0UxN2UOvN9L+mb0
         pTk/g9ZZtrnCC5dZXpdq5WnmenMTUHRJivBuax3G2EGVq8UuOM/CnHT6iUpjH48dL5Qu
         oJg/QnZpY7SiEluUV9IyL3HJBbYzWueqv76U6TWAd78Mt7ZL+f/fYH4CucPii+kj90VD
         FuW9X3C3i3zCXYUEmEV0/bGZFLaMgm8gLhFu6o9OiSybbt5MnLDW7pv9Z2wZ1EtP1v+o
         uz0Qpw31LLypi/85/Qsa8XQBmSyfZPKd9aQZh0hS+5/yXP3z5oZs1ut/2CHyGuAuv5As
         Xavw==
X-Forwarded-Encrypted: i=1; AJvYcCWHCcJz2WGEnxtdnjbCXcBGR/FBqGDalVgz5kuDkyzMswnk/cu83AOQy9S7bGssG2RI5cnU6XOiIjh60KAopIBn@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1cv93mRT8SGS9FG3ETFqKEchGh4RhlL/I9HP5QRgZuEhY25K
	zHgEcFIU481gnj5U0MaYO0i40ZyqKVyorQlIYrEWdiRONT21rlEZzFJRKSShg1zfvg==
X-Gm-Gg: ASbGncsloBsLgYLR11AXfClB8gxZeIhXtNlwfTcRDIK24bSXeLMIiFc8FJNT7cGo8ST
	Feg6UpIHo09BeyLq83TZNJQWBgtcByo8ieo/B1uL7S8/n2C+DIN0Nx+JXWPV9ohZw4ilFUC2o56
	ik/wgf7V7bNdRKMwtA74UBfiur8IAwjBnBDzjo4wd54vMGFmr46UWlfADT9fWJygY6Esnwf2Su1
	nj0mWwkr31W4R8V6Ccr8JIHdBnpc5roudMOsevDQwkKQBsKH0G9My6CWZQ1qM0Dy++zpqpJo7qD
	L5c/BdPwOv0gzwwkXR5YZFwhxpRDdQIOBpMiXJ14/DGJMTYWXnA/udNT3BmR/ZKi4VvjWjZgaRO
	jnQ1pOQ==
X-Google-Smtp-Source: AGHT+IH+DKL6K4/WPA2RhHiNNf/xq1FLisWHBAwHOLkFnDa7gAGYcOYg9/XqQ605Um/pwe9fvlkMrw==
X-Received: by 2002:a05:620a:4144:b0:7c5:5859:1b81 with SMTP id af79cd13be357-7d3a8903c14mr535543785a.57.1749653139282;
        Wed, 11 Jun 2025 07:45:39 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38c57a71csm621980885a.30.2025.06.11.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:45:38 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 11 Jun 2025 10:45:37 -0400 (EDT)
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: [perf] crashing bug in icl_update_topdown_event
Message-ID: <352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

the perf_fuzzer found a hard-lock crash with current git on my RaptorLake 
machine.  Appears to be in icl_update_topdown_event()

this crashes the machine so hard that I had to take a picture with a 
camera and transcribe the oops, let me know if there's missing info that 
would help.  (Also what's current best practices for getting dumps like 
this on machines without serial ports for serial console?)

This does seem to be reproducible so I will try to investigate a bit more 
too.

Vince

Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
CPU: 23 UID: 0 PID: 0 Comm: swapper/23
Tainted: [W]=WARN
Hardware name: Dell Inc. Precision 9660/0VJ762
RIP: 0010:native_read_pmc+0x7/0x40
Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
RSP: 000:fffb03100273de8 EFLAGS: 00010046
....
Call Trace:
  <TASK>
  icl_update_topdown_event+0x165/0x190
  ? ktime_get+0x38/0xd0
  intel_pmu_read_event+0xf9/0x210
  __perf_event_read+0xf9/0x210
  ? __pfx___perf_event_read+0x10/0x10
  __flush_smp_call_function_queue+0x37/0x70
  do_idle+0x144/0x240
  cpu_startup_entry+0x29/0x30
  start_secondary+0x119/0x140 
  common_startup_64+0x13e/0x141
  </TASK>
 Modules linked in: ...

