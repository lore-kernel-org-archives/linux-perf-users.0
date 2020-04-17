From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/6] perf/imx_ddr: Add namespace for i.MX8 DDR Perf
Date: Fri, 17 Apr 2020 09:14:39 +0100
Message-ID: <1952b369-f3fd-845f-650b-3c0464e37016@huawei.com>
References: <20200222104621.2258-1-qiangqing.zhang@nxp.com>
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
 <8341b035-2fac-52dd-45d1-2bf6f5ea4ba4@huawei.com>
 <DB8PR04MB67952380E7240167C7E81178E6D90@DB8PR04MB6795.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <DB8PR04MB67952380E7240167C7E81178E6D90@DB8PR04MB6795.eurprd04.prod.outlook.com>
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
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "irogers@google.com" <irogers@google.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Zhangshaokun <zhangshaokun@hisilicon.com>, "will@kernel.org" <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, "acme@kernel.org" <acme@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Jiri Olsa <jolsa@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

On 17/04/2020 06:49, Joakim Zhang wrote:
>>   smmuv3_pmcg.transaction  (49.56%)
>> 124902473      smmuv3_pmcg.cycles       (49.56%)
>>
>>          1.001167246 seconds time elapsed
>>
>> So you can compare this to yours.
>>
>> I did have to fix what looks like a bug in mainline on that branch:
> Tested on private-topic-perf-5.7-sys-pmu-events-v1-debug branch, DDR Perf can work now, thanks.
> Please remember to update JSON files which notified before.
> 
> Best Regards,
> Joakim Zhang
>> --->8-----


ok, good. So without this fix I supplied, it did still look to work for 
me, but will lots of complaining from perf.

Anyway, I'll look to send this series soon, and I'll update the imx 
JSONs as requested. You will need to then add a fresh signed-off-by to 
what I send.

thanks,
john
