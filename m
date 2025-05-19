Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57699283C97;
	Mon, 19 May 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665485; cv=none; b=i7ZofO0cAYQr1lNrhM5NRtbDuOjaG+BSsp+myOoPSxHdmRWNTI77XudjrLe6Xn/C5qyH1qHtn+/bBoRm0i9AlxZ4i7Hrdp5XSbHkZ3rnX8iEXURZ6z3NBZIqRXeSaGHo35lGOzsJ25ynfX4DavkKmhmZWsVHVpzMSuk8Mk7KbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665485; c=relaxed/simple;
	bh=gAt85zQuH7Ja3vEags4uoPq7LdbNyWTR60A0wFFgeQs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fPeQRcoIPSzCH/CmW4zhJB1IGnciCZgEqO/876+2JYAArRzuCc0bKy4g+wJm51tsjoeFl3JF7VNRClOvkCJottsNM41tkbx6nZeJ5MJdW3r7xJHOB4YPFsXDDuxpmqLbbLhvRDfBjDtC97pgKHGSPJfk0M5SI6Hs+hVS8n77Chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF5nh7YT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF5nh7YT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3081f72c271so3916134a91.0;
        Mon, 19 May 2025 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747665483; x=1748270283; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUAue7lju4/IXaynIzGavH1If8DEHLtoUCFcc+xrYWc=;
        b=aF5nh7YT6t4GphO6r9/RIo3XKGif14Cpo6CC0F4JO5zMBRG+u0VGJGNxc3lY3HrLtc
         lW51lnqr+RFBOyzniV2gjFWsW9ywG1VQutpkN5nq7bqLNsrfAjxGZME8VmFDgWpTWChf
         9bDEBfZLvZjDdShEMTaiE2e1T2R3TaAeQ5mEPIw7HHDo4mHZVhz//InHhXvXqrJNruPj
         IU1v1S6gVUKE7IXuIkPN+vN7c7Ulcj9LdizLh+vvA8rnlaL7JdIg8AzcN1osvHw3Ensq
         kd+JrWtrTD4OY9eM236Oj0280relzFV2juMMawjAzlnDjXywbzY4bAndKc2V7pWj59ci
         Mvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665483; x=1748270283;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUAue7lju4/IXaynIzGavH1If8DEHLtoUCFcc+xrYWc=;
        b=OSXPqLLsltvdkxfixDLgRV3AiXjSjYg88EypYZCUU1cGrRf8NtW9vY9fxhCL3CH9Wx
         mXt+K9sHDyNbJwFvWqd5vPUrqcN+ZrfmmqYHLcxj2zDoyEAvlnwB3TVbh2IvpoQX2M6A
         bE6B8NauzBIHByn+DLiHN9uASzCMonHv00HEhEusNnkVtFz9KiVUvuM5NRNgYrj3iT2i
         KkOd9FAGT35IUaXgD+c0ITwNXWe40mg1zw34hEustKg0gVHI746Rpo6qNdYAT6pILFRx
         3qDLovqb44T+P0tXwNWbTFw+dA8acBYzYu9vM4uIt6djm2MmiuYdxhu1uEimKQmX5Sea
         N7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUsfokwiz/NIm5n/gYwZDU9yVhPruczptsqNCTwPtZzEAQNUu7qB7DkCwV/gb0wXl8szkgWUKcjAZ80qLM=@vger.kernel.org, AJvYcCWWt0qVO/KJ/KtXgYf1o7QqzTUiQq/AhJd9lVyWlKUn7PWUdD8PuWkIfFmry7FZmzSSKwAllmG0fnfHYUROZ5FuFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGqBiKKdj082xtOZKehbs6zjnmx498W5OsMSE96dM3Xubl3P4
	7CVSBGKDRPifl799aYa5aX446xeEx2nhoCxrMB3cobDPwthCy/twHWN0JUy4redb
X-Gm-Gg: ASbGnctdYR77a+8NEaPIXxebq7ZP3m/3jYhdtH6jJ4HiIkzBlXD9feln9pRX33F/Bcz
	/4+tbI/VOu4W4FdtCsxZFb2aZTcjLboJzjCP0yo3iRFH8OKSy/A1roNx+gEROcILEYFVYYBguae
	mgn0/r1npU20I5qinsMc4Pknj7VYomb5OUcJ+jW6orI4KbeU2BIrP+gvB+Rj8ewYkcFRBnXMvQS
	R9PH0KmmoZM9+JLSwwey+6G6clxfQ5mStKNxrYzN8E7lbSAcfE2bE+9zKZzM6m8r17//grpyCge
	ojLrYWeAcQBp7ig1SSN7f6WJJT9kwjP23+wmf2RKTT9yrE8dJQBJnj10lYTz/E/yXU4yttBZbE8
	eFuvgzdQ=
X-Google-Smtp-Source: AGHT+IFsymKgFw8VDGAcL4fu5PSwCz9cVlgoSOxKeBp1loAmVB7h2LufHLhcTYN/2nLq8NDrELzlJA==
X-Received: by 2002:a17:90a:c883:b0:2ee:e518:c1cb with SMTP id 98e67ed59e1d1-30e830c797dmr20934920a91.7.1747665483282;
        Mon, 19 May 2025 07:38:03 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ea61d8b87sm4835976a91.30.2025.05.19.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:38:02 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luckd0g@163.com,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH 6.14.y] perf: fix double calling of event->destroy
Date: Mon, 19 May 2025 07:37:52 -0700
Message-Id: <20250519143752.37372-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Affected kernel versions: greater than or equal to 6.12.24 and less than 6.15

