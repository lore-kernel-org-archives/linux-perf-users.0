From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/6] perf/imx_ddr: Add namespace for i.MX8 DDR Perf
Date: Thu, 16 Apr 2020 17:10:20 +0100
Message-ID: <8341b035-2fac-52dd-45d1-2bf6f5ea4ba4@huawei.com>
References: <20200222104621.2258-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB4618D2E1892120EB659B8695E6EC0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <2f81eb7a-a6e4-1cc6-cd0a-ca3d749bd552@huawei.com>
 <DB7PR04MB4618C0A8DD9BAB2A529CDCECE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a2cc0772-4f5d-aba3-1f5c-7d4eef7a3f72@huawei.com>
 <DB7PR04MB461803AD15E47AA880F0915DE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <55836919-41b5-0834-f7a7-1a2a34535677@huawei.com>
 <bd67910e-1522-39cd-5527-b9b18f3da96d@huawei.com>
 <DB8PR04MB6795996085AD2167E2358907E6C30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <ccab39b0-c84f-e529-4067-07466b5433a1@huawei.com>
 <VI1PR04MB68000808CEE4BC23403C35A0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
 <ca2db002-975a-ffe0-2dfc-c85f4e6205bb@huawei.com>
 <VI1PR04MB6800F2A5949F0AFAF2E82CE0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
 <0b3999b8-c307-6b4a-1a1b-e90b45f50b61@huawei.com>
 <DB8PR04MB67957F63165ACC0483F6AE39E6D80@DB8PR04MB6795.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <DB8PR04MB67957F63165ACC0483F6AE39E6D80@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, irogers@google.com
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Zhangshaokun <zhangshaokun@hisilicon.com>, "will@kernel.org" <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, "acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Jiri Olsa <jolsa@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

+ Ian (please check the patch at the bottom, thanks)

On 16/04/2020 08:15, Joakim Zhang wrote:
>> ?
>>
>> If that doesn't work, then I'll try this myself.
> Hi John,
> 
> It still cannot work with this code change.
> 

So I got a SMMUv3 PMCG test metric working here:

https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.7-sys-pmu-events-v1-debug

as follows:

john@ubuntu:~/perf list metric

List of pre-defined events (to be used in -e):

Metrics:

   smmuv3_pmcg.fake
        [SMMUv3 PMCG fake metric]

john@ubuntu:~/sudo ./perf stat -a -M smmuv3_pmcg.fake sleep 1

  Performance counter stats for 'system wide':

    531510      smmuv3_pmcg.transaction  (49.90%)
124914193      smmuv3_pmcg.cycles       (49.90%)
    531331      smmuv3_pmcg.transaction  (50.29%)
124879887      smmuv3_pmcg.cycles       (50.29%)
    531269      smmuv3_pmcg.transaction  (50.45%)
124867388      smmuv3_pmcg.cycles       (50.45%)
    531372      smmuv3_pmcg.transaction  (50.45%)
124896723      smmuv3_pmcg.cycles       (50.45%)
    531431      smmuv3_pmcg.transaction  (50.12%)
124901700      smmuv3_pmcg.cycles       (50.12%)
    531574      smmuv3_pmcg.transaction  (49.72%)
124924231      smmuv3_pmcg.cycles       (49.72%)
    531598      smmuv3_pmcg.transaction  (49.56%)
124916914      smmuv3_pmcg.cycles       (49.56%)
    531440      smmuv3_pmcg.transaction  (49.56%)
124902473      smmuv3_pmcg.cycles       (49.56%)

        1.001167246 seconds time elapsed

So you can compare this to yours.

I did have to fix what looks like a bug in mainline on that branch:

--->8-----

perf parse-events: Fix comparison of evsel and leader pmu name

Since we now strdup() the pmu name for the event selector, use strcmp()
instead of pointer equality for comparison.

Fixes: d4953f7 ("perf parse-events: Fix 3 use after frees found with 
clang ASANutil/parse-events.c")
Signed-off-by: John Garry <john.garry@huawei.com>
---
tools/perf/util/parse-events.c
@@ -1629,7 +1629,7 @@ parse_events__set_leader_for_uncore_aliase(char 
*name, struct list_head *list,
		 * event. That can be used to distinguish the leader from
		 * other members, even they have the same event name.
		 */
		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
		if ((leader != evsel) && !strcmp(leader->pmu_name, evsel->pmu_name)) {
			is_leader = false;
			continue;
		}


---8<

Without it, I would get a spew of these:

assertion failed at util/parse-events.c:1637

@Ian, does this change look right? I am not intimately familiar with 
that code.

Thanks,
John
