Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4435DC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 01:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiDMBFB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 21:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDMBFB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 21:05:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BA220E1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 18:02:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l7so912038ejn.2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Apr 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHgRgX3+0ilVJ9YEz+Ro35NSCV1c4ZJEIy9ObWgb1b8=;
        b=NUCfHE9xdZ9NzydGuze+K4FGrkTRWikvoUjVdKKEmj+51xkJonHOUtFyTKNZ8fE3k8
         n2mvmJWCsJv2SuD0lN1+Ao+lt9oMDLmPksYpizz9qGjWMmSZjRdT014Qvq/AazOMe+lz
         EWc3XnI6Ff08/IESsrCyfoQKheL6BpyxJrDZT3skcTlAm87BPKgTLJcu96KLQyBKwJe3
         GvvglTGHlqgekGZWihpodT1+zUyXqRmDA5a6IGWeis9Ak8Y9aGxTXnCL/8TwIWwMMCjt
         PZq1jN1OH0Q1TQfDXDPZVt1+pkwDFbksdGcMTMsJRNP6BTsIN9JtrwNWtYChVUbAd1RZ
         2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHgRgX3+0ilVJ9YEz+Ro35NSCV1c4ZJEIy9ObWgb1b8=;
        b=Q8Kxc0x6+Zc/r6JSxocIBwZGA84NYG5HTdyGkkfF/1gqB2pBG70bPDA9vm0zUVRz50
         PZROhheS5k0S4LD/Oij2TVW41hQd0PtvZfr0JLdrT79u6UcjFT6lxm0nFKm/mSlFMVRO
         Kg/uBKy5NiTcsJ0xEtr6d5UZw46NUJYI+T1wjHxbbJT6iHi7Fzeu/Yk1EX8Kl3u6dCwT
         MScbuxcpH9ILCZ1CYKkLzHfcNfMgZNr/pAEMosBKPkbmLAudZ4m/9dDtNFxorjBJtmHW
         ofjUVIL4GDwKyZv1Ix9sWl56rrNaaWeEbw5mghsE86gxYZv/ghP2FFw85qUK1Zve3iAa
         q5ZA==
X-Gm-Message-State: AOAM5318dRUq2U7HQJ09gC7xrsk/taM7oPvtT2nah/y6D64exIY7UmX4
        P7FbgfjUkRobTz4hHCdoGAVBig==
X-Google-Smtp-Source: ABdhPJz6nR5gS7smVj1tOoFEo1ZKYCvXsj50KSC95aQgmU9VFWO11RjMevciiQIBq2XNa9yaSNR2HA==
X-Received: by 2002:a17:907:97d4:b0:6e8:6b69:7120 with SMTP id js20-20020a17090797d400b006e86b697120mr17895555ejc.531.1649811759886;
        Tue, 12 Apr 2022 18:02:39 -0700 (PDT)
Received: from localhost.localdomain (111-250-44-108.dynamic-ip.hinet.net. [111.250.44.108])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm475834edk.50.2022.04.12.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 18:02:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf arm-spe: Test memory samples
Date:   Wed, 13 Apr 2022 09:02:21 +0800
Message-Id: <20220413010221.81332-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a new test to verify the Arm SPE synthesized memory samples with
'perf mem report' command.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index e59044edc406..b36125e127eb 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -62,6 +62,18 @@ perf_report_samples() {
 		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
 }
 
+perf_mem_report_samples() {
+	echo "Looking at perf.data file for reporting memory samples:"
+
+	# Below is an example of the memory samples reporting:
+	#   20.71%    1696    27    L1 hit     [k] el0t_64_sync_handler    [kernel.kallsyms]    ...
+	#   17.21%    1903    20    L1 hit     [k] el0t_64_sync            [kernel.kallsyms]    ...
+	#    8.52%     897    21    L1 hit     [k] ksys_read               [kernel.kallsyms]    ...
+	#    0.12%      16    17    L1 hit     [.] 0x0000000000004ce8      dd                   ...
+	perf mem report --stdio -i ${perfdata} 2>&1 | \
+		egrep " +[0-9]+\.[0-9]+% +[0-9]+ +[0-9]+ .* +$1 " > /dev/null 2>&1
+}
+
 arm_spe_snapshot_test() {
 	echo "Recording trace with snapshot mode $perfdata"
 	perf record -o ${perfdata} -e arm_spe// -S \
@@ -79,7 +91,8 @@ arm_spe_snapshot_test() {
 	wait $PERFPID
 
 	perf_script_samples dd &&
-	perf_report_samples dd
+	perf_report_samples dd &&
+	perf_mem_report_samples dd
 
 	err=$?
 	arm_spe_report "SPE snapshot testing" $err
-- 
2.25.1

