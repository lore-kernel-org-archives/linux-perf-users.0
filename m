Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516D5C6FA90
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiIZQGM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiIZQFp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 12:05:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2927DC8407;
        Mon, 26 Sep 2022 07:53:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 137C41042;
        Mon, 26 Sep 2022 07:53:30 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.0.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC1C43F66F;
        Mon, 26 Sep 2022 07:53:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tests: Fix SafeConfigParser deprecation warning
Date:   Mon, 26 Sep 2022 15:53:14 +0100
Message-Id: <20220926145314.226590-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The following command:

  perf test attr -vvv

Results in this deprecation warning:

  ./tests/attr.py:142: DeprecationWarning: The SafeConfigParser class
  has been renamed to ConfigParser in Python 3.2. This alias will be
  removed in future versions. Use ConfigParser directly instead.

The last Python 3.2 release was in 2013 and Rhel-6 has Python 3.3 so I
think it's safe to make the replacement now.

Tested with Python 3.8

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index cb39ac46bc73..6d9b5312e6c2 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -139,7 +139,7 @@ class Event(dict):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = configparser.SafeConfigParser()
+        parser = configparser.ConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -198,7 +198,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = configparser.SafeConfigParser()
+        parser_event = configparser.ConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -212,7 +212,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = configparser.SafeConfigParser()
+                parser_base = configparser.ConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
-- 
2.28.0

