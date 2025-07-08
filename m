Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2F2E03ED
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Jul 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985897; cv=none; b=dDBo6zuHFVf+Ra9zGv4wxmOisR2jqBj99L0IJtoJrRSmv+c6mHkAmjddHzPImHcpDWbmHmcCQYu4dKHF7SGbzAjMX2+qotuBB7AufRzpKckQa7NAH+bqsZwXLXUsPHfljqCxOytPvLxnPSGXPqBXgp3n7MBSCH3p1Xs4+HTsuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985897; c=relaxed/simple;
	bh=fN4tOIQJAoq+AKMfht5dCRp3iRRsCe06SubkHAC/Bdw=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VeObq9eTjeSaQtDZTSTKuwDp6ZTtYh2IpGo9rI8g/2G53VxzzUn8hfHJ9mVzzOhPW/4PDP3D8zE75PbPAmtRx6SpCaT0b+WUZiDIfXrZ2dCqojtcPgNclg7GN7J6YYiJFp8HZcSvOMZauXOiAh/LQzLgQdt3yJBQIRtOo2SPL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=OnZ6/4kz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="OnZ6/4kz"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a5851764e1so99885591cf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jul 2025 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1751985895; x=1752590695; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzXFZEk6yErY6D/LjQRstWxZLYYVjR6/95xhHqGbv20=;
        b=OnZ6/4kzGFD7k0pSK2stL7IDrMFKy2Q1fNgKN113CuLiP5xMXzNqm1RK0mpP77IVXh
         pdR5CVi4JPBnTjx/x9iui7FExv9ufpbgBJ+P66qiG9oeECAckMQgXWxvadwkF/yU5d9q
         jfRcItcFSLCW2GUjgXa2sAyhcUGu1RYspODgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985895; x=1752590695;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzXFZEk6yErY6D/LjQRstWxZLYYVjR6/95xhHqGbv20=;
        b=CeUu7h2vP2njwAn4HHObpTgogvPiqHnOswZNfM2Oc5DRfRro9spKatC5PIfS84oq0i
         GYLBF39nvPA8iRC3uxNOtgUtXqyUqWkDyRwh2ID/aY6Dtul6zmMOjQQEOGqb+yDJG4cf
         dQJHSR83dK3CYLJvw4zAB5gkT8reEiV+uxklw/R08/0dJb0ypQohcxi/zFAnuSpBxU+j
         wstt/lsCGaBL0UQ7pUrqqvD5IsiEMEIwVsABftH4E7s25rWaFsRMC+IDsgAaBhmUPL1y
         CObSA2cZOUWa6WIhMxnuEm2HTvI0iV9SWakVpivPWgy8bwpJKSRdscyfxqHVNci+Vj4W
         CtIg==
X-Forwarded-Encrypted: i=1; AJvYcCX8nbP9MFrnjE9zpIuY6+MymE8ku9lH1yChdTDVoXT+ZiPFBkqh10zhBN/rLMUMtbiUnnLwfejIheekNyXQH/oZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTYoyVm2zbCYu5Ru6rkcOxKeLJpYBBy0yQnlbQjhlNaZhthO7M
	tTklWow8rV1YHeHK6pnXIcgHh8Wv9fZ97e7TFOIpZeKiV+o8Ukyn4uMdvQhg4AEQig==
X-Gm-Gg: ASbGncsmSJex3z/DGLFwn5ElcSJQswEtUtCExJuBMjLuMmBylNZYykFGEDaF8B3xi+/
	W//6roeah9U8CnW80vpO1tOzvrKSrd3dgnf2/N2TO+JFOypU2VndskDG6rubB+i7rS/0vtUsr/G
	6/OE0KoGCoi4oKet9q+8aOi94Fpu1qnjtolA8CSdW+LCiiPoF4ZxD3sy8BWTDcVUE7g4AOJf8Me
	E/ZgUlY1lyAH5gYc3t5ESznTXPLdbXP+1ghNzwdL/wnEQXZ+UU20W6aTN4X10wnMybj/Yuc8mtp
	tn7g+7zwTi3LmbaG+Rx1BOFPCmo8AvxhMWuZUpKRZG7vh8I5vhEwAP0PJzxZ/w6iyFHQzevyIY2
	m4tyQDQ==
X-Google-Smtp-Source: AGHT+IHsUOny0OkJ2EB15KMJQvEZrTOer5pzJrOyVcvXVEprUMWypU/1HP1gAhVYH0BuTrhYNhwDPQ==
X-Received: by 2002:a05:622a:191e:b0:4a9:5220:7fc3 with SMTP id d75a77b69052e-4a9cc6ca287mr59779551cf.18.1751985894660;
        Tue, 08 Jul 2025 07:44:54 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79106sm83843961cf.45.2025.07.08.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:44:54 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 8 Jul 2025 10:44:49 -0400 (EDT)
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
Message-ID: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
doesn't look obviously perf related but since the perf_fuzzer triggered it 
I thought I'd report it as a perf issue first.  I can work on a smaller 
test case but that might take a bit especially as the machine locks up 
super hard and requires being unplugged after it's triggered.

let me know if there's any other info I can provide.  The dump below is 
transcribed from a screenshot as I still haven't figured out a way to get 
a serial console on this Raptorlake system.

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
Hardware name: Dell Inc. Precision 3660/0VJ7G2
RIP: 0010:rb_insert_color+0x18/0x130
Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
RAX: ffff93f1927f8168 .....
...
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
DR0: 00000000a000001 ....
PKRU: 55555554
Call Trace:
 <TASK>
 timerqueue_add+0x66/0xb0
 hrtimer_start_range_ns+0x102/0x420
 ? next_zone+0x42/0x70
 tick_nohz_stop_tick+0xce/0x230
 tick_nohz_idle_stop_tick+0x70/0xd0
 do_idle+0x1d3/240
 cpu_startup_entry+0x29/0x30
 start_secondary+0x119/0x140
 common_startup_64+0x13e/0x141
 </TASK>



