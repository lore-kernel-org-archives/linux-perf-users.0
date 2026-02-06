Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D08318B83
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363519; cv=pass; b=oRL++bisAVfGqVh0FZtXBt2DNBTlNc0MnLT82KplQqsxw3ClKbT0WeFd7QBuXKo8YZk5K7wYXJDFYkp4hsBr8rXJkHQkaBL+WSV0+nfASOoyBwGY3fmjRChKBb571HC88ZhhlF6nCx7l0adBhfiI07Bqp2cH7TUluTxq/DdnzfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363519; c=relaxed/simple;
	bh=mmg3AM5byBUK9uuu8j6gU+2F7VmpdgECaI9kbuugKxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/gukX1poSvQW4f3K3QYxtwin5tw1qLkERz75HQe/2HfoocVhZ0wpr7m4yEBGedVgGc4qAPeNGido/MNxkY4oTgbFUCv4GHKG4GNNTK3V9QS9jdrtKZ+Rzo/9cn3FeFzJNM4+GNMER0VfXiDX4OqcfWdYD5lo2EV6uqrldl9+Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u9R2ETWW; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u9R2ETWW"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fe06aa94so3349991fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 23:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770363517; cv=none;
        d=google.com; s=arc-20240605;
        b=DBeoP1e0FQEa9MhAeMTa19QviPycDcWQtEfgXtUSYd/vhR9GFIM5WTtNIVslYDpcpx
         xzAj0k3oya/WWuKjmlxsLZQNIVXD+RkR2Ag7hwdxwLW1mfFqyLLk4tYBnBh5Ou9Q5N35
         Kpam8RVH7ogAJQBAO4LByS7/FP3Rj7JqlbiqAUnGAB/fZIRQng2ZBV0+1w9Y+mfM2gBI
         D2Tbw3sBmPbRezbgasblQ7hpQaq5FbVkWfbdoZf+BYSaHVL3IWwJPP1k8j1SLPOgp/Nx
         Dseg+SN/G7em6N9Chm5EpgeZb4njj1iQRSvn8dBik+USYiMNLO8xs8W9j3mPiqftpd8o
         Csrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ubauWayYPVungVrF1gxcOMjAA2AWE+1QpPnrVDa0hhU=;
        fh=zuIL+IcDppgvLhIyq04fbaxhaznX1OF0Dh0J0mYphW0=;
        b=Os3ooVi2rGIlFlHnT8afJKTIiM9xXl7V7Fk7rTtSAZvgJk9sZ3JPwqKm8+lSlQVKw7
         241j24TMpQ42IBNYdAfBlo7s4ElYia0k3VWrZZu2SphAElg4dNc3GrDc/e/tMiaZZmEo
         SiRjoniad+9rwBro6q/PHHH+a9nfQyCh3J1CH7ERLz+JyjSra7C86pM9Lm6kbEO7i74c
         eXKoZxSoNRDPTQMrwMkCJTsG4xDW76xDeRisL3+r+yQ3EQ0TdVZGEJ64ADtvojlKtdZt
         tHQTBA77vbSvIyhP0aWPN7wJRW6BeuP/zc8QWRGNT9Fl23RPl6pxFqOxUdjABk2em0tC
         u96w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770363517; x=1770968317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubauWayYPVungVrF1gxcOMjAA2AWE+1QpPnrVDa0hhU=;
        b=u9R2ETWWNzbPhS5f7lLmpbSll2sMn0hJ8YNgaFemqVl7Iszon+HuAteAkHvqnC/1oB
         x5HTpppZ3oLAPtCMEVp390WIeOC/U9k3wHOq45xpvHa19loRnhQzCF1k0bZ5ExHd9d1d
         4fbvVn3GxcSLLbffV80pn+2yDbdHxSXZVQICfbNj+4BorGZFxyoLEoqDAGLsYESTkaSO
         FoJbZEdKUKGNjiZ4XUpMTAmSy6Zw4bB+MZbJTWfcJO2xmEOoQra33OT4xuPRUAbro+lk
         prTq0hbTNfXswjzSCP9QbGu15sWz7oL0pB+KttQyfho6W4OZX5PKlUXaVZIvYRxde41b
         Sy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770363517; x=1770968317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubauWayYPVungVrF1gxcOMjAA2AWE+1QpPnrVDa0hhU=;
        b=o2B0l6CUz2RDTwDMcl+2R9Xxz53PNnjfbI8usFuEnAf6PAs/KBDXe0hglAI2OmFCYx
         skW1wfz7xobQpQo+SYmRv5C1RVTdor+PWqknO6ebl+WJwdQKRx9cQvtUrYHN3927ilDk
         VeMKtb0r7d0K6NueobC4rgJT/mAKAm1oDpINb2ao+hNsxMo7orgKulC+fFaE2qYultbC
         TtlSLJgX1esTCqwpAwLE3Ca9NJ2cJW42Zyt5o1G27aIyUXLudzBW7Ndeu5jh5L63OGYx
         w5sE5LiYZYnyLE8ot2Nj9HIAbRPEnCtvOqrZ6ylfN83knczO8ADvudVCjlDTKofR+bGQ
         6BRw==
