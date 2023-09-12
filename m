Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E5CA0EC3
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 13:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjILNfa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjILNfS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 09:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2147A26A3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694525606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6XfrFAlS9UKiyS7XvA0HLiPApT67DDlr8YGGnU6hK4g=;
        b=dbjNi6YM3xMbCrTf0al4Zw2SjBrYgQNeyNQxa93WWP9eU8Vy0/IEGCFghzz2PEuNP0QAjK
        Dv2ttbN0DUWil9vOhwqQWAq5tnp2KqT3JxH44F+rXn5oViD/q+bxgfdn+bfY1zZcf86YSc
        J0kMcRr+0l2QLmOGivgPesEDqYrA0OE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-qdCwfTzeOPW5mA_0eXQZnQ-1; Tue, 12 Sep 2023 09:33:22 -0400
X-MC-Unique: qdCwfTzeOPW5mA_0eXQZnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FAB53C0EAA2;
        Tue, 12 Sep 2023 13:33:22 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F4A921B2413;
        Tue, 12 Sep 2023 13:33:20 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        ravi.bangoria@amd.com
Cc:     peterz@infradead.org, namhyung@kernel.org, sandipan.das@amd.com
Subject: [PATCH] perf/x86/amd/core: Rename branch-brs event to not break the parser
Date:   Tue, 12 Sep 2023 15:33:18 +0200
Message-Id: <20230912133318.18103-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The problem is described in detail in 146edff3d7ed ("perf test: Parse
events workaround for dash/minus"). In short, although perf-list offers
"branch-brs" event to be used, when used with "-e" switch, the parser
does not accept it and needs to be enclosed to "cpu//", such as:

```
  $ perf stat -e branch-brs true
  event syntax error: 'branch-brs'
                             \___ parser error

  $ perf stat -e cpu/branch-brs/ true

   Performance counter stats for 'true':

              46,179      cpu/branch-brs/
```

This is confusing for the users.

Rename the event using underscore instead of dash to avoid the problem.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..f4c5d4100035 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1286,21 +1286,21 @@ amd_branches_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 }
 
 static struct attribute_group group_caps_amd_branches = {
 	.name  = "caps",
 	.attrs = amd_pmu_branches_attrs,
 	.is_visible = amd_branches_is_visible,
 };
 
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
-EVENT_ATTR_STR(branch-brs, amd_branch_brs,
+EVENT_ATTR_STR(branch_brs, amd_branch_brs,
 	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
 
 static struct attribute *amd_brs_events_attrs[] = {
 	EVENT_PTR(amd_branch_brs),
 	NULL,
 };
 
 static umode_t
 amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-- 
2.18.4

