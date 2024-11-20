Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF95336D;
	Wed, 20 Nov 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089877; cv=none; b=eSksisM9xgEKNKMCbTxer4DDf6scpMVgDbmJCB7dMu5RqyELm8+ralUck4721ZLWP/n5mUoHs2z5FxMRDC71RbTDBAeALHyiLf7MZdnDbSWmAtGnDnDunS5WRDRanwfFpajkScshItK5+dwlMaw7McbRWmORacGNcJnpBC3cEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089877; c=relaxed/simple;
	bh=HFltQYfSyHCHNcIfQ4g3Z4HZuHhmS+kgfIWAsCe+nA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNguvah3btGzV1R2MC7YR4uv0s4PvvHSB6DOVSPPjzQv5xOzy9vDNJXBb2y12HL2YcM5JhIVtyc+TqBIIl9wQ5lyExafQ59SQwhMGA00ZmZ/CPQd+o/2kMQ7LxBBBnuq31CRPWZpNrfNwtDGiOYzr3rDhZU9BMfEseEA44WfJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=RNUnxjJq; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="RNUnxjJq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF801280999;
	Wed, 20 Nov 2024 08:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1732089514; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=M2sU5qJlBqmG4hFYvlsdBKny2YgDpcGgLzIdU3OytIs=;
	b=RNUnxjJqc7yZta007DFWhfJk18f3W1+XnUDNX663yxpz6EtTo/+vw6sgyFwP8aGe2v0Nq4
	5vOFPPG39wnkcIf5GK5+uTfA9edFDXKqObsBm75htgDe3YZhn6h49ynxXpouw1lAktwwYv
	H2XcNha4DrQ7LuP8XpOTuXxa7JtG0yf1GqvwmdmmSP7vtnphrq3yDsVmDHvlTxeLpE8tQx
	BTaxt3IOMjSlbehCk4Hkn9TNO//u3za/dOyQQFoUWSkXz44sgWHWT1N/ILznBpTueN2Iji
	pBYceyBuTPlvXL65d72ckLMolBh+qAMQO6YgQJ8Oq54vR5rkcvCrayK3quyRRw==
Message-ID: <a7159bad-92a1-47e8-b892-2ae0dd9a94f6@cachyos.org>
Date: Wed, 20 Nov 2024 08:58:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, rui.zhang@intel.com, irogers@google.com,
 kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei,
 gautham.shenoy@amd.com
Cc: kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi together,

This patch seems to crash the kernel  and results into a not bootable 
system.


The patch has been applied on base 6.12.rc7 - I have not tested it yet 
on linux-next.

I was able to reproduce this issue also on the v6 and the only "good" 
version was the v4.
This has been reproduced on several zen3+ machines and also on my 9950X.

Bisect log:
```
git bisect start
# status: waiting for both good and bad commits
# good: [2d5404caa8c7bb5c4e0435f94b28834ae5456623] Linux 6.12-rc7
git bisect good 2d5404caa8c7bb5c4e0435f94b28834ae5456623
# status: waiting for bad commit, 1 good commit known
# bad: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add 
core energy counter support for AMD CPUs
git bisect bad 372e95a40e04ae6ebe69300b76566af6455ba84e
# good: [fd3c84b2fc8a50030e8c7d91983f50539035ec3a] perf/x86/rapl: Rename 
rapl_pmu variables
git bisect good fd3c84b2fc8a50030e8c7d91983f50539035ec3a
# good: [96673b2c940e71fde50a54311ecdce00ff7a8e0b] perf/x86/rapl: Modify 
the generic variable names to *_pkg*
git bisect good 96673b2c940e71fde50a54311ecdce00ff7a8e0b
# good: [68b214c92635f0b24a3f3074873b77f4f1a82b80] perf/x86/rapl: Move 
the cntr_mask to rapl_pmus struct
git bisect good 68b214c92635f0b24a3f3074873b77f4f1a82b80
# first bad commit: [372e95a40e04ae6ebe69300b76566af6455ba84e] 
perf/x86/rapl: Add core energy counter support for AMD CPUs
```

