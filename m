Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA9219E93
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132658; cv=none; b=IsVWuvZ281M7prAm+HfSCXjf02K7Ig5J+RgHW11S4zfRHElTcxrVfCE7CblZalHtJmalmeMrn1LLMRiPVhCFa+EOPC0w7ibXOqOWb1aqs0N2D7X/GPViAnY7e6JP1yE/zTXBmVUuI4Pl6+5Zfo5uPI/C6Z2WD570Agh6BfFeww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132658; c=relaxed/simple;
	bh=zdUKaEQPaR0Y8p/zfg05UZDAo7TL4JCVF0QTyHSO8x0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E4YitfP5S5+Wb9q/UtDfxkz8gm67D5zr2fVruGUy+LmI6/HiBN2a/Z2EGn+03NNtqa5/rwhRZgJM5GQXpQ1MAHrZpoq1v95QTP00fj1Tc33cyuZYwIBYE8QLKOQNBLGh77OrVdP9S/EPF8tr6i2VTAH/shbbx56Cg9D5p0pXf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=FobE9HHn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="FobE9HHn"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso46773721cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753132654; x=1753737454; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGJk1iJIsjh54/ScdRo2P8arFiYQbmD3zTFqCzvJy0=;
        b=FobE9HHnoGddf1Gua2+kXxL20cg04/Zda9sIKfOv+pjKCVRh56NSlXaxN0PSS+GkDS
         y2vuFHhIlV/5UmzZOqrrHzoJkEAr8x49oUkF/VwlKZBARqO6WOZW7kJyBeiRiwlvnA0K
         uz0Z46aQGxpLqMUGXRwPOerdrkc58VzyfuMJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753132654; x=1753737454;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWGJk1iJIsjh54/ScdRo2P8arFiYQbmD3zTFqCzvJy0=;
        b=Ltz79s7ENb9UmpV2o0raluRBQ/ugQKViD5Vaz4izoE1ci5wtN3G45/y2KFHwqDsLwZ
         d+ZTA+3kMaDhFclNS24gFpaPiBGuWewbc14K72867hgHt9L3rwKopAyl5tK6BXJxgoS/
         c7hE6yE6HxBPxo07Cggpz4FvcUXRMHebKYFpfxComcG7/BjxbWqOdZwiQNDBCwS6BpuI
         gVZ6MFlLxrJEDnqTOQXNUXk/CYIQx8SUecJEgpdhI9iIerXCbB+U7j1Cs6DVtBsH2HRW
         IGbJ6MWIur17m/G5lnxfDEJ4BMAiOCBiw0Tle0J40B0xuJbgsN0eEBdpwO3J7sqo/v1M
         6UcA==
X-Forwarded-Encrypted: i=1; AJvYcCVqcalQcKcoapxF3rmd36odj/0B4IeNs/tb2E2hbszFf9Z/p5oEHeMfXxZn7sw+12NwBYeQs5XLTA+rH5UeF5SL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4I0Qsyt3hrbKq507+QE8uPA2lx52fNucAk7yBIt6yhDPSkS0n
	cNyNMziWN+5Eu5i20mzOWYnHu9C9TWL0V3bJna22Am78UqahKMiMNQYtvYEHL/0Sbw==
X-Gm-Gg: ASbGncvlR43n815r2szj/eCraicRYOvHvxzHbVRbvq1jqsIwOUxBi5IfjMWEI3jgOrs
	EEIqVhp7MB61jMMH0zR6fHbnTPxITTJPaWUarJ+MRBGWD2MhxAx8t9QwfYX8jGVneui5eM+3ZMu
	BGqVz2FSAJbcmgISrlkSvwchPwtwrizqBGH6WR0pskdXw5u0O1vpG967scUZwANBT+fd0bV4qyF
	Orabm3NWaeSqvsbY5EvREhHoAFmub2S45/UiOMOxUwoa4ttG/qVna4J9m9LVpcJb9XK0z7d8FqP
	ijTPBT/y25DJAyO2xPSAP2hsBDky21sGDn2rHEaTrr9zvOd3OnushAT997lS/jRitdCfrllxdeR
	cjxyZpK/X0TrNHl+Wbn98M+l35CswC5869bVzRe6QrQ==
X-Google-Smtp-Source: AGHT+IGgbc2+HpbbkCjaHb07n+MxIhFnG5PNcc7/sdOmvMZ4DuULITdNYAqCLBKU+qLcRC76lYXY1g==
X-Received: by 2002:ac8:7f93:0:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4ae5b7c3eb5mr18526461cf.17.1753132654248;
        Mon, 21 Jul 2025 14:17:34 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b46b27sm46652641cf.64.2025.07.21.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:17:33 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Mon, 21 Jul 2025 17:17:32 -0400 (EDT)
To: Vince Weaver <vincent.weaver@maine.edu>
cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
In-Reply-To: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Message-ID: <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


I'm still tracking this fuzzer issue.  The fuzzer can reliably trigger the 
crash but only 32000 syscalls deep into a run and I am having a lot of 
trouble trying to gather a trace/testcase that can generate it.

I was hoping the recent
	[PATCH] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
patch might fix things as the symptoms were vaguely similar but that 
particular patch does not fix the problem.

Vince

On Tue, 8 Jul 2025, Vince Weaver wrote:

> Hello
> 
> the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
> doesn't look obviously perf related but since the perf_fuzzer triggered it 
> I thought I'd report it as a perf issue first.  I can work on a smaller 
> test case but that might take a bit especially as the machine locks up 
> super hard and requires being unplugged after it's triggered.
> 
> let me know if there's any other info I can provide.  The dump below is 
> transcribed from a screenshot as I still haven't figured out a way to get 
> a serial console on this Raptorlake system.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
> Hardware name: Dell Inc. Precision 3660/0VJ7G2
> RIP: 0010:rb_insert_color+0x18/0x130
> Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
> RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
> RAX: ffff93f1927f8168 .....
> ...
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
> DR0: 00000000a000001 ....
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  timerqueue_add+0x66/0xb0
>  hrtimer_start_range_ns+0x102/0x420
>  ? next_zone+0x42/0x70
>  tick_nohz_stop_tick+0xce/0x230
>  tick_nohz_idle_stop_tick+0x70/0xd0
>  do_idle+0x1d3/240
>  cpu_startup_entry+0x29/0x30
>  start_secondary+0x119/0x140
>  common_startup_64+0x13e/0x141
>  </TASK>
> 
> 
> 
