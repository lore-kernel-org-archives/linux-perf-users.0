Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B41C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F200661503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhKHNnm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNnm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AX20VMIyxKyx4eOSkBs3U7iabi8dvdlAgohi7haU4sc=;
        b=OXplyXsK7O6ro79DCukjxtt6/wxPFzKPFklCOVck/Py3iW+3eHwJVvT9azKWYvb7zKrD73
        JXKV+U6gJFhbtOaBmT9ZTrGAv7uqzAd2fma6LgZurOBJ6ehj4Ets0oKYY5IQifSZ5vutMe
        JsNGiVGPtYPg/NdVUGf7NCOVU0Eiu4s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-mQWuQ3RIN42vk7ln5bn3Sg-1; Mon, 08 Nov 2021 08:40:56 -0500
X-MC-Unique: mQWuQ3RIN42vk7ln5bn3Sg-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso2775047wms.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AX20VMIyxKyx4eOSkBs3U7iabi8dvdlAgohi7haU4sc=;
        b=xNKS7Ph/p43dxfuL826P1pQnYtJRwU2Ngz92TbqSqkzRg0JKj3e6BQ+5WCw5uYlB4q
         BvPAN1wBx4dWBxj6NbJuxeZqH6jPrsp7AuezcD6NphoFF5oy9AoEhXtg/UBKakeqVgsY
         8LxyXLsyuQm5ybMYM5ZkTjOc4OEgsdnRbfsWf/ihpBOgszDjdbxtyunTpdOhmNZtMAih
         DL5B6A8vtsTDf8i63lWp2zbwE9XtWzTItcCRoDHK1Ejv6KEk31BdKD1lUdViMU5HDbyh
         4h3plHDQuKJXgsTdnSnNDmILICM9hOJhpxc/9MR2ACPg+ewYiRLv6MDFkhny/f3Fo+PD
         BxNg==
X-Gm-Message-State: AOAM530iyZBEa/YXGpc4uw8rE1NOiaI9Y/v+0BX81xBvkfGx3ocahGTl
        y0nwlSXzaYreoiUXlArNMejbf22yAy0KZLmH7+mz/BA1ZQ3I+spBvgAoCXMQ9VVhsU+CKR5rkLz
        I5+ke2eT7b4LYu3lU4TIVo2lBL4CanA==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr31622292wmm.5.1636378855019;
        Mon, 08 Nov 2021 05:40:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6RdilUbUdHaQNbD8fqWi1qSdp3GpfKXqj/WQoFgwTIDP/k6SwlVADzRxEExrnuH6mCkotzA==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr31622267wmm.5.1636378854880;
        Mon, 08 Nov 2021 05:40:54 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm16688866wrv.42.2021.11.08.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:54 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 36/59] perf tools: Make parse_events__modifier_event work over perf_evsel
Date:   Mon,  8 Nov 2021 14:36:47 +0100
Message-Id: <20211108133710.1352822-37-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Making parse_events__modifier_event work over perf_evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 1e3ec927545e..41615c6e9871 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1770,22 +1770,22 @@ struct event_modifier {
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
-			       struct evsel *evsel)
-{
-	int eu = evsel ? evsel->core.attr.exclude_user : 0;
-	int ek = evsel ? evsel->core.attr.exclude_kernel : 0;
-	int eh = evsel ? evsel->core.attr.exclude_hv : 0;
-	int eH = evsel ? evsel->core.attr.exclude_host : 0;
-	int eG = evsel ? evsel->core.attr.exclude_guest : 0;
-	int eI = evsel ? evsel->core.attr.exclude_idle : 0;
-	int precise = evsel ? evsel->core.attr.precise_ip : 0;
+			       struct perf_evsel *evsel)
+{
+	int eu = evsel ? evsel->attr.exclude_user : 0;
+	int ek = evsel ? evsel->attr.exclude_kernel : 0;
+	int eh = evsel ? evsel->attr.exclude_hv : 0;
+	int eH = evsel ? evsel->attr.exclude_host : 0;
+	int eG = evsel ? evsel->attr.exclude_guest : 0;
+	int eI = evsel ? evsel->attr.exclude_idle : 0;
+	int precise = evsel ? evsel->attr.precise_ip : 0;
 	int precise_max = 0;
 	int sample_read = 0;
-	int pinned = evsel ? evsel->core.attr.pinned : 0;
-	int exclusive = evsel ? evsel->core.attr.exclusive : 0;
+	int pinned = evsel ? evsel->attr.pinned : 0;
+	int exclusive = evsel ? evsel->attr.exclusive : 0;
 
 	int exclude = eu | ek | eh;
-	int exclude_GH = evsel ? evsel->core.exclude_GH : 0;
+	int exclude_GH = evsel ? evsel->exclude_GH : 0;
 	int weak = 0;
 	int bpf_counter = 0;
 
@@ -1893,7 +1893,7 @@ static int check_modifier(char *str)
 
 int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 {
-	struct evsel *evsel;
+	struct perf_evsel *evsel;
 	struct event_modifier mod;
 
 	if (str == NULL)
@@ -1905,26 +1905,26 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 	if (!add && get_event_modifier(&mod, str, NULL))
 		return -EINVAL;
 
-	__evlist__for_each_entry(list, evsel) {
+	__perf_evlist__for_each_entry(list, evsel) {
 		if (add && get_event_modifier(&mod, str, evsel))
 			return -EINVAL;
 
-		evsel->core.attr.exclude_user   = mod.eu;
-		evsel->core.attr.exclude_kernel = mod.ek;
-		evsel->core.attr.exclude_hv     = mod.eh;
-		evsel->core.attr.precise_ip     = mod.precise;
-		evsel->core.attr.exclude_host   = mod.eH;
-		evsel->core.attr.exclude_guest  = mod.eG;
-		evsel->core.attr.exclude_idle   = mod.eI;
-		evsel->core.exclude_GH          = mod.exclude_GH;
-		evsel->core.sample_read         = mod.sample_read;
-		evsel->core.precise_max         = mod.precise_max;
-		evsel->core.weak_group          = mod.weak;
-		evsel->core.bpf_counter	        = mod.bpf_counter;
-
-		if (evsel__is_group_leader(evsel)) {
-			evsel->core.attr.pinned = mod.pinned;
-			evsel->core.attr.exclusive = mod.exclusive;
+		evsel->attr.exclude_user   = mod.eu;
+		evsel->attr.exclude_kernel = mod.ek;
+		evsel->attr.exclude_hv     = mod.eh;
+		evsel->attr.precise_ip     = mod.precise;
+		evsel->attr.exclude_host   = mod.eH;
+		evsel->attr.exclude_guest  = mod.eG;
+		evsel->attr.exclude_idle   = mod.eI;
+		evsel->exclude_GH          = mod.exclude_GH;
+		evsel->sample_read         = mod.sample_read;
+		evsel->precise_max         = mod.precise_max;
+		evsel->weak_group          = mod.weak;
+		evsel->bpf_counter         = mod.bpf_counter;
+
+		if (perf_evsel__is_group_leader(evsel)) {
+			evsel->attr.pinned = mod.pinned;
+			evsel->attr.exclusive = mod.exclusive;
 		}
 	}
 
-- 
2.31.1

