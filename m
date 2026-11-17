Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957039;
	b=tMro7ak+3AFdO3UsJ0dElgdCDGfwEFM77GD9hE6pmuxYZtDG64WflgUauvA4E11OmxK/
	 jzsSjBIuHbw2sVkhNxJGfmfx/OyNPOR6zxhnljMJJ1rctLcS+j/cYhRhRIzjQkxKUl0YP
	 UYLCizw3D6O3jGUokljtKJpnQNBvQCjE2/hNmeg0vwC+8FnG8GVj/482AN7zMrqlFzZDH
	 42COFvLDbLcCsC2xri76d5/FVd6vrgfV1MF4ggc8gvfDaPsQzwgoM3FtiKcwDQ/moFVDV
	 Nhv01VV/aRJsVpMC4LAqhVtHfWEyHsrbZy6k/x80O2GgqOMf+5UW+PORbZB47QTaPNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957039;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type:Content-Transfer-Encoding;
	bh=+wBAluwliayr72IP0v4lzu4cOma3Jxi3Zj2huXDAK58=;
	b=123KwU6sKcKON31qYyTdgqnsv+9iJZm+mGMPKxLzUkMK9KcKdiAnaxcNG/8cWsB4cZ2Q
	 mG35xy1Cdt4D+AwZ5AJ0KjgJ7K5tSggE0bG+NOtuIuZ2lJIoyhaTTKU61wWpuYF3YdrSo
	 sM9OuvCOt7mHPMqqs+uSVUU+d1wDGK9S2nuPFQmBTaUK3qcdah1SEFcES7bbIHO5M2aIn
	 3RcO9XZAoGhVKi3B/KzSix8hZ64ltSrU6tGlDZMsP3K48wLHojWnNeDL39OOszZnuUNfE
	 a5tYlyEmR5TdTr6JWjhZgvWP7ezWbayimCy8Ztf1u4rdek9otYoXMr8JrQ4VZLLdL5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FE606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 23:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab4f652f9bso225341b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 15:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794957038; x=1795561838;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wBAluwliayr72IP0v4lzu4cOma3Jxi3Zj2huXDAK58=;
        b=N7VPB41yAzr4d51gRpxICfrtj5WL2fjQHa7KOMEmxeGNjUPS7+Uw3BqnQvWKHwPeJZ
         zn9k37FR7o14I3cLxT1lFkO6SAt3bYI4OZL7QT2WgGA6WJaWjCAUog1NCDVZo1UCqijW
         cOY9qE04N2fDCoR1WgirNRle4nnwZfEu2Ygel+CkKlA3TXt+g2l150noiR10q12p9trZ
         UrHF3addnx5o5B7uoHHiw+Bv3ZJ+T/HuXLsKwl8AdK20lbKMlFLA7nBGtN9sCAsIQxC+
         1FB5ZNNQ3K3VkoQMpzgFzUesShtS0shcHoZtzbOwYtwYfpw2gfUnJW5F+rGnn4Fv668a
         k77Q==
X-Forwarded-Encrypted: i=1; AL+hErEECS1e5iubMu+6r6zVTXW7t0F3MusAeB60Zx5+zISpkSaWdd7DwcenpXVnz3bfLpU3Kl6ps5gOWYchRPnJ7hz2@vger.kernel.org
X-Gm-Message-State: APuU4Z8TrxmBN2j8cXeyZuPBkD1zYNp2hJ3XAo918rzvKfQbm0Ydeb12
	XTVyCiemH2dPumsdVvqbxBj8pxNN7NsxmM1xSur2KM3oJHhoogxbkiQnvQZQnQu0T0MyuJWD9s3
	7jbz1ljyOMoRnglAkbMmsPdzSSzcF8nmvNXncQEWpaWx8RmkxvIGpAewsuns=
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5088:b0:4a4:744:a4ff with SMTP id
 5614622812f47-5773db24bc2mr1479483b6e.4.1794957037943; Tue, 17 Nov 2026
 15:10:37 -0800 (PST)
