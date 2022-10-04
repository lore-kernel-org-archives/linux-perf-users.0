Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB18CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 19:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJDTGX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 15:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDTGW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 15:06:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1638A3A
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664910381; x=1696446381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hoGq4ON4duNSnKqAnwwownd8hkmETxdtA5PK1fCjkWA=;
  b=lPdzzRfa+/jUZ9zJiOIiRVjFCAW32CzBnOIwqJCrTlex2W5z79st4VjF
   7HQxtgS+nVMd/M/3ISB0gP/ieCIKg3bjQdR6lgRB6j9jo4l5Jiha6efP+
   +VcCE/e8pwQabakzQwLy88iX+OeIAKi3qX4bboRqjD9gZlj2GvXjMGHVq
   ReWPoDz+u1gy7F6bZaGD2ZtpOroNZJJDkmthoKcOKR9xvt84M6dLoEwgc
   rvthjydO+F9PRstB4sbaG9+bxo094Knnip8SKMmaqqQ9FQrkyI2OVcUMs
   EXLwN0gE736GgV7djaHzYlcxUAOH4FMJl3a+lJKQwjpviK3n+sKjpfClv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="301722700"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="301722700"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:06:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="692612704"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="692612704"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:06:21 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf lzma: Quieten lzma warning
Date:   Tue,  4 Oct 2022 12:06:15 -0700
Message-Id: <20221004190615.998656-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On my Fedora system which is missing some modules I always get a long flood
of

lzma: fopen failed on /usr/lib/modules/5.3.9-300.fc31.x86_64/kernel/sound/pci/hda/snd-hda-codec.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.16.7-200.fc35.x86_64/kernel/sound/pci/hda/snd-hda-intel.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.1.11-200.fc29.x86_64/kernel/drivers/vhost/vhost_net.ko.xz: 'No such file or directory'

for each use of "perf list".

Disable the message.

Also I'm not sure why it's looking at the modules of each kernel, not
just the running one, but that's a different problem.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/lzma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
index 51424cdc3b68..ef0520c82245 100644
--- a/tools/perf/util/lzma.c
+++ b/tools/perf/util/lzma.c
@@ -44,11 +44,8 @@ int lzma_decompress_to_file(const char *input, int output_fd)
 	FILE *infile;
 
 	infile = fopen(input, "rb");
-	if (!infile) {
-		pr_err("lzma: fopen failed on %s: '%s'\n",
-		       input, strerror(errno));
+	if (!infile)
 		return -1;
-	}
 
 	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
 	if (ret != LZMA_OK) {
-- 
2.37.2

