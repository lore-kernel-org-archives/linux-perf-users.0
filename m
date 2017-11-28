From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: How to use PERF_RECORD_MMAP
Date: Tue, 28 Nov 2017 10:24:50 -0300
Message-ID: <20171128132450.GE3298@kernel.org>
References: <CABUc5FFGkqn1kS9p=_ZmfuMEn-jhkJc60yvtC3eEjuw7HcHbeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752473AbdK1NYx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Nov 2017 08:24:53 -0500
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265062148C
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2017 13:24:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CABUc5FFGkqn1kS9p=_ZmfuMEn-jhkJc60yvtC3eEjuw7HcHbeg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kiran T <kiran.lkml@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Nov 27, 2017 at 12:27:54PM -0800, Kiran T escreveu:
> Hello,
> Man pages/documentation is not clear on how to use PERF_RECORD_MMAP .
> Dummy event did not record this -- probably need a qualifier to add
> sample_id_all?  ( Of course I could create a custom program with
> perf_event_open.  But wanted to use perf if possible.)

# perf record --delay 1 sleep 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (8 samples) ]
# perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|PERIOD, read_format: ID, disabled: 1, inherit: 1, freq: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1
dummy:HG: type: 1, size: 112, config: 0x9, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ID|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1
[root@jouet ~]#

So when you ask for running sleep but only start collecting samples
after 1ms passes after the workload starts ('sleep 2' in this case), we
have to have an active event to at least receive the PERF_RECORD_MMAP
events (perf_event_attr.mmap = 1).

Look at the fields set in the perf_event_attr for the dummy event in the
example above, that should suffice.

There are some fields that just got existing defaults, but are not
relevant nor used here, what matters really is:

dummy: type: 1, size: 112, config: 0x9, sample_type: ID, disabled: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1

- Arnaldo
