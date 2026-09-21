Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B637E5C8
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967310; cv=none; b=nP9GN/vjrHGsFZr8/r136/fsELpogU7GX1tGkRK0JYudTk5qJ9++/E/VEjCq0XG5vFnk8itBm2VFltHEM21zck+173IVbsK+9hq+KpWQLo8Q7vzzlQsg9AYPscU9P4SzwG9UC3YlMrEJDP35TltdUvhMW0F6hTxDP+PUS/DiWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967310; c=relaxed/simple;
	bh=dPc2rZ9IHOZBuIwQ7fIGzFigfiTTsSpE7vsITxL6iXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHxkrjoWohKrDhtIwtxnIe3IQEkYyhEThoktWdC7gq19FzbLDJ571nXAtjfu/jJlVwg/1sEJEofUQBmfkRJOxWNVIGQg59NQl0w2aCPKY7tHgkDrZaCTIJJ7H3y3S1pBCEeD8F1xZJbF2fR9jwjrbmPp5iJC1AU6hg3FhlDGPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmRIEkBe; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmRIEkBe"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so3719004a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967307; x=1790572107; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nfoNTd08RT8GD2giFHP65MfQZ3c7ugMPsVQvB8yXD8k=;
        b=HmRIEkBeVXYsLlq5rwN7QzWaHBcgyKXNB9M0Mua9ypqJB1cwmbJojSF4bHkKLa3tlE
         BeNv7nuINqGlNct8qpq+fcX2dEc5P/wUMwyQSNFst893maX8Cr+Yx/IBNWPkgbOsm4Bz
         KJaP/ax+k1kh17Y8OQwQMP/sGQ5kyImeL3Qf2RVz+3I4eMmhip+OBqDgu3b+7WkfMDfH
         d4tfYWKuCV71sKFFDPq0Q6Ef7ulFlz4lxX51JLs+VOXL+K3gDWEhL7svjZaVrYOlhRnQ
         DqXWcJznbdqZNBA4YtZz0f7MlshX9lLAYYjnuDS9mgD2tP82VczavZE8km7OuSvtBsu1
         khvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967307; x=1790572107;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfoNTd08RT8GD2giFHP65MfQZ3c7ugMPsVQvB8yXD8k=;
        b=H1sEVniknwOHZ3nMLspMnaGLYG7i3WnlQJFZmxmtXgm/6hxLYVsk2swqUwhKB+m+Vb
         a9NqDiKJKigtL2vDvsm0yxSeS6W4UevQcoZUG3sSnEBEy+OqhWn3/PzMn/V5NaCutmZv
         VZd9F9mH1Wph+41M1Q/cDeN2vIdShq6gPzuYxcZUO7xPQlNzQ7q+qmTC/4pDaRyUysxh
         2U1vSMB+qi3GR2hRuOwHrjFRy0fRVnMeeTOjCV7iN3aoG30pvJTjIjd8YTn/UYtQAPoQ
         X+L4ZK8McB585mdmA7ZIkNI0G+MS4dIzEuym18cO24UtP20wiKQjc9p6R5nINA2tJsEI
         PmZw==
X-Forwarded-Encrypted: i=1; AKwUvBxbZlCskpWa+p5WK3GH4UUHiTanHA3IL/5LZlcoD5jpT92sCaHK9fE4TAArPRZchLTphy+QGgN3cIOjDeQ9SHU3@vger.kernel.org
X-Gm-Message-State: AFuF++kS2EvA6ALf9pXC9NBjJGVUspVLL06gYIaEe16GQwaXooyRjxUW
	DjlJyzzJhdxDe+3cqduZRLCwTks1uferEFSJG+16RgRM+F7IS2eB6nXVAa5/PUfGZVDB9oH5n0D
	w50pkn7RMWQ==
X-Received: from dly18-n2.prod.google.com ([2002:a05:701b:2052:20b0:144:c5ae:2157])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c89:b0:39d:f253:ed66
 with SMTP id 98e67ed59e1d1-39e54e3dad7mr13866134a91.22.1789967306892; Sun, 20
 Sep 2026 22:08:26 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:54 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <c794dcf503b03d95428b8a2d434e2ddfe5a3f7ad.1789966896.git.irogers@google.com>