Date: Tue, 17 Nov 2026 15:10:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afcdeed.8f566acc.2517be.000e.GAE@google.com>
Subject: [syzbot] [perf?] [arm?] BUG: workqueue lockup in wg_ratelimiter_gc_entries
From: syzbot <syzbot+4610f17b25e845477657@syzkaller.appspotmail.com>
To: acme@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    518e5b794c06 Merge tag 'for-7.3-rc3-tag' of git://git.kern.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15dffff9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc3be6e434b07ebb=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4610f17b25e845477=
657
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-=
1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8646adfc1052/disk-=
518e5b79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b37f45f956ef/vmlinux-=
518e5b79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/20143fe230d6/bzI=
mage-518e5b79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+4610f17b25e845477657@syzkaller.appspotmail.com

sched: DL replenish lagged too much
BUG: workqueue lockup - pool cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 stuck f=
or 156s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D10 refcnt=3D11
    in-flight: 5700:request_firmware_work_func for 156s
    pending: nsim_dev_hwstats_traffic_work, vmstat_shepherd, psi_avgs_work,=
 4*ovs_dp_masks_rebalance, nsim_fib_event_work, delayed_vfree_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D13 refcnt=3D14
    in-flight: 5692:reg_todo for 157s
    pending: 4*nsim_dev_hwstats_traffic_work, 3*psi_avgs_work, 2*ovs_dp_mas=
ks_rebalance, 2*psi_avgs_work, xfrm_state_gc_task
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D21 refcnt=3D22
    in-flight: 146:cfg80211_wiphy_work for 155s cfg80211_wiphy_work ,12:cfg=
80211_wiphy_work for 156s cfg80211_wiphy_work
    pending: nsim_dev_trap_report_work, flush_memcg_stats_dwork, cfg80211_w=
iphy_work, 4*nsim_dev_trap_report_work, 7*macvlan_process_broadcast, toggle=
_allocation_gate, crng_reseed, macvlan_process_broadcast
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D12 refcnt=3D13
    in-flight: 1123:cfg80211_wiphy_work for 147s ,160:cfg80211_wiphy_work f=
or 156s cfg80211_wiphy_work ,59:cfg80211_wiphy_work for 153s ,1116:cfg80211=
_wiphy_work for 153s ,13:cfg80211_wiphy_work for 147s ,50:cfg80211_wiphy_wo=
rk for 147s
    pending: 5*cfg80211_wiphy_work
workqueue events_freezable: flags=3D0x104
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: update_balloon_stats_func
workqueue events_power_efficient: flags=3D0x180
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D3 refcnt=3D4
    pending: do_cache_clean, 2*check_lifetime
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D12 refcnt=3D13
    in-flight: 5730:wg_ratelimiter_gc_entries for 156s
    pending: neigh_managed_work, neigh_periodic_work, hash_ipmac4_gc, neigh=
_managed_work, gc_worker, neigh_periodic_work, reg_check_chans_work, 4*chec=
k_lifetime
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D8 refcnt=3D9
    pending: 8*defense_work_handler
workqueue kvfree_rcu_reclaim: flags=3D0xa
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D4 MAYDAY
    pending: 2*kfree_rcu_monitor
workqueue netns: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4
    in-flight: 139:cleanup_net for 159s
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue writeback: flags=3D0x4a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D3 MAYDAY
    pending: wb_workfn
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D3 MAYDAY
    pending: wb_update_bandwidth_workfn
workqueue kblockd: flags=3D0x118
  pwq 3: cpus=3D0 node=3D0 flags=3D0x0 nice=3D-20 active=3D1 refcnt=3D2
    pending: blk_mq_timeout_work