X-Forwarded-Encrypted: i=1; AJvYcCXkBL/FBudbP3Y/JKHwdML1yssGM6P6EtoX1e7q7Zj74PnC2mQD6JjKDYm+X3+9HsgrOXLfyT//DqFCX8LHJSKS@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGY9OqSRL8/JwSepnzQlXfFUG2YjicINsMl1H3PkZeqswXHgB
	cenpunIBc1nyvfQy9J14Ipex55/cPQSIazd8olbxD62yZpZLUGKl53NSPNURNFdyg9ZI5aJ3utL
	96fD02EPIY5E5KFF9H4iec9Urj6jXH/zYAI2IEKjA
X-Gm-Gg: AZuq6aIAbwjllip7xWNbk7KGa63g1I396DoZBgYpKBpxHub1VSgbEvdlT6BkwrmMJvx
	teNKaMZNuLIWiUhiK0benlJZxcBJsS5QcJjXzWa5t+zd7CjG6h9TmJEnliX6JoPJ1GcGMPE7DIP
	fWsgiw6U4qkPODtpgzWtA20WHRgzHNpEgmYy1cjGOS6b9rWlHk9CDudwUvRmXQAmM5cqFzVMTSL
	xKh6eaKnThH7oGj5UyDRIX/hPxiLk+EeaEcSopoAuKz3y32viFW5nkXe/qlFS1tIoVjuHfFnvHY
	+R+phZN2m8D7/rdYHdRdbsQe7pGy
X-Received: by 2002:a2e:bcd2:0:b0:385:ceb0:c34d with SMTP id
 38308e7fff4ca-386b4e7d858mr6972091fa.4.1770363516679; Thu, 05 Feb 2026
 23:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69859a00.a00a0220.34fa92.0028.GAE@google.com>
