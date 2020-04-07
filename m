From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/6] perf/imx_ddr: Add namespace for i.MX8 DDR Perf
Date: Tue, 7 Apr 2020 15:59:33 +0100
Message-ID: <ccab39b0-c84f-e529-4067-07466b5433a1@huawei.com>
References: <20200222104621.2258-1-qiangqing.zhang@nxp.com>
 <6dbeabcf-c15a-0bbd-cef4-b25d0133854f@huawei.com>
 <DB7PR04MB4618D2E1892120EB659B8695E6EC0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <2f81eb7a-a6e4-1cc6-cd0a-ca3d749bd552@huawei.com>
 <DB7PR04MB4618C0A8DD9BAB2A529CDCECE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <a2cc0772-4f5d-aba3-1f5c-7d4eef7a3f72@huawei.com>
 <DB7PR04MB461803AD15E47AA880F0915DE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <55836919-41b5-0834-f7a7-1a2a34535677@huawei.com>
 <bd67910e-1522-39cd-5527-b9b18f3da96d@huawei.com>
 <DB8PR04MB6795996085AD2167E2358907E6C30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <DB8PR04MB6795996085AD2167E2358907E6C30@DB8PR04MB6795.eurprd04.prod.outlook.com>
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
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Zhangshaokun <zhangshaokun@hisilicon.com>, Jiri Olsa <jolsa@redhat.com>, Frank Li <frank.li@nxp.com>, Linuxarm <linuxarm@huawei.com>, "acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Joakim,

> 
> It can't work on my platform:
> 
> root@imx8mmevk:~# cat /sys/bus/event_source/devices/imx8_ddr0/identifier
> i.mx8mm
> 
> 
> root@imx8mmevk:~# ./perf list metric
> List of pre-defined events (to be used in -e):
> 
> Metrics:
> 
>    imx8mm_ddr0_read.all
>         [Bytes of all masters read from ddr0. Unit: uncore_i.mx8,ddrc ]

I think I simply missed something in jevents.c . Can you add this, 
regenerate, and retry:

diff --git a/tools/perf/pmu-events/jevents.c 
b/tools/perf/pmu-events/jevents.c
index 675aec9881ce..16dcf00c792a 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -258,6 +258,7 @@ static struct map {
        { "hisi_sccl,l3c", "hisi_sccl,l3c" },
        /* it's not realistic to keep adding these, we need something 
more scalable ... */
        { "smmuv3_pmcg", "smmuv3_pmcg" },
+       { "imx8_ddr", "imx8_ddr" },
        { "L3PMC", "amd_l3" },
        {}


> 
> 
> root@imx8mmevk:~# ./perf stat -a -I 1000 -M imx8mm_ddr0_read.all
> event syntax error: ''
>                        \___ parser error
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -M, --metrics <metric/metric group list>
>                            monitor specified metrics or metric groups (separated by ,)
> 
> However, it can work on branch: private-topic-perf-5.6-pmu-events-upstream-v2. What changes have you made compared to last?
> 
> Could you help do below change? Since some Socs may have two ddr controller(ddr0/ddr1) with the same event code.

The perf tool can handle that. So just run perf with -v option, and it 
will show event count breakdown per PMU, like this:

root@ubuntu:/# ./perf stat -v -e smmuv3_pmcg.l1_tlb sleep 1
Using CPUID 0x00000000480fd010
Using SYSID HIP08
-> smmuv3_pmcg_200100020/event=0x8a/
-> smmuv3_pmcg_200140020/event=0x8a/
-> smmuv3_pmcg_100020/event=0x8a/
-> smmuv3_pmcg_140020/event=0x8a/
-> smmuv3_pmcg_200148020/event=0x8a/
-> smmuv3_pmcg_148020/event=0x8a/
smmuv3_pmcg.l1_tlb: 0 1001221690 1001221690
smmuv3_pmcg.l1_tlb: 0 1001220090 1001220090
smmuv3_pmcg.l1_tlb: 101 1001219660 1001219660
smmuv3_pmcg.l1_tlb: 0 1001219010 1001219010
smmuv3_pmcg.l1_tlb: 0 1001218360 1001218360
smmuv3_pmcg.l1_tlb: 134 1001217850 1001217850


Here smmuv3_pmcg_200100020, smmuv3_pmcg_200140020, etc are all instances 
of the same PMU, like your DDRC.

And if you want to run just for a single PMU, try like:

./perf stat -e smmuv3_pmcg_200148020/smmuv3_pmcg.l1_tlb/

[thanks for jirka for that hint :) ]

Thanks,
John

> Delete file: tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
> Replace file: tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json, put all events into metric.
> [
>     {
> 	"PublicDescription": "ddr0 cycles event",
> 	"MetricName": "imx8mm_ddr0.cycles",
> 	"MetricExpr": "imx8_ddr0\\/cycles\\/",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>     },
>     {
> 	"PublicDescription": "ddr0 read-cycles event",
> 	"MetricName": "imx8mm_ddr0.read_cycles",
> 	"MetricExpr": "imx8_ddr0\\/read\\-cycles\\/",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>     },
>     {
> 	"PublicDescription": "ddr0 write-cycles event",
> 	"MetricName": "imx8mm_ddr0.write_cycles",
> 	"MetricExpr": "imx8_ddr0\\/write\\-cycles\\/",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>     },
>     {
> 	"PublicDescription": "ddr0 read event",
> 	"MetricName": "imx8mm_ddr0.read",
> 	"MetricExpr": "imx8_ddr0\\/read\\/",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>     },
>     {
> 	"PublicDescription": "ddr0 write event",
> 	"MetricName": "imx8mm_ddr0.write",
> 	"MetricExpr": "imx8_ddr0\\/write\\/",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>     },
>     {
> 	"PublicDescription": "bytes all masters read from ddr0 based on read-cycles event.",
> 	"MetricName": "imx8mm_ddr0_read.all",
> 	"MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ ) * 4 * 4",
> 	"ScaleUnit": "9.765625e-4MB",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>      },
>     {
> 	"PublicDescription": "bytes all masters write to ddr0 based on read-cycles event.",
> 	"MetricName": "imx8mm_ddr0_write.all",
> 	"MetricExpr": "( imx8_ddr0\\/write\\-cycles\\/ ) * 4 * 4",
> 	"ScaleUnit": "9.765625e-4MB",
> 	"Unit": "imx8_ddr",
> 	"Compat": "i.mx8mm"
>      }
> ]
> 
> Thanks.
> 
> Best Regards,
> Joakim Zhang
> 