workqueue usb_hub_wq: flags=3D0x104
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    in-flight: 5699:hub_event for 157s hub_event
workqueue ksmbd-conn-release: flags=3D0xa
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D3 MAYDAY
    pending: ksmbd_session_expiration_worker
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D11 MAYDAY
    in-flight: 3195(RESCUER):addrconf_verify_work for 147s
    pending: mayday_cursor_func
    inactive: 5*addrconf_verify_work
workqueue krxrpcd: flags=3D0x2001a
  pwq 9: cpus=3D0-1 node=3D0 flags=3D0x4 nice=3D-20 active=3D1 refcnt=3D4
    pending: rxrpc_peer_keepalive_worker
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D40 MAYDAY
    in-flight: 3226(RESCUER):batadv_dat_purge for 2s
    pending: mayday_cursor_func
    inactive: batadv_bla_periodic_work, 5*batadv_mcast_mla_update, 4*batadv=
_iv_send_outstanding_bat_ogm_packet, 3*batadv_purge_orig, 4*batadv_iv_send_=
outstanding_bat_ogm_packet, batadv_purge_orig, batadv_iv_send_outstanding_b=
at_ogm_packet, batadv_purge_orig, 3*batadv_iv_send_outstanding_bat_ogm_pack=
et, 5*batadv_tt_purge, batadv_dat_purge, 2*batadv_bla_periodic_work, batadv=
_dat_purge, batadv_bla_periodic_work, batadv_dat_purge
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_tx_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue krds_cp_wq#0/0: flags=3D0x20002
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D5
    in-flight: 37:rds_shutdown_worker for 85s
    inactive: rds_shutdown_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D147s workers=3D9 idle=
: 5664 1558 5701 9 5739 5749 10
pool 6: cpus=3D1 node=3D0 flags=3D0x0 nice=3D0 hung=3D156s workers=3D9 idle=
: 989 5672 25 5349 5671 5679 44
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D2s workers=3D11 manager: 156
Showing backtraces of busy workers in stalled worker pools:
pool 6:
task:kworker/1:8     state:R  running task     stack:25288 pid:5730  tgid:5=
730  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7277
 preempt_schedule_irq+0x4b/0x90 kernel/sched/core.c:7599
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:539 [inline]
 irqentry_exit+0x14f/0x910 kernel/entry/common.c:167
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
674
RIP: 0010:lock_is_held_type+0x106/0x150 kernel/locking/lockdep.c:6021
Code: 1b 00 00 b8 ff ff ff ff 65 0f c1 05 dc 9c af 07 83 f8 01 75 25 9c 58 =
a9 00 02 00 00 75 39 41 f7 c4 00 02 00 00 74 01 fb 89 d8 <5b> 41 5c 41 5d 4=
1 5e 41 5f 5d e9 5b 01 03 00 cc 90 0f 0b 90 48 c7
RSP: 0018:ffffc90004ccf9f8 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 0000000000000000 RSI: ffffffff8e69d180 RDI: ffffffff8c6da780
RBP: 00000000ffffffff R08: ffffffff8f9962e3 R09: 1ffffffff1f32c5c
R10: dffffc0000000000 R11: fffffbfff1f32c5d R12: 0000000000000246
R13: ffff8880328b0000 R14: ffffffff8ed5c940 R15: 0000000000000002
 lock_is_held include/linux/lockdep.h:249 [inline]
 __might_resched+0x37/0x4c0 kernel/sched/core.c:9219
 wg_ratelimiter_gc_entries+0x3a4/0x450 drivers/net/wireguard/ratelimiter.c:=
