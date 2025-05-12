Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D191E1E00
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058939; cv=none; b=c+lspM9Fvkzke1EC4LQQyMO4HSh5lYTGbdXjs5c2t0xYghqcF0/MCKJd2T+uiM6aS08fHIeTwZyAEAu28Mn70bH6cJvDG+9QWwlAbFZKg+OMLq6/h02QhaPKRQotAKeIBrP87svQeOFqzfezfIXGlR6eI1WTwu7O531+/WITXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058939; c=relaxed/simple;
	bh=+iywdlur6nphe1FJAlLFjto1jX5dtMomAgjsxCtm6Gc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XRTjx17GkDUx/7y3YBg9BgqViSCZ7sKER46G58ih6FpGvh5Kht9wvWILMVl8Oj2OGljr/uNe7zkyazxHpQDenrj4Ecg8mbSABlAYKXAnmCi2GQ1JGS/UaADLpDe8YqmTcwpEBbvcjesoS1iliBYDouxVUF2XKrG3T0FQniKv8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NO0EFwlV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NO0EFwlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747058936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=t6F/HXttFGEwh7CM5xDejgWccoHrgvvuQDWCPPftjIw=;
	b=NO0EFwlVK6vBKPPE/k+LDW6QcL66S+6D6wjDmCsAxzLOq7GgnIhn4h5Juxdm+9xqJFM/I/
	WKZDNXrX9U1AUfjMMIsB+Qk5HspF9XSW8S6Mle7rrieVMVXlQ4aCyy6O6u/6NOuOdCcQ0Q
	KCLtfBn87UzqFmL9XFQfqMw3S4KnszM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-KV96vJhjPGCd1O9tRnKnYQ-1; Mon, 12 May 2025 10:08:55 -0400
X-MC-Unique: KV96vJhjPGCd1O9tRnKnYQ-1
X-Mimecast-MFC-AGG-ID: KV96vJhjPGCd1O9tRnKnYQ_1747058934
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb61452b27so499658066b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 07:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058934; x=1747663734;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6F/HXttFGEwh7CM5xDejgWccoHrgvvuQDWCPPftjIw=;
        b=Q2dBbBprsB9HngijrKwA1cNYjyDzIdLli79asLSTtGb++5HXvujxUGAbAnv7d1H3qM
         gbQDqeic5tIBQQEIwJZkQCZ6R/X/1QcLOLFYEIM6erVYIYS1nRq1eXGkyFOnu1u4F0EA
         81t3fcmluRqAC0Pyl/rUBMeoLbOZTBAT17GEYnMDIu8OUYPSp7Nk6GwV5yIMKQWA0mjq
         8jYVKpC6JM12m7eaTDnvBbfNGyarVPj7P39eM9BdP0tcMifiRtsPQxXA6bsVbccdYUfD
         YDJu8R2+YKlvJ9fECOHnAaSoOHGeSKhmgc/XpncRxjzYtzlKRekIu6ExwkDrh4RDWc3P
         1uBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwf6YUMRHof0xkUcle+g15hkVPJoNF6kc9aoDv643u+04phiAO5ueC0L8POYFEFgq20gQcz7yEwAbOKd7rdRGV@vger.kernel.org
X-Gm-Message-State: AOJu0YwF94dzVrphLy5gNx71uiCVC/z+Jrnuh/vbKozLSh+jeNirYM2r
	81wsDwCPuzRP69uuIffGrDsfPMnahp1aVofo5TFjP8XxIe8O9PbnyrMZo2G7jAZbuqzt9ymerwT
	6LiUFbQU7tW0IiE7E5OqNz+tZecRsvQUMLCzEZ4Nj6UV1+LfmT1pUVQ1WTOqTv+j6dtgHKuDYKd
	qOkxi0DOB6HuKIorTfhGQSHf/5usmjxCgEPJNgQWPckQ==
