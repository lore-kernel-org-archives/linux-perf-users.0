Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C071C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKHTAa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKHTAa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 14:00:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7A657D3
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 11:00:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 21so23973112edv.3
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Nov 2022 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDk0RSn7ZtHuL+0KnrS64+6CajwdImdu91s947j1YZQ=;
        b=i9WDRlhX7cjL1VQbCZLxBsroiV73Wbbt2MM8CBiSpJBNA/6mTurP/kDXTOwzSIc8ww
         AlPidMGkk2cnbyIwUSeZRZa3ISiNkb/liQgwWOLi0i7OL3fF7Il0QWFbpPU68K/Cu1Jo
         ZygMy5C+IcLZf0bfq1nHVHislFrLvpEmoUzXeG966vcuvrbTNR7C5Z6EVZdc2tPBjOPA
         aNDs+3oWS9rlwXj+OPc71yHS+4VwTHuUmakunFiXHpZvVrd8jTfwg8cBqjKPazISOqbC
         U+RDym8Y6t2iu3MomiuSknmItpaOlBAhfntXtf8hdnx6n3mEr0LKhWhhxVt1FYwixRQl
         v1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDk0RSn7ZtHuL+0KnrS64+6CajwdImdu91s947j1YZQ=;
        b=nviut24FeptTkXVQCJxWxbKLFdac1r7lmAtwBiV1c3wY1wSmz3J3AC3TK81rF6b6vG
         C5HogLaeteVOkvIiieZyYrwpMRr+LZuGFBpvFKkci4Xh8m5oTDDJlkU7WbmoWtl6TqU8
         aLpWKT2g05Fe1u9ebpW/9vjK/YbJP/J6ed43E2/mnSw4upnEN6QhaVPm0U5AJFwzKozq
         33RHUjCf6m30MmkeaV27V66nhvGRql+weBVrn5FzgMLICuVdvKxW+Ii96O1X+cVLUUJu
         ZqO/Kk0oZSV7a0OdCuuhsuo/Y2sOl2HLz0s8HVcDaqQwNzRDSGBcOyHOK51ZpfmN1y+Q
         y7Iw==
X-Gm-Message-State: ACrzQf3nfTkdBJSxQWLwjFOmwUKYi5R3UL1kZ++gYnlnpTmWoCmn3dOD
        Du1x069wyTC3WUJ/IAXZSgUY87q4Zmc=
X-Google-Smtp-Source: AMsMyM6beUY/7crJoHYJv6pXoi7rSOIRKreTzlwCQUeLDexSsSZVATpGN/1KX4u25jfPKSrQ0nbI+A==
X-Received: by 2002:a05:6402:2813:b0:461:e7bc:560a with SMTP id h19-20020a056402281300b00461e7bc560amr57637503ede.340.1667934027690;
        Tue, 08 Nov 2022 11:00:27 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-094-222-001-087.094.222.pools.vodafone-ip.de. [94.222.1.87])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm5898151eds.82.2022.11.08.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:00:27 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v1] perf data: Add fields when converting to json
Date:   Tue,  8 Nov 2022 20:00:19 +0100
Message-Id: <20221108190019.19265-1-9erthalion6@gmail.com>
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

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/util/data-convert-json.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 613d6ae82663..d30816eafb2f 100644
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
+		if (fields != NULL) {
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
2.27.0