78
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6242/1:b..l
rcu: 	(detected by 0, t=3D10621 jiffies, g=3D21385, q=3D996 ncpus=3D2)
task:syz.2.155       state:R  running task     stack:24928 pid:6242  tgid:6=
241  ppid:5626   task_flags:0x40054c flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7277
 preempt_schedule_common+0x7f/0xd0 kernel/sched/core.c:7456
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __raw_spin_unlock include/linux/spinlock_api_smp.h:201 [inline]
 _raw_spin_unlock+0x41/0x50 kernel/locking/spinlock.c:213
 spin_unlock include/linux/spinlock.h:401 [inline]
 zap_pte_range mm/memory.c:2095 [inline]
 zap_pmd_range mm/memory.c:2151 [inline]
 zap_pud_range mm/memory.c:2179 [inline]
 zap_p4d_range mm/memory.c:2200 [inline]
 __zap_vma_range+0x40e1/0x4f80 mm/memory.c:2240
 unmap_vmas+0x390/0x550 mm/memory.c:2309
 exit_mmap+0x293/0x9f0 mm/mmap.c:1315
 __mmput+0x118/0x420 kernel/fork.c:1193
 exit_mm+0x221/0x2d0 kernel/exit.c:617
 do_exit+0x6cd/0x2360 kernel/exit.c:999
 do_group_exit+0x22d/0x2f0 kernel/exit.c:1154
 get_signal+0x121b/0x12c0 kernel/signal.c:3051
 arch_do_signal_or_restart+0xbb/0x860 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x10e/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [in=
line]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07d6f9e159
RSP: 002b:00007f07d7f530e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f07d7225fa8 RCX: 00007f07d6f9e159
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f07d7225fa8
RBP: 00007f07d7225fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f07d7226038 R14: 00007f07d734f960 R15: 00007f07d734fa48
 </TASK>
rcu: rcu_preempt kthread starved for 3099 jiffies! g21385 f0x0 RCU_GP_WAIT_=
FQS(5) ->state=3DR ->cpu=3D0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expec=
ted behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27496 pid:17    tgid:1=
7    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7277
 __schedule_loop kernel/sched/core.c:7354 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7369
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2122
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2330
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      syzkalle=
r #0 PREEMPT(full)=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/24/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: bc 88 02 c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d b3 c1 23 00 fb f4 <e9> 8c 08 03 00 c=
c cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8ea07ca0 EFLAGS: 00000242
RAX: 00000000001b75e9 RBX: ffffffff819bb25c RCX: 8000000000000001
RDX: 0000000000000001 RSI: ffffffff8e414979 RDI: ffffffff8c6da780
RBP: ffffffff8ea07d78 R08: ffff8880b8633a1b R09: 1ffff110170c6743
R10: dffffc0000000000 R11: ffffed10170c6744 R12: 0000000000000000
R13: 1ffffffff1d51e00 R14: 1ffffffff1d40f9c R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124cce000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000020f030 CR3: 000000007f564000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x1cc/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 rest_init+0x378/0x3a0 init/main.c:732
 start_kernel+0x392/0x3e0 init/main.c:1190
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x157
 </TASK>
----------------
Code disassembly (best guess):
   0:	1b 00                	sbb    (%rax),%eax
   2:	00 b8 ff ff ff ff    	add    %bh,-0x1(%rax)
   8:	65 0f c1 05 dc 9c af 	xadd   %eax,%gs:0x7af9cdc(%rip)        # 0x7af9=
cec
   f:	07
  10:	83 f8 01             	cmp    $0x1,%eax
  13:	75 25                	jne    0x3a
  15:	9c                   	pushf
  16:	58                   	pop    %rax
  17:	a9 00 02 00 00       	test   $0x200,%eax
  1c:	75 39                	jne    0x57
  1e:	41 f7 c4 00 02 00 00 	test   $0x200,%r12d
  25:	74 01                	je     0x28
  27:	fb                   	sti
  28:	89 d8                	mov    %ebx,%eax
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5d                	pop    %r13
  2f:	41 5e                	pop    %r14
  31:	41 5f                	pop    %r15
  33:	5d                   	pop    %rbp
  34:	e9 5b 01 03 00       	jmp    0x30194
  39:	cc                   	int3
  3a:	90                   	nop
  3b:	0f 0b                	ud2
  3d:	90                   	nop
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
