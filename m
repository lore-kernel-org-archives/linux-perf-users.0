Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED815C48BC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3D36138C
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhF1Drh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 23:47:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8474 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhF1Drh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 23:47:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GCthY1CC9zZnCc;
        Mon, 28 Jun 2021 11:42:05 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 11:45:08 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 11:45:08 +0800
Subject: Re: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf
 script
To:     Leo Yan <leo.yan@linaro.org>
CC:     <john.garry@huawei.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <james.clark@arm.com>,
        <andre.przywara@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
 <20210628014953.GA163942@leoy-ThinkPad-X240s>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <75dac5f8-9c82-0db1-d362-44289dcaa206@huawei.com>
Date:   Mon, 28 Jun 2021 11:45:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210628014953.GA163942@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Leo,

On 2021/6/28 9:49, Leo Yan wrote:
> Hi Jihong,
> 
> On Sat, Jun 26, 2021 at 11:21:15AM +0800, Yang Jihong wrote:
>> When use perf script to parse ARM SPE data, sample timestamp does not match
>> the timestamp stored in the AUX buffer, arm_spe_prep_sample function set
>> "samlpe->time = speq->timestamp", "speq->timestamp" is the timestamp of first
>> packet in auxtrace buffer. As a result, the time of all samples in a auxtrace
>> buffer uses the same timestamp.
> 
> Could you confirm if the patch set [1] can fix your issue?
> 
After I apply this patch set, and verify it as follows:

# ./perf/perf record -e arm_spe_0/ts_enable=1,branch_filter=1/ ls
accounting  bootconfig  build   debugging  elf.s     firmware  hv 
include   kvm     leds  Makefile      objtool  pcmcia  perf.data 
scripts  testing  time     usb     vm
arch        bpf         cgroup  edid       firewire  gpio      iio 
io_uring  laptop  lib   memory-model  pci      perf    power      spi 
    thermal  tracing  virtio  wmi
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.031 MB perf.data ]
# ./perf/perf script --ns
               ls 23104 [030] 314938.859071370:          1 
               branch-miss:  ffffb7ee2a20e100 __pi_memcpy+0x80 
([kernel.kallsyms])
               ls 23104 [030] 314938.859753820:          1 
               branch-miss:  ffffb7ee29f360e0 __split_vma+0x110 
([kernel.kallsyms])
               ls 23104 [030] 314938.859820430:          1 
               branch-miss:      fffe85dd87e0 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.859941110:          1 
               branch-miss:      fffe85dd7a28 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.859948890:          1 
               branch-miss:      fffe85dd7a28 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.859953610:          1 
               branch-miss:      fffe85dc8f58 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.859955730:          1 
               branch-miss:  ffffb7ee2a12856c common_mmap.part.23+0x34 
([kernel.kallsyms])
               ls 23104 [030] 314938.860059900:          1 
               branch-miss:      fffe85dc8f58 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.860095470:          1 
               branch-miss:      fffe85dc8f58 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.860105460:          1 
               branch-miss:      fffe85dc8f58 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.860111870:          1 
               branch-miss:      fffe85dd7a20 [unknown] 
(/usr/lib64/ld-2.28.so)
               ls 23104 [030] 314938.860237310:          1 
               branch-miss:      fffe85bc8e00 [unknown] 
(/usr/lib64/libc-2.28.so)
               ls 23104 [030] 314938.860419000:          1 
               branch-miss:      fffe85bd4638 __strcoll_l+0xc58 
(/usr/lib64/libc-2.28.so)
               ls 23104 [030] 314938.860455790:          1 
               branch-miss:  ffffb7ee2a20e10c __pi_memcpy+0x8c 
([kernel.kallsyms])
               ls 23104 [030] 314938.860473730:          1 
               branch-miss:  ffffb7ee29d0af50 __queue_work+0x1a8 
([kernel.kallsyms])
               ls 23104 [030] 314938.860485020:          1 
               branch-miss:  ffffb7ee2a20e0c0 __pi_memcpy+0x40 
([kernel.kallsyms])
               ls 23104 [030] 314938.860533380:          1 
               branch-miss:  ffffb7ee29f39158 tlb_flush+0x30 
