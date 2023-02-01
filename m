Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CCC636D4
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 21:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBAVu3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVu2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 16:50:28 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE91CA34;
        Wed,  1 Feb 2023 13:50:25 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BA9EF240006;
        Wed,  1 Feb 2023 21:50:20 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 0/2] Script style improvements in lib/coresight.sh
Date:   Wed,  1 Feb 2023 22:49:43 +0100
Message-Id: <20230201214945.127474-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These 2 patches improve the efficiency and quality of the
lib/coresight.sh script.

The first one uses grep's `-c` parameter to count the results instead of
piping it to `wc -l`.
The second one replaces the use of backticks (`...`) with $(...) as the
former has several potential issues while the latter does not.

Diederik de Haas (2):
  perf test: Replace 'grep | wc -l' with 'grep -c'
  perf test: Replace legacy `...` with $(...)

 tools/perf/tests/shell/lib/coresight.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.39.1

