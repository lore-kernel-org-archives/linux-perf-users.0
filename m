Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E1C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 11:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3615D6138E
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 11:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhHWLY2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:24:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3679 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhHWLY2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 07:24:28 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GtVFz1mGPz67kFq;
        Mon, 23 Aug 2021 19:22:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 23 Aug 2021 13:23:43 +0200
Received: from [10.47.87.96] (10.47.87.96) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 23 Aug
 2021 12:23:42 +0100
From:   John Garry <john.garry@huawei.com>
Subject: [Question] perf tools: lex parsing issue
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "irogers@google.com" <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Message-ID: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
Date:   Mon, 23 Aug 2021 12:27:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.96]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi jirka,

If you remember from some time ago we discussed how the lex parsing 
creates strange aliases:

https://lore.kernel.org/lkml/20200320093006.GA1343171@krava/

I am no expert on l+y, but it seems that we simply don't set the term 
config field for known term types. Well, not for 
PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD type anyway.

This super hack resolves that issue:

--->8----

--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -765,7 +765,12 @@ event_config ',' event_term
struct list_head *head = $1;
struct parse_events_term *term = $3

+ if (term->type_term == PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD) {
+ 	term->config = strdup("period");
+ }
+
if (!head) {
	parse_events_term__delete(term);
	YYABORT;
-- 

----8-----

So we get "umask=0x80,period=0x30d40,event=0x6" now, rather than 
"umask=0x80,(null)=0x30d40,event=0x6", for the perf_pmu_alias.str, as an 
example.

Did you ever get a chance to look into this issue? Do you know how could 
or should this field be set properly?

Some more background:
The reason I was looking at this is because I think it causes a problem 
for pmu-events (JSONs) aliasing for some PMUs. Specifically it's PMU 
which use "config=xxx" in sysfs files in 
/sys/bus/event_source/devices/PMUx/events/, rather than "event=xxx". The 
actual problem is that I trigger this warn in pmu.c:

static void perf_pmu_assign_str(char *name, const char *field, char 
**old_str,
char **new_str)
{

if (*new_str) { /* Have new string, check with old */
	if (strcasecmp(*old_str, *new_str))
		pr_debug("alias %s differs i ... <---

As I get "config=event=0xXXX" vs "config=(null)=0xXXX"

As I am not sure how to solve that yet, but, since we have 
config=(null), I thought it best to solve the first issue first.

Thanks,
John
