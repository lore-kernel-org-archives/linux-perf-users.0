Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E83C04A6A
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Aug 2023 07:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjHDHdr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Aug 2023 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjHDHdc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Aug 2023 03:33:32 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCCC59F8;
        Fri,  4 Aug 2023 00:32:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vp.c2HC_1691134188;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vp.c2HC_1691134188)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 15:29:53 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: [PATCH v4 0/2] perf/core: Bail out early if the request AUX area is out of bound
Date:   Fri,  4 Aug 2023 15:29:43 +0800
Message-Id: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

changes since v3 (per James):
- change to return with existing value -ENOMEM
- split doc part to a separate patch since they are going to be merged through
  separate trees.

changes since v2:
- remove unnecessary overflow check (per Peter)

changes since v1:
- drop out patch2 because it has been fixed on upstream (Thanks James for reminding)
- move sanity check into rb_alloc_aux (per Leo)
- add overflow check (per James)

Shuai Xue (2):
  perf/core: Bail out early if the request AUX area is out of bound
  perf record: Update docs regarding the maximum limitation of AUX area

 kernel/events/ring_buffer.c              | 3 +++
 tools/perf/Documentation/perf-record.txt | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.39.3

