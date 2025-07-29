Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577D288C32
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807842; cv=none; b=AZ/TmbQt6sdD94W3u9jbCrJqVN1UOfJzZqSS+uwxjZdMfUnLLH9zVru6zKOs/Mz5qUFCz00Apd+F434ipibaFzlohddO+8jJ1vW++ldBLSha7J2K1D2fpm3HXfvNSJruvC8Yi/6P7icaubdEAe4Us6ZcmUofBEo5xbbTsjkyyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807842; c=relaxed/simple;
	bh=wVS4ZGXL5Q8rCd9VTXRYor1vj7ZS1t7rfVvHPIDALDI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iqBz8OEzcBMYr2Z0APSsASvKCqDl+tjs4ep91I3Myigtw44/kRj/ZrNkHKbedeYPuHSMqQ6l9y/s0iGsR+vLzqrBvmOm1U7shOg1h85rhnnx23Oz+qwsQCipdgFVPpIyryQyJiOsELGU+Kq0baKqT9akgcBO1jhhm1hM+D6mfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=CvvQTq4b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="CvvQTq4b"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45892deb25bso894805e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753807839; x=1754412639; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=suVvJU4WKFdmKsQQk2tvEAp6/zICUM8EOf9Pdbq8t4c=;
        b=CvvQTq4b4HB1CriswKIo+mckpjBDqeH6yDdIkhzSSm0Xj/1reoryBDEKEkhRsANvLA
         hA2udTr6+EFYhwU8107+qEChA05vO4y1GrO1LvujfDeYj0itv22tPiKr14V/yZPy4Yxy
         p2VTVodYpEh0WbN8Nur2skdyC3BJIYWM8Dqjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753807839; x=1754412639;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suVvJU4WKFdmKsQQk2tvEAp6/zICUM8EOf9Pdbq8t4c=;
        b=ghN3esXmwI1jf9VUPu392bK/4xx0NOWzIM9JYRKiHzwg1J0xdqYPExqXGbxOlgAFzL
         R602CV+zE2Ui3NyszKIuQhurOD3ixX3BxNUrboxVYsfw5isSCEFt3kD5Do4ppzeZ7VMN
         +k37xl873iMfM0C67O+1Y7epPFEimPRMW/LyQSV3+TEZoNSoFzmn73ZaQIKn94jWIITQ
         002o9OKjhKJIZhGCqiV6/L0n+gL0d5pwGPDbFs4WXSMEemDneitZ9lPac8rhS3BVei86
         8VNWv9BAwFNS1ttIE2WUE5/YNXNU/pzqNrXww8ijF2LhyZ8kOdp0GLHYiHzWt5rHKbL9
         bHSg==
X-Forwarded-Encrypted: i=1; AJvYcCUmUEpEMTbGRHs5hWTjrVneamOjMTD9QhXhpD8BgYV2TljfLXJp8a+MgcenxXr6iVSS5Bu2M5n26WcPeW3ETZRc@vger.kernel.org
X-Gm-Message-State: AOJu0YziLASLvoiCD3/xtt6t3b/sVOHUAPuEM3QHn2kJh+csJyoYQrA6
	1HW3tF/aJvLO+879SDx/TrReP93Eot4Mn9++N8V8RIAOlcqdJobN4ExpNGyIg97C0w==
X-Gm-Gg: ASbGnct5iZa7rQ6QH5KttPYTUHuB0CzqAJunwcIGkJw5qdujB16uLatovpwZJumuNDf
	ax7aZ79rETjWdL1zk1+dI34y1uVEu22KS426GypmCGD7j1jdkU/SiipO9BxB/gtkFInHwOBXKYY
	gmSs+rxUJ9z6fRRJFJ5M6pSaYsDxLPX9sb8rxLpmRGMsXxXusYIKFhPDrkIThZs8cwhHgcOt4ZD
	kOkdXW5gKfu4Uks6sp01RZ4EdsGqIvA6CbN8beRqePVBRA+FuFn6uHs4TA4AYs4OAJ63YgpDw3u
	wF9vKxBjOPzAzAAHsLK2f8hK9LgN4tKTceHa0cB15y8F475kmbo3kdlygF2XHeCvDt928j1Fkxk
	Pw6s5AI37mYnVVftB0iwubP1jZutgRyjOg+nKRyTYgw==