X-Gm-Gg: ASbGncvb0YxwlKHqAkJZPeug2r92qOpnZspml3urUdYzBOD6B0i9bxxjtJ5hCtyRo9r
	ZMwgheL/LpOd4Yfx8BSWuDljRJRMFqUc6ONq61Gd29FqYK4yW5PazGVpNhUCTqgzKQ55xnY2AMX
	2ML0YjaMYd5dluIlxIktQxCyA=
X-Received: by 2002:a17:907:968c:b0:ad2:49cc:b460 with SMTP id a640c23a62f3a-ad249ccb8admr547320066b.3.1747058934175;
        Mon, 12 May 2025 07:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcevVH/6lfbagTqi3aUM91UYOgKGprVmNOb7KEb7kx03tC64DbltJnK+NyYmxZkUg533PKLhSRjs6BhSQjRa8=
X-Received: by 2002:a17:907:968c:b0:ad2:49cc:b460 with SMTP id
 a640c23a62f3a-ad249ccb8admr547316466b.3.1747058933669; Mon, 12 May 2025
 07:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 12 May 2025 16:08:42 +0200
X-Gm-Features: AX0GCFuzKy6TASLqPCYoKUqmLQ_eFSaYPnjVvRbm7JyBu8Rsq5dtBEaauvM2WF4
Message-ID: <CAP4=nvS2r=-1GgnmsEA9s7JPs1EVg9R63FLLNboN=f1cq0WEqQ@mail.gmail.com>
Subject: [BUG?] perf_event_open fails on synthetic event created through dynamic_events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear perf and tracing maintainers,

I would like to report a bug in perf/tracing (not sure where the bug
actually is) with synthetic events and perf, on the latest 6.15-rc6
kernel.

Tracefs allows creating synthetic events through the
/sys/kernel/tracing/dynamic_events file, which show up in perf as
synthetic:test_event:

$ echo 's:test_event u64 arg;' > /sys/kernel/tracing/dynamic_events
$  cat /sys/kernel/tracing/dynamic_events
s:synthetic/test_event  u64 arg
$  perf list | grep test_event
 synthetic:test_event                               [Tracepoint event]

However, perf_event_open is failing on those events:

$ perf record -e synthetic:test_event
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (synthetic:test_event).
/bin/dmesg | grep -i perf may provide additional information.

dmesg shows this:

[   81.136609] ------------[ cut here ]------------
[   81.136614] WARNING: CPU: 12 PID: 5384 at kernel/tracepoint.c:142
tracepoint_add_func+0x351/0x3a0
[   81.136621] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje
ct_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables
nfnetlink b
infmt_misc intel_rapl_msr intel_rapl_common
intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_class
intel_vsec kvm_intel kvm sn
d_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
snd_hda_codec snd_hda_core irqbypass rapl snd_hwdep snd_seq snd_seq_de
vice snd_pcm iTCO_wdt snd_timer intel_pmc_bxt joydev snd
iTCO_vendor_support i2c_i801 soundcore pcspkr virtio_balloon lpc_ich
i2c_smbus nfsd
auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc xfs polyval_clmulni
polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 virtio
_gpu virtio_net sha1_ssse3 net_failover failover virtio_dma_buf
serio_raw fuse qemu_fw_cfg
[   81.136653] CPU: 12 UID: 0 PID: 5384 Comm: perf Kdump: loaded Not
tainted 6.15.0-rc6 #24 PREEMPT(lazy)
[   81.136657] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-3.fc41 04/01/2014
[   81.136658] RIP: 0010:tracepoint_add_func+0x351/0x3a0
[   81.136660] Code: fe ff ff 49 8b 7e 18 48 85 ff 0f 84 8c fe ff ff
49 8b 56 28 49 8b 76 20 4c 89 04 24 e8 e8 d6 10 00 4c 8b 04 24 e9 72
fe
ff ff <0f> 0b b8 ea ff ff ff 45 84 e4 0f 85 4a fd ff ff e9 9f fe ff ff 49
[   81.136661] RSP: 0018:ffffcfd2408779c0 EFLAGS: 00010246
[   81.136663] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
[   81.136666] RDX: 000000000000000a RSI: ffffcfd240877a00 RDI: 0000000000000000
[   81.136667] RBP: 000000000000000a R08: ffff8881d901e090 R09: ffffefd23fcaf600
[   81.136667] R10: ffffffffb7f07720 R11: 0000000000000080 R12: 0000000000000001
[   81.136668] R13: ffffcfd240877a00 R14: ffff8881d8302120 R15: 0000000000000000
[   81.136669] FS:  00007f5bd4b3e2c0(0000) GS:ffff8883ed610000(0000)
knlGS:0000000000000000
[   81.136670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.136671] CR2: 000055a33b2c5248 CR3: 0000000127ed9001 CR4: 0000000000772ef0
[   81.136674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   81.136674] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   81.136675] PKRU: 55555554
[   81.136676] Call Trace:
[   81.136677]  <TASK>
[   81.136679]  tracepoint_probe_register+0x5b/0x90
[   81.136680]  perf_trace_event_reg+0xfd/0x1f0
[   81.136685]  perf_trace_event_init+0x33/0x160
[   81.136688]  ? trace_event_dyn_try_get_ref+0x61/0x80
[   81.136691]  perf_trace_init+0x73/0xc0
[   81.136692]  perf_tp_event_init+0x24/0x50
[   81.136695]  perf_try_init_event+0x4a/0x2c0
[   81.136701]  perf_init_event+0xd7/0x190
[   81.136703]  ? __pfx_perf_event_output_forward+0x10/0x10
[   81.136705]  perf_event_alloc+0x3cf/0x840
[   81.136709]  ? __pfx_perf_event_output_forward+0x10/0x10
[   81.136711]  __do_sys_perf_event_open+0x268/0xb90
[   81.136716]  do_syscall_64+0x82/0x170
[   81.136720]  ? __mod_memcg_state+0xad/0x1d0
[   81.136723]  ? refill_stock+0x79/0xc0
[   81.136724]  ? __memcg_slab_free_hook+0x114/0x170
[   81.136726]  ? event_function_call+0x1a5/0x1b0
[   81.136729]  ? __memcg_slab_free_hook+0x114/0x170
[   81.136731]  ? __x64_sys_close+0x3d/0x80
[   81.136733]  ? kmem_cache_free+0x340/0x450
[   81.136735]  ? syscall_exit_to_user_mode_prepare+0x154/0x190
[   81.136738]  ? syscall_exit_to_user_mode+0x10/0x210
[   81.136740]  ? do_syscall_64+0x8e/0x170
[   81.136741]  ? count_memcg_events.constprop.0+0x1a/0x30
[   81.136743]  ? handle_mm_fault+0x233/0x350
[   81.136745]  ? do_user_addr_fault+0x2d0/0x8b0
[   81.136748]  ? syscall_exit_to_user_mode+0x10/0x210
[   81.136749]  ? clear_bhb_loop+0x35/0x90
[   81.136751]  ? clear_bhb_loop+0x35/0x90
[   81.136752]  ? clear_bhb_loop+0x35/0x90
[   81.136753]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.136754] RIP: 0033:0x7f5bd41076cd
[   81.136756] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08
0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1b 17 0f 00 f7 d8 64 89 01 48
[   81.136757] RSP: 002b:00007ffcfd937af8 EFLAGS: 00000246 ORIG_RAX:
000000000000012a
[   81.136760] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f5bd41076cd
[   81.136761] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 000055a33b2a57b0
[   81.136761] RBP: 00007ffcfd937bf0 R08: 0000000000000008 R09: 0000000000000000
[   81.136762] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000008
[   81.136763] R13: 0000000000000000 R14: 0000000000000000 R15: 000055a33b2a57a0
[   81.136764]  </TASK>
[   81.136765] ---[ end trace 0000000000000000 ]---

(repeated multiple times)

It seems that it is trying to access a struct tracepoint object whose
func field is NULL. I have not tried attaching to dynamic events
through perf before, so I don't know whether this is just
unimplemented and poorly handled or a regression. For what it's worth,
it also happens on CentOS Stream 9 kernel (5.14.0-578.el9).

Thanks,
Tomas

