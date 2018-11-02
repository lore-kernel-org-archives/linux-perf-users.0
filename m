From: Xin Long <lucien.xin@gmail.com>
Subject: perf script doesn't dump a normal call trace
Date: Fri, 2 Nov 2018 15:36:13 +0900
Message-ID: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):

# perf record -e 'skb:consume_skb' -ag
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]

# perf script
swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
skbaddr=0xffff962c591d4900
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
        ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])


On RHEL-7 kernel(3.10.0):

# perf record -e 'skb:consume_skb' -ag
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.170 MB perf.data (214 samples) ]

# perf script
swapper     0 [001] 69006.726193: skb:consume_skb: skbaddr=0xffff917db9647900
            7fffb3425a00 consume_skb ([kernel.kallsyms])
            7fffb34ba3cb arp_process ([kernel.kallsyms])
            7fffb34bad65 arp_rcv ([kernel.kallsyms])
            7fffb343b6d9 __netif_receive_skb_core ([kernel.kallsyms])
            7fffb343b9d8 __netif_receive_skb ([kernel.kallsyms])
            7fffb343ba60 netif_receive_skb_internal ([kernel.kallsyms])
            7fffb343c6e8 napi_gro_receive ([kernel.kallsyms])
            7fffc007d1f5 virtnet_poll ([kernel.kallsyms])
            7fffb343c07f net_rx_action ([kernel.kallsyms])
            7fffb2ea2f05 __do_softirq ([kernel.kallsyms])
            7fffb357a32c call_softirq ([kernel.kallsyms])
            7fffb2e30675 do_softirq ([kernel.kallsyms])
            7fffb2ea3285 irq_exit ([kernel.kallsyms])
            7fffb357b5e6 __irqentry_text_start ([kernel.kallsyms])
            7fffb356d362 ret_from_intr ([kernel.kallsyms])
            7fffb356c12e default_idle ([kernel.kallsyms])
            7fffb2e386f0 arch_cpu_idle ([kernel.kallsyms])
            7fffb2efe3ba cpu_startup_entry ([kernel.kallsyms])
            7fffb2e59db7 start_secondary ([kernel.kallsyms])
            7fffb2e020d5 start_cpu ([kernel.kallsyms])

swapper     0 [001] 69006.754090: skb:consume_skb: skbaddr=0xffff917db9647100
            7fffb3425a00 consume_skb ([kernel.kallsyms])
            7fffb34ba3cb arp_process ([kernel.kallsyms])
            7fffb34bad65 arp_rcv ([kernel.kallsyms])
            7fffb343b6d9 __netif_receive_skb_core ([kernel.kallsyms])
            7fffb343b9d8 __netif_receive_skb ([kernel.kallsyms])
            7fffb343ba60 netif_receive_skb_internal ([kernel.kallsyms])
            7fffb343c6e8 napi_gro_receive ([kernel.kallsyms])
            7fffc007d1f5 virtnet_poll ([kernel.kallsyms])
            7fffb343c07f net_rx_action ([kernel.kallsyms])
            7fffb2ea2f05 __do_softirq ([kernel.kallsyms])
            7fffb357a32c call_softirq ([kernel.kallsyms])
            7fffb2e30675 do_softirq ([kernel.kallsyms])
            7fffb2ea3285 irq_exit ([kernel.kallsyms])
            7fffb357b5e6 __irqentry_text_start ([kernel.kallsyms])
            7fffb356d362 ret_from_intr ([kernel.kallsyms])
            7fffb356c12e default_idle ([kernel.kallsyms])
            7fffb2e386f0 arch_cpu_idle ([kernel.kallsyms])
            7fffb2efe3ba cpu_startup_entry ([kernel.kallsyms])


any idea why I could get a proper call trace on the new kernel?

Thanks.