Log:
```
Nov 17 12:17:37 varvalian kernel: Oops: general protection fault, 
probably for non-canonical address 0x796772656e650073: 0000 [#1] PREEMPT 
SMP NOPTI
Nov 17 12:17:37 varvalian kernel: CPU: 8 UID: 0 PID: 549 Comm: 
(udev-worker) Tainted: G           OE      6.12.0-rc7-6-cachyos-rc-test 
#1 bf94bb78cd9745ddc98a0655e5681df034f56f3d
Nov 17 12:17:37 varvalian kernel: Tainted: [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
Nov 17 12:17:37 varvalian kernel: Hardware name: LENOVO 
82SN/LNVNB161216, BIOS J4CN41WW 04/09/2024
Nov 17 12:17:37 varvalian kernel: RIP: 0010:internal_create_group+0x9a/0x4e0
Nov 17 12:17:37 varvalian kernel: Code: 7b 20 00 0f 84 cb 00 00 00 48 8d 
74 24 1c 48 8d 54 24 18 4c 89 ff e8 15 8a 99 00 48 83 3b 00 74 59 48 8b 
43 18 48 85 c0 74 11 <48> 8b 30 48 85 f6 74 09 4c 8b 5b 08 4d 85 db 75 
1a 48 8b 43 20 48
Nov 17 12:17:37 varvalian kernel: RSP: 0018:ffffaa5281fe7868 EFLAGS: 
00010202
Nov 17 12:17:37 varvalian kernel: RAX: 796772656e650073 RBX: 
ffffffffc2a642aa RCX: f781ec27a963db00
Nov 17 12:17:37 varvalian kernel: RDX: ffffaa5281fe7880 RSI: 
ffffaa5281fe7884 RDI: ffff90c611dc8400
Nov 17 12:17:37 varvalian kernel: RBP: 000000000000000f R08: 
0000000000000000 R09: 0000000000000001
Nov 17 12:17:37 varvalian kernel: R10: 0000000002000001 R11: 
ffffffff8e86ee00 R12: 0000000000000000
Nov 17 12:17:37 varvalian kernel: R13: ffff90c6038469c0 R14: 
ffff90c611dc8400 R15: ffff90c611dc8400
Nov 17 12:17:37 varvalian kernel: FS:  00007163efc54880(0000) 
GS:ffff90c8f0000000(0000) knlGS:0000000000000000
Nov 17 12:17:37 varvalian kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Nov 17 12:17:37 varvalian kernel: CR2: 00007163efd6a637 CR3: 
0000000121298000 CR4: 0000000000f50ef0
Nov 17 12:17:37 varvalian kernel: PKRU: 55555554
Nov 17 12:17:37 varvalian kernel: Call Trace:
Nov 17 12:17:37 varvalian kernel:  <TASK>
Nov 17 12:17:37 varvalian kernel:  ? __die_body+0x6a/0xb0
Nov 17 12:17:37 varvalian kernel:  ? die_addr+0xa4/0xd0
Nov 17 12:17:37 varvalian kernel:  ? exc_general_protection+0x170/0x220
Nov 17 12:17:37 varvalian kernel:  ? asm_exc_general_protection+0x26/0x30
Nov 17 12:17:37 varvalian kernel:  ? __pfx_device_get_ownership+0x10/0x10
Nov 17 12:17:37 varvalian kernel:  ? internal_create_group+0x9a/0x4e0
Nov 17 12:17:37 varvalian kernel:  ? internal_create_group+0x8b/0x4e0
Nov 17 12:17:37 varvalian kernel:  sysfs_update_groups+0x37/0x80
Nov 17 12:17:37 varvalian kernel:  pmu_dev_alloc+0xc6/0xe0
Nov 17 12:17:37 varvalian kernel:  perf_pmu_register+0x28c/0x3e0
Nov 17 12:17:37 varvalian kernel:  init_module+0x1d9/0x240 [rapl 
339c1d4b88353cca8b92d05e1524f5f14886bd70]
Nov 17 12:17:37 varvalian kernel:  ? __pfx_init_module+0x10/0x10 [rapl 
339c1d4b88353cca8b92d05e1524f5f14886bd70]
Nov 17 12:17:37 varvalian kernel:  do_one_initcall+0x122/0x370
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? idr_alloc_cyclic+0x139/0x1d0
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? 
security_kernfs_init_security+0x54/0x190
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? __kernfs_new_node+0x1ba/0x240
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? kernfs_link_sibling+0xef/0x110
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? kernfs_activate+0x2c/0x110
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? kernfs_add_one+0x108/0x140
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? __kernfs_create_file+0x75/0xb0
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? sysfs_create_bin_file+0xc6/0x120
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? __vunmap_range_noflush+0x344/0x410
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? insert_vmap_area+0xab/0xf0
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? module_decompress_cleanup+0x4a/0x70
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? load_module+0x1111/0x1330
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? __kmalloc_cache_noprof+0x12b/0x2e0
Nov 17 12:17:37 varvalian kernel:  do_init_module+0x60/0x240
Nov 17 12:17:37 varvalian kernel:  __se_sys_finit_module+0x270/0x380
Nov 17 12:17:37 varvalian kernel:  do_syscall_64+0x88/0x160
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? __x64_sys_lseek+0x5d/0xa0
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? syscall_exit_to_user_mode+0x34/0xd0
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? do_syscall_64+0x94/0x160
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? do_user_addr_fault+0x289/0x730
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Nov 17 12:17:37 varvalian kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 17 12:17:37 varvalian kernel: RIP: 0033:0x7163ef71f15d
Nov 17 12:17:37 varvalian kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 
00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 
4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9b 6b 0d 00 
f7 d8 64 89 01 48
Nov 17 12:17:37 varvalian kernel: RSP: 002b:00007ffe2bda0ac8 EFLAGS: 
00000246 ORIG_RAX: 0000000000000139
Nov 17 12:17:37 varvalian kernel: RAX: ffffffffffffffda RBX: 
00005c1834b627f0 RCX: 00007163ef71f15d
Nov 17 12:17:37 varvalian kernel: RDX: 0000000000000004 RSI: 
00007163eef044ac RDI: 000000000000002b
Nov 17 12:17:37 varvalian kernel: RBP: 00007163eef044ac R08: 
00007163ef7f6ad0 R09: 00007ffe2bda0bf8
Nov 17 12:17:37 varvalian kernel: R10: 00005c18349ed010 R11: 
0000000000000246 R12: 0000000000020000
Nov 17 12:17:37 varvalian kernel: R13: 00005c1834b47b80 R14: 
0000000000000000 R15: 00005c1834b54470
Nov 17 12:17:37 varvalian kernel:  </TASK>
Nov 17 12:17:37 varvalian kernel: Modules linked in: rapl(+) 
nvidia_wmi_ec_backlight pcspkr sparse_keymap roles wmi_bmof 
platform_profile snd snd_pci_acp3x k10temp i2c_smbus ccp rfkill mousedev 
soundcore joydev typec i2c_hid_acpi i2c_hid amd_pmc ip6t_REJECT acpi_tad 
nf_reject_ipv6 mac_hid xt_hl ip6t_rt ipt_REJECT nf_reject_ipv4 xt_LOG 
nf_log_syslog xt_recent nft_limit xt_limit xt_addrtype xt_tcpudp 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat 
nf_tables pkcs8_key_parser uinput i2c_dev crypto_user loop dm_mod 
nfnetlink zram 842_decompress 842_compress lz4hc_compress lz4_compress 
ip_tables x_tables amdgpu btrfs crc16 libcrc32c amdxcp crc32c_generic 
drm_buddy raid6_pq serio_raw drm_suballoc_helper xor drm_exec atkbd 
sdhci_pci i2c_algo_bit crc32c_intel vivaldi_fmap libps2 sha256_ssse3 
cqhci drm_display_helper nvme sdhci cec nvme_core i8042 mmc_core 
gpu_sched nvme_auth serio hid_logitech_hidpp hid_logitech_dj hid_generic 
usbhid nvidia_drm(OE) drm_ttm_helper ttm nvidia_uvm(OE) 
nvidia_modeset(OE) video wmi nvidia(OE)
Nov 17 12:17:37 varvalian kernel: RIP: 0010:internal_create_group+0x9a/0x4e0
Nov 17 12:17:37 varvalian kernel: Code: 7b 20 00 0f 84 cb 00 00 00 48 8d 
74 24 1c 48 8d 54 24 18 4c 89 ff e8 15 8a 99 00 48 83 3b 00 74 59 48 8b 
43 18 48 85 c0 74 11 <48> 8b 30 48 85 f6 74 09 4c 8b 5b 08 4d 85 db 75 
1a 48 8b 43 20 48
Nov 17 12:17:37 varvalian kernel: RSP: 0018:ffffaa5281fe7868 EFLAGS: 
00010202
Nov 17 12:17:37 varvalian kernel: RAX: 796772656e650073 RBX: 
ffffffffc2a642aa RCX: f781ec27a963db00
Nov 17 12:17:37 varvalian kernel: RDX: ffffaa5281fe7880 RSI: 
ffffaa5281fe7884 RDI: ffff90c611dc8400
Nov 17 12:17:37 varvalian kernel: RBP: 000000000000000f R08: 
0000000000000000 R09: 0000000000000001
Nov 17 12:17:37 varvalian kernel: R10: 0000000002000001 R11: 
ffffffff8e86ee00 R12: 0000000000000000
Nov 17 12:17:37 varvalian kernel: R13: ffff90c6038469c0 R14: 
ffff90c611dc8400 R15: ffff90c611dc8400
Nov 17 12:17:37 varvalian kernel: FS:  00007163efc54880(0000) 
GS:ffff90c8efe00000(0000) knlGS:0000000000000000
Nov 17 12:17:37 varvalian kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Nov 17 12:17:37 varvalian kernel: CR2: 00005c1834b98298 CR3: 
0000000121298000 CR4: 0000000000f50ef0
Nov 17 12:17:37 varvalian kernel: PKRU: 55555554
Nov 17 12:17:47 varvalian kernel: ------------[ cut here ]------------
```

