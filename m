Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F368C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 11:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiDMLTP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiDMLTO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 07:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D24354BE3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649848612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=+7RzPlk3rkj283aD3rT5lMfAYKr641wYoaxQulPL3No=;
        b=E2beIF64SPfqR8qrLECJ7D/ajbDcGJEas99FLz+F+Fzo7XlWV+99TD3W6j2/qnkpXjylPZ
        qLB0VIN3EXyIWvKB4TFWIg5HkmHiwCjHcRoFWcQUDYnFtQ/xzfiVbkzfzRvd3yp+Bpy6bV
        hh9n4zsjKtHgwc6lkvCmDnjDy4ewJ4U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-8Rnal9EyNv-OMzzksh8YnA-1; Wed, 13 Apr 2022 07:16:50 -0400
X-MC-Unique: 8Rnal9EyNv-OMzzksh8YnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 811B6101AA45
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 11:16:50 +0000 (UTC)
Received: from Diego (unknown [10.39.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3CCC2024CB6
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 11:16:49 +0000 (UTC)
Date:   Wed, 13 Apr 2022 13:16:47 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     linux-perf-users@vger.kernel.org
Subject: perf :: intel hybrid events (fwd)
Message-ID: <alpine.LRH.2.20.2204131302230.29735@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Forwarding the questions to perf-users...

Also, I have found out that mem-stores:p event does not work on
Intel Alderlake:

# perf record -e mem-stores -- ./examples/dummy > /dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.024 MB perf.data (64 samples) ]

While with precise, it records nothing:

# perf record -e mem-stores:p -- ./examples/dummy > /dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.021 MB perf.data ]

This makes the perf-mem and perf-c2c commands less useful.

Again, is this how it is supposed to work or do I miss some fixes?
Or does upstream also miss some fixes?

Thanks.
Michael

---------- Forwarded message ----------
Date: Tue, 12 Apr 2022 22:59:11
From: Michael Petlan <mpetlan@redhat.com>
To: yao.jin@linux.intel.com
Subject: perf :: intel hybrid events

Hello Jin Yao,

I have a few questions/ideas about hybrid events on Alderlake...


1) L1-{d,i}cache-load{,-misse}s supported partially

Interestingly enough, perf offers the following events in the hwcache set:

L1-dcache-load-misses
L1-dcache-loads
L1-icache-load-misses
L1-icache-loads

Of course, each expands to its cpu_core and cpu_atom version, as following:

# perf stat -e L1-icache-load-misses
^C
 Performance counter stats for 'system wide':
           146,566      cpu_core/L1-icache-load-misses/
           164,971      cpu_atom/L1-icache-load-misses/

On my Alderlake testing box with RHEL-9 I see the following support pattern:

                         |  cpu_core  |  cpu_atom  |
L1-dcache-load-misses    |     OK     |     N/A    |
L1-dcache-loads          |     OK     |     OK     |
L1-icache-load-misses    |     OK     |     OK     |
L1-icache-loads          |     N/A    |     OK     |

For dcache, loads are supported on both, while misses do not work on atom.
That can be, atom is simpler, thus I can expect it missing some events...

For icache, misses are supported on both, while loads do not work on core.
This looks weird, is that really the wanted behavior? Isn't there a bug in
the drivers/event specifications?


2) You added --cputype switch to perf-stat via e69dc84282fb474cb87097c6c94
so one can restrict the expansion and keep only one cpu type used. Doesn't
perf-record need the same?


3) While perf-stat defaults to "use whatever we can" approach when not every
event is supported, puts "<not supported>" into the results, perf-record
fails. This is bad for the cases like above, since it fails when one of the
events aren't supported. That might make sense if the unsupported event was
specified explicitly by the user, e.g. `perf record -e AA -e BB -- ./load`
and perf fails "sorry, I don't support event BB".

However, what if the user just wants L1-dcache-load-misses and encounters
perf-record failing just because the event is not supported on Atom?

Shouldn't this behavior be fixed by some --tolerant switch that would ignore
the problems and record what is going on on the Core at least?


What are your ideas?
Thanks...

Michael

