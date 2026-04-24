Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E33ED12B
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049354; cv=none; b=EMtAzzX8uE4av8hPqCGUA2VUMaR2hpnscBVOWD/xXnYMFQrF7DZ2KnXJAZ5gAxjKvyK2opRtpwqB5X+0xImw3WKWy2Z6v5FewY9ZQml+63EBUYoIye5DqTJtPoqjMPVtj2w35BsbEpkRjmX1dyQQT60J33kvihb/HVPFc9YYMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049354; c=relaxed/simple;
	bh=KB/00P3nD6nNe5SsuupWVClHJLt8UwKWs0nb9SK8Ljs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLp36BFiRqbWmzBNwdYmzZYD84wc4BFQ//9AWZqGJ5mwqjPp7F/xYmywYtxv02MLfGnXD86AM4GCnelywxZeB5Bi9JAf9DErltDwwxtaCYQBO+bTGlEmLyWyGa86SPJI5v8a8mC2HAkkJuJ3l0mse5DKeq2pVW/UFanU/uPGFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/1DpGvn; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/1DpGvn"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso10403599eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049352; x=1777654152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0M3CzhpFg+IY8zfWINLxr1/jybMU+pqGQaNw9IsEXU=;
        b=L/1DpGvn/vfAqQwUtWvqf0RAfCkHfws52rvfmKRMxNO9qSoZO3vj1/+UqyyH7Ub+Vz
         gcS6hImg1cJeRE94pUrRB3KS2watXhIdorWSjcrUblC10a2UZ3g08UU3IjObWI/YeqrR
         0SVAerxuSE3WSYHmhRCAvqI+aFp49pg3ZlPqUrIbKaTuE8hCt4O0oUAuT0I7py/+S0jW
         K7Ie0MZ1B0H6uSDyQ1z0ogygSMZjykFnrbg5mkzMLczGNTt4pajpT3TfxYSC5BWGM39E
         /m9OIXZGfVRpYhYNJGCL2QyoNFoLBMpaFvg9p3Jk3lV04HuCip2uca97xCBpden3/SrL
         JWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049352; x=1777654152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0M3CzhpFg+IY8zfWINLxr1/jybMU+pqGQaNw9IsEXU=;
        b=E2go2RCleN3/zClDGnIcNW96M9k15FyISp2SS0xLtp6FJDOOdspbn5ZDxjosD2P0W1
         VXhoywwTF1jXBFX0Dh2bWqKh1B7WiIXBAYEY8ddRCJn8cWVzOf6cyKT7WZZasrvUpHz0
         VDK4sQU7E3YNh9snGRaWQS3b+gU/e5+9z4KNUaeZnGYAJWx2+JFLupMTGGgoaQSggVFW
         mDlyrQk2R2l+9Rv7ntXopzzTGT7sei8fsGTvf6TvA5W7iAdXD2egI78ms4tD1iWUqjmC
         vye22gz4nYfnhnSnBqVMG3Thp3J3WQU+hizzUORqWDfBj6eMxqjUiLy5r791S9Z1OOop
         qAtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0doVB6WXoLqSa0hBufNVo90Ldto5gWm0nLVwPisaFvPl6JQklEg8Es6kjYs48eX6/TlNbi0aRb9SrAkHZwkRd@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5sMEjd5wtnlsarIAd1czJbkNbjTnBz2BKJ6pIGggWvwfPpKB
	HB5/+rCkDJtfxQT0hEemzuwGaeZCg5n98N8Rgw4P1b5DS+Ii47u1wFjgFQNcdNqt8o8Zvdw1cIJ
	oaJ/V85N5Gg==
X-Received: from dldz5-n2.prod.google.com ([2002:a05:701b:4185:20b0:12c:20df:7530])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d87:b0:12a:85ef:1e50
 with SMTP id a92af1059eb24-12c73f6c614mr18184021c88.12.1777049351566; Fri, 24
 Apr 2026 09:49:11 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:03 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-42-irogers@google.com>
Subject: [PATCH v5 41/58] perf netdev-times: Port netdev-times to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/.
- Refactored the script to use a class structure (NetDevTimesAnalyzer)
  to encapsulate state.
