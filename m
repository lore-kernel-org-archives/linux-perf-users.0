Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F0C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 06:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiC1GKh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiC1GKg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 02:10:36 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4469E17066
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2022 23:08:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m184so14539768vsm.12
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2022 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c4Kli4Bm4ZJjhE8y+bsYiWkPFSF4bxftqpOOEIMMA9I=;
        b=VfysOgUFlvW+tAoplmlK3sfdwVPgzDI/BRkX02m56Mzw5TEascbKfID4O3VUBpvQQ7
         5GRRoyC3w9cC9SQn4KFpvbrxeHoqI6/Iq2fxIsGlHqVxTl6VPaPaW8lUIiOjBfN0lpRl
         28R0+F7O6G1Z2gGiltrL8VyxrA27lS3f1boVdNbIwoYXXZ3VptFR3n4UW1hzcjK6GrDN
         VqMRCE9tF8ZtzDpFxp2vyo6V2tfVG9dTD2wmJUIXYcF91CleBa5EuUn1dnDMQhbbV4qQ
         uMVxGTroz+RqeX4cmlzRUc7S9xcrcH31AMxmFuHcz/2Vdd5KEFKzy63TOOtaVrN+b0rN
         Tm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c4Kli4Bm4ZJjhE8y+bsYiWkPFSF4bxftqpOOEIMMA9I=;
        b=ojVJR7oS9ltrgr+7Xlp3ZPEvvjKall4XGBP/O5XRh27Rz5pjYtr3eLpaFXFxKm6Pv2
         MBsFWSnKW0x9g+rNOU0tX9MrRbS9EpHxtXKDigkcGjPz+wXAaEO9OBo+dNL89GD9F+z+
         VNm110WgXCQrzBcGtENL2GzNtP4WyaV7my2ZklYWiinNa+zrq9Z687iusFeQD4qmg41i
         4Us7le7MtUFvYHfKVuWFTCXSa3SpMn5iEoIV1s50XHjGIgM660lK7d3aAPaSums0Q4/E
         HW9/R2mssoqQ4XJN4KivwT+QAlzdTGKw6lAoYzVISKoxInOc21vISXlt2z+iSpj6xQWh
         TpcA==
X-Gm-Message-State: AOAM531k2K/tQIZlpooipNo/BLHOwbRzvxb+36oVQhc8H4uXIIbwx2cn
        aqufnOnzX0rTdujerPHq+Sk9wvjuvASZBqZvc45n3ukBDsg=
X-Google-Smtp-Source: ABdhPJxu7vsbiWyURALqnHAiXi99S3a9kBbxvA/6UdB7UZ2TUzOT/slLMzkByqEJ5xtqfM4lpNUSr4MbmWJIPuY9Slk=
X-Received: by 2002:a05:6102:2339:b0:325:880f:62f5 with SMTP id
 b25-20020a056102233900b00325880f62f5mr2865197vsa.36.1648447736208; Sun, 27
 Mar 2022 23:08:56 -0700 (PDT)
MIME-Version: 1.0
From:   Tanu M <tanu235m@gmail.com>
Date:   Sun, 27 Mar 2022 23:08:46 -0700
Message-ID: <CAPS78prawYzRZnyhWjgOnGw4EwoswNwztvfZFdCOPOydFzVwzQ@mail.gmail.com>
Subject: [PATCH] perf tools/perf/python/tracepoint.py: Converted to Python3
To:     linux-perf-users@vger.kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
I have converted the tracepoint.py file to python3 as many of the
files in tools/perf are already written in python3.

Signed-off-by: Tanusree Debnath <tanu235m@gmail.com>

---
 tools/perf/python/tracepoint.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 461848c7f..6a63e6c41 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -34,7 +34,7 @@ def main():
             if not isinstance(event, perf.sample_event):
                 continue

-            print "time %u prev_comm=%s prev_pid=%d prev_prio=%d
prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
+            print ("time %u prev_comm=%s prev_pid=%d prev_prio=%d
prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
                    event.sample_time,
                    event.prev_comm,
                    event.prev_pid,
@@ -42,7 +42,7 @@ def main():
                    event.prev_state,
                    event.next_comm,
                    event.next_pid,
-                   event.next_prio)
+                   event.next_prio))

 if __name__ == '__main__':
     main()
-- 
2.25.1
