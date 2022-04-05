Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66B2C4167B
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Apr 2022 21:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiDEVZy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444471AbiDEPld (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC73C3347;
        Tue,  5 Apr 2022 07:04:58 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXq9B2TTJz67nP6;
        Tue,  5 Apr 2022 22:02:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 16:04:55 +0200
Received: from [10.47.91.157] (10.47.91.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 15:04:55 +0100
Message-ID: <5f1d8b3f-0afa-2724-4ff1-f061939c68c5@huawei.com>
Date:   Tue, 5 Apr 2022 15:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     <alexandre.truong@arm.com>
From:   John Garry <john.garry@huawei.com>
Subject: perf tool: About "perf arm64: Inject missing frames when using 'perf
 record --call-graph=fp'"
CC:     <linux-perf-users@vger.kernel.org>,
        "jolsa@kernel.org >> Jiri Olsa" <jolsa@kernel.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.157]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Alexandre,

I notice that with commit b9f6fbb3b2c2 ("perf arm64: Inject missing 
frames when using 'perf record --call-graph=fp'") that I get messages 
spewing the console when running perf record+report, as below:

john@ubuntu:~/linux$sudo tools/perf/perf record -ag fio null12.fio
john@ubuntu:~/linux$sudo tools/perf/perf report > report
unwind: can't read reg 29
unwind: can't read reg 29
unwind: can't read reg 29
unwind: can't read reg 29
...

Do you know the possible cause? I haven't checked...

Thanks,
john
