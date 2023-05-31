Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04991C7EE32
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 May 2023 11:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjEaLvf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 May 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjEaLvS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 May 2023 07:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9401E8
        for <linux-perf-users@vger.kernel.org>; Wed, 31 May 2023 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685533832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uBfJqBxSH/96EhXdOTadQ71az9HOT1CZWpJefAbLQ7Q=;
        b=CZzVAyIfjtnUDofhISfdcBlQ1T4eiDFMzY+QYVjDYznxRnYs+jLJSfG8uXHfhh+rhJ9pK5
        VzsHZ2p7abIEQDUWTtVQkutRXFqWixP0RX8GCjwyEnBtb8ZkyZ3J2atuv7StLEfnLmhrU/
        bAJUjWH02J6EcAHkz6xgNiDiLX2yKa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-B5gnuG_mNCmxVPX-_VAmEw-1; Wed, 31 May 2023 07:50:29 -0400
X-MC-Unique: B5gnuG_mNCmxVPX-_VAmEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CC7B85A5AA;
        Wed, 31 May 2023 11:50:29 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 896FC40CFD45;
        Wed, 31 May 2023 11:50:27 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 0/2] perf tools: annotation browser from c2c tui
Date:   Wed, 31 May 2023 13:50:12 +0200
Message-Id: <20230531115014.161454-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These patches add ability to start annotation browser from c2c report
tui. The idea comes from Arnaldo's "Profiling Data Structures" talk [1].

[1]: http://vger.kernel.org/~acme/prez/linux-plumbers-2022/

Artem Savkov (2):
  perf util: move symbol__new_unresolved() to util/symbol.c
  perf tools: allow running annotation browser from c2c-report

 tools/perf/builtin-c2c.c       | 76 +++++++++++++++++++++++++++++++---
 tools/perf/ui/browsers/hists.c | 22 ----------
 tools/perf/util/symbol.c       | 22 ++++++++++
 tools/perf/util/symbol.h       |  1 +
 4 files changed, 94 insertions(+), 27 deletions(-)

-- 
2.40.1

