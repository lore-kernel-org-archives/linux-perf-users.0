Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC1AC7EE29
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 01:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjFGBqD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 21:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjFGBoo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1E1BC7
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 18:44:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5689bcc5f56so102379017b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 18:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102282; x=1688694282;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5i/HcXWZK6yNAnvq9kN2ruEXhS3nctm8EhXDDQYxW0=;
        b=t7gIuC7RMSZxifslee8OkIZwaZvgm8eHWrgQsoRbPEqRSzohhLm5euXvuOaHTMGjTW
         ZQClMPQyMlfx1RwmBzKAQvCsfJOaqsVeBK4ngDOTz1Eh7sRrslTD4+9cNSM5YFstL4p6
         Pfeqp3G0SF2J6BRCKSbjLoM158ia7k30ps3q/fyd+LAg9RF5185Ion/Z4bs6ke9rs8uI
         IhpznhPojPzY9Eyow9Ff4Jirl7l6AC6o9kttvqYEZsjSu2XeB9liT7TWhpi/47lQHrP1
         Hw31TFt/y9n9bOl+SCCVm82dnuV+Yku5+kXZX0GNKqtGjMFHVVckk0jUGtRvSVOO2KX0
         RpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102282; x=1688694282;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5i/HcXWZK6yNAnvq9kN2ruEXhS3nctm8EhXDDQYxW0=;
        b=A0ORTfyfElYAHDhfKuJGVbl2xcclu3VPm/y7GYS9U8u/poT3KZCiOrbH3FkCMvJ1W2
         CIXB7FJOnIqQJnU93r4zpR/pL/deRB0Ry+Ixk2j1PW7kFyrFmn7UHZ5NBuZzRNrvDis4
         hmHT81a0rYq5d/2FUFXeyXI1G4F/LlaAGNlSdwT4UjKjX9J33euFaLx9gR23xf5arC3J
         QuDIg9FvgKBu0ZSXBUayZd8eskWfBUVIAl83v8PqkyPdcvTI1QcFi2R6bjvbR3238eXI
         QoAqFVFiNGsdJQ3EClNwjMcDPW+NAd13QYJ5v+gGKq8hTPHMiWOXAKqxh66Kso4huUyE
         G94w==
X-Gm-Message-State: AC+VfDx3CLW21wD/COLVMr+P5mk8Abm/TfvvQ2ugznihI0d5k2XEeTI5
        B3ZW0D8xZ5lvClMnffmwoH8uY5byfp6m
X-Google-Smtp-Source: ACHHUZ6sXa4pQEp7493QMMx/+lFm2yYaX/H67xkftwZIrCy4G77CgeVMKsJI+bSIONd37E/2O8+CJYx/NMxP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:ac57:0:b0:565:9bee:22e0 with SMTP id
 z23-20020a81ac57000000b005659bee22e0mr2032744ywj.0.1686102282285; Tue, 06 Jun
 2023 18:44:42 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:47 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-15-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 14/20] perf python: Avoid 2 leak sanitizer issues
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Leak sanitizer complains about the variable size bf allocation and
store to bf if sized 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6b89eec98dd7..59944fef8108 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -735,6 +735,9 @@ static void regs_map(struct regs_dump *regs, uint64_t mask, const char *arch, ch
 	unsigned int i = 0, r;
 	int printed = 0;
 
+	if (size <= 0)
+		return;
+
 	bf[0] = 0;
 
 	if (!regs || !regs->regs)
@@ -764,7 +767,7 @@ static void set_regs_in_dict(PyObject *dict,
 	 * 10 chars is for register name.
 	 */
 	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
-	char bf[size];
+	char *bf = malloc(size);
 
 	regs_map(&sample->intr_regs, attr->sample_regs_intr, arch, bf, sizeof(bf));
 
@@ -775,6 +778,7 @@ static void set_regs_in_dict(PyObject *dict,
 
 	pydict_set_item_string_decref(dict, "uregs",
 			_PyUnicode_FromString(bf));
+	free(bf);
 }
 
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
-- 
2.41.0.rc0.172.g3f132b7071-goog

