From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/6] perf/imx_ddr: Add namespace for i.MX8 DDR Perf
Date: Wed, 15 Apr 2020 10:28:16 +0100
Message-ID: <0b3999b8-c307-6b4a-1a1b-e90b45f50b61@huawei.com>
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
 <ccab39b0-c84f-e529-4067-07466b5433a1@huawei.com>
 <VI1PR04MB68000808CEE4BC23403C35A0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
 <ca2db002-975a-ffe0-2dfc-c85f4e6205bb@huawei.com>
 <VI1PR04MB6800F2A5949F0AFAF2E82CE0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <VI1PR04MB6800F2A5949F0AFAF2E82CE0E6C00@VI1PR04MB6800.eurprd04.prod.outlook.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Zhangshaokun <zhangshaokun@hisilicon.com>, "will@kernel.org" <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, "acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Jiri Olsa <jolsa@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

On 08/04/2020 12:41, Joakim Zhang wrote:
>> That code should be effectively the same.
>>
>> What does perf list show for the metrics now?
> root@imx8mmevk:~# ./perf list ddrc
> 
> List of pre-defined events (to be used in -e):
> 
> 
> ddrc:
>    imx8_ddr.cycles
>         [ddr cycles event. Unit: imx8_ddr]
>    imx8_ddr.read
>         [ddr read event. Unit: imx8_ddr]
>    imx8_ddr.read_cycles
>         [ddr read-cycles event. Unit: imx8_ddr]
>    imx8_ddr.write
>         [ddr write event. Unit: imx8_ddr]
>    imx8_ddr.write_cycles
>         [ddr write-cycles event. Unit: imx8_ddr]
> 
> root@imx8mmevk:~# ./perf list metric
> 
> List of pre-defined events (to be used in -e):
> 
> 
> Metrics:
> 
>    imx8mm_ddr_read.all
>         [bytes all masters read from ddr based on read-cycles event. Unit: imx8_d
> dr ]
>    imx8mm_ddr_write.all
>         [bytes all masters write to ddr based on read-cycles event. Unit: imx8_dd
> r ]
> 
> root@imx8mmevk:~# ./perf stat -a -I 1000 -v -M imx8mm_ddr_read.all
> Using CPUID 0x00000000410fd040
> adding
> event syntax error: ''
>                        \___ parser error
> 
>   Usage: perf stat [<options>] [<command>]
> 
>      -M, --metrics <metric/metric group list>
>                            monitor specified metrics or metric groups (separated by ,)
> 
> It seems that metricgroup fails to parse the metric expression.
> metric.json:
> [
>     {
> 	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
> 	    "MetricName": "imx8mm_ddr_read.all",
> 	    "MetricExpr": "imx8_ddr.read_cycles * 4 * 4",
> 	    "ScaleUnit": "9.765625e-4MB",
> 	    "Unit": "imx8_ddr",

I noticed that previously we used imx8,ddr, which I think was wrong, so 
can you try to remove this here?

If that doesn't work, then I'll try this myself.

Thanks,
John

> 	    "Compat": "i.mx8mm"
>      },
>     {
> 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
> 	    "MetricName": "imx8mm_ddr_write.all",
> 	    "MetricExpr": "imx8_ddr.write_cycles * 4 * 4",
> 	    "ScaleUnit": "9.765625e-4MB",
> 	    "Unit": "imx8_ddr",
> 	    "Compat": "i.mx8mm"
>      }
> ]
> 
>>>>> root@imx8mmevk:~# ./perf stat
