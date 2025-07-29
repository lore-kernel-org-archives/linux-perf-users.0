Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202818BC3D
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812394; cv=none; b=YOqNfjGKPYVIPvwyssf/T1c35H2XKjdNLRkDzV9z1qCVsnLxmNUqNUtGoN+nvyVUwHfLQUDJmB7Hjalah+uEug7hsBwLNBdihucq0EWQjT4OnL/YMMt1Ll6i6lyFPR9zAHFgNrjMzdNG9MnrgsiISRuRVW5x+EdC63UqHvtQngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812394; c=relaxed/simple;
	bh=UHjSZSLqRGvbAquAUIqqIg+kswpH3hdSmAuFD7Hm+LY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e6ozd6qIKo3yWpDWICGOHBpesVuo8elriZsqbrSSboDcN1DHHll3UOWZeWlF0rleSD5mHfxvwSNtNnpjYRIJQgaOrJu7CgqX++Zud0+d+aimu9JVvXJk8h9QSWLpdNp0N8J0p/PRAoO+aWvHHXyT7Pfk5mTybuOYxzaTbbOF5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=OmPDSU53; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="OmPDSU53"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e6696eb422so57385685a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753812391; x=1754417191; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3hsNN4tBk8HZkdsjsm/7BszW2d4F/WvJrs6hXwBGls=;
        b=OmPDSU53yW4c0HOBk/pNNCxpbb8o4JKWyqsPerfvy2a+YOXfvgtdwQX/k2NvrGqAZy
         B6mqEoTbupadND7lthUnBHG98d4CCaZ9Nw+6uFJAMWTFcF1pYsaF8QusVebdCTlWMWsm
         GsFTphcmPkJqeN5BERfzUH3X+KWyrkKoSpvGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753812391; x=1754417191;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3hsNN4tBk8HZkdsjsm/7BszW2d4F/WvJrs6hXwBGls=;
        b=TK1chTp7NjLheVy3He5fpMAv192Mjz+Z4IatbaSUIftxCJg9frN544zd589C5d5asw
         bNZ4wLrQs9Evtj2uaGAMaZ8Svi82hdvLfc0JuoccuNFKpS49IZ1QhdAfArbTAFcwqr80
         i5mVFptewc9HT+D1nVz+UESLsQa5HAbEUCHME1L9SJogr9uU0QAc4ZaU3kt3J50uVOxS
         Hx4MBHMJCSnuhEZJWFvonvh8ac+oQUBtYlESaNl/s7S3rk1xDeR2SQSaOn7SWy7YhmAE
         aTMxqOLFB6EEh80QPElMwMf3FNTLaPsvhDeW61afO8mz/dspcmW4MvYo1yLndCYZdAi5
         3F5A==
X-Forwarded-Encrypted: i=1; AJvYcCVNWPXsoeBwYhmiq5n3SYBqqNeQEDLU5HwAJQn0z5ndUMIBNKnMdnz9uQvKAPuFnn3FloQk6Vs5T1wsWB4LK00J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyshu4xIXKea2TwBmDClR2mkGdr0AVmyLvfN+th/8c13qNth4Y+
	A6vyEaZtOs/bdBDPS7GE9qSoQH6WoiBA2Pz9VCuyFN7sz11xlHDbI4A4olutHEywyQ==
X-Gm-Gg: ASbGnctj/ZmCHMNx+ldKwGzfrVO0InDZYk02to8xacZg6MVWZPTa7pjmwp4PAo4KH04
	Myu04U3TY5ylpUF+QA+03EZ3vCAfgWeZ8X/0gYHDfGoCbYwCK6v3FC8d3IDrfSBrZatRvcbmX8n
	EJX1W6oxbwRZN8a9+AypnvoPpvGU3Wb7yk+tnK4ViQPc1VBI3rubyWygr3VpkjCLEaPYcasA+V+
	05gebmYlMC6Iiwgptz/J8jSiuAjgejhnbVyuxqpn+axX0dG0NuQCZSX9s0M/rtqfdTgrjb/HI0Q
	gGhIUl05NH70aqsBkwTDpQh+RfAMvNMRfGJC7mjgUPdGGkkMx8CUw/qHrFiTLEHaJEFMRP/E9jF
	rw7enZQz5trgLUhYZVPLAdl30EoaATlrFg7TXXlnzwQ==
X-Google-Smtp-Source: AGHT+IGOZeWnoyllekiZdDJDMMRxSIQ5WNjBrcKo11O3Y6bTvb57Tzuub2uvd0v21wtUzUpTY4nOhQ==
X-Received: by 2002:a05:620a:17a7:b0:7e3:35e3:3412 with SMTP id af79cd13be357-7e66f3571b2mr32513485a.34.1753812391016;
        Tue, 29 Jul 2025 11:06:31 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e668fd0d44sm60133485a.47.2025.07.29.11.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:06:30 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 29 Jul 2025 14:06:29 -0400 (EDT)
To: Vince Weaver <vincent.weaver@maine.edu>
cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, linux-kernel@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
In-Reply-To: <ff282f45-9f17-5790-174c-e765aae0038c@maine.edu>
Message-ID: <6f2ecd8e-a041-6c0d-e4bc-7a3886b7bdd2@maine.edu>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu> <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu> <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com> <ff282f45-9f17-5790-174c-e765aae0038c@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Jul 2025, Vince Weaver wrote:

> This is on a RaptorLake system.
> 
> I can reproduce this issue with the perf_fuzzer but it is possibly timing 
> sensitive and so if I enable fuzzer trace logging to try to make a 
> reproducible test case it won't trigger anymore.
> 
> The system locks up extremely hard and so I can't really get the panic 
> message besides taking a picture of the screen.
> 
> I can try enabling KASAN to see if that helps get better debug messages.

