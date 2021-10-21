Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125A560C4D
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJUL3i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 07:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhJUL3e (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 07:29:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1820AED1;
        Thu, 21 Oct 2021 04:27:18 -0700 (PDT)
Received: from e121896.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A33C03F73D;
        Thu, 21 Oct 2021 04:27:16 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     denik@chromium.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix /proc/kcore access on 32 bit systems
Date:   Thu, 21 Oct 2021 12:27:00 +0100
Message-Id: <20211021112700.112499-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Because _LARGEFILE64_SOURCE is set in perf, file offset sizes can be
64 bits. If a workflow needs to open /proc/kcore on a 32 bit system
(for example to decode Arm ETM kernel trace) then the size value will be
wrapped to 32 bits in the function file_size() at this line:

  dso->data.file_size = st.st_size;

Setting the file_size member to be u64 fixes the issue and allows
/proc/kcore to be opened.

Reported-by: Denis Nikitin <denik@chromium.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/dso.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 83723ba11dc8..011da3924fc1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -193,7 +193,7 @@ struct dso {
 		int		 fd;
 		int		 status;
 		u32		 status_seen;
-		size_t		 file_size;
+		u64		 file_size;
 		struct list_head open_entry;
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_offset;
-- 
2.28.0

