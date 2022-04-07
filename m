Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9B3C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Apr 2022 01:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiDGBJJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiDGBJI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Apr 2022 21:09:08 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBB15AACD
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Apr 2022 18:07:10 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id t6so2229694vsq.11
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Apr 2022 18:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E2RNuXCVUKhmEMo9Yw5RsA0QIsCalXzTL4ACsbdmhVE=;
        b=lQWzbJ+f9glXqpTVNrWaNEiEyVC/PFHS7L8uoZisalIGKDTvozrYYy+sa7tttrHB4m
         rZDQKiP+OLdlbeYPoi2lm9yp+xq9ykLM2Hg/Hd64e/pqKY9h8dJAUNmkGAt5Nl0zfj5a
         tOinzXDv4S4pTlOd7Kp6Ucrf+P7dE04IAdWeCHZCVJ/0qjPYJ6YeAkqAayUhZixhqSgp
         JFzCMuwPorlFcAk815pZzPvaWF5kZtgrGKleg/ESroMYNBAZvdarDngZz891b43bM+ZD
         PFqb4Bv9qMRyMjTYNcOaFawhLX8LYzsl2pI1v9upxDDXg7J53mBT38+wmMtp5u9Z1cPV
         6Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E2RNuXCVUKhmEMo9Yw5RsA0QIsCalXzTL4ACsbdmhVE=;
        b=cNnTAEqzxwL/QnjeokYGjr8Dy0M/4EaxqRo+oPBoiH6BhnHIXZrdcK+rDFnqyO03QG
         3JVfYlBx+rgJmLlcIgWzNT6PkovmhkBvULo+2WHUv/Ha0EiiHQRGhjJYUHzjCw8e1DE8
         mYx+0fJ2ooeTkiI3/T42Ude3f5TjBaOZR7hirqtpbZp1hX3HdyHP9QIalsf/pLAlZFTT
         EMF5bRKND1UsF6zzIKEZvkPGHQVuC9frSXDPUxfsdJkZ0cJUEJ5cqxkl5Y8CdEjLBU9I
         PhPm2EZg0XCo7uE+Qi6EDxuZVcsaY/iRHdbW+76NffDC+rje3QWc5CJqIPkXwHfnneIX
         dtsQ==
X-Gm-Message-State: AOAM531xL4ICDa1NxnNMfu3h5vzhvbFgp+TdCTw3Z83CihGu6CRbOBBQ
        GqxfVpJz4OAGaSG2V6CA9Xa6K8Azt8fqY3Bxx9dko1DsTFc=
X-Google-Smtp-Source: ABdhPJxBX8jIHT35Xcv91lVJc2kobZzTL+cZwxbx2V0zE+bclkIzhFs0etG0bLuSgGXxMBOFhC1T32D8c/7lEjOCb+8=
X-Received: by 2002:a67:f601:0:b0:325:5b5d:d1d6 with SMTP id
 k1-20020a67f601000000b003255b5dd1d6mr3590828vso.4.1649293629256; Wed, 06 Apr
 2022 18:07:09 -0700 (PDT)
MIME-Version: 1.0
From:   Tanusree Debnath <tanu235m@gmail.com>
Date:   Wed, 6 Apr 2022 18:06:58 -0700
Message-ID: <CAPS78posWM==DUKsNeh10UFouETOOt-iUkXqdJZDcrew6vnw0A@mail.gmail.com>
Subject: [PATCH] perf tools/perf/python/tracepoint.py: Added few more event
 attributes to the main function
To:     linux-perf-users@vger.kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, peterz@infradead.org,
        arnaldo.melo@gmail.com, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
I have added some more event attributes to the print statement of the
main function in the tracepoint.py file and also kept the output of
the function in the comment.

Signed-off-by: Tanusree Debnath <tanu235m@gmail.com>
---
tools/perf/python/tracepoint.py | 26 +++++++++++++++++++++++++-
1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index bba68a6d451..b56ef13197c 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -34,7 +34,31 @@ def main():
if not isinstance(event, perf.sample_event):
continue
- print("time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x
==> next_comm=%s next_pid=%d next_prio=%d" % (
+ '''
+ Added more attributes to the print statement:
+ event.sample_addr,
+ event.sample_cpu,
+ event.sample_id,
+ event.sample_ip,
+ event.sample_period,
+ event.sample_pid,
+ event.sample_stream_id,
+ event.sample_tid,
+
+ sample output:
+ sample_addr=0 sample_cpu=4 sample_id=18446744073709551615
sample_ip=0 sample_period=1 sample_pid=0
sample_stream_id=18446744073709551615 sample_tid=0 time 20322533945096
prev_comm=bytearray(b'swapper/4\x00\x00\x00\x00\x00\x00\x00')
prev_pid=0 prev_prio=120 prev_state=0x0 ==>
next_comm=bytearray(b'kworker/u16:6\x00\x00\x00') next_pid=10086
next_prio=120
+
+ '''
+
+ print("sample_addr=%s sample_cpu=%s sample_id=%s sample_ip=%s
sample_period=%s sample_pid=%s sample_stream_id=%s sample_tid=%s time
%u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==>
next_comm=%s next_pid=%d next_prio=%d" % (
+ event.sample_addr,
+ event.sample_cpu,
+ event.sample_id,
+ event.sample_ip,
+ event.sample_period,
+ event.sample_pid,
+ event.sample_stream_id,
+ event.sample_tid,
event.sample_time,
event.prev_comm,
event.prev_pid,
-- 
2.25.1
