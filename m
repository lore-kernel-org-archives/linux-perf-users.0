Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0120C27C7C
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 13:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjATNla (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 08:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjATNl3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 08:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27949037
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674222046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jk3Jhe3pV2lehKoaoy4oIX5gegI9rdM3yt0E7sYV+1c=;
        b=irED+003LxS65pRDGP7SIeVX2q/ZVjRsQSdQEqkQMnq4TvQ3YcKGifzZhE3hzKhyp4OYJV
        X+8wiJ9aKzF8OFKYIgmoJZWVrt5PvOd8HhbKoiJjG5341kJRyF/RGP3K6olHIsi3A3+/NQ
        3It9qtTVqhT358hyJG1POVLOQhaeMMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-m41axH9-N1C1HVYMiTXj4A-1; Fri, 20 Jan 2023 08:40:43 -0500
X-MC-Unique: m41axH9-N1C1HVYMiTXj4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFA08101A521;
        Fri, 20 Jan 2023 13:40:42 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8302166B2B;
        Fri, 20 Jan 2023 13:40:41 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     acme@redhat.com, qzhao@redhat.com, cjense@google.com
Subject: [PATCH 0/2] perf test: Fix JSON linter
Date:   Fri, 20 Jan 2023 14:40:37 +0100
Message-Id: <20230120134039.17788-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello all.

We have observed issues with the 'perf stat JSON output linter' testcase
on systems that allow topdown metrics.

=========================

1) The topdown metrics handling hardcodes printing more than one metric
per line (refer to util/stat-shadow.c):

    if (retiring > 0.7 && heavy_ops > 0.1)
        color = PERF_COLOR_GREEN;
    print_metric(config, ctxp, color, "%8.1f%%", "Heavy Operations",
            heavy_ops * 100.);
    if (retiring > 0.7 && light_ops > 0.6)
        color = PERF_COLOR_GREEN;
    else
        color = NULL;
    print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
            light_ops * 100.);

Thus, the test cannot rely on the fact that there will be only one
metric per line.

2) Since the JSON printing engine thinks that one and only one metric
is printed, it always closes the line by adding '}'. This is not true,
so I have fixed the comma printing and adjusted the engine to be
capable of printing 1-N metrics and then close the line.

=========================

On machines that don't support topdown, the problem can be shown by
doubling the following line in util/stat-shadow.c, so that the simple
'insn per cycle' metric is printed twice:

  print_metric(config, ctxp, NULL, "%7.2f ", "insn per cycle", ratio);

The worst problem is that the JSON line is broken, such as:

... "pcnt-running" : 100.00, "metric-value" : 3.501931, "metric-unit"
    : "Heavy Operations"}"metric-value" : 14.007787, "metric-unit" : ...
                  here ^^^^^

=========================

The first patch solves the JSON output correctness, the second tries
to adjust the testcase to some extent, so that it should work on the
topdown-capable machines.

However, it's highly possible that the testcase will have to be fixed
or maybe rewritten in future. First, it has quite naive evaluation of
what's expected/correct/etc. Second, it does no JSON format validation
at all. As a linter it should do so though.

 ***

For further discussion: What about removing the check for number of
expected elements in the line and just check for the keywords, such
as "metric-value", "counter-value", "event", etc. and for some values
that should be numeric. And, do proper JSON format sanity check?


Thank you for inputs!

Michael




Michael Petlan (2):
  perf stat: Fix JSON metric printout for multiple metrics per line
  perf test: Fix JSON format linter test checks

 .../tests/shell/lib/perf_json_output_lint.py  | 16 +++++------
 tools/perf/util/stat-display.c                | 28 +++++++++++--------
 2 files changed, 24 insertions(+), 20 deletions(-)

--
2.18.4