- Used perf.session for event collection and processed them in time
  order at the end to match legacy behavior.
- Extracted tracepoint fields directly from sample attributes.
- Moved format string constants to module level.
- Cleaned up Python 2 compatibility artifacts (like cmp_to_key).

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Corrected Field Names: Fixed getattr calls for skblen and dev_name
    to use "len" and "name" respectively, as exposed by the actual
    tracepoints.
---
 tools/perf/python/netdev-times.py | 472 ++++++++++++++++++++++++++++++
 1 file changed, 472 insertions(+)
 create mode 100755 tools/perf/python/netdev-times.py

diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev-times.py
new file mode 100755
index 000000000000..568986e2d492
--- /dev/null
+++ b/tools/perf/python/netdev-times.py
@@ -0,0 +1,472 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Display a process of packets and processed time.
+It helps us to investigate networking or network device.
+
+Ported from tools/perf/scripts/python/netdev-times.py
+"""
+
+import argparse
+from collections import defaultdict
+import sys
+from typing import Optional
+import perf
+
+# Format for displaying rx packet processing
+PF_IRQ_ENTRY = "  irq_entry(+%.3fmsec irq=%d:%s)"
+PF_SOFT_ENTRY = "  softirq_entry(+%.3fmsec)"
+PF_NAPI_POLL = "  napi_poll_exit(+%.3fmsec %s)"
+PF_JOINT = "         |"
+PF_WJOINT = "         |            |"
+PF_NET_RECV = "         |---netif_receive_skb(+%.3fmsec skb=%x len=%d)"
+PF_NET_RX = "         |---netif_rx(+%.3fmsec skb=%x)"
+PF_CPY_DGRAM = "         |      skb_copy_datagram_iovec(+%.3fmsec %d:%s)"
+PF_KFREE_SKB = "         |      kfree_skb(+%.3fmsec location=%x)"
+PF_CONS_SKB = "         |      consume_skb(+%.3fmsec)"
+
+
+class NetDevTimesAnalyzer:
+    """Analyzes network device events and prints charts."""
+
+    def __init__(self, cfg: argparse.Namespace):
+        self.args = cfg
+        self.session: Optional[perf.session] = None
+        self.show_tx = cfg.tx or (not cfg.tx and not cfg.rx)
+        self.show_rx = cfg.rx or (not cfg.tx and not cfg.rx)
+        self.dev = cfg.dev
+        self.debug = cfg.debug
+        self.buffer_budget = 65536
+        self.irq_dic: dict[int, list[dict]] = defaultdict(list)
+        self.net_rx_dic: dict[int, dict] = {}
+        self.receive_hunk_list: list[dict] = []
+        self.rx_skb_list: list[dict] = []
+        self.tx_queue_list: list[dict] = []
+        self.tx_xmit_list: list[dict] = []
+        self.tx_free_list: list[dict] = []
+
+        self.buffer_budget = 65536
+        self.of_count_rx_skb_list = 0
+        self.of_count_tx_queue_list = 0
+        self.of_count_tx_xmit_list = 0
+
+    def diff_msec(self, src: int, dst: int) -> float:
+        """Calculate a time interval(msec) from src(nsec) to dst(nsec)."""
+        return (dst - src) / 1000000.0
+
+    def print_transmit(self, hunk: dict) -> None:
+        """Display a process of transmitting a packet."""
+        if self.dev and hunk['dev'].find(self.dev) < 0:
+            return
+        queue_t_sec = hunk['queue_t'] // 1000000000
+        queue_t_usec = hunk['queue_t'] % 1000000000 // 1000
+        print(f"{hunk['dev']:7s} {hunk['len']:5d} "
+              f"{queue_t_sec:6d}.{queue_t_usec:06d}sec "
+              f"{self.diff_msec(hunk['queue_t'], hunk['xmit_t']):12.3f}msec      "
+              f"{self.diff_msec(hunk['xmit_t'], hunk['free_t']):12.3f}msec")
+
+    def print_receive(self, hunk: dict) -> None:
+        """Display a process of received packets and interrupts."""
+        show_hunk = False
+        irq_list = hunk['irq_list']
+        if not irq_list:
+            return
+        cpu = irq_list[0]['cpu']
+        base_t = irq_list[0]['irq_ent_t']
+
+        if self.dev:
+            for irq in irq_list:
+                if irq['name'].find(self.dev) >= 0:
+                    show_hunk = True
+                    break
+        else:
+            show_hunk = True
+
+        if not show_hunk:
+            return
+
+        base_t_sec = base_t // 1000000000
+        base_t_usec = base_t % 1000000000 // 1000
+        print(f"{base_t_sec}.{base_t_usec:06d}sec cpu={cpu}")
+        for irq in irq_list:
+            print(PF_IRQ_ENTRY %
+                  (self.diff_msec(base_t, irq['irq_ent_t']),
+                   irq['irq'], irq['name']))
+            print(PF_JOINT)
+            irq_event_list = irq['event_list']
+            for irq_event in irq_event_list:
+                if irq_event['event'] == 'netif_rx':
+                    print(PF_NET_RX %
+                          (self.diff_msec(base_t, irq_event['time']),
+                           irq_event['skbaddr']))
+                    print(PF_JOINT)
+
+        print(PF_SOFT_ENTRY % self.diff_msec(base_t, hunk['sirq_ent_t']))
+        print(PF_JOINT)
+        event_list = hunk['event_list']
+        for i, event in enumerate(event_list):
+            if event['event_name'] == 'napi_poll':
+                print(PF_NAPI_POLL %
+                      (self.diff_msec(base_t, event['event_t']),
+                       event['dev']))
+                if i == len(event_list) - 1:
+                    print("")
+                else:
+                    print(PF_JOINT)
+            else:
+                print(PF_NET_RECV %
+                      (self.diff_msec(base_t, event['event_t']),
+                       event['skbaddr'],
+                       event['len']))
+                if 'comm' in event:
+                    print(PF_WJOINT)
+                    print(PF_CPY_DGRAM %
+                          (self.diff_msec(base_t, event['comm_t']),
+                           event['pid'], event['comm']))
+                elif 'handle' in event:
+                    print(PF_WJOINT)
+                    if event['handle'] == "kfree_skb":
+                        print(PF_KFREE_SKB %
+                              (self.diff_msec(base_t, event['comm_t']),
+                               event['location']))
+                    elif event['handle'] == "consume_skb":
+                        print(PF_CONS_SKB %
+                              self.diff_msec(base_t, event['comm_t']))
+                print(PF_JOINT)
+
+    def handle_irq_handler_entry(self, event: dict) -> None:
+        """Handle irq:irq_handler_entry event."""
+        time = event['time']
+        cpu = event['cpu']
+        irq = event['irq']
+        irq_name = event['irq_name']
+        irq_record = {'irq': irq, 'name': irq_name, 'cpu': cpu,
+                      'irq_ent_t': time, 'event_list': []}
+        self.irq_dic[cpu].append(irq_record)
+
+    def handle_irq_handler_exit(self, event: dict) -> None:
+        """Handle irq:irq_handler_exit event."""
+        time = event['time']
+        cpu = event['cpu']
+        irq = event['irq']
+        if cpu not in self.irq_dic or not self.irq_dic[cpu]:
+            return
+        irq_record = self.irq_dic[cpu].pop()
+        if irq != irq_record['irq']:
+            return
+        irq_record['irq_ext_t'] = time
+        # if an irq doesn't include NET_RX softirq, drop.
+        if irq_record['event_list']:
+            self.irq_dic[cpu].append(irq_record)
+
+    def handle_irq_softirq_raise(self, event: dict) -> None:
+        """Handle irq:softirq_raise event."""
+        time = event['time']
+        cpu = event['cpu']
+        if cpu not in self.irq_dic or not self.irq_dic[cpu]:
+            return
+        irq_record = self.irq_dic[cpu].pop()
+        irq_record['event_list'].append({'time': time, 'event': 'sirq_raise'})
+        self.irq_dic[cpu].append(irq_record)
+
+    def handle_irq_softirq_entry(self, event: dict) -> None:
+        """Handle irq:softirq_entry event."""
+        time = event['time']
+        cpu = event['cpu']
+        self.net_rx_dic[cpu] = {'sirq_ent_t': time, 'event_list': []}
+
+    def handle_irq_softirq_exit(self, event: dict) -> None:
+        """Handle irq:softirq_exit event."""
+        time = event['time']
+        cpu = event['cpu']
+        irq_list = []
+        event_list = []
+        sirq_ent_t = None
+
+        if cpu in self.irq_dic:
+            irq_list = self.irq_dic[cpu]
+            del self.irq_dic[cpu]
+        if cpu in self.net_rx_dic:
+            sirq_ent_t = self.net_rx_dic[cpu]['sirq_ent_t']
+            event_list = self.net_rx_dic[cpu]['event_list']
+            del self.net_rx_dic[cpu]
+        if not irq_list or not event_list or sirq_ent_t is None:
+            return
+        rec_data = {'sirq_ent_t': sirq_ent_t, 'sirq_ext_t': time,
+                    'irq_list': irq_list, 'event_list': event_list}
+        self.receive_hunk_list.append(rec_data)
+
+    def handle_napi_poll(self, event: dict) -> None:
+        """Handle napi:napi_poll event."""
+        time = event['time']
+        cpu = event['cpu']
+        dev_name = event['dev_name']
+        work = event['work']
+        budget = event['budget']
+        if cpu in self.net_rx_dic:
+            event_list = self.net_rx_dic[cpu]['event_list']
+            rec_data = {'event_name': 'napi_poll',
+                        'dev': dev_name, 'event_t': time,
+                        'work': work, 'budget': budget}
+            event_list.append(rec_data)
+
+    def handle_netif_rx(self, event: dict) -> None:
+        """Handle net:netif_rx event."""
+        time = event['time']
+        cpu = event['cpu']
+        skbaddr = event['skbaddr']
+        skblen = event['skblen']
+        dev_name = event['dev_name']
+        if cpu not in self.irq_dic or not self.irq_dic[cpu]:
+            return
+        irq_record = self.irq_dic[cpu].pop()
+        irq_record['event_list'].append({'time': time, 'event': 'netif_rx',
+                                         'skbaddr': skbaddr, 'skblen': skblen,
+                                         'dev_name': dev_name})
+        self.irq_dic[cpu].append(irq_record)
+
+    def handle_netif_receive_skb(self, event: dict) -> None:
+        """Handle net:netif_receive_skb event."""
+        time = event['time']
+        cpu = event['cpu']
+        skbaddr = event['skbaddr']
+        skblen = event['skblen']
+        if cpu in self.net_rx_dic:
+            rec_data = {'event_name': 'netif_receive_skb',
+                        'event_t': time, 'skbaddr': skbaddr, 'len': skblen}
+            event_list = self.net_rx_dic[cpu]['event_list']
+            event_list.append(rec_data)
+            self.rx_skb_list.insert(0, rec_data)
+            if len(self.rx_skb_list) > self.buffer_budget:
+                self.rx_skb_list.pop()
+                self.of_count_rx_skb_list += 1
+
+    def handle_net_dev_queue(self, event: dict) -> None:
+        """Handle net:net_dev_queue event."""
+        time = event['time']
+        skbaddr = event['skbaddr']
+        skblen = event['skblen']
+        dev_name = event['dev_name']
+        skb = {'dev': dev_name, 'skbaddr': skbaddr, 'len': skblen, 'queue_t': time}
+        self.tx_queue_list.insert(0, skb)
+        if len(self.tx_queue_list) > self.buffer_budget:
+            self.tx_queue_list.pop()
+            self.of_count_tx_queue_list += 1
+
+    def handle_net_dev_xmit(self, event: dict) -> None:
+        """Handle net:net_dev_xmit event."""
+        time = event['time']
+        skbaddr = event['skbaddr']
+        rc = event['rc']
+        if rc == 0:  # NETDEV_TX_OK
+            for i, skb in enumerate(self.tx_queue_list):
+                if skb['skbaddr'] == skbaddr:
+                    skb['xmit_t'] = time
+                    self.tx_xmit_list.insert(0, skb)
+                    del self.tx_queue_list[i]
+                    if len(self.tx_xmit_list) > self.buffer_budget:
+                        self.tx_xmit_list.pop()
+                        self.of_count_tx_xmit_list += 1
+                    return
+
+    def handle_kfree_skb(self, event: dict) -> None:
+        """Handle skb:kfree_skb event."""
+        time = event['time']
+        skbaddr = event['skbaddr']
+        comm = event['comm']
+        pid = event['pid']
+        location = event['location']
+        for i, skb in enumerate(self.tx_queue_list):
+            if skb['skbaddr'] == skbaddr:
+                del self.tx_queue_list[i]
+                return
+        for i, skb in enumerate(self.tx_xmit_list):
+            if skb['skbaddr'] == skbaddr:
+                skb['free_t'] = time
+                self.tx_free_list.append(skb)
+                del self.tx_xmit_list[i]
+                return
+        for i, rec_data in enumerate(self.rx_skb_list):
+            if rec_data['skbaddr'] == skbaddr:
+                rec_data.update({'handle': "kfree_skb",
+                                 'comm': comm, 'pid': pid, 'comm_t': time, 'location': location})
+                del self.rx_skb_list[i]
+                return
+
+    def handle_consume_skb(self, event: dict) -> None:
+        """Handle skb:consume_skb event."""
+        time = event['time']
+        skbaddr = event['skbaddr']
+        for i, skb in enumerate(self.tx_xmit_list):
+            if skb['skbaddr'] == skbaddr:
+                skb['free_t'] = time
+                self.tx_free_list.append(skb)
+                del self.tx_xmit_list[i]
+                return
+
+    def handle_skb_copy_datagram_iovec(self, event: dict) -> None:
+        """Handle skb:skb_copy_datagram_iovec event."""
+        time = event['time']
+        skbaddr = event['skbaddr']
+        comm = event['comm']
+        pid = event['pid']
+        for i, rec_data in enumerate(self.rx_skb_list):
+            if skbaddr == rec_data['skbaddr']:
+                rec_data.update({'handle': "skb_copy_datagram_iovec",
+                                 'comm': comm, 'pid': pid, 'comm_t': time})
+                del self.rx_skb_list[i]
+                return
+
+
+
+    def print_summary(self) -> None:
+        """Print charts."""
+
+        # display receive hunks
+        if self.show_rx:
+            for hunk in self.receive_hunk_list:
+                self.print_receive(hunk)
+
+        # display transmit hunks
+        if self.show_tx:
+            print("   dev    len      Qdisc        "
+                  "       netdevice             free")
+            for hunk in self.tx_free_list:
+                self.print_transmit(hunk)
+
+        if self.debug:
+            print("debug buffer status")
+            print("----------------------------")
+            print(f"xmit Qdisc:remain:{len(self.tx_queue_list)} "
+                  f"overflow:{self.of_count_tx_queue_list}")
+            print(f"xmit netdevice:remain:{len(self.tx_xmit_list)} "
+                  f"overflow:{self.of_count_tx_xmit_list}")
+            print(f"receive:remain:{len(self.rx_skb_list)} "
+                  f"overflow:{self.of_count_rx_skb_list}")
+
+    def handle_single_event(self, event: dict) -> None:
+        """Handle a single processed event."""
+        name = event['name']
+        if name == 'irq:softirq_exit':
+            self.handle_irq_softirq_exit(event)
+        elif name == 'irq:softirq_entry':
+            self.handle_irq_softirq_entry(event)
+        elif name == 'irq:softirq_raise':
+            self.handle_irq_softirq_raise(event)
+        elif name == 'irq:irq_handler_entry':
+            self.handle_irq_handler_entry(event)
+        elif name == 'irq:irq_handler_exit':
+            self.handle_irq_handler_exit(event)
+        elif name == 'napi:napi_poll':
+            self.handle_napi_poll(event)
+        elif name == 'net:netif_receive_skb':
+            self.handle_netif_receive_skb(event)
+        elif name == 'net:netif_rx':
+            self.handle_netif_rx(event)
+        elif name == 'skb:skb_copy_datagram_iovec':
+            self.handle_skb_copy_datagram_iovec(event)
+        elif name == 'net:net_dev_queue':
+            self.handle_net_dev_queue(event)
+        elif name == 'net:net_dev_xmit':
+            self.handle_net_dev_xmit(event)
+        elif name == 'skb:kfree_skb':
+            self.handle_kfree_skb(event)
+        elif name == 'skb:consume_skb':
+            self.handle_consume_skb(event)
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process events directly on-the-fly."""
+        name = str(sample.evsel)
+        pid = sample.sample_pid
+        if hasattr(self, 'session') and self.session:
+            comm = self.session.process(pid).comm()
+        else:
+            comm = "Unknown"
+        event_data = {
+            'name': name[6:-1] if name.startswith("evsel(") else name,
+            'time': sample.sample_time,
+            'cpu': sample.sample_cpu,
+            'pid': pid,
+            'comm': comm,
+        }
+
+        # Extract specific fields based on event type
+        if name.startswith("evsel(irq:softirq_"):
+            event_data['vec'] = getattr(sample, "vec", 0)
+            # Filter for NET_RX
+            try:
+                if perf.symbol_str("irq:softirq_entry", "vec",  # type: ignore
+                                   event_data['vec']) != "NET_RX":
+                    return
+            except AttributeError:
+                # Fallback if symbol_str not available or fails
+                if event_data['vec'] != 3:  # NET_RX_SOFTIRQ is usually 3
+                    return
+        elif name == "evsel(irq:irq_handler_entry)":
+            event_data['irq'] = getattr(sample, "irq", -1)
+            event_data['irq_name'] = getattr(sample, "name", "[unknown]")
+        elif name == "evsel(irq:irq_handler_exit)":
+            event_data['irq'] = getattr(sample, "irq", -1)
+            event_data['ret'] = getattr(sample, "ret", 0)
+        elif name == "evsel(napi:napi_poll)":
+            event_data['napi'] = getattr(sample, "napi", 0)
+            event_data['dev_name'] = getattr(sample, "dev_name", "[unknown]")
+            event_data['work'] = getattr(sample, "work", 0)
+            event_data['budget'] = getattr(sample, "budget", 0)
+        elif name in ("evsel(net:netif_receive_skb)", "evsel(net:netif_rx)",
+                      "evsel(net:net_dev_queue)"):
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "len", 0)
+            event_data['dev_name'] = getattr(sample, "name", "[unknown]")
+        elif name == "evsel(net:net_dev_xmit)":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "len", 0)
+            event_data['rc'] = getattr(sample, "rc", 0)
+            event_data['dev_name'] = getattr(sample, "name", "[unknown]")
+        elif name == "evsel(skb:kfree_skb)":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['location'] = getattr(sample, "location", 0)
+            event_data['protocol'] = getattr(sample, "protocol", 0)
+            event_data['reason'] = getattr(sample, "reason", 0)
+        elif name == "evsel(skb:consume_skb)":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['location'] = getattr(sample, "location", 0)
+        elif name == "evsel(skb:skb_copy_datagram_iovec)":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "skblen", 0)
+
+        self.handle_single_event(event_data)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Display a process of packets and processed time.")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("tx", nargs="?", help="show only tx chart")
+    ap.add_argument("rx", nargs="?", help="show only rx chart")
+    ap.add_argument("dev", nargs="?", help="show only specified device")
+    ap.add_argument("debug", nargs="?", help="work with debug mode. It shows buffer status.")
+    args = ap.parse_args()
+
+    parsed_args = argparse.Namespace(tx=False, rx=False, dev=None, debug=False, input=args.input)
+
+    for arg in sys.argv[1:]:
+        if arg == 'tx':
+            parsed_args.tx = True
+        elif arg == 'rx':
+            parsed_args.rx = True
+        elif arg.startswith('dev='):
+            parsed_args.dev = arg[4:]
+        elif arg == 'debug':
+            parsed_args.debug = True
+
+    analyzer = NetDevTimesAnalyzer(parsed_args)
+
+    try:
+        session = perf.session(perf.data(parsed_args.input), sample=analyzer.process_event)
+        analyzer.session = session
+        session.process_events()
+        analyzer.print_summary()
+    except KeyboardInterrupt:
+        analyzer.print_summary()
+    except Exception as e:
+        print(f"Error processing events: {e}")
-- 
2.54.0.545.g6539524ca2-goog

