Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14C1898F8
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760905210; cv=none; b=AcDOPsh5W1AuoPbnNQCiC7vjphL2mCoz+0VpS45NfyhoSPjlMtP5H4ZDeeOWYEjGN16ZJ6a6zho2s1SrNGPHIkz0Tc2qVAGhj/9G+fO6JdbXgYQnvu/UTlWlzZu7/0TAnPDbQv9FqV/QO9+LHJU3OXcThVXJvHi/r1W8h0Ovgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760905210; c=relaxed/simple;
	bh=2CxS4y+l0L27meZSjGJEaayPPI49yDmtzC0d6yfWETU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BGxnl+0ckFK7t7LdVdvXDWivL/UfsHZ14gFjGkfC8cCr6j71cy/e2VxICcrZPC2u6ykGEdGDAHfT0UEA1MPWU9g32qg5mZjm4lc4Rc9zakFsFNvPiCflF/aTOusSDvHOkmq8/nJ5//KUcfAYrxwz9Rd1XEwehc9rJLzelzw6tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJuXJq2v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJuXJq2v"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so3687103b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Oct 2025 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760905207; x=1761510007; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g4HxyRRBlNg3Uy1WJvknBsTLo2+VRNyQvX/LTki0p1M=;
        b=nJuXJq2vZba8COtuIkvM56AsjsEWrMlMcmk72upy7pP8O7IsPz9KnA4ONvJeX/owoQ
         modUpVu2ZriYOAvy5Ux7PE2Ez2n0+ESRF2KKF2ALPTDy0bjE7OTjQ62jgJPTTufKmFM6
         4s4C4JupGSlnBiLuVfmDLuWY0YPNNISCwgmRRd0WbMmc+DRVyHYV6VXrVRP7/8Ele14b
         TpgvmXKSEmbdOCDq8YAgtBPKTQS2rBYV147ItOvagZGZXVnr0WQVZcpS+F5paroUt83k
         ALn82IoLzL+msuyPSnLR9CcXmJLt7zHRvUydfKW4pkDduoOij04TH8p4OrcifpMdqAEA
         BJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760905207; x=1761510007;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4HxyRRBlNg3Uy1WJvknBsTLo2+VRNyQvX/LTki0p1M=;
        b=bXTfKO+vheZHR/U5w1HhUW0qnoXTC6rA41MOyTJ+551iZPfU/8Kvpwv4Z5Wgbqpfyi
         ZNfsi94PpT1jsXUkPdTpQXAWZqGtjPptd6mtlosTas779AOGjS0iPQ3CCxFZthsHkUcQ
         8AOkooM1jLCWpTG4ToTr/3ffcRKqNt+76dqiySPLEwvwgcL5ikbmvtazkAIe3FWzTEGx
         g/Q0ST7J+MxpFtj1BYYaUGUIE9RqrOtP/dMwxtT4pbTJ+4HjXK/gsxtQv3N8iowXRLak
         oyR3rdYlrtiKwzFmYoqvZHERlr9Aaf1/mmQRXco+GnpbB1NTRJnWyzkzeRsvlWs49Dec
         v1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVXSHYX8XTHuJ+dySA2ZSkwa9n/HxcLtQRdzFzpXsYfNDvfGBd1lxHGsGCbsX9dafueZTjjHKC25JZTUgvLZbi6@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQVELSdmSWJJy5sbdwYtcInZJmw23QI+c4cOoUXPsEH8KSOQj
	n6FT1C6nzVBycsLzUo5Xj9YOMhuVGw+1cGITILn9nWJwhds/6fRIJZTBm7svTQ==
X-Gm-Gg: ASbGncvoTnZxGJKWv1t4JzOQ4cuJLvzmScgN+tybhbe5yqya2JE+Lps0pERk8WlBscx
	HfabTqud2pPHzU0G4Qicp6Kv9jOMpgo7pAWVaOZAB5K3Pk80EbsqVhLg9p43Ih4M5XL49QWc8lR
	zFdabqaflvTNNxer7CF/4bHS+Pm+otv11mKZWuy4V6nXxoj2HUABN7qk/Kg8MDAogq/oBhHeBek
	YRSPSkFR9SP/7K6IWgv85VTE/HY9x7nnUhlX7ony8pBdXB8DNCRAsByzjxdGs6mGChhKxgSgCdU
	IgTHyRuC0PejovJBIuk0r5t0/76cIYaF9kbXI5O0ztnT8wo86Ashryua2GZqAeDRbO5hhs6biYa
	7vUm/1VzRhdPYbqHatEMb8S7bKKQwHKwdXtZWZOJys8ZFxwcKV4FaOUfsM5lkS7h/8EmmUANvjz
	k18j24n0FEAPxA
