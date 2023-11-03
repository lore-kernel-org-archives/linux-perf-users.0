Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789517C5
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E737BD;
	Thu,  2 Nov 2023 22:17:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id E53DB24E288;
	Fri,  3 Nov 2023 13:17:02 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Nov
 2023 13:17:02 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Nov
 2023 13:16:56 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: <irogers@google.com>
CC: <acme@kernel.org>, <adrian.hunter@intel.com>,
	<alexander.shishkin@linux.intel.com>, <aou@eecs.berkeley.edu>,
	<beeman@rivosinc.com>, <jisheng.teoh@starfivetech.com>, <jolsa@kernel.org>,
	<kconsul@ventanamicro.com>, <leyfoon.tan@starfivetech.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <mark.rutland@arm.com>,
	<mingo@redhat.com>, <n.shubin@yadro.com>, <namhyung@kernel.org>,
	<palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <peterz@infradead.org>
Subject: Re: [PATCH] perf vendor events riscv: add StarFive Dubhe-80 JSON file
Date: Fri, 3 Nov 2023 13:15:30 +0800
Message-ID: <20231103051530.912669-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP-5=fW6Qeu8Q_mQ7zUBsHn+BiMmDJvjn0nT1YAZaLH6EaBjnA@mail.gmail.com>
References: <CAP-5=fW6Qeu8Q_mQ7zUBsHn+BiMmDJvjn0nT1YAZaLH6EaBjnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

>>
>> StarFive's Dubhe-80 supports raw event id 0x00 - 0x22.
>> The raw events are enabled through PMU node of DT binding.
>>
>> Example of PMU DT node:
>> pmu {
>>         compatible =3D "riscv,pmu";
>>         riscv,raw-event-to-mhpmcounters =3D
>>                 /* Event ID 1-31 */
>>                 <0x00 0x00 0xFFFFFFFF 0xFFFFFFE0 0x00007FF8>,
>>                 /* Event ID 32-33 */
>>                 <0x00 0x20 0xFFFFFFFF 0xFFFFFFFE 0x00007FF8>,
>>                 /* Event ID 34 */
>>                 <0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;
>> };
>>
>> Example of Perf stat output:
>> [root@user]# perf stat -a \
>>         -e access_mmu_stlb \
>>         -e miss_mmu_stlb \
>>         -e access_mmu_pte_c \
>>         -e rob_flush \
>>         -e btb_prediction_miss \
>>         -e itlb_miss \
>>         -e sync_del_fetch_g \
>>         -e icache_miss \
>>         -e bpu_br_retire \
>>         -e bpu_br_miss \
>>         -e ret_ins_retire \
>>         -e ret_ins_miss \
>>         -- openssl speed rsa2048
>>
>> Doing 2048 bits private rsa's for 10s: 39 2048 bits private RSA's in
>> 10.14s
>> Doing 2048 bits public rsa's for 10s: 1563 2048 bits public RSA's in
>> 10.00s
>> version: 3.0.11
>> built on: Tue Sep 19 13:02:31 2023 UTC
>> options: bn(64,64)
>> CPUINFO: N/A
>>                   sign    verify    sign/s verify/s
>> rsa 2048 bits 0.260000s 0.006398s      3.8    156.3
>>
>>  Performance counter stats for 'system wide':
>>
>>            1338350      access_mmu_stlb
>>            1154025      miss_mmu_stlb
>>            1162691      access_mmu_pte_c
>>              34067      rob_flush
>>           11212384      btb_prediction_miss
>>            1256242      itlb_miss
>>          652523491      sync_del_fetch_g
>>             384465      icache_miss
>>           64635789      bpu_br_retire
>>             323440      bpu_br_miss
>>            8785143      ret_ins_retire
>>              31236      ret_ins_miss
>>
>>       20.760822480 seconds time elapsed
>>
>> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@xxxxxxxxxxxxxxxx>
>
> Thanks Ji Sheng,
>
> in adding these events for this new architecture is there a reason not
> to add the architecture standard events in
> tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json ?
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json?h=3Dperf-=
tools-next
>
> Perhaps it is worth commenting in the commit message whether or not
> these events are supported.
>
> Thanks,
> Ian

Thanks Ian for the comment,

The architecture standard events are supported as well.
I will include them in v2.

Thanks,
Ji Sheng
