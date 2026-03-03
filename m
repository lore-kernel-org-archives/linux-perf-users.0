Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA21A6801
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541485; cv=pass; b=AIjlnrhLPZlsWKyBHPTqA3lfDW1Fr4HMoBiWlTR8gFwg2sdQpS1GrdzNU3DZTLbI+r52efVCWCA106wwsqXzSl7imtnPS98a/iMaBCThKCcngO4Ig6bufH0Dju8ivtOkt2QtbH8AOTbxdrmmvHvsBsLTKSZSuRYVoamKKzYR6rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541485; c=relaxed/simple;
	bh=SE8OsuOearTbpLewa/D9O40p1Vtj0EdgohxwdO4h3qg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mAMPrLs6Y6bWW3N5yUNiGES6H/EzfPEK4+JU6R4HrDI0gv2w2hptWvNlyA3aicjZN+5xok+FvFdkPJf7D+8vETUuk/Wlbp0ugETXXKE5auE6N6DmIkrrzDFVwz46rB9ANNdzirVnmzCUhQKCxHXKqx1BTabLdHb5P7wR7TvDDB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIv2vAIm; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIv2vAIm"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35984cd0335so1037551a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 04:38:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772541484; cv=none;
        d=google.com; s=arc-20240605;
        b=D0l+1496u5x/HDIlleCQSUDSrjiPCjQ/9+jgtV74ODGFzOgvn0VGTS03JlUMxrRmEl
         8P+MgvlnQNLi8u79YEp3eb6B9CNNccU6blnuW2BGG9mfG+7IvtoBRyGba/+rWdAxBg11
         lcEYE6Vr9hXMxzIw3F9MBSPPdJ39JSHNVS41wMKq4Xyys7s5Bw1wHVfZVw7vP6cG0RUA
         vwFIUrOdMUP4EFuR+hDlouTowgVhSg3JE7WvmKLZBshGadiRmHyDL1sChxELFsp8ht4a
         FaZThlrZLqCJFWifqgTzpBH3WpOGYgHYUFR6hjyGofce1IdvUge9XB/5RhGFkBmY/GH+
         F3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        fh=NmBQp949CYc6hbwlIH4N4dXA03Ec05+S7oZYrruDNF0=;
        b=gvcR8K/h/VNrW5sZiKG6rOLgYhAmMwYdU8I9Glq9PV9tF+1BDpT4mgS+LwmAGHEig7
         4aJ3mDVoT2M088SpgX7zERkBUx+ZIljB9REJstNXTfebuwv2jZ57i2Ci6wfX0/1jLJo/
         mu1mFSwKAkg0MQpdLtEtslXcZgw1JF0roXZGMxGQGF+WOnkWpx4WPG6kxi+1nIAaSvqC
         6RLpBzjdLknlCIwcIROdWX/VEvvgOOgouR2bjHU9XDp1M9iXknjFn4YDjZrU8VPp9Jqp
         +1465v+r4o/u0MTZtlMo7uDiLySUuWnC1CFeoCIMVVA0qhZSrfs40e1EiIJVZF20KZHi
         bABw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772541484; x=1773146284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        b=nIv2vAImkNUX82TjIXd8M5ckaTLMaN9l9A3H6eponq9/VEMByLn53QW9aMHi85+9Se
         JTa8gXKYlAXe7r8TBsOTMx7FfbusxJTrSKzKoSfzDXPCWQQOLg/b5VSyI6aYSrhx/3Xb
         r5OL4ImrsGtiiYfXMvDc4r68e9iuVnAWcmvBluHPraE3pHcUCXNpMBm6Wr1kIzgfUb3f
         pRq5QK4Y07kR3K7Mc3hp/FWmBDx1BXoYQvTb2F7cjV5EvRuAmBPce1gm07+Kl9ka/tNZ
         FvxCDth/Jish/Dzjxn4K3qBTNZtCG54BqT7oCyMn29XXVJzLsdGdRmP7uHHDC25xy54X
         7SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541484; x=1773146284;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Od8VmsAkxkDfornZBSHD3NThhpuDKPeufz3L6FQsdo=;
        b=ORT/gyEDqpAETmxZCnryGGl4wsCZ8rD/KP2K/ztwXQa+IXqT82gMPRGxXCOh5/ztdf
         NE9nvN0fwBMlI2BgGyR7UPdl6Srksygtm2UumC4KQfmvEdS1+VcEtV6x6qWla2VtmCQd
         8HxrJbThJewT2hEN++uop4huMcxvpaBdME2qtUF4jnnOeyFixmUhWNAh0DHqDzXgvZsh
         AiygD0EGi9963xFzNhoxGs0ZsJNFPwcRiCEujGGAKMvnCEFQMREru8fy+Qw29EvIzhjh
         c2Sgdu3gY5oMusAeqFrHl3jyQNhzR5xGdGeX24N/udoTGgF8SFl6nt74Ysxdtghho2ZJ
         gyow==