X-Google-Smtp-Source: AGHT+IGLgRfuhRQYRvtZHHbuh2zLZ6kne8DSM040Adl2P8ZbLAe+9zKBhxIgTG2lMIP+fhk5iprQyQ==
X-Received: by 2002:a05:6a20:72a3:b0:249:18e4:52a9 with SMTP id adf61e73a8af0-334a7876b76mr13581094637.9.1760905207057;
        Sun, 19 Oct 2025 13:20:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33c7asm5967650a12.21.2025.10.19.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:20:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 19 Oct 2025 13:20:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] parisc: Add initial kernel-side perf_event support
Message-ID: <eec4fe59-c750-4460-9a88-6bbccffed89c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Helge,

On Tue, Oct 07, 2025 at 05:08:16PM +0200, Helge Deller wrote:
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---

This patch triggers a spinlock recursion and subsequent hang in my testing.

Starting network: udhcpc: started, v1.36.1
[   96.037009] Backtrace:
[   96.037545]  [<104320d4>] unwind_once+0x1c/0x5c
[   96.037802]  [<10434a00>] walk_stackframe.isra.0+0x74/0xb8
[   96.037959]  [<10434a6c>] arch_stack_walk+0x28/0x38
[   96.038074]  [<104e5e18>] stack_trace_save+0x48/0x5c
[   96.038190]  [<105d1ac0>] set_track_prepare+0x44/0x6c
[   96.038312]  [<105d9b64>] ___slab_alloc+0xfc4/0x1024
[   96.038421]  [<105d9c1c>] __slab_alloc.isra.0+0x58/0x90
[   96.038529]  [<105dc6f0>] kmem_cache_alloc_noprof+0x2ac/0x4a0
[   96.038646]  [<105b8d38>] __anon_vma_prepare+0x60/0x280
[   96.038762]  [<105a8120>] __vmf_anon_prepare+0x68/0x94
[   96.038870]  [<105a8a18>] do_wp_page+0x8cc/0xf10
[   96.038969]  [<105aac6c>] handle_mm_fault+0x6c0/0xf08
[   96.039076]  [<10425568>] do_page_fault+0x110/0x440
[   96.039179]  [<10427938>] handle_interruption+0x184/0x748
[   96.039299]  [<111781c8>] schedule+0x4c/0x190
[   96.039567] BUG: spinlock recursion on CPU#0, ifconfig/2433
[   96.039720]  lock: terminate_lock.2+0x0/0x1c, .magic: dead4ead, .owner: ifconfig/2433, .owner_cpu: 0

Bisect log is attached.

Guenter

---
# bad: [d9043c79ba68a089f95bb4344ab0232c3585f9f1] Merge tag 'sched_urgent_for_v6.18_rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [7dbec0bbc3b468310be172f1ce6ddc9411c84952] Merge tag 'for-6.18/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect good 7dbec0bbc3b468310be172f1ce6ddc9411c84952
# good: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect good 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# good: [37bfdbc11b245119210ac9924a192aec8bd07d16] Merge tag 'pci-v6.18-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect good 37bfdbc11b245119210ac9924a192aec8bd07d16
# bad: [ae13bd23102805383bf04f26e0b043f3d02c9b15] Merge tag 'mm-nonmm-stable-2025-10-10-15-03' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad ae13bd23102805383bf04f26e0b043f3d02c9b15
# good: [18a7e218cfcdca6666e1f7356533e4c988780b57] Merge tag 'net-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 18a7e218cfcdca6666e1f7356533e4c988780b57
# bad: [1b1391b9c4bfadcaeb89a87edf6c3520dd349e35] Merge tag 'block-6.18-20251009' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
git bisect bad 1b1391b9c4bfadcaeb89a87edf6c3520dd349e35
# good: [9976831f401eeb302d699b2d37624153d7cd2892] Merge tag 'gpio-fixes-for-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect good 9976831f401eeb302d699b2d37624153d7cd2892
# good: [fdfa38e95e1229ec2fb2f18540987c97f861d470] Merge tag 'sound-fix-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good fdfa38e95e1229ec2fb2f18540987c97f861d470
# bad: [8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2] Merge tag 'parisc-for-6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect bad 8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2
# good: [912b9fd7c7775060900ad315f0ceb616f9381bc3] parisc: Report software alignment faults via perf
git bisect good 912b9fd7c7775060900ad315f0ceb616f9381bc3
# bad: [44ac7f5c6d4c7fd62784bb2700245dbc4ac7e102] parisc: Firmware: Fix returned path for PDC_MODULE_FIND on older machines
git bisect bad 44ac7f5c6d4c7fd62784bb2700245dbc4ac7e102
# bad: [610cb23bcc75bcd9fead3e41cbd867cccd0eb229] parisc: Add initial kernel-side perf_event support
git bisect bad 610cb23bcc75bcd9fead3e41cbd867cccd0eb229
# first bad commit: [610cb23bcc75bcd9fead3e41cbd867cccd0eb229] parisc: Add initial kernel-side perf_event support
