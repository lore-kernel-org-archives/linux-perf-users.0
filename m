Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5CDC43217
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 10:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKIKjp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKIKjo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 05:39:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C51CFCF
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 02:39:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bs21so25114555wrb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dR3cBGwI6tyesmJbjauTaf6DUSEm8DN9qJcNBBjh/so=;
        b=JE1uWUK27UrW5sYBArg8DgNY5YzkxXgaDek/yDxHwnYrWgF2lJJEdHRKJQAmOeT89u
         qlWmEiWTADTJ+SLoGvL4psLbmLZRLFrJPjJcId0Jn0j+WOnITGcmqMmOGJoKhIG9EKON
         6kUGvpDw7Xru+xyJGaBAEaimxjCusv+CKHBsbQWbTPXmqAopRxnt9Plt7wHr3W7yWYDM
         GEvFVPtmENCsOi6W4PIi6XM9XZsLrzk3V4MFUgH75BDt/ycJc1CbQpOD8APW+SXLXHYF
         BkjETEwBBaQBRyhX48NcY0dXo3gaAJX0RoFYxKr2H+i4fwdrReFt9GLn44485UTq2TJ0
         wo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dR3cBGwI6tyesmJbjauTaf6DUSEm8DN9qJcNBBjh/so=;
        b=c5KLPSTGCmNtzNw1USg1O9vEeYe39DOsWA2EKgkaEaryQaZM1+BhGrqkoL5P54ec4V
         CmWV8Yq6Zhyz1tfuGnLcpSE71tql+6TPJjTySwPgI/NfvLe2oUiqBjXYrSpkkGWpr1/L
         YgjigrjLCy1+Ibz1xKXetht3PLyuZRuI988yc8jhaRxCfYQHHz9PPihhzBLjxvxW5dNG
         CN7AvGeU28J2EaQG3p9F2TLN5TjhWlUPLcbFRa+Cdght5eWmQB1rRStqpfYzNHmJ0MT+
         1Whsqn6fZtiescQuCII0W4im8/yg41nXAtYzaYDdNl9TIvBWpFxCjnTkA6lxhYDCaXxL
         i+gA==
X-Gm-Message-State: ACrzQf1SwgosXsax3QEGcC74ZRUNRccurbJUsMHfdR8PoP88+ngJybX+
        ggWEk9UO7AJKBraIHKFixi6dw54rJZPRUQ==
X-Google-Smtp-Source: AMsMyM7dleWmqKRZoavjy9ugJBkFJMUAfbF5WTuKX2sMVrq0ImhttjsiWcq6zsEe1QcWHPLPRNoy+g==
X-Received: by 2002:a05:6000:1143:b0:236:5ede:cdad with SMTP id d3-20020a056000114300b002365edecdadmr39016145wrx.410.1667990381646;
        Wed, 09 Nov 2022 02:39:41 -0800 (PST)
Received: from ddolgov.local (dslb-094-222-001-087.094.222.pools.vodafone-ip.de. [94.222.1.87])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b003cf5ec79bf9sm1156101wmk.40.2022.11.09.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:39:41 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        irogers@google.com, Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH v2] perf data: Add fields when converting to json
Date:   Wed,  9 Nov 2022 11:39:32 +0100
Message-Id: <20221109103932.65675-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When converting recorded data into json format, perf data omits probe
variables. Add them to the output in the format "field name": "field value"
using tep_print_field:

    $ perf data convert --to-json output.json

    // output.json
    {
        "linux-perf-json-version": 1,
        "headers": { ... },
        "samples": [
            {
            "timestamp": 29182079082999,
            "pid": 309194,
                    [...]
            "__probe_ip": "0x93ee35",
            "query_string_string": "select 2;",
            "nxids": "0"
            }
        ]
    }

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v2:
    - Slight improvement of fields condition

 tools/perf/util/data-convert-json.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 613d6ae82663..57db59068cb6 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -217,6 +217,26 @@ static int process_sample_event(struct perf_tool *tool,
 	}
 	output_json_format(out, false, 3, "]");
 
+	if (sample->raw_data) {
+		int i;
+		struct tep_format_field **fields;
+
+		fields = tep_event_fields(evsel->tp_format);
+		if (fields) {
+			i = 0;
+			while (fields[i]) {
+				struct trace_seq s;
+
+				trace_seq_init(&s);
+				tep_print_field(&s, sample->raw_data, fields[i]);
+				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
+
+				i++;
+			}
+			free(fields);
+		}
+	}
+
 	output_json_format(out, false, 2, "}");
 	return 0;
 }
-- 
2.31.1

