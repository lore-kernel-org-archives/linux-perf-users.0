From: Ilya Verbin <iverbin@gmail.com>
Subject: Which events can use PEBS?
Date: Fri, 10 Feb 2017 18:35:47 +0300
Message-ID: <CADG=Z0Etah1_vi=TxwWrvppXb+WxkgqdzpztdZWd_50881SgLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35987 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbdBJQbA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Feb 2017 11:31:00 -0500
Received: by mail-ot0-f172.google.com with SMTP id 32so31921720oth.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2017 08:31:00 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I want to understand which events can have the precise modifier on my
CPU (Sandy Bridge).

Intel Software Developer's Manual (Table 18-32. PEBS Performance
Events for Intel Microarchitecture Code Name Sandy Bridge) contains
only the following events: INST_RETIRED, UOPS_RETIRED,
BR_INST_RETIRED, BR_MISP_RETIRED, MEM_UOPS_RETIRED,
MEM_LOAD_UOPS_RETIRED, MEM_LOAD_UOPS_LLC_HIT_RETIRED.

And https://download.01.org/perfmon/SNB/SandyBridge_core_V15.json
lists the same events with PEBS > 0.

However I can successfully record e.g. cpu-cycles:p.

perf record -e cpu-cycles:p -vv -- sleep 1 2>&1 | grep precise_ip
also prints "precise_ip 1".  So does CPU_CLK_UNHALTED really use PEBS?

Is it possible to get the full list of events, which support ":p"?

Thanks,
  -- Ilya
