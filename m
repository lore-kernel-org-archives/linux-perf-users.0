Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBBC76196
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 06:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCTGQm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCTGQk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 02:16:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2817211C8
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 23:16:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so6754642pjl.4
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679292997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh6mUjNb9FiKF7I+GjENPLAa8wG+aCWE1nTIMFKFpIE=;
        b=hAhUR/tLA/6zvpc+6xnsZ8t9YbT+RPN0pMkMXxLzo4+akIiv+I/w20iLX9gtrq2nro
         TbubBVTj0mvgxdtP9HPzwqpgFrU3AJ3xjozoPFWORo6qqokvNwv9hI6ngre+ViUkcO3t
         j2U4YGMwf4tAXAY/N2suBjAVYxTreCnIg4Cmp8ExXXDSvWP7fqFObFlegE8OUAL5ybVo
         qK32USLyjZHsWC0OY1f53+RPYDzbt/vgLb1YTuyyMuSlJE1mv/1AIHCNDjM4IqWXnAMs
         /BE3oJ3GpR1LB7AoWccKaTTB9W+laGQvM89IA8RRVaHqF/bNhi3gy4P8UBXlSBNKwLe4
         0Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh6mUjNb9FiKF7I+GjENPLAa8wG+aCWE1nTIMFKFpIE=;
        b=ug9qMCKTkDs3V7IlrKvJLuOJZkY0HlfsqmugZIRQRoq5x0S9T8XjM1vpzZkpLTJCCp
         vchrf7muAKBEcAPGddGOAtH36rJ2CdU9CPfQCAJhS1Uvo8Gs0/yEC8CboiCXpP4VAYgN
         bwA1Y9c6Za4vxrsAwj4LXfYUH1iAZpaHtmUczT2gxQRP3qw7VUkaNn13F7110SFqM7wt
         rAmtJKbILCoLvJSnx4vxBj7bXTVw7x3J1AEk0fMxv3Hl46ig4CGKC5YFVUDjnKhUIWUJ
         rsr3aGROsP6lwOoMIF3rdB8t+S1jmbfi/I5wOe4XPv0L8WkfJD7O/pOpYm0lU5cu5Iud
         B0uA==
X-Gm-Message-State: AO0yUKW867EPbYNnhBu8w2PsXrxbRoXGikUmW99NDmqRHm11dDT1yEIE
        pwii1f1pGz43Gc24MCni8X+JVQ==
X-Google-Smtp-Source: AK7set+k3m3yvjsif3ZiGXOP/Ma69G3WbeFfqonLN8gZaD5K/BL/zbhNeijIFAlMyvpQiUYINPFt2A==
X-Received: by 2002:a17:902:e5c9:b0:1a1:cefd:aa1f with SMTP id u9-20020a170902e5c900b001a1cefdaa1fmr3421983plf.52.1679292996971;
        Sun, 19 Mar 2023 23:16:36 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c61616f82sm5750129plo.230.2023.03.19.23.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:16:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf kvm: Delete histograms entries before exiting
Date:   Mon, 20 Mar 2023 14:16:19 +0800
Message-Id: <20230320061619.29520-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320061619.29520-1-leo.yan@linaro.org>
References: <20230320061619.29520-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's good not to release resources for a program when kernel cleans up
memory space, this patch explicitly releases histograms entries with
hists__delete_entries().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 1e1cb5a9d0a2..fb9dc0dc46f9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1528,6 +1528,8 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	}
 
 out:
+	hists__delete_entries(&kvm_hists.hists);
+
 	if (kvm->timerfd >= 0)
 		close(kvm->timerfd);
 
@@ -1690,6 +1692,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	kvm_display(kvm);
 
 exit:
+	hists__delete_entries(&kvm_hists.hists);
 	return ret;
 }
 
-- 
2.39.2

