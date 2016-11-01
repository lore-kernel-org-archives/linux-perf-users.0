From: Keno Fischer <keno@juliacomputing.com>
Subject: PERF_RECORD_FINISHED_ROUND documentation
Date: Mon, 31 Oct 2016 23:01:39 -0400
Message-ID: <CABV8kRzdV0eWvbH11rHenz6PHqGGexmH4GXFBxaLYy5QZoAi5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36847 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161519AbcKADCV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Oct 2016 23:02:21 -0400
Received: by mail-ua0-f178.google.com with SMTP id b35so47756602uaa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Oct 2016 20:02:20 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

The perf.data file format documentation at

tools/perf/Documentation/perf.data-file-format.txt#L264 (and later in the file)

says about PERF_RECORD_FINISHED_ROUND:

   No event reordering over this header.

This documentation seems slightly misleading to me, since records can
indeed be reordered
across this event. All that perf is saying that it finished one round
of reading the buffers from
all CPUs. This is nicely explained in session.c. Maybe part of that
explanation could be
moved to the file format documentation to explain the actual semantics
and guarantees
that PERF_RECORD_FINISHED_ROUND provides?

Keno
