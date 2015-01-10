From: Dennis <daodennis@gmail.com>
Subject: JVM Profiling: Does hotspot emit frame pointer, and other Q's
Date: Sat, 10 Jan 2015 01:03:49 -0800
Message-ID: <CANqRL=RKvTEWc=t0ff_NOc6Ja8j3MLq5s-ZmsPtXZOfTMGB8Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:39355 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbbAJJDu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Jan 2015 04:03:50 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so12551948qcx.13
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2015 01:03:49 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

http://www.brendangregg.com/perf.html mentions the following** in
regards to profiling JVMs.

1) Is this still an issue, if not when was it fixed?
2) Are there workarounds? (Other JVMs?)
3) Does it even matter? What is the status quo? Are symbols just not
resolved or are parts of the stack omitted completely?

3 The lightweight-java-profiler seems to be able to resolve most
symbols, but I don't understand why it can and perf cannot.

** Note that Java may not show full stacks to begin with, due to
hotspot omitting the frame pointer (just like gcc). There is currently
no option to disable this optimization (either in OpenJDK or Oracle
JDK), meaning that profiling is basically broken. I've heard that the
performance benefit for omitting the frame pointer in hotspot is
negligible, meaning, we lose the incredibly useful ability to profile
stack traces for no real gain. Hotspot, at least, need to provide us
with an option to not omit the frame pointer.

P.S. I love the perf tool!


Regards,

Dennis Ordanov
