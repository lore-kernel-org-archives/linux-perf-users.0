Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0E3BD226
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774927; cv=pass; b=AKYsL10hZkno3iZqSTKGJ3aIQkXRQigBL6pOmHV85aMJcbhGvz7waLfq8YVP9O0HZ8/rLRPc6j0Bt2rMp5zsbtRqOTcw24gnsWGiwYytYOrRvPeRmhr9CIOyrWgg95wAG7AVf1kCj5EFKCEnec4CtlY8sQ4KcTwnF2YppQLngQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774927; c=relaxed/simple;
	bh=vGQpb6xeRunUba6drZXCbVzcVDq6G+FXK09EM7ydFx4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZaNBI/b283qIZPNh9w1LFF/Hmy17pwWQnViDiU3Rx+Pj+5dULlsFw+xIaObf7/ELp7IZkx2eRIceDuQwgdztg9xYQPY/LM9Uvw+BSkAM1CfVygZpokgTygrGvBVE7zyeelvuRkP3Xql/RH4B17Gbtg39OcW90grhPgcOOCnZAdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ok00lHc0; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok00lHc0"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so1565987a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 05:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776774925; cv=none;
        d=google.com; s=arc-20240605;
        b=MEOPw0jaY7vKM4FOrleERPZj0LOITOM7aTnVPCpVQGhfzhhp/MC6D+CSoOe4NQDNz+
         mdv/qzbRo1kzkfBmUrg/UuQ0BCQ1Fxu2NSZVjk/qG1+AF4XShUS5+N97jnQauhWsOU/k
         0fySKOsKkCxAJX1LL+ZontAkmRHaZ80ql6Sape5WxM+9Zw482ooOPFrM56EDTcFxCL1T
         /F7SgpSQ/e+bTvqjNYKjJHxZuYUfSUr7WCgYiiod2qrnnIGmGnqVhO4Vj9Tdm9U1jK6Q
         QCo/r6Btili98uZSPT1bCh1bp418hKIwmZizg/ZsWTuQb7ehs2mzqvyYb8bBMUgheXnI
         PUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vGQpb6xeRunUba6drZXCbVzcVDq6G+FXK09EM7ydFx4=;
        fh=exOB0J8UrkXBn5+/hebcDfMC9bGRg+KDHbyKWQuLvNE=;
        b=TeoRh73gts7lo+qjtOr91QPIGxlbn62xigvNNfXej/rhYk+3TP7A/cInrZPM5Mu1Ao
         ckvzxK7uFcpxilD5TuVjAd/tOMsHTlG4ANDwZeA8JimPUq1uXqxpxejHrAisco7ql2yI
         VEprhCHC6QjlyveYgE3LWKLQNqTd+QjTeB4O8p5yzJnhnKGNfkKH+q5rbDXoiwSsGHAw
         rMqw+ztoQJ8gHxCUsA1LqyQF27p0+xlN0uK1741aZNdamCcPBd4MbrTEqxD2kjRaUSrw
         40ycmT4h90xFnUWVAY4GbGKtWFmZ4bwBQjsjRaXAw2qBl6MCTYoEzJ9ZYjwPEh248N/V
         sHUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776774925; x=1777379725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGQpb6xeRunUba6drZXCbVzcVDq6G+FXK09EM7ydFx4=;
        b=ok00lHc0XmduvdNKYdPJvrkIAJht3bl8pm5v0sNfG1+1CoGEjxggUeGeB0JpXfCqzh
         5OIH7dHuIawVLMTjwIIGeDRy+D7qXSCwfKNITfXn1Z3kC8FMV0qDgqSKwbHYxUQM8Al7
         rrmPyj9XD0WVI+8/jpO+TG4aP2VKrKG3HJr4EfWXUQwQkFDFX0tWgJ/LKX6olRl/HY7u
         6GW3xaWv9MHqsX8uL4WZ188CEjOLc21GAPARBFGeIX+Mc0o9jOaRQVadXOJhTIkgNeFk
         q7xe5AI363zYjs9T+9YhNrZlA+6cT5mmQU1kEiDPKxxEGJHcznBiqr5ve27tGuafHZ6u
         UBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774925; x=1777379725;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGQpb6xeRunUba6drZXCbVzcVDq6G+FXK09EM7ydFx4=;
        b=mY8rlpSE2KxU1j5AwneOhcYUSgAvzDyeMyIrwA92KaDOpMk+cCDnYSKyWSjNaz7Qw6
         VQYvr0zsNtklyAp0Z8883cFcJoo+Fx/JwM7v0YY6le8DUgeW0hCyopBr6sdu1hI0e2wA
         vjOKNe7y+b0pH9IJB0Ac1kaoI442yDj/afxYQCWwIzTCVAeBei0AVUsPSejg8hn8v/DY
         S+TuTjT65kRrPtu5DJDiPwtVskAQLjYhELZEJiq4mG33KI+i5FwYQBwOf8v4LzgbywOU
         EbEJH8pm+UnksHGL2muS1+SOKRN0kwM4jSdMSFe/BD3CQTdQvhmHYtxnn4877Imxo5Je
         zYRA==