X-Gm-Message-State: AOJu0Yzl/wPfVglZblRmDaKwz1HHI5oIoBMJuHFiCy5i8i57Lqykk3Zv
	D6iB9bkNqxn/OpxicyPIhpHTIUt/BtSQOQrUJbpKsfYHtkHHBaNM4WwScvEiAO8wIaSRxHzD97K
	wDT+9e/mIHjeuj+oGebZ22+Rpb5Nc1FI=
X-Gm-Gg: ATEYQzzdFc4eYvRvIT3TO44q9+837nN3HzxbN5++HlB4PRLLslvglrKJUVw43p25I1Z
	GUQcQpQZaE6+Ylb1r66Q397L1JEfuI+UyNWeUcmYkoApBlaGiNpdmO41xvJDF5kWc3++jeW/Arz
	Kl4hffxIxUvR7QwR4ot3ihcy2AawRyUI4GlGvKdrUXqDEdgyo45t+lKFI1XnnHKGoe6omXrHnxO
	UFyM8Gp+/i3k3mJ/sStpS3WQ+o/0fXb5RVPLkqQCg7JWSxfR1eWTUCrUWhGerMt71ym4MIDapZk
	x2FMQKY=
X-Received: by 2002:a17:90b:5289:b0:359:806c:7aa1 with SMTP id
 98e67ed59e1d1-3599ce03d7emr2037572a91.2.1772541484045; Tue, 03 Mar 2026
 04:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 3 Mar 2026 20:37:54 +0800
X-Gm-Features: AaiRm535xsaj4VoSKoOw9tJiv_BU8fScEnpA3N2KgqFZaXGTc84pg3falQ7tcTI
Message-ID: <CAPHJ_VLapzvWHz_ot4uvxSJ_Z3ubtCCp=_ZVReh7KAwjxu5uFQ@mail.gmail.com>
Subject: [BUG] WARNING in __perf_event_account_interrupt (kernel/events/core.c:2797)
To: peterz@infradead.org, mingo@redhat.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a WARNING triggered by a syzkaller reproducer on Linux 7.0.0-rc1.

The kernel hits a WARN in perf events interrupt accounting:

WARNING: kernel/events/core.c:2797 at __perf_event_account_interrupt+0x485/0x530

It is triggered from the perf overflow path while closing a perf_event
fd created for a tracepoint (PERF_TYPE_TRACEPOINT). The call trace
shows:

__perf_event_overflow()
perf_tp_event()
...
__x64_sys_close()

This looks like a potential state inconsistency / reentrancy issue
between tracepoint-perf event handling (overflow/accounting) and event
close/teardown paths, causing __perf_event_account_interrupt() to hit
a WARN_ON.

log:

[  109.197980] Call Trace:
[  109.198578]  <TASK>
[  109.199163]  __perf_event_overflow+0xb6/0xa00
[  109.200270]  ? perf_tp_event+0x703/0xcd0
[  109.201256]  perf_swevent_overflow+0xac/0x150
[  109.202321]  perf_swevent_event+0x14d/0x2e0
[  109.203372]  perf_tp_event+0x3d8/0xcd0
[  109.204320]  ? __perf_tp_event_target_task+0x540/0x540
[  109.205578]  ? __lock_acquire+0x55a/0x1ef0
[  109.206595]  ? lock_acquire+0x199/0x2f0
[  109.207556]  ? find_held_lock+0x2b/0x80
[  109.208512]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.209655]  ? _perf_event_period+0x1b2/0x240
[  109.210714]  ? perf_event_refresh+0x100/0x100
[  109.211984]  ? __might_fault+0x151/0x190
[  109.212905]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.214104]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.215238]  ? _perf_ioctl+0x147/0x1d40
[  109.216203]  ? perf_trace_run_bpf_submit+0xef/0x180
[  109.217378]  perf_trace_run_bpf_submit+0xef/0x180
[  109.218542]  perf_trace_lock_acquire+0x385/0x590
[  109.219684]  ? lock_release+0xc9/0x2b0
[  109.220824]  ? perf_trace_lock+0x510/0x510
[  109.221820]  ? __mutex_unlock_slowpath+0x157/0x760
[  109.223132]  ? _mutex_trylock_nest_lock+0x370/0x370
[  109.224302]  ? perf_event_ctx_lock_nested+0x89/0x4d0
[  109.225533]  lock_acquire+0xdf/0x2f0
[  109.226428]  ? file_close_fd+0x4d/0x80
[  109.227390]  ? __sanitizer_cov_trace_pc+0x1d/0x50
[  109.228570]  _raw_spin_lock+0x2b/0x40
[  109.229517]  ? file_close_fd+0x4d/0x80
[  109.230481]  file_close_fd+0x4d/0x80
[  109.231386]  __x64_sys_close+0x38/0x120
[  109.232343]  do_syscall_64+0x115/0x650
[  109.233305]  entry_SYSCALL_64_after_hwframe+0x4b/0x53


Reproducer:
C reproducer: https://pastebin.com/raw/GJtNs8JE
console output: https://pastebin.com/raw/zGwk1RhB
kernel config: https://pastebin.com/raw/g6ZhXQ79

Kernel:
git tree: torvalds/linux
commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
kernel version: 7.0.0-rc1
hardware: QEMU Ubuntu 24.10