I managed to get KASAN to trigger the issue without crashing the system, 
not sure if this helps at all:

[  115.636383] ==================================================================
[  115.636432] BUG: KASAN: slab-use-after-free in rb_erase+0xd25/0x1370
[  115.636467] Read of size 8 at addr ffff8881151dc0b8 by task swapper/5/0

[  115.636508] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0+ #13 PREEMPT(voluntary) 
[  115.636517] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.17.0 08/09/2024
[  115.636520] Call Trace:
[  115.636524]  <TASK>
[  115.636528]  dump_stack_lvl+0x64/0x80
[  115.636536]  print_report+0xce/0x650
[  115.636547]  ? rb_erase+0xd25/0x1370
[  115.636552]  kasan_report+0xce/0x100
[  115.636559]  ? rb_erase+0xd25/0x1370
[  115.636565]  rb_erase+0xd25/0x1370
[  115.636570]  ? __tmigr_cpu_activate+0x13d/0x310
[  115.636578]  timerqueue_del+0x68/0x120
[  115.636585]  __remove_hrtimer+0x84/0x200
[  115.636592]  hrtimer_try_to_cancel+0x19c/0x350
[  115.636597]  hrtimer_cancel+0x15/0x30
[  115.636602]  tick_nohz_restart_sched_tick+0x5b/0x210
[  115.636609]  tick_nohz_idle_exit+0xfc/0x180
[  115.636615]  do_idle+0x258/0x410
[  115.636623]  ? __pfx_do_idle+0x10/0x10
[  115.636631]  ? do_idle+0x2c1/0x410
[  115.636638]  cpu_startup_entry+0x54/0x60
[  115.636645]  start_secondary+0x20f/0x290
[  115.636654]  ? __pfx_start_secondary+0x10/0x10
[  115.636661]  common_startup_64+0x13e/0x141
[  115.636671]  </TASK>

[  115.637037] Allocated by task 1091:
[  115.637054]  kasan_save_stack+0x33/0x60
[  115.637062]  kasan_save_track+0x14/0x30
[  115.637069]  __kasan_slab_alloc+0x89/0x90
[  115.637076]  kmem_cache_alloc_node_noprof+0x136/0x450
[  115.637086]  perf_event_alloc+0x100/0x41e0
[  115.637093]  __do_sys_perf_event_open+0x39b/0x1c30
[  115.637098]  do_syscall_64+0x82/0x2f0
[  115.637105]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  115.637121] Freed by task 0:
[  115.637136]  kasan_save_stack+0x33/0x60
[  115.637143]  kasan_save_track+0x14/0x30
[  115.637149]  kasan_save_free_info+0x3b/0x60
[  115.637155]  __kasan_slab_free+0x51/0x70
[  115.637162]  kmem_cache_free+0x2f2/0x540
[  115.637167]  rcu_do_batch+0x39a/0xe00
[  115.637174]  rcu_core+0x3f0/0xb10
[  115.637180]  handle_softirqs+0x1bf/0x5d0
[  115.637188]  __irq_exit_rcu+0x14e/0x1a0
[  115.637193]  sysvec_apic_timer_interrupt+0x72/0x90
[  115.637201]  asm_sysvec_apic_timer_interrupt+0x1a/0x20

[  115.637216] Last potentially related work creation:
[  115.637235]  kasan_save_stack+0x33/0x60
[  115.637242]  kasan_record_aux_stack+0xa7/0xc0
[  115.637248]  __call_rcu_common.constprop.0+0xc8/0x1160
[  115.637255]  perf_event_release_kernel+0x2f6/0x400
[  115.637262]  perf_release+0x31/0x50
[  115.637270]  __fput+0x35b/0xac0
[  115.637276]  task_work_run+0x11a/0x1f0
[  115.637282]  do_exit+0x6c6/0x2400
[  115.637289]  do_group_exit+0xac/0x230
[  115.637297]  get_signal+0x1cbc/0x1e40
[  115.637304]  arch_do_signal_or_restart+0x8d/0x5e0
[  115.637312]  irqentry_exit_to_user_mode+0x12c/0x1f0
[  115.637319]  asm_sysvec_reschedule_ipi+0x1a/0x20

[  115.637334] The buggy address belongs to the object at ffff8881151dbf40
                which belongs to the cache perf_event of size 1344
[  115.637376] The buggy address is located 376 bytes inside of
                freed 1344-byte region [ffff8881151dbf40, ffff8881151dc480)

[  115.637428] The buggy address belongs to the physical page:
[  115.637450] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1151d8
[  115.637457] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  115.637461] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  115.637470] page_type: f5(slab)
[  115.637477] raw: 0017ffffc0000040 ffff88810004b040 dead000000000122 0000000000000000
[  115.637483] raw: 0000000000000000 0000000000160016 00000000f5000000 0000000000000000
[  115.637488] head: 0017ffffc0000040 ffff88810004b040 dead000000000122 0000000000000000
[  115.637492] head: 0000000000000000 0000000000160016 00000000f5000000 0000000000000000
[  115.637497] head: 0017ffffc0000003 ffffea0004547601 00000000ffffffff 00000000ffffffff
[  115.637501] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  115.637504] page dumped because: kasan: bad access detected

[  115.637517] Memory state around the buggy address:
[  115.637537]  ffff8881151dbf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  115.637564]  ffff8881151dc000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  115.637590] >ffff8881151dc080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  115.637615]                                         ^
[  115.637636]  ffff8881151dc100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  115.637661]  ffff8881151dc180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  115.637687] ==================================================================
[  115.637712] Disabling lock debugging due to kernel taint
