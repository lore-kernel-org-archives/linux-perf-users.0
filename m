From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] Perf stat: Fix the ratio comments of miss-events
Date: Sat, 16 Nov 2019 06:45:19 -0800
Message-ID: <87pnhrg9s0.fsf@linux.intel.com>
References: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
        (lqqq's message of "Sat, 16 Nov 2019 15:48:41 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: lqqq341 <liuqi115@hisilicon.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, zhangshaokun@hisilicon.com, huangdaode@hisilicon.com, linyunsheng@huawei.com
List-Id: linux-perf-users.vger.kernel.org

lqqq341 <liuqi115@hisilicon.com> writes:

> From: Qi Liu <liuqi115@hisilicon.com>
>
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
> iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio
> is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
> L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
> accesses" seems better. The comments of L1-icache, dTLB cache, iTLB
> cache and LL-cache are fixed in the same way.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
