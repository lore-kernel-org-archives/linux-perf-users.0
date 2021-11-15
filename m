Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1BDC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841536137B
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhKOMmJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 07:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKOMmF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 07:42:05 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Nov 2021 04:39:06 PST
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343AC061570
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Nov 2021 04:39:05 -0800 (PST)
Received: from vla1-a78d115f8d22.qloud-c.yandex.net (vla1-a78d115f8d22.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:2906:0:640:a78d:115f])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C67542E0A49;
        Mon, 15 Nov 2021 15:36:59 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-a78d115f8d22.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id R6fiPkel6m-axsiSKon;
        Mon, 15 Nov 2021 15:36:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1636979819; bh=WeD0Jx6jb58Og4dG/gGc7oe0t+qBbAbV4+yW7cMyObk=;
        h=Cc:Date:Subject:To:From:Message-Id;
        b=rv4G54xDJtEY7Nq9va6hxkB+bveGXxOsi34siI07EKLrDrtVlgDe8rv2y+JVtaZuQ
         CmTw8IoQ0N6aFwve7jKveihRq8lhZOa3KIFusR1jUzWf64AWx2bpI9SR3hUOsNwaDh
         trC8EJFU8DWSTsps4maBD9zHMC1Vc9n1+xcu5ILA=
Authentication-Results: vla1-a78d115f8d22.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from oleglatin-nix.yandex.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c367:9f24:3433:3e57])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPS id N1AtIpsZFc-axwK3sCK;
        Mon, 15 Nov 2021 15:36:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Oleg Latin <oleglatin@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmtrmonakhov@yandex-team.ru
Subject: [PATCH] perf: add event name to json output
Date:   Mon, 15 Nov 2021 15:36:29 +0300
Message-Id: <20211115123632.150711-1-oleglatin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After converting perf.data to json it missing event name entry.

In perf script output it is clear that events have different types:

    $ perf script -F -ip
    ...
    dd 130321 [001] 10282.698083:     117995       cycles:
    dd 130321 [001] 10282.698091:     225856 instructions:
    ...

But json output lack of this information and it hard to distinguish
different event types:

    ...
    {
        "timestamp": 10282698083472,
        "pid": 130321,
        "tid": 130321,
        "comm": "dd",
        "callchain": [
            {
                "ip": "0xffffffff901f4cd5",
                "symbol": "syscall_exit_to_user_mode",
                "dso": "[kernel.kallsyms]"
            }
        ]
    },
    {
        "timestamp": 10282698091328,
        "pid": 130321,
        "tid": 130321,
        "comm": "dd",
        "callchain": [
            {
                "ip": "0x7fb7f0c271e7",
                "symbol": "__GI___libc_write",
                "dso": "libc-2.31.so"
            }
        ]
    },
    ...

This patch adds event name entry to resulting json.

Signed-off-by: Oleg Latin <oleglatin@yandex-team.ru>
---
 tools/perf/util/data-convert-json.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index b0e3d69c6835..72aaf6babc22 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -168,6 +168,9 @@ static int process_sample_event(struct perf_tool *tool,
 	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
 	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
 
+	if (evsel->name)
+		output_json_key_string(out, true, 3, "event", evsel->name);
+
 	if (al.cpu >= 0)
 		output_json_key_format(out, true, 3, "cpu", "%i", al.cpu);
 
-- 
2.25.1

