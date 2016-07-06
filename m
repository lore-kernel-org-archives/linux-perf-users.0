From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf bpf examples
Date: Wed, 6 Jul 2016 13:29:22 -0700
Message-ID: <CAE40pdfDNi-+80az4YNa9asLGyOJc2e5RcPgFxz5FK9VwgRUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:32860 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbcGFU3x (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Jul 2016 16:29:53 -0400
Received: by mail-io0-f174.google.com with SMTP id t74so5620836ioi.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Jul 2016 13:29:52 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>

G'Day,

Are perf bpf examples shared anywhere? I've seen many posted to lkml
(by Wang Nan), but don't see them in the linux source, or
documentation. Would be very handy to throw them all up somewhere for
searching/learning, if that hasn't already happened, eg, github.

I was also looking to see if perf bpf supports sampling yet, but I
don't think it does. Eg, imagine a:

perf record -F 99 -e bpf_process_samples.c -a -- sleep 10

which would require BPF attaching to perf_swevent_hrtimer()/etc, and
also emitting a map (eg, sampled instruction pointer counts). I don't
think perf currently does either, but was hoping for a collection of
examples to double check.

Brendan
