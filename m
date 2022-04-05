Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Apr 2022 05:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiDEFGC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDEFGA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Apr 2022 01:06:00 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2825280
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Apr 2022 22:04:02 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id n5so11353990vsc.4
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Apr 2022 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZaaQIE1WxgclIP9vFhosogYQIYhUP2lfYu8ALVET0+U=;
        b=mQzKnyc75DwjVFsXsjvUiqESFkK/AmYyphG04ncMSl+WHwWvtKyruFPvGh4gOe1ctQ
         lCN1MWvG1dTLyNcV6ieH+LjndyiBDW/Vd9H+pPkhXTKHS/iKYR0ptFIJgRigwQcwDGzE
         tz65ATqD+CrBNCiJB+6DHDp8INcKnn0SBdQ/z4RiJxQbxE5hGBrq8fyVZ21BvfkHHMd8
         461uSIms2jISne4C9fFPiYV6IwL0tugzkKbvO9d6pz0OmJcdC/GPDKmhXSRAQvjbZ4jp
         R3SGZRPnD6rR6tCYYZK7+dpZs9c3jdC85tJyFUMpJBKD4kWR9fjgP18VmdIlIb6t5B9k
         kx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZaaQIE1WxgclIP9vFhosogYQIYhUP2lfYu8ALVET0+U=;
        b=7MatwphgWv6xHdMdcNAPY8W5TQ/RDQlzalnrqno3OTiUZIADaWNHujq+lD54HgpSDv
         3hHmmG9wXNEdDn35xXa91xKvGLeTZYYEB1lbws9rRPOm7EHE4+jeju30h5XNbzw9KIOi
         QCximiPxY4/jV4bcpcL/nkc152SLbx6ymuqwndmcGw9QThvFO/KsnuUjyL/EvKd5uNqV
         O+AdiU673gT9coslP/8tSHnzFD2rmRgGbUVyEVkh/BJvavlt2p1PJzOUynk6Uk7EeAka
         sgx5iS7E8pmdzqopdSefO5eCfAxOQUVXNWtgeblMf8JFpvj98otNPFZGqyNgWAsNAtuh
         54LQ==
X-Gm-Message-State: AOAM53191rw0TsN0QKoLqVhnC3FivdbMHc9GdOwCzk5V4AagU9vT9VII
        XV0PYagqYwxlaPKK/+YR3ECnliN/MzB6BRXN6BqOPi7eGYU=
X-Google-Smtp-Source: ABdhPJyr82ynvAurc1jf3Wps4Y9zpKBTXAyG62vF9Q0ey1bEiBzdvgg/r+beUhITL5SbqCO/hV8MHYrrXSzcfOdCsx0=
X-Received: by 2002:a67:f601:0:b0:325:5b5d:d1d6 with SMTP id
 k1-20020a67f601000000b003255b5dd1d6mr516117vso.4.1649135041701; Mon, 04 Apr
 2022 22:04:01 -0700 (PDT)
MIME-Version: 1.0
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Mon, 4 Apr 2022 22:03:51 -0700
Message-ID: <CAPS78ppA6jg2MM=17cyEi1NvbcH1mP3V-dmTSC83VsLtGg5dgg@mail.gmail.com>
Subject: [PATCH] perf tools/perf/python/tracepoint.py: Added comments and
 sample output
To:     linux-perf-users@vger.kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        arnaldo.melo@gmail.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
I have added some comments and one sample output for the tracepoint.py file.

Signed-off-by: Tanusree Debnath <tanu235m@gmail.com>

---
tools/perf/python/tracepoint.py | 16 ++++++++++++++++
1 file changed, 16 insertions(+)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index bba68a6d451..9392dee199a 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -14,6 +14,22 @@ class tracepoint(perf.evsel):
freq = 0, sample_period = 1, wakeup_events = 1,
sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU |
perf.SAMPLE_RAW | perf.SAMPLE_TIME)
+
+'''
+Prints sampled time, command, pid, priority, state of previous event and
+command, priority, pid of next event.
+
+Command to run:
+sudo perf script -s tracepoint.py -i perf.data
+
+Example output:
+
+time 656699805729247 prev_comm=perf prev_pid=174965 prev_prio=120
prev_state=0x1 ==> next_comm=swapper/4 next_pid=0 next_prio=120
+time 656699805736173 prev_comm=swapper/4 prev_pid=0 prev_prio=120
prev_state=0x0 ==> next_comm=perf next_pid=174965 next_prio=120
+time 656699805778216 prev_comm=perf prev_pid=174965 prev_prio=120
prev_state=0x1 ==> next_comm=swapper/4 next_pid=0 next_prio=120
+
+'''
+
def main():
tp = tracepoint("sched", "sched_switch")
cpus = perf.cpu_map()
-- 
2.25.1