In-Reply-To: <69859a00.a00a0220.34fa92.0028.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 08:38:25 +0100
X-Gm-Features: AZwV_QgzGiToJD87UQAuIcWbC-AcQmrTwsg9x8VZUNuqD_HgPjw2pYE31ohK8fE
Message-ID: <CACT4Y+axrv7knEVcS_2BHoPgkrqfwKd0VmHVRk7eogjssfZ6jQ@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in perf_event_set_state / perf_mmap_rb
To: syzbot <syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 08:36, syzbot
<syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c537e12daeec Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1133a5fc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c160236e1ef1e401
> dashboard link: https://syzkaller.appspot.com/bug?extid=5334e6bdc43f6d1dcb7d
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/036ac5d12a14/disk-c537e12d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/07ddd15f46f8/vmlinux-c537e12d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7866e67b7a58/bzImage-c537e12d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5334e6bdc43f6d1dcb7d@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in perf_event_set_state / perf_mmap_rb
>
> write to 0xffff88812279f1a0 of 8 bytes by task 12011 on cpu 1:
>  perf_event_update_time kernel/events/core.c:737 [inline]
>  perf_mmap_rb+0x71c/0x910 kernel/events/core.c:7037
>  perf_mmap+0x1ce/0x2f0 kernel/events/core.c:7164
>  vfs_mmap include/linux/fs.h:2053 [inline]
>  mmap_file mm/internal.h:167 [inline]
>  __mmap_new_file_vma mm/vma.c:2421 [inline]
>  __mmap_new_vma mm/vma.c:2484 [inline]
>  __mmap_region mm/vma.c:2708 [inline]
>  mmap_region+0x1045/0x1410 mm/vma.c:2786
>  do_mmap+0x9b3/0xbe0 mm/mmap.c:558
>  vm_mmap_pgoff+0x17a/0x2e0 mm/util.c:581
>  ksys_mmap_pgoff+0x268/0x310 mm/mmap.c:604
>  x64_sys_call+0x16bb/0x3000 arch/x86/include/generated/asm/syscalls_64.h:10
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88812279f1a0 of 8 bytes by task 12005 on cpu 0:
>  __perf_update_times kernel/events/core.c:720 [inline]
>  perf_event_update_time kernel/events/core.c:735 [inline]
>  perf_event_set_state+0x153/0x440 kernel/events/core.c:754
>  event_sched_out+0x2d4/0x4d0 kernel/events/core.c:2391
>  group_sched_out kernel/events/core.c:2415 [inline]
>  __pmu_ctx_sched_out+0x3e7/0x530 kernel/events/core.c:3458
>  ctx_sched_out+0x273/0x2d0 kernel/events/core.c:3539
>  task_ctx_sched_out+0x4d/0x70 kernel/events/core.c:2859
>  perf_event_context_sched_out kernel/events/core.c:3746 [inline]
>  __perf_event_task_sched_out+0x286/0x370 kernel/events/core.c:3846
>  perf_event_task_sched_out include/linux/perf_event.h:1654 [inline]
>  prepare_task_switch kernel/sched/core.c:5045 [inline]
>  context_switch kernel/sched/core.c:5201 [inline]
>  __schedule+0xbf0/0xcd0 kernel/sched/core.c:6863
>  __schedule_loop kernel/sched/core.c:6945 [inline]
>  schedule+0x5f/0xd0 kernel/sched/core.c:6960
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:7017
>  __mutex_lock_common kernel/locking/mutex.c:692 [inline]
>  __mutex_lock+0x4ff/0xe20 kernel/locking/mutex.c:776
>  __mutex_lock_slowpath+0xa/0x10 kernel/locking/mutex.c:1065
>  mutex_lock+0x89/0x90 kernel/locking/mutex.c:290
>  perf_poll+0x180/0x1f0 kernel/events/core.c:6150
>  vfs_poll include/linux/poll.h:82 [inline]
>  select_poll_one fs/select.c:480 [inline]
>  do_select+0x8f1/0xf40 fs/select.c:536
>  core_sys_select+0x3dc/0x6e0 fs/select.c:677
>  do_pselect fs/select.c:759 [inline]
>  __do_sys_pselect6 fs/select.c:798 [inline]
>  __se_sys_pselect6+0x213/0x280 fs/select.c:789
>  __x64_sys_pselect6+0x78/0x90 fs/select.c:789
>  x64_sys_call+0x2e98/0x3000 arch/x86/include/generated/asm/syscalls_64.h:271
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xca/0x2b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x000000000038c145 -> 0x00000000003929d3
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 12005 Comm: syz.4.2772 Tainted: G        W           syzkaller #0 PREEMPT(voluntary)
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================


LLM concluded this is a harmful race:

======

Because `perf_mmap_rb()` does not hold the `perf_event_context` lock
(`ctx->lock`), which is the intended protection for these timing
fields, it races with the `event_sched_out()` path (which does hold
`ctx->lock`).

The race on `total_time_enabled` and `total_time_running` involves
non-atomic read-modify-write operations. If both threads read the same
old value of `total_time_enabled` before either writes back the
updated value, one of the updates (representing a chunk of time the
event was enabled) will be lost. Additionally, the race on
`event->tstamp` can lead to inconsistent state where the timestamp and
the total time counters are out of sync, causing further errors in
subsequent time calculations.

### Conclusion

This data race is **harmful**. While it does not lead to an immediate
kernel crash or memory corruption, it causes permanent inaccuracy in
the performance counters. For a subsystem dedicated to high-precision
performance monitoring, lost timing updates constitute a significant
functional bug. The race is also highly reproducible in scenarios
where one task maps an event while another task using the same event
is forced to schedule out (e.g., by blocking on the same
`mmap_mutex`).
