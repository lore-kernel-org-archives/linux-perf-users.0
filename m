From: William Cohen <wcohen@redhat.com>
Subject: Monitoring NUMA Machine Memory Hierarchy Performance
Date: Tue, 13 Feb 2018 11:11:16 -0500
Message-ID: <87851944-4680-6177-120a-156794d5b76c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934544AbeBMQLQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Feb 2018 11:11:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B86040FB645
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2018 16:11:16 +0000 (UTC)
Received: from [10.13.129.233] (dhcp129-233.rdu.redhat.com [10.13.129.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32D3894598
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2018 16:11:16 +0000 (UTC)
Content-Language: en-MW
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

The available events listed for the "Hardware cache event" category
produced by "perf list" on some machines (for example CPUID
AuthenticAMD-16-2) only list *-loads and *-load-misses there is no
*-stores or *-store-misses.  Looking through the event code in the
kernel to set up these events it appears these *-load* events without
similar *-store* events are really covering both read and write
accesses for x86 processors. Is that the case? Is there some place
that this sould be clarified in the documentation?

The AMD and Intel implementation of the node-* "hardware cache event"
events are very different.  Is the following correct about how these
events work on AMD and Intel?

Intel implementation uses a single OFFCORE_RESPONSE register to select
the operation to be monitored, if more than one node-load,
node-load-misses node-stores, and node-store-misses being used
simultaneously they are multiplexed.  The resulting values measured
need to be scaled by their duty cycle.

AMD implementation uses a normal on-CPU performance monitoring events
and both node-load-misses and node-loads can be collected at the same
time.


Is the following a reasonable method to obtain local vs remote memory?

# perf stat -a --scale --per-socket -e node-loads-misses,node-loads

^C
 Performance counter stats for 'system wide':

S0        4          6,525,428      node-loads-misses                                             (30.04%)
S0        4         19,866,811      node-loads                                                    (15.99%)
S1        4          7,942,866      node-loads-misses                                             (27.35%)
S1        4         19,680,169      node-loads                                                    (16.92%)

      14.657431853 seconds time elapsed


The "perf-stat" page mentioned producing additional statistics that
include memory hierarchy information with "-d", "-d -d", and "-d -d
-d".  Would it make sense to have some option includes the node-*
metric information for "perf stat"?

-Will