X-Google-Smtp-Source: AGHT+IFrImQZIdQJ5afgNUQwJWxIUmYS11pLeuixhQihMfc6ma0YIHh7wftRZDig4J0+lfjlNM+gpw==
X-Received: by 2002:a05:600c:c4a3:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-45892b92f27mr5653835e9.3.1753807838783;
        Tue, 29 Jul 2025 09:50:38 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5b7677sm32030045e9.7.2025.07.29.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:50:37 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 29 Jul 2025 12:50:34 -0400 (EDT)
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
In-Reply-To: <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com>
Message-ID: <ff282f45-9f17-5790-174c-e765aae0038c@maine.edu>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu> <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu> <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1991168305-1753807837=:1913886"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1991168305-1753807837=:1913886
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Jul 2025, Mi, Dapeng wrote:

> Could you please provide more information about this issue?  Like HW
> information, how long can the issue be produced and whether the issue can
> be seen in latest kernel (6.16)? Thanks.

I just reproduced this with current git (6.16.0+)

This is on a RaptorLake system.

I can reproduce this issue with the perf_fuzzer but it is possibly timing 
sensitive and so if I enable fuzzer trace logging to try to make a 
reproducible test case it won't trigger anymore.

The system locks up extremely hard and so I can't really get the panic 
message besides taking a picture of the screen.

I can try enabling KASAN to see if that helps get better debug messages.

Vince


> 
> --
> 
> Dapeng Mi
> 
> On 7/22/2025 5:17 AM, Vince Weaver wrote:
> > I'm still tracking this fuzzer issue.  The fuzzer can reliably trigger the 
> > crash but only 32000 syscalls deep into a run and I am having a lot of 
> > trouble trying to gather a trace/testcase that can generate it.
> >
> > I was hoping the recent
> > 	[PATCH] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
> > patch might fix things as the symptoms were vaguely similar but that 
> > particular patch does not fix the problem.
> >
> > Vince
> >
> > On Tue, 8 Jul 2025, Vince Weaver wrote:
> >
> >> Hello
> >>
> >> the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
> >> doesn't look obviously perf related but since the perf_fuzzer triggered it 
> >> I thought I'd report it as a perf issue first.  I can work on a smaller 
> >> test case but that might take a bit especially as the machine locks up 
> >> super hard and requires being unplugged after it's triggered.
> >>
> >> let me know if there's any other info I can provide.  The dump below is 
> >> transcribed from a screenshot as I still haven't figured out a way to get 
> >> a serial console on this Raptorlake system.
> >>
> >> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 0 P4D 0
> >> Oops: Oops: 0000 [#1] SMP NOPTI
> >> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
> >> Hardware name: Dell Inc. Precision 3660/0VJ7G2
> >> RIP: 0010:rb_insert_color+0x18/0x130
> >> Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
> >> RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
> >> RAX: ffff93f1927f8168 .....
> >> ...
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
> >> DR0: 00000000a000001 ....
> >> PKRU: 55555554
> >> Call Trace:
> >>  <TASK>
> >>  timerqueue_add+0x66/0xb0
> >>  hrtimer_start_range_ns+0x102/0x420
> >>  ? next_zone+0x42/0x70
> >>  tick_nohz_stop_tick+0xce/0x230
> >>  tick_nohz_idle_stop_tick+0x70/0xd0
> >>  do_idle+0x1d3/240
> >>  cpu_startup_entry+0x29/0x30
> >>  start_secondary+0x119/0x140
> >>  common_startup_64+0x13e/0x141
> >>  </TASK>
> >>
> >>
> >>
> 

--8323329-1991168305-1753807837=:1913886--
