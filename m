Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B02D94BC
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883610; cv=none; b=Gu9MYs8898/oXZJBWOjfS4IKdJlCv9NZ9zl1tOS3KHjUWueef+J6YYOjPc0xxsIwmy200J6GeRojxU+6FLgZ5kgCr+kgEi4J9lSiSk01kTx5vcm3Jykt/pzkUUwHHBEcaXic6KtH4q6RHNqwsmZq+alrpVACzW++DidBKEDBtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883610; c=relaxed/simple;
	bh=IHzhk2MoW4xpq16rWlxrTfK0s7uTNJEKX5bczNq2v6E=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=G/7DjwzWlbhmKGtAuG/+9cq6BDVmCumXYzE6kzSuUubNumAnGtFLX3AZHraUSfQCiOuJxmbRyBfr/S0Oa1kNDjbZfIlkdJ9zohYaReKdiwAXr8OaPccpsd2fOdnYho2DVYp9OnWu0Ebi5BV4nAKmWyKyIF/3cUvVNhT8Bu9j3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=ffLBMs8H; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="ffLBMs8H"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70756dc2c00so26481576d6.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Jul 2025 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1753883607; x=1754488407; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfBKYiq3E5bby2FVP4Nb+uSJ1m62RFzk3S05K+Qp+E8=;
        b=ffLBMs8HD68Qhg7hNfhjI+aMgYWQ7Zf8yHZUxFQN7HqbwZWnQ8iv81u2SA7bwKeNYm
         Ne3opkfO/ZtKIxuLwoQrb59yWUgXAiSUF6xNzRzYqUgNRqTf7+3AU5w+EFGfnbz76Hds
         /s9EezDSvcpgP3CCwUbKFzHN8K3UYJ7dFGoog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883607; x=1754488407;
        h=mime-version:message-id:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfBKYiq3E5bby2FVP4Nb+uSJ1m62RFzk3S05K+Qp+E8=;
        b=OdkbKIiDMflMfYQIJoso48xtrPqr6fRzwIhR2Ro/rq3iXXf0u+rCuvlrIhaSQC/286
         Eh9NAlgtBu3j6C8tGnzBnwUAm6lZkpZDw90GUFLcsEHjd1e7pdw9EDLjhu84qZCN3d/V
         RVppLH7EdDYEBfja0DnH6ssSX0mEcQ41vynVU6p8z90FZT16eFxumQoFYtRix3SaOr8i
         UepPHX2lacVDUpFUoWr7QN3Gdm4+AvUmksgavbyZ+9yg4ElzN9SSNGX2CF/PvjBc2Ndg
         tbMnkhwS3KD0S19ZnqGXYBP7fi4jQr/mo7BbBiG2XXMrVEZbNOBFLPQtVAfTQFZSeyru
         2cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbp8Z44lMoUIQRw2qdt6OWlpeUAUdR4G8yod3H5GS0v1P3xGGZh/5U55bTK63PMI3vcwHOTWllEfqv9oFxI1Dz@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOmkoGXOtGSi0K9Kgcn497i/gcJLHFpvJiNgdwMQR7fnW5mLW
	clCAMzOKc6lusS4yl9fHGR1DsXEZDkn9lnFPUQjCTjgTrrOxkA65+4LHI/soepSTHg==
X-Gm-Gg: ASbGncvx9E4qo0zgn49F73CQb+CQRX+v6tqHhG4P0aymBvQdgcs2WJW7K8sJYMGcFr7
	hoT92LnJzywscsOo6oMK0oFJVVaRaQpeKuQpyp7HDipSSbIlLBFHaLgR46Ho0cUwbexTXMAhWuY
	f4MNWnJM5JY8fqU05IzVsQhqtXc5wEvsam7iGA3zOtFmbDI6oJ+ExO3uJgfgddzSuDidFopy/Gc
	pojh9Pt8TqIfSuTR3hslYLGR07cyV50NWnMceHnppFrPd5uSYkYmc7f/AK5AUJrUQg8YLNN9ZcO
	aoKKwskz3m0PrfXkBDfs11Q8mjkbzmILNQrtmF3YfgXcYlEgeRpLBXCOsnmxntqtNZSCWoS1sFp
	udkV2SJ+8sC8Do0kLaOSnFmmSXrHPcAq+5P6CKzv6zQ==