X-Forwarded-Encrypted: i=1; AFNElJ8ED4v5aK2yCCdtCdujdrBg1jL7lJtKMkNHIsAmN1EEmmaJgHabqTtVTk+HoYNjNRJybZ0hngNad5fT28Gvu+a3@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDjzGSWBZsi3k2B8Z2YY50GaM+BOiMqSMvt0GxBOVzfmQrDml
	KQ27uQ600C/TGiDKC4x6r8vzwR0HTbR/Mh7zZtwWYkT8rCwcoY3YXsrr/H7i5ZbG9CNDYcY38qk
	68TqWCCLtaPSY4C+CMuEKB2YDGSJ5m1wwftR2IxxtGg==
X-Gm-Gg: AeBDievIzuEB4ScbmnZsHqcJ5rLQvjRIPVgQKNY6dLa3X854+jH7oUdHKMxfbWFNz+F
	w7nFg4ObHWJvvxtK4PFCp9J1VZyeSw9fqPC1MNX6eaUmFfOb4XUombb454YT8t+a+VcpRhoKmsu
	tbaaKAJbCJIE4VDYphtjrpI3BhcprpVwj7lrFGAxxYxPCFakzMwmP3nPAfq+IZyhhLlQQ4i5fnK
	cOzlNtUOd+3hl/uLStK+O5Z0vjJFVNHK3GIZX3nmcTJG/bM8w0oE9qIdxAh7NlIL8lw0sGEaOPI
	WZAP68KUy/0Mts2QRA==
X-Received: by 2002:a05:6300:218a:b0:39f:94cb:1bc with SMTP id
 adf61e73a8af0-3a08d687dbamr19761416637.1.1776774925270; Tue, 21 Apr 2026
 05:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 21 Apr 2026 20:35:14 +0800
X-Gm-Features: AQROBzCLGQh41tCx9CrHdN7_ys9WFl9T3wGnYz6BKTQR2WXmewF3VbD-7EcWDxE
Message-ID: <CAPHJ_VL11XkFkLj5P7zT2CsRkTH7Xb9Vyxpdh-tGRr-4YY5dUg@mail.gmail.com>
Subject: BUG: soft lockup in run_timer_softirq
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, 
	peterz@infradead.org, mingo@redhat.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a soft lockup issue triggered by a syzkaller reproducer on
Linux 7.0.0-08391-g1d51b370a0f8.

The system gets stuck with CPU#1 spinning in the timer softirq path for more
than 22 seconds. The lockup is observed in run_timer_softirq(), with the
interrupt stack showing the CPU stuck in __run_timer_base.part.0(). The
reproducer repeatedly invokes perf_event_open() with crafted
perf_event_attr values, so this looks like a timer softirq stall likely
triggered by the perf event subsystem.

Reproducer:
C reproducer: pastebin.com/raw/Rghf0nF6
console output: pastebin.com/raw/rWkVMZF2
kernel config: pastebin.com/raw/NSpXqAz9

Kernel:
HEAD commit: 1d51b370a0f8
git tree:
kernel version: 7.0.0-08391-g1d51b370a0f8 #1 PREEMPT(lazy) (QEMU)

The observed crash log is:

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [repro:684]
CPU: 1 UID: 0 PID: 684 Comm: repro Tainted: G B D W N
7.0.0-08391-g1d51b370a0f8 #1 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:_raw_spin_unlock_irq+0x2b/0x40

Call Trace:

__run_timer_base.part.0+0x6e4/0xb10
? call_timer_fn+0x590/0x590
? __sysvec_apic_timer_interrupt+0x2d6/0x3a0
run_timer_softirq+0x16c/0x1e0
handle_softirqs+0x195/0x7f0
? __hrtimer_rearm_deferred+0x1fd/0x580
irq_exit_rcu+0x141/0x1c0
sysvec_apic_timer_interrupt+0x70/0x80


asm_sysvec_apic_timer_interrupt+0x1a/0x20
finish_task_switch+0x1e5/0x8e0
__schedule+0x11b9/0x4a20
preempt_schedule_common+0x2f/0x50
preempt_schedule_thunk+0x16/0x30
_raw_spin_unlock+0x2e/0x30
do_wp_page+0xb4a/0x3c60
__handle_mm_fault+0x1ac9/0x2ab0
handle_mm_fault+0x40f/0xd90
do_user_addr_fault+0x6be/0x1970
exc_page_fault+0xb0/0x180
asm_exc_page_fault+0x26/0x30

The reproducer mainly performs repeated perf_event_open() calls with unusual
attribute combinations. Based on the stack, the visible stall point is in the
timer softirq path rather than in the userspace fault path. My current guess is
that some timer callback associated with perf events gets the CPU stuck inside
__run_timer_base.part.0().

Please let me know if I should provide a minimized reproducer or any additional
debugging information.

Thanks.