Subject: [PATCH v2 36/49] perf python: Port netdev-times to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port netdev-times.py from tools/perf/scripts/python/ to a standalone
script in tools/perf/python/:
- Refactor the script into a NetDevTimesAnalyzer class with full type
  annotations to encapsulate state.
- Collect events via perf.session and sort them in timestamp order
  before analysis so multi-CPU TX and RX packet timelines are
  reconstructed deterministically.
- Replace custom argument parsing with argparse (-i/--input, --tx,
  --rx, --dev, --debug), extract tracepoint fields directly from sample
  attributes, and remove Python 2 compatibility artifacts.

Add a shell test (test_netdev_times_python.sh) to verify the standalone
script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/netdev-times.py             | 486 ++++++++++++++++++
 .../tests/shell/test_netdev_times_python.sh   |  61 +++
 2 files changed, 547 insertions(+)
 create mode 100755 tools/perf/python/netdev-times.py
 create mode 100755 tools/perf/tests/shell/test_netdev_times_python.sh

diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev-times.py
new file mode 100755
index 000000000000..85f6d41e1179
--- /dev/null
+++ b/tools/perf/python/netdev-times.py
@@ -0,0 +1,486 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Display a process of packets and processed time.
+It helps us to investigate networking or network device.
+
+Ported from tools/perf/scripts/python/netdev-times.py
+"""
+
+from __future__ import annotations
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
+                if 'handle' in event:
+                    print(PF_WJOINT)
+                    if event['handle'] == "kfree_skb":
+                        print(PF_KFREE_SKB %
+                              (self.diff_msec(base_t, event['comm_t']),
+                               event['location']))
+                    elif event['handle'] == "consume_skb":
+                        print(PF_CONS_SKB %
+                              self.diff_msec(base_t, event['comm_t']))
+                    elif event['handle'] == "skb_copy_datagram_iovec":
+                        print(PF_CPY_DGRAM %
+                              (self.diff_msec(base_t, event['comm_t']),
+                               event['pid'], event['comm']))
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
+        if irq != self.irq_dic[cpu][-1]['irq']:
+            return
+        irq_record = self.irq_dic[cpu].pop()
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
+        irq_list = None
+        event_list = None
+        sirq_ent_t = None
+
+        if cpu in self.irq_dic:
+            irq_list = self.irq_dic[cpu]
+            del self.irq_dic[cpu]
+        if cpu in self.net_rx_dic:
+            sirq_ent_t = self.net_rx_dic[cpu]['sirq_ent_t']
+            event_list = self.net_rx_dic[cpu]['event_list']
+            del self.net_rx_dic[cpu]
+        if irq_list is None or event_list is None or sirq_ent_t is None:
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
+        for i, rec_data in enumerate(self.rx_skb_list):
+            if rec_data['skbaddr'] == skbaddr:
+                rec_data.update({'handle': "consume_skb", 'comm_t': time})
+                del self.rx_skb_list[i]
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
+        ev_name = name[6:-1] if name.startswith("evsel(") else name
+        pid = sample.sample_pid
+        if hasattr(self, 'session') and self.session:
+            try:
+                thread = self.session.find_thread(pid)
+                comm = (thread.comm() if thread else None) or "[unknown]"
+            except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
+                comm = "[unknown]"
+        else:
+            comm = "Unknown"
+        event_data = {
+            'name': ev_name,
+            'time': sample.sample_time,
+            'cpu': sample.sample_cpu,
+            'pid': pid,
+            'comm': comm,
+        }
+
+        # Extract specific fields based on event type
+        if ev_name.startswith("irq:softirq_"):
+            event_data['vec'] = getattr(sample, "vec", 0)
+            # Filter for NET_RX
+            if event_data['vec'] != 3:  # NET_RX_SOFTIRQ is usually 3
+                return
+        elif ev_name == "irq:irq_handler_entry":
+            event_data['irq'] = getattr(sample, "irq", -1)
+            event_data['irq_name'] = getattr(sample, "name", "[unknown]")
+        elif ev_name == "irq:irq_handler_exit":
+            event_data['irq'] = getattr(sample, "irq", -1)
+            event_data['ret'] = getattr(sample, "ret", 0)
+        elif ev_name == "napi:napi_poll":
+            event_data['napi'] = getattr(sample, "napi", 0)
+            event_data['dev_name'] = getattr(sample, "dev_name", "[unknown]")
+            event_data['work'] = getattr(sample, "work", 0)
+            event_data['budget'] = getattr(sample, "budget", 0)
+        elif ev_name in ("net:netif_receive_skb", "net:netif_rx",
+                         "net:net_dev_queue"):
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "len", 0)
+            event_data['dev_name'] = getattr(sample, "name", "[unknown]")
+        elif ev_name == "net:net_dev_xmit":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "len", 0)
+            event_data['rc'] = getattr(sample, "rc", 0)
+            event_data['dev_name'] = getattr(sample, "name", "[unknown]")
+        elif ev_name == "skb:kfree_skb":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['location'] = getattr(sample, "location", 0)
+            event_data['protocol'] = getattr(sample, "protocol", 0)
+            event_data['reason'] = getattr(sample, "reason", 0)
+        elif ev_name == "skb:consume_skb":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['location'] = getattr(sample, "location", 0)
+        elif ev_name == "skb:skb_copy_datagram_iovec":
+            event_data['skbaddr'] = getattr(sample, "skbaddr", 0)
+            event_data['skblen'] = getattr(sample, "len", 0)
+
+        self.handle_single_event(event_data)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser(description="Display a process of packets and processed time.")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("--tx", action="store_true", help="show only tx chart")
+    ap.add_argument("--rx", action="store_true", help="show only rx chart")
+    ap.add_argument("--dev", default=None, help="show only specified device")
+    ap.add_argument("--debug", action="store_true",
+                    help="work with debug mode. It shows buffer status.")
+    ap.add_argument("positionals", nargs="*",
+                    help="optional positional arguments (tx, rx, dev=<name>, debug)")
+    args, unknown_args = ap.parse_known_args()
+
+    parsed_args = argparse.Namespace(
+        tx=args.tx, rx=args.rx, dev=args.dev, debug=args.debug, input=args.input
+    )
+
+    for arg in list(args.positionals) + unknown_args:
+        if not arg or not isinstance(arg, str):
+            continue
+        if arg in ('tx', '--tx'):
+            parsed_args.tx = True
+        elif arg in ('rx', '--rx'):
+            parsed_args.rx = True
+        elif arg.startswith('dev='):
+            parsed_args.dev = arg[4:]
+        elif arg.startswith('--dev='):
+            parsed_args.dev = arg[6:]
+        elif arg in ('debug', '--debug'):
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
+    except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+        print(f"Error processing events: {e}")
+        sys.exit(1)
diff --git a/tools/perf/tests/shell/test_netdev_times_python.sh b/tools/perf/tests/shell/test_netdev_times_python.sh
new file mode 100755
index 000000000000..b512d1946ff0
--- /dev/null
+++ b/tools/perf/tests/shell/test_netdev_times_python.sh
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# netdev_times python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/netdev-times.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, netdev-times.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
+
+echo "Testing netdev-times.py..."
+
+# Create a perf.data file. Force dropping a packet if tracepoint is available!
+if ! perf record -e skb:kfree_skb -a -o "${temp_data}" \
+	-- ping -c 1 127.0.0.1 >/dev/null 2>&1; then
+	perf record -e cycles -o "${temp_data}" \
+		-- perf test -w noploop >/dev/null 2>&1 || \
+		{ echo "Skipping test, perf record failed"; exit 2; }
+fi
+
+# Check that the script executes
+if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	echo "netdev-times.py test failed"
+	err=1
+else
+	echo "netdev-times test passed."
+fi
+rm -f "${temp_out}"
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