X-Google-Smtp-Source: AGHT+IFS+NsWWCRAZT7DU1w30WDWGwT6PJJLySC0o1Ml3zqCyPQFp5+54OL74nnoFTiSvL+lbNIZeQ==
X-Received: by 2002:a05:6214:c84:b0:707:54b6:1f32 with SMTP id 6a1803df08f44-70766de2240mr48776486d6.9.1753883607150;
        Wed, 30 Jul 2025 06:53:27 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951747csm66766601cf.12.2025.07.30.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:53:26 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 30 Jul 2025 09:53:25 -0400 (EDT)
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
cc: "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Subject: [perf] fuzzer triggers BUG: KASAN: wild-memory-access in
 x86_pmu_stop
Message-ID: <d869feec-dc50-070c-a363-6f677ab6d678@maine.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello

I was fuzzing current git (6.16) on a RaptorLake machine with KASAN 
enabled and it turned up this issue.  I think this is unrelated to the 
other issue I've been tracking on this machine.

Vince Weaver
vincent.weaver@maine.edu


[62790.535489] ==================================================================
[62790.535493] BUG: KASAN: wild-memory-access in x86_pmu_stop+0x80/0x2b0
[62790.535499] Read of size 8 at addr 1fff888770d28e98 by task perf_fuzzer/1142475

