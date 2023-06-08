Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA0C7EE25
	for <linux-perf-users@archiver.kernel.org>; Thu,  8 Jun 2023 08:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjFHIpY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 04:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjFHIpO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Jun 2023 04:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DED1984
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686213867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fj2mCkYLNG5L67gHa0q5WGVDFbE4zI2Uml3ICcP6iqo=;
        b=e3XQ0HLJvuRC7iHySoyV1VQ4EElfznK5fSpIRb8n0+l7iHHWyBS2r4NfZAjtEYHWfakD/n
        txpFmJUt4Fm2S/FzFtcdoCSn2/L4iY+crLMlI/Qt5/nrfvyYQvbem7Rvajjl3Br2qTWxXP
        N9YVl8HGljRiLZRYAjtRUlkcZGCoudM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-7ktfpiYxMjyevyMBmDPXZQ-1; Thu, 08 Jun 2023 04:44:21 -0400
X-MC-Unique: 7ktfpiYxMjyevyMBmDPXZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76463802BF5;
        Thu,  8 Jun 2023 08:44:20 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C498C40CFD46;
        Thu,  8 Jun 2023 08:44:18 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2 0/2] perf tools: annotation browser from c2c tui
Date:   Thu,  8 Jun 2023 10:44:05 +0200
Message-Id: <20230608084407.140323-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These patches add ability to start annotation browser from c2c report
tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].

[1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/

v1->v2: Addressed comments from Namhyung Kim
- No longer saving evsel for each hist entry, using evlist__first
  instead.
- Factored out preparations to call annotation browser to do_annotate()
  function
- Other small fixes and adjustments.

Artem Savkov (2):
  perf util: move symbol__new_unresolved() to util/symbol.c
  perf tools: allow running annotation browser from c2c-report

 tools/perf/builtin-c2c.c       | 73 +++++++++++++++++++++++++++++++---
 tools/perf/ui/browsers/hists.c | 22 ----------
 tools/perf/util/symbol.c       | 22 ++++++++++
 tools/perf/util/symbol.h       |  1 +
 4 files changed, 91 insertions(+), 27 deletions(-)

-- 
2.40.1

