Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C841C27C76
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Jan 2023 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjAYSmg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 13:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYSmO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Jan 2023 13:42:14 -0500
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A27045BF2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 10:42:13 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2F233261B75
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 18:34:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AD0C5261C1A
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 18:34:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674671660; a=rsa-sha256;
        cv=none;
        b=0luErxAMt3W3ZSOvJyiv3FsI+fhutYfPb3GZHOnpa7Sa+/JE4Mkh6rpFsZkp+1eB5LUsUO
        PTcGnQ8nOQ6IbopCl+v4gSjJcl/kaO+sfbX0ukokfhHVZB55xzvhykhj7RC5lSXA7STLMU
        GcjjB4JVLElqycqi6c/6+g+EW/uDi0jSZaoGYKl9Oy5m1y54XL+vrMfGK8XDQQfyAL1dtu
        Q/eiPTdjzTUreQxr8PSXhQ5Hen/k/lzJvJxVXWugoEAyRoxLFcYvh5WxIHketgw0nV79Jf
        2eeJpvUbOZJ5CPJqWao/C41lySlw6aDZkoN5DMYOg8UYTlTcl5k81spIylB2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674671660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LkeKleEDMVCNjKIW3DlOQ6z6V0h2UxZNTVRuJ7I3Uy8=;
        b=9b+dRayTVO5vP+Ooh/SVmg1/2w3VDFte7IS3TN7QPedXbakdR/OPXkEQDbpbdzNtOd3zKk
        AXAMeuvi6VKPpnoWFi5ggaF+7GjhCgDgjArMXcwnABoS8VCyesgfz3sTaJr9DUV+Stqb2g
        Ti+HzuwnjgBpspPbZu/Q8km/3Vh5CI2WUOfK2hCbJbNnuydC9oT0X1rqmLEEHAAueReaix
        bfY+mrTvVQOh6CQ44mQ0aXDuNTTqL//r+Ex61odOaJH3rzA2i2e8i7uU/5jIolIX4K1t4M
        Wyv1n0AON9PJgXXJX1+D12mAJvdosyDWf526pBS4Unvd2PvCpCLPY2eeWovv4A==
ARC-Authentication-Results: i=1;
        rspamd-65f5b7cf85-mb8bs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-White-Industry: 36124741546cf338_1674671660973_2937313759
X-MC-Loop-Signature: 1674671660973:3685007118
X-MC-Ingress-Time: 1674671660973
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.99 (trex/6.7.1);
        Wed, 25 Jan 2023 18:34:20 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4P2CDD23QfzRn
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Jan 2023 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1674671660;
        bh=LkeKleEDMVCNjKIW3DlOQ6z6V0h2UxZNTVRuJ7I3Uy8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=A8KtaZKkUDU0VW7aIb+A21v1hNAq7FyF4xiS1eKqVQk6vPU1pXyTxmJU9gWvgmZqx
         OjDqxyi79pRvB7gFUN/YSUa4QXEzipJyUuzJtWNxbeSWC+a9CeJku6mn2AxP7S8xU6
         C3EA/6ipl+na3DRKPqwSFTFHVdzkUQe9aiUjbYBE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e2
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 25 Jan 2023 10:34:18 -0800
Date:   Wed, 25 Jan 2023 10:34:18 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>
Subject: [PATCH v2] perf/util: Symbol lookup with kcore can fail if multiple
 segments match stext
Message-ID: <20230125183418.GD1963@templeofstupid.com>
References: <20230124223531.GB1962@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124223531.GB1962@templeofstupid.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This problem was encountered on an arm64 system with a lot of memory.
Without kernel debug symbols installed, and with both kcore and kallsyms
available, perf managed to get confused and returned "unknown" for all
of the kernel symbols that it tried to look up.

On this system, stext fell within the vmalloc segment.  The kcore symbol
matching code tries to find the first segment that contains stext and
uses that to replace the segment generated from just the kallsyms
information.  In this case, however, there were two: a very large
vmalloc segment, and the text segment.  This caused perf to get confused
because multiple overlapping segments were inserted into the RB tree
that holds the discovered segments.  However, that alone wasn't
sufficient to cause the problem. Even when we could find the segment,
the offsets were adjusted in such a way that the newly generated symbols
didn't line up with the instruction addresses in the trace.  The most
obvious solution would be to consult which segment type is text from
kcore, but this information is not exposed to users.

Instead, select the smallest matching segment that contains stext
instead of the first matching segment.  This allows us to match the text
segment instead of vmalloc, if one is contained within the other.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
v2:
  - Correct whitespace, add comments, and fix-up subject. (Feedback from Adrian
    Hunter)
---
 tools/perf/util/symbol.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..98014f937568 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,10 +1368,23 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		u64 replacement_size = 0;
+
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			u64 new_size = new_map->end - new_map->start;
+
+			if (!(stext >= new_map->start && stext < new_map->end))
+				continue;
+
+			/*
+			 * On some architectures, ARM64 for example, the kernel
+			 * text can get allocated inside of the vmalloc segment.
+			 * Select the smallest matching segment, in case stext
+			 * falls within more than one in the list.
+			 */
+			if (!replacement_map || new_size < replacement_size) {
 				replacement_map = new_map;
-				break;
+				replacement_size = new_size;
 			}
 		}
 	}
-- 
2.25.1