[62790.535502] CPU: 2 UID: 1000 PID: 1142475 Comm: perf_fuzzer Not tainted 6.16.0+ #13 PREEMPT(voluntary) 
[62790.535505] Hardware name: Dell Inc. Precision 3660/0VJ7G2, BIOS 2.17.0 08/09/2024
[62790.535507] Call Trace:
[62790.535508]  <NMI>
[62790.535509]  dump_stack_lvl+0x64/0x80
[62790.535512]  kasan_report+0xce/0x100
[62790.535516]  ? x86_pmu_stop+0x80/0x2b0
[62790.535519]  kasan_check_range+0x100/0x1b0
[62790.535521]  x86_pmu_stop+0x80/0x2b0
[62790.535523]  __perf_event_account_interrupt+0x3a8/0x560
[62790.535527]  __perf_event_overflow+0xf9/0xc00
[62790.535529]  ? __pfx_perf_event_output+0x10/0x10
[62790.535530]  ? __pfx_perf_event_update_userpage+0x10/0x10
[62790.535533]  ? __pfx___perf_event_overflow+0x10/0x10
[62790.535534]  ? setup_pebs_adaptive_sample_data+0x18a/0x24e0
[62790.535537]  ? intel_pmu_save_and_restart_reload.isra.0+0x169/0x200
[62790.535539]  intel_pmu_drain_pebs_icl+0x6da/0xc60
[62790.535542]  ? __pfx_intel_pmu_drain_pebs_icl+0x10/0x10
[62790.535544]  ? mutex_lock+0x81/0xe0
[62790.535546]  ? intel_bts_disable_local+0x53/0xf0
[62790.535551]  handle_pmi_common+0x606/0xab0
[62790.535553]  ? __pfx_handle_pmi_common+0x10/0x10
[62790.535554]  ? nmi_handle.part.0+0xa4/0x2e0
[62790.535558]  ? ring_buffer_put+0x18/0x90
[62790.535560]  ? intel_bts_interrupt+0x334/0x400
[62790.535562]  ? __pfx_intel_bts_interrupt+0x10/0x10
[62790.535564]  intel_pmu_handle_irq+0x1bf/0xac0
[62790.535566]  perf_event_nmi_handler+0x3b/0x60
[62790.535568]  nmi_handle.part.0+0xaa/0x2e0
[62790.535570]  ? __pfx_nmi_cpu_backtrace_handler+0x10/0x10
[62790.535572]  default_do_nmi+0x40/0x100
[62790.535575]  exc_nmi+0x128/0x1a0
[62790.535576]  end_repeat_nmi+0xf/0x53
[62790.535578] RIP: 0010:kasan_check_range+0x4d/0x1b0
[62790.535581] Code: cc cc cc 48 b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 00 00 00 80 ff ff 48 39 c7 0f 82 b3 00 00 00 4c 8d 54 37 ff 48 89 fd <48> b8 00 00 00 00 00 fc ff df 4d 89 d1 48 c1 ed 03 49 c1 e9 03 48
[62790.535583] RSP: 0018:ffff888126247c70 EFLAGS: 00000202
[62790.535585] RAX: ffff800000000000 RBX: ffff888128d1ac08 RCX: ffffffffa18c0551
[62790.535586] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888128d1ac08
[62790.535587] RBP: ffff888128d1ac08 R08: 0000000000000001 R09: ffffed1024c48fa8
[62790.535588] R10: ffff888128d1ac0f R11: 1ffff110ee1a51fa R12: ffff88816bce1ac0
[62790.535589] R13: ffffed102ba8cc7f R14: dffffc0000000000 R15: ffff888128d1ac80
[62790.535591]  ? mutex_lock+0x81/0xe0
[62790.535592]  ? kasan_check_range+0x4d/0x1b0
[62790.535594]  ? kasan_check_range+0x4d/0x1b0
[62790.535596]  </NMI>
[62790.535596]  <TASK>
[62790.535597]  mutex_lock+0x81/0xe0
[62790.535599]  ? __pfx_mutex_lock+0x10/0x10
[62790.535600]  ? __pfx___perf_event_enable+0x10/0x10
[62790.535602]  ? __pfx_event_function_call+0x10/0x10
[62790.535603]  perf_event_ctx_lock_nested.constprop.0+0x127/0x1f0
[62790.535605]  ? __pfx_perf_event_ctx_lock_nested.constprop.0+0x10/0x10
[62790.535607]  ? mutex_unlock+0x82/0xd0
[62790.535609]  ? __pfx_mutex_unlock+0x10/0x10
[62790.535611]  ? vm_mmap_pgoff+0x2cc/0x3a0
[62790.535614]  perf_event_task_enable+0x81/0x1f0
[62790.535617]  __do_sys_prctl+0x98d/0x1830
[62790.535620]  ? __pfx___do_sys_prctl+0x10/0x10
[62790.535623]  ? fput+0x29/0x80
[62790.535625]  do_syscall_64+0x82/0x2f0
[62790.535628]  ? fpregs_assert_state_consistent+0x63/0xf0
[62790.535631]  ? do_syscall_64+0xc9/0x2f0
[62790.535633]  ? fpregs_assert_state_consistent+0x63/0xf0
[62790.535635]  ? do_syscall_64+0xc9/0x2f0
[62790.535637]  ? fpregs_assert_state_consistent+0x63/0xf0
[62790.535639]  ? do_syscall_64+0xc9/0x2f0
[62790.535641]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[62790.535642] RIP: 0033:0x7faf2c2e940d
[62790.535644] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
[62790.535645] RSP: 002b:00007ffdccacc260 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
[62790.535647] RAX: ffffffffffffffda RBX: 000000000000000e RCX: 00007faf2c2e940d
[62790.535648] RDX: 0000000000000001 RSI: 00007ffdccacc294 RDI: 0000000000000020
[62790.535649] RBP: 00007ffdccacc2d0 R08: 00007faf2c3b2200 R09: 00007faf2c3b2260
[62790.535650] R10: 00007faf2c3b21f4 R11: 0000000000000246 R12: 0000000000000000
[62790.535651] R13: 00007ffdccace728 R14: 0000560c62688dd8 R15: 00007faf2c41c020
[62790.535653]  </TASK>
[62790.535654] ==================================================================
[62790.535654] Disabling lock debugging due to kernel taint