Ill do on the weekend some additonal tests based on the latest 
linux-next snapshot and provide some more logs.

Regards,

Peter

On 15.11.24 07:08, Dhananjay Ugwekar wrote:
> Add a new "power_core" PMU and "energy-core" event for monitoring
> energy consumption by each individual core. The existing energy-cores
> event aggregates the energy consumption of CPU cores at the package level.
> This new event aligns with the AMD's per-core energy counters.
> 
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
> 
> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
> machine:
> 
> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
> stress-ng: info:  [21250] setting to a 5 second run per stressor
> stress-ng: info:  [21250] dispatching hogs: 1 matrix
> stress-ng: info:  [21250] successful run completed in 5.00s
> 
>   Performance counter stats for 'system wide':
> 
> S0-D0-C0              1               0.00 Joules power_core/energy-core/
> S0-D0-C1              1               0.00 Joules power_core/energy-core/
> S0-D0-C2              1               0.00 Joules power_core/energy-core/
> S0-D0-C3              1               0.00 Joules power_core/energy-core/
> S0-D0-C4              1               8.43 Joules power_core/energy-core/
> S0-D0-C5              1               0.00 Joules power_core/energy-core/
> S0-D0-C6              1               0.00 Joules power_core/energy-core/
> S0-D0-C7              1               0.00 Joules power_core/energy-core/
> S0-D1-C8              1               0.00 Joules power_core/energy-core/
> S0-D1-C9              1               0.00 Joules power_core/energy-core/
> S0-D1-C10             1               0.00 Joules power_core/energy-core/
> 
> Signed-off-by: Dhananjay Ugwekar<Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Gautham R. Shenoy<gautham.shenoy@amd.com>
> ---
>   arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 152 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 6e51386ff91f..e9be1f31163d 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -39,6 +39,10 @@
>    *	  event: rapl_energy_psys
>    *    perf code: 0x5
>    *
> + *  core counter: consumption of a single physical core
> + *	  event: rapl_energy_core (power_core PMU)
> + *    perf code: 0x1
> + *
>    * We manage those counters as free running (read-only). They may be
>    * use simultaneously by other tools, such as turbostat.
>    *
> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>   	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>   };
>   
> +#define PERF_RAPL_CORE			0		/* single core */
> +#define PERF_RAPL_CORE_EVENTS_MAX	1
> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
> +
>   static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>   	"pp0-core",
>   	"package",
> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>   	"psys",
>   };
>   
> +static const char *const rapl_core_domain_name __initconst = "core";
> +
>   /*
>    * event code: LSB 8 bits, passed in attr->config
>    * any other bit is reserved
> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>   
>   struct rapl_model {
>   	struct perf_msr *rapl_pkg_msrs;
> +	struct perf_msr *rapl_core_msrs;
>   	unsigned long	pkg_events;
> +	unsigned long	core_events;
>   	unsigned int	msr_power_unit;
>   	enum rapl_unit_quirk	unit_quirk;
>   };
>   
>    /* 1/2^hw_unit Joule */
>   static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
> +static int rapl_core_hw_unit __read_mostly;
>   static struct rapl_pmus *rapl_pmus_pkg;
> +static struct rapl_pmus *rapl_pmus_core;
>   static u64 rapl_timer_ms;
>   static struct rapl_model *rapl_model;
>   
> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>    * Helper function to get the correct topology id according to the
>    * RAPL PMU scope.
>    */
> -static inline unsigned int get_rapl_pmu_idx(int cpu)
> -{	/*
> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
> +{
> +	/*
>   	 * Returns unsigned int, which converts the '-1' return value
>   	 * (for non-existent mappings in topology map) to UINT_MAX, so
>   	 * the error check in the caller is simplified.
>   	 */
> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> -					     topology_logical_die_id(cpu);
> +	switch (scope) {
> +	case PERF_PMU_SCOPE_PKG:
> +		return topology_logical_package_id(cpu);
> +	case PERF_PMU_SCOPE_DIE:
> +		return topology_logical_die_id(cpu);
> +	case PERF_PMU_SCOPE_CORE:
> +		return topology_logical_core_id(cpu);
> +	default:
> +		return -EINVAL;
> +	}
>   }
>   
>   static inline u64 rapl_read_counter(struct perf_event *event)
> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>   	return raw;
>   }
>   
> -static inline u64 rapl_scale(u64 v, int cfg)
> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>   {
> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
> -		return v;
> -	}
> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
> +
> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
> +		hw_unit = rapl_core_hw_unit;
> +
>   	/*
>   	 * scale delta to smallest unit (1/2^32)
>   	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>   	 * or use ldexp(count, -32).
>   	 * Watts = Joules/Time delta
>   	 */
> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
> +	return v << (32 - hw_unit);
>   }
>   
>   static u64 rapl_event_update(struct perf_event *event)
> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>   	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>   	delta >>= shift;
>   
> -	sdelta = rapl_scale(delta, event->hw.config);
> +	sdelta = rapl_scale(delta, event);
>   
>   	local64_add(sdelta, &event->count);
>   
> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>   static int rapl_pmu_event_init(struct perf_event *event)
>   {
>   	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> -	int bit, ret = 0;
> +	int bit, rapl_pmus_scope, ret = 0;
>   	struct rapl_pmu *rapl_pmu;
>   	unsigned int rapl_pmu_idx;
> +	struct rapl_pmus *rapl_pmus;
>   
> -	/* only look at RAPL events */
> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
> -		return -ENOENT;
> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
>   
>   	/* check only supported bits are set */
>   	if (event->attr.config & ~RAPL_EVENT_MASK)
> @@ -356,31 +381,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
>   	if (event->cpu < 0)
>   		return -EINVAL;
>   
> -	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
> +	if (!rapl_pmus)
>   		return -EINVAL;
> -
> -	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> -	bit = cfg - 1;
> -
> -	/* check event supported */
> -	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
> +	rapl_pmus_scope = rapl_pmus->pmu.scope;
> +
> +	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
> +		/* only look at RAPL package events */
> +		if (event->attr.type != rapl_pmus_pkg->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
> +	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
> +		/* only look at RAPL core events */
> +		if (event->attr.type != rapl_pmus_core->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
> +	} else
>   		return -EINVAL;
>   
> -	/* unsupported modes and filters */
> -	if (event->attr.sample_period) /* no sampling */
> +	/* check event supported */
> +	if (!(rapl_pmus->cntr_mask & (1 << bit)))
>   		return -EINVAL;
>   
> -	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
> -	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>   		return -EINVAL;
> -
>   	/* must be done before validate_group */
> -	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
> +	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
>   	if (!rapl_pmu)
>   		return -EINVAL;
>   
>   	event->pmu_private = rapl_pmu;
> -	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>   	event->hw.config = cfg;
>   	event->hw.idx = bit;
>   
> @@ -397,12 +440,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>   RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
>   RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
>   RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> +RAPL_EVENT_ATTR_STR(energy-core,   rapl_core, "event=0x01");
>   
>   RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
>   RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
>   RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
>   RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
>   RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
> +RAPL_EVENT_ATTR_STR(energy-core.unit,   rapl_core_unit, "Joules");
>   
>   /*
>    * we compute in 0.23 nJ increments regardless of MSR
> @@ -412,6 +457,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
>   RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
>   RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
>   RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
>   
>   /*
>    * There are no default events, but we need to create
> @@ -444,6 +490,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
>   	NULL,
>   };
>   
> +static const struct attribute_group *rapl_core_attr_groups[] = {
> +	&rapl_pmu_format_group,
> +	&rapl_pmu_events_group,
> +	NULL,
> +};
> +
>   static struct attribute *rapl_events_cores[] = {
>   	EVENT_PTR(rapl_cores),
>   	EVENT_PTR(rapl_cores_unit),
> @@ -504,6 +556,18 @@ static struct attribute_group rapl_events_psys_group = {
>   	.attrs = rapl_events_psys,
>   };
>   
> +static struct attribute *rapl_events_core[] = {
> +	EVENT_PTR(rapl_core),
> +	EVENT_PTR(rapl_core_unit),
> +	EVENT_PTR(rapl_core_scale),
> +	NULL,
> +};
> +
> +static struct attribute_group rapl_events_core_group = {
> +	.name  = "events",
> +	.attrs = rapl_events_core,
> +};
> +
>   static bool test_msr(int idx, void *data)
>   {
>   	return test_bit(idx, (unsigned long *) data);
> @@ -541,6 +605,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
>   	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>   };
>   
> +static struct perf_msr amd_rapl_core_msrs[] = {
> +	[PERF_RAPL_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_core_group,
> +				 test_msr, false, RAPL_MSR_MASK },
> +};
> +
>   static int rapl_check_hw_unit(void)
>   {
>   	u64 msr_rapl_power_unit_bits;
> @@ -552,6 +621,8 @@ static int rapl_check_hw_unit(void)
>   	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
>   		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>   
> +	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
> +
>   	switch (rapl_model->unit_quirk) {
>   	/*
>   	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
> @@ -570,7 +641,6 @@ static int rapl_check_hw_unit(void)
>   		break;
>   	}
>   
> -
>   	/*
>   	 * Calculate the timer rate:
>   	 * Use reference of 200W for scaling the timeout to avoid counter
> @@ -589,9 +659,13 @@ static int rapl_check_hw_unit(void)
>   static void __init rapl_advertise(void)
>   {
>   	int i;
> +	int num_counters = hweight32(rapl_pmus_pkg->cntr_mask);
> +
> +	if (rapl_pmus_core)
> +		num_counters += hweight32(rapl_pmus_core->cntr_mask);
>   
>   	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
> -		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
> +		num_counters, rapl_timer_ms);
>   
>   	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
>   		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
> @@ -599,6 +673,10 @@ static void __init rapl_advertise(void)
>   				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>   		}
>   	}
> +
> +	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
> +		pr_info("hw unit of domain %s 2^-%d Joules\n",
> +			rapl_core_domain_name, rapl_core_hw_unit);
>   }
>   
>   static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
> @@ -619,6 +697,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>   	NULL,
>   };
>   
> +static const struct attribute_group *rapl_core_attr_update[] = {
> +	&rapl_events_core_group,
> +};
> +
>   static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>   {
>   	struct rapl_pmu *rapl_pmu;
> @@ -645,13 +727,22 @@ static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>   	return -ENOMEM;
>   }
>   
> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
> +				 const struct attribute_group **rapl_attr_groups,
> +				 const struct attribute_group **rapl_attr_update)
>   {
>   	int nr_rapl_pmu = topology_max_packages();
>   	struct rapl_pmus *rapl_pmus;
>   
> +	/*
> +	 * rapl_pmu_scope must be either PKG, DIE or CORE
> +	 */
>   	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
>   		nr_rapl_pmu	*= topology_max_dies_per_package();
> +	else if (rapl_pmu_scope == PERF_PMU_SCOPE_CORE)
> +		nr_rapl_pmu	*= topology_num_cores_per_package();
> +	else if (rapl_pmu_scope != PERF_PMU_SCOPE_PKG)
> +		return -EINVAL;
>   
>   	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>   	if (!rapl_pmus)
> @@ -740,8 +831,10 @@ static struct rapl_model model_spr = {
>   
>   static struct rapl_model model_amd_hygon = {
>   	.pkg_events	= BIT(PERF_RAPL_PKG),
> +	.core_events	= BIT(PERF_RAPL_CORE),
>   	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>   	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
> +	.rapl_core_msrs	= amd_rapl_core_msrs,
>   };
>   
>   static const struct x86_cpu_id rapl_model_match[] __initconst = {
> @@ -813,7 +906,8 @@ static int __init rapl_pmu_init(void)
>   	if (ret)
>   		return ret;
>   
> -	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
> +	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
> +			     rapl_attr_update);
>   	if (ret)
>   		return ret;
>   
> @@ -825,6 +919,27 @@ static int __init rapl_pmu_init(void)
>   	if (ret)
>   		goto out;
>   
> +	if (rapl_model->core_events) {
> +		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
> +				     rapl_core_attr_groups,
> +				     rapl_core_attr_update);
> +		if (ret) {
> +			pr_warn("power-core PMU initialization failed (%d)\n", ret);
> +			goto core_init_failed;
> +		}
> +
> +		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
> +						     PERF_RAPL_CORE_EVENTS_MAX, false,
> +						     (void *) &rapl_model->core_events);
> +
> +		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_core", -1);
> +		if (ret) {
> +			pr_warn("power-core PMU registration failed (%d)\n", ret);
> +			cleanup_rapl_pmus(rapl_pmus_core);
> +		}
> +	}
> +
> +core_init_failed:
>   	rapl_advertise();
>   	return 0;
>   
> @@ -837,6 +952,10 @@ module_init(rapl_pmu_init);
>   
>   static void __exit intel_rapl_exit(void)
>   {
> +	if (rapl_pmus_core) {
> +		perf_pmu_unregister(&rapl_pmus_core->pmu);
> +		cleanup_rapl_pmus(rapl_pmus_core);
> +	}
>   	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
>   	cleanup_rapl_pmus(rapl_pmus_pkg);
>   }
> -- 2.34.1
> 

