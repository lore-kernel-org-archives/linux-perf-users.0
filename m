Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106FFC61DA4
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 08:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjBWIC3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjBWICZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 03:02:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5F4C6F7
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 00:02:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so11989488pjc.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Feb 2023 00:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oCCHulnPjeXfVxB2hc2FnPODrNWqu5nDv28ixYfrxMM=;
        b=jD+TbkRKtV9BQXTQHgW6EMy89Wv6sq4xhRDSgXlUtbyGezotuogOjMpX1gS+AS9vgs
         rbLwrQaWNYcF9egRPxc/BKIU/nfaxagr/FraNQPR7PHSAoWVMjduYbUEOpHt/WlfbgSp
         RuN04HbAEg8kCH2Yi9uOBAsytqdkJ2M9CX3rnuHBb6ogtgx0tPrG0KbPNpQy/oLo0u/+
         3AIbaOz4ygcsudW1hATYkd2yflFkWcxoxQpBIk7zFHm22oYo7X7eCAt1x8smc7y+DPI2
         54Lm/fqM4lZOiemaO445cMMHnfzyyw95+0e3QWxKRfgsFqQz+M1MfXErWveKSwaSYcYj
         RBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCCHulnPjeXfVxB2hc2FnPODrNWqu5nDv28ixYfrxMM=;
        b=5cboQhGrbAmydUWTnT3dXCNHUmgAkMqHYKh8ZcBPODiFfyjr+YNJpCQMbSA3WSJAMs
         em++cI0+3F2H5AdxMyjk/qnsYuih4zWuB8GqLiMvk0AnncItednl5RBBKHq5tR7UUqRL
         qffB0R1mKX+WJYq0Cd+17i+V96Rgo9hDvGgu3Ui6NrocpBVEtv2MsCpasfKhioNSIajc
         Dz+fhImQRLmiaU4jYwkSaOl+ZClt2bfDy043xSA/duufrcYqWmktegvQHjSVHzmmoqSZ
         vfQABU8OIYYLjfdYBm0dP7BzutfJQUr+vVvO1W5KG81GRSW916Ib3U8WSzIEErezVySH
         5fyQ==
X-Gm-Message-State: AO0yUKWclVcejNsSDSGlK09gMfyN8Pp/lY+1VIOct0w6rnasxrdqdBGU
        4omdpA9IhWeN4VzDAzbLri4xlbsmH5LIccmRuAYgMFMDGkg=
X-Google-Smtp-Source: AK7set/Z56Ijpbz4lc+SqXvPct9PPLxoQnz2+Qk9UZb0t3HqxthYWZQZG1DAlr9SynoKkTPwC5jTlwI4B9NWYB9dzYs=
X-Received: by 2002:a17:90a:ca88:b0:237:2516:f76a with SMTP id
 y8-20020a17090aca8800b002372516f76amr293257pjt.2.1677139342599; Thu, 23 Feb
 2023 00:02:22 -0800 (PST)
MIME-Version: 1.0
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Thu, 23 Feb 2023 10:02:11 +0200
Message-ID: <CAPXMrf9hCmTKjUJJ_cymxqw696FdDvgV0xuDjwGeQTkoDpi=KQ@mail.gmail.com>
Subject: perf record is crashing on system with bpf progs are running
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi ,

perf record is crashing on systems with bpf programs are running.

We are running on the 4.18 host kernel and we launch a container ,
inside the container we run perf record command, (bpf program is
running). Perf is built on top of the 5.4.228 kernel.

(gdb) bt
#0  0x000000000055becf in perf_event__synthesize_one_bpf_prog
(opts=0x94def8 <record+280>, event=0xabd910, fd=132, machine=0xaf6208,
process=0x421260 <process_synthesized_event>,
    session=0xaf6090) at util/bpf-event.c:242
#1  perf_event__synthesize_bpf_events (session=session@entry=0xaf6090,
process=process@entry=0x421260 <process_synthesized_event>,
machine=machine@entry=0xaf6208,
    opts=opts@entry=0x94def8 <record+280>) at util/bpf-event.c:333
#2  0x000000000041ff5c in record__synthesize (tail=tail@entry=false,
rec=0x94dde0 <record>) at builtin-record.c:1323
#3  0x0000000000422bc4 in __cmd_record (rec=0x94dde0 <record>,
argv=<optimized out>, argc=<optimized out>) at builtin-record.c:1465
#4  cmd_record (argc=<optimized out>, argv=<optimized out>) at
builtin-record.c:2474
#5  0x0000000000490769 in run_builtin (p=p@entry=0x9574b8
<commands+216>, argc=argc@entry=1, argv=argv@entry=0x7fffffffc120) at
perf.c:312
#6  0x000000000040c05a in handle_internal_command
(argv=0x7fffffffc120, argc=1) at perf.c:364
#7  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:408
#8  main (argc=1, argv=0x7fffffffc120) at perf.c:538

We tried running perf record --no-bpf-event but crash is still seen so
we added the below patch to skip processing bpf events when
no-bpf-event options is provided , but not sure if this is the actual
solution, please provide your inputs.

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 454e275..78e96ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1320,11 +1320,12 @@ static int record__synthesize(struct record
*rec, bool tail)
                return err;
        }

-       err = perf_event__synthesize_bpf_events(session,
process_synthesized_event,
-                                               machine, opts);
-       if (err < 0)
-               pr_warning("Couldn't synthesize bpf events.\n");
-
+        if (!opts->no_bpf_event) {
+                err = perf_event__synthesize_bpf_events(session,
process_synthesized_event,
+                                                       machine, opts);
+               if (err < 0)
+                       pr_warning("Couldn't synthesize bpf events.\n");
+        }


Thanks,
Rajesh Dasari.