[BUG]
[   40.427200] ------------[ cut here ]------------
[   40.428671] UBSAN: array-index-out-of-bounds in kernel/events/hw_breakpoint.c:245:3
[   40.430615] index 5 is out of range for type 'atomic_t [4]'
[   40.432261] CPU: 0 UID: 65534 PID: 226 Comm: a.out Tainted: G        W          6.14.7 #1
[   40.432267] Tainted: [W]=WARN
[   40.432268] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   40.432270] Call Trace:
[   40.432272]  <TASK>
[   40.432274]  dump_stack_lvl+0x53/0x70
[   40.432313]  __ubsan_handle_out_of_bounds+0xc8/0x100
[   40.432405]  toggle_bp_slot.constprop.0+0x1c6a/0x1cc0
[   40.432427]  ? __percpu_down_read+0x4d/0x2b0
[   40.432437]  register_perf_hw_breakpoint+0xe6/0x270
[   40.432440]  ? __pfx_register_perf_hw_breakpoint+0x10/0x10
[   40.432442]  ? kasan_save_track+0x14/0x30
[   40.432447]  hw_breakpoint_event_init+0x68/0xd0
[   40.432449]  ? kmem_cache_alloc_node_noprof+0x10c/0x330
[   40.432465]  perf_try_init_event+0x108/0xb60
[   40.432468]  perf_event_alloc+0xec0/0x2be0
[   40.432472]  ? fdget+0x53/0x3a0
[   40.432482]  __do_sys_perf_event_open+0x351/0x1b50
[   40.432485]  ? hw_breakpoint_exceptions_notify+0x25f/0x370
[   40.432489]  ? __pfx___do_sys_perf_event_open+0x10/0x10
[   40.432492]  ? __pfx_notify_die+0x10/0x10
[   40.432496]  ? fpregs_assert_state_consistent+0x1b/0xa0
[   40.432510]  do_syscall_64+0x9e/0x1a0
[   40.432515]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   40.432518] RIP: 0033:0x7f1b0b58bfc9
[   40.432532] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 8
[   40.432534] RSP: 002b:00007fff11481da8 EFLAGS: 00000206 ORIG_RAX: 000000000000012a
[   40.432538] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1b0b58bfc9
[   40.432540] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff11481dc0
[   40.432542] RBP: 00007fff11481e40 R08: 0000000000000000 R09: 0000000000000000
[   40.432543] R10: 00000000ffffffff R11: 0000000000000206 R12: 0000561a1955c060
[   40.432545] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   40.432547]  </TASK>
[   40.476591] ---[ end trace ]---

[CAUSE]
When perf_event_alloc() fails, it calls event->destroy twice.

	perf_event_alloc
		perf_init_event
			perf_try_init_event
				event->destroy
				~~~~~~~~~~~~~~
		__free_event
			event->destroy
			~~~~~~~~~~~~~~

This double call triggers multiple bugs, some of which low-privilege users
can also trigger. Examples include:

	hw_breakpoint: array-index-out-of-bounds
	uprobe: use-after-free
	kprobe: use-after-free
	...

[FIX]
After calling event->destroy in perf_try_init_event(), set it to NULL.

[POC]
#include <unistd.h>
#include <string.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include <linux/hw_breakpoint.h>
int main(void) {
	struct perf_event_attr attr;
	memset(&attr, 0, sizeof(attr));
	attr.type = PERF_TYPE_BREAKPOINT;
	attr.size = sizeof(struct perf_event_attr);
	attr.disabled = 1;
	attr.inherit = 1;
	attr.exclusive = 1;
	attr.exclude_kernel = 1;
	attr.bp_type = HW_BREAKPOINT_W;
	attr.bp_len = HW_BREAKPOINT_LEN_2;
	attr.sample_regs_user = 1;
	attr.sample_regs_intr = 0x20000000002;
	// This code will incorrectly change the value of info->cpu_pinned to -1.
	syscall(__NR_perf_event_open, &attr, 0, 0x80000000000000, -1, PERF_FLAG_FD_CLOEXEC | 0x4);

	for (int i = 0; i < 100; i++) {
		memset(&attr, 0, sizeof(attr));
		attr.type = PERF_TYPE_BREAKPOINT;
		attr.size = sizeof(attr);
		attr.config = 0;
		attr.bp_type = HW_BREAKPOINT_W;
		int var = 0;
 		attr.bp_addr = (unsigned long)&var + i;
		attr.bp_len = HW_BREAKPOINT_LEN_2;
		attr.sample_period = 0;
		attr.disabled = 0;
		attr.exclude_kernel = 1;
		attr.exclude_hv = 1;
		attr.read_format = 0;
		syscall(__NR_perf_event_open, &attr, 0, 0, -1, 0);
	}
	return 0;
}

Reported-by: Penglei Jiang <superman.xpt@gmail.com>
Reported-by: Jianzhou Zhao <luckd0g@163.com>
Fixes: 1209b0b29fd4 ("perf/core: Simplify the perf_event_alloc() error path")
Closes: https://lore.kernel.org/all/3a701a0.8f4a.196860948e3.Coremail.luckd0g@163.com
Closes: https://lore.kernel.org/all/tencent_B50959BC76205E0AE666AE21F7A07D017306@qq.com
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 93ce810384c9..29300bde69db 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12045,8 +12045,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 			}
 		}
 
-		if (ret && event->destroy)
+		if (ret && event->destroy) {
 			event->destroy(event);
+			event->destroy = NULL;
+		}
 	}
 
 	if (ret) {
-- 
2.17.1

