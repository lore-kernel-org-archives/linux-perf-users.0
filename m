Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE9C54E94
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 22:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjAXWpQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjAXWpO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 17:45:14 -0500
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 14:45:13 PST
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110CABBB2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 14:45:12 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1557F8C1411
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 22:35:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B0F388C0C92
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 22:35:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674599735; a=rsa-sha256;
        cv=none;
        b=bgyb15ENRL8H/hKQIgyM3uy4c98oMU3OIpe0NseqVOiVX6eRmxIBka1Z/8m4HBsRyLPl4H
        DZijtIvi0afmbrkU20LEiWH7P5e+9+jZK362LaE1YawmdCHVXyfxqgJIn2fDUOT9xc12nT
        VVF/9mLCA4bOgBSaciROkoSfjAzPSNiAQapce4qItbDs3/blqlojBPQAAygGd4auIz0RXW
        JIq+ZdcTB4sJbelrWp0HuUQM/TcyBKz/nM+BxAV0ZYq+fDH16j8AztI+lEK+5/DjTOKpFI
        FgS6PKifv4uQ2qoRrFVauP3iftpaVRqLM2qYDhzgcANwEzXJvSylYIsVdfOD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674599735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=0+ddPJb+zJ+MbSfxufS7SFMyh6w2pn/FBUTVrzUXLsI=;
        b=bQ36b3aedpyaEICveV1NwOczYCt8lx5ZXGPraTgFYplFX5pqDS7RM5z0xJHRFiXfK2TZFT
        DACNxTQlhc9N0G/Mv0K05G/45OXGeRjEEEQ5JaJv0U5UwMSrQhcWm+SlVy0vqvIEF4L10x
        ubs2fqEyF96GQ5fj37h2kys3Q36RE+WhElF/pqGdpCE9t3yNdISu69XxH2ejj9ERXERIZb
        UTMj2jU2WStVa6hvFCp6HiVKda9GbNpELX/O/UIoMDImRhjZRMOFsR9oqSR591ToUXx4nG
        xQTK+CUOAbVLD2Vul+Pfrccc4SywUrRXG6H6JJqMiABQQ1sVLBk0k6VRLFF4lQ==
ARC-Authentication-Results: i=1;
        rspamd-55978756d7-w5djg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Language-Lyrical: 2742c7562fc391f9_1674599735944_1554686273
X-MC-Loop-Signature: 1674599735944:1474463778
X-MC-Ingress-Time: 1674599735944
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.44 (trex/6.7.1);
        Tue, 24 Jan 2023 22:35:35 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4P1hd22XcPzkm
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1674599734;
        bh=0+ddPJb+zJ+MbSfxufS7SFMyh6w2pn/FBUTVrzUXLsI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AaFTNpWBxQPJHMXLLBcTebA4aRJ+hUQTYpRSjhlAoCif7jsgVkh9kEOwZKqCUGelU
         aHIvYUmHJnewioA+PH5fqjULC0J5dwyRj27/WY3+pR3HQHQwhNZ26U5kupPsTdZnpO
         pRCV0kL2OguWmeFyH5S6zk1T/OOUdvit4PtvxRdo=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e006a
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 24 Jan 2023 14:35:31 -0800
Date:   Tue, 24 Jan 2023 14:35:31 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/util: Symbol lookup can fail if multiple segmets match
 stext
Message-ID: <20230124223531.GB1962@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 tools/perf/util/symbol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..14ac4189eaff 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,10 +1368,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		u64 replacement_size = 0;
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			u64 new_size = new_map->end - new_map->start;
+
+			if (!(stext >= new_map->start && stext < new_map->end))
+				continue;
+
+			if (!replacement_map || new_size < replacement_size) {
 				replacement_map = new_map;
-				break;
+				replacement_size = new_size;
 			}
 		}
 	}
-- 
2.25.1

