Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D103C05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjATNli (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 08:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjATNlh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 08:41:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2E5421A
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674222049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tQ8W8SPPlCoUCN3wenGWtKLQcEnJNAQjktmRuE7o6pM=;
        b=H9/YSqfcXS6gB6XJjWq/yZkG49IDTAakjDXn7mc/v8nxsKYu2BPWJjaEPGyvj96lQr8PFe
        Q1s+wbom+vXGG40QdzihbYYRUvBOtRwmEu6fo84Q01gjP+Nca9eWZ/NjRNmDUhJhIBWB0w
        SZHcFWoaRoKlT1PUCymZzM5X/75VolM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-XU9SgbAbNk-QNJwRguIt3Q-1; Fri, 20 Jan 2023 08:40:47 -0500
X-MC-Unique: XU9SgbAbNk-QNJwRguIt3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE70E29DD998;
        Fri, 20 Jan 2023 13:40:46 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE3B2166B2A;
        Fri, 20 Jan 2023 13:40:44 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     acme@redhat.com, qzhao@redhat.com, cjense@google.com
Subject: [PATCH 2/2] perf test: Fix JSON format linter test checks
Date:   Fri, 20 Jan 2023 14:40:39 +0100
Message-Id: <20230120134039.17788-3-mpetlan@redhat.com>
In-Reply-To: <20230120134039.17788-1-mpetlan@redhat.com>
References: <20230120134039.17788-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The test fails on CPUs with topdown metrics, where it is common to print
two metrics per line. Since these are included in default event set for
`perf stat -- something`, it causes the "no args" subtest to fail due to
unexpected member count. We need to accept 7 or 9 members in that case.

Coming to that, counting commas in the JSON line and consider it a number
of elements is incorrect and misleading. There should be +1 element than
the count of commas, while also, commas can potentially appear in the
event names. Count " : " substrings rather, since these better fit to
what should be actually counted.

Fixes: 0c343af2a2f8 ("perf test: JSON format checking")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../tests/shell/lib/perf_json_output_lint.py     | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index d90f8d102eb9..4f1bbb3f07ec 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -40,17 +40,17 @@ def is_counter_value(num):
   return isfloat(num) or num == '<not counted>' or num == '<not supported>'
 
 def check_json_output(expected_items):
-  if expected_items != -1:
+  if expected_items:
     for line in Lines:
       if 'failed' not in line:
         count = 0
-        count = line.count(',')
-        if count != expected_items and count >= 1 and count <= 3 and 'metric-value' in line:
+        count = line.count(' : ')
+        if count not in expected_items and count >= 2 and count <= 4 and 'metric-value' in line:
           # Events that generate >1 metric may have isolated metric
           # values and possibly other prefixes like interval, core and
           # aggregate-number.
           continue
-        if count != expected_items:
+        if count not in expected_items:
           raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                              f' in \'{line}\'')
   checks = {
@@ -82,14 +82,14 @@ def check_json_output(expected_items):
 
 try:
   if args.no_args or args.system_wide or args.event:
-    expected_items = 6
+    expected_items = [7, 9]
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
-    expected_items = 7
+    expected_items = [8, 10]
   elif args.per_core or args.per_socket or args.per_node or args.per_die:
-    expected_items = 8
+    expected_items = [9, 11]
   else:
     # If no option is specified, don't check the number of items.
-    expected_items = -1
+    expected_items = []
   check_json_output(expected_items)
 except:
   print('Test failed for input:\n' + '\n'.join(Lines))
-- 
2.18.4