([kernel.kallsyms])
# ./perf/perf script -D
[...]
.  00000a7c:  b0 00 e1 20 2a ee b7 ff c0                      PC 
0xffb7ee2a20e100 el2 ns=1
.  00000a85:  99 02 00                                        LAT 2 ISSUE
.  00000a88:  98 03 00                                        LAT 3 TOT
.  00000a8b:  52 c2 00                                        EV RETIRED 
NOT-TAKEN MISPRED
.  00000a8e:  4a 01                                           B COND
.  00000a90:  b1 04 e1 20 2a ee b7 ff c0                      TGT 
0xffb7ee2a20e104 el2 ns=1
.  00000a99:  00 00 00 00 00 00                               PAD
.  00000a9f:  71 3f e9 51 b9 a9 1c 00 00                      TS 
31515284203839
[...]
.  000018c0:  b0 e0 60 f3 29 ee b7 ff c0                      PC 
0xffb7ee29f360e0 el2 ns=1
.  000018c9:  99 02 00                                        LAT 2 ISSUE
.  000018cc:  98 03 00                                        LAT 3 TOT
.  000018cf:  52 82 00                                        EV RETIRED 
MISPRED
.  000018d2:  4a 01                                           B COND
.  000018d4:  b1 68 61 f3 29 ee b7 ff c0                      TGT 
0xffb7ee29f36168 el2 ns=1
.  000018dd:  00 00 00 00 00 00                               PAD
.  000018e3:  71 d4 f3 52 b9 a9 1c 00 00                      TS 
31515284272084
[...]
.  000019f4:  b0 e0 87 dd 85 fe ff 00 80                      PC 
0xfffe85dd87e0 el0 ns=1
.  000019fd:  99 02 00                                        LAT 2 ISSUE
.  00001a00:  98 03 00                                        LAT 3 TOT
.  00001a03:  52 c2 00                                        EV RETIRED 
NOT-TAKEN MISPRED
.  00001a06:  4a 01                                           B COND
.  00001a08:  b1 e4 87 dd 85 fe ff 00 80                      TGT 
0xfffe85dd87e4 el0 ns=1
.  00001a11:  00 00 00 00 00 00                               PAD
.  00001a17:  71 d9 0d 53 b9 a9 1c 00 00                      TS 
31515284278745
[...]
.  00001f48:  b0 28 7a dd 85 fe ff 00 80                      PC 
0xfffe85dd7a28 el0 ns=1
.  00001f51:  99 07 00                                        LAT 7 ISSUE
.  00001f54:  98 08 00                                        LAT 8 TOT
.  00001f57:  52 c2 00                                        EV RETIRED 
NOT-TAKEN MISPRED
.  00001f5a:  4a 01                                           B COND
.  00001f5c:  b1 2c 7a dd 85 fe ff 00 80                      TGT 
0xfffe85dd7a2c el0 ns=1
.  00001f65:  00 00 00 00 00 00                               PAD
.  00001f6b:  71 fd 3c 53 b9 a9 1c 00 00                      TS 
31515284290813
[...]
.  00001fcc:  b0 28 7a dd 85 fe ff 00 80                      PC 
0xfffe85dd7a28 el0 ns=1
.  00001fd5:  99 08 00                                        LAT 8 ISSUE
.  00001fd8:  98 09 00                                        LAT 9 TOT
.  00001fdb:  52 82 00                                        EV RETIRED 
MISPRED
.  00001fde:  4a 01                                           B COND
.  00001fe0:  b1 10 7a dd 85 fe ff 00 80                      TGT 
0xfffe85dd7a10 el0 ns=1
.  00001fe9:  00 00 00 00 00 00                               PAD
.  00001fef:  71 07 40 53 b9 a9 1c 00 00                      TS 
31515284291591
[...]
.  00002050:  b0 58 8f dc 85 fe ff 00 80                      PC 
0xfffe85dc8f58 el0 ns=1
.  00002059:  99 22 00                                        LAT 34 ISSUE
.  0000205c:  98 23 00                                        LAT 35 TOT
.  0000205f:  52 82 00                                        EV RETIRED 
MISPRED
.  00002062:  4a 01                                           B COND
.  00002064:  b1 40 8f dc 85 fe ff 00 80                      TGT 
0xfffe85dc8f40 el0 ns=1
.  0000206d:  00 00 00 00 00 00                               PAD
.  00002073:  71 df 41 53 b9 a9 1c 00 00                      TS 
31515284292063
[...]

The timestamp does not match. Each timestamp has a difference of 
213.98296702 seconds. Is the command I executed wrong?

|symbol_address|perf script| perf script -D|
|ffffb7ee2a20e100|314938.859071370|31515284203839|
|ffffb7ee29f360e0|314938.859753820|31515284272084|
|fffe85dd87e0|314938.859820430|31515284278745|
|fffe85dd7a28|314938.859941110|31515284290813|
|fffe85dd7a28|314938.859948890|31515284291591|
|fffe85dc8f58|314938.859953610|31515284292063|

Thanks,
Jihong
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/patchwork/cover/1431624/
> .
> 
