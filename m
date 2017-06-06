From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 0/3] perf fix test case 14
Date: Tue,  6 Jun 2017 16:31:53 +0200
Message-ID: <20170606143156.10471-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751606AbdFFOcK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2017 10:32:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v56ETXP8059950
        for <linux-perf-users@vger.kernel.org>; Tue, 6 Jun 2017 10:32:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2awnkmund4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2017 10:32:09 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 6 Jun 2017 15:32:08 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>

I have taken the following commits from Jiri Olsa's
branch perf/attr_test to work on a fix.

Commit-id
070b9644981e perf tests attr: Do not store failed events
c9666c26ead0 perf tests attr: Make compare_data global
10eb9496d1c3 perf tests attr: Fix compare logic
4ba31b633fab perf tests attr: Add 1s for exclude_kernel ..
ede0b0a2e007 perf tests attr: Fix no-delay test

I have then added 3 new fixes

Thomas Richter (3):
  perf: fix incorrect sample_type value for perf stat tests
  perf: fix exit code check in test case execution
  perf: fix perf test case 14

I can test these changes only on s390.
With these changes some test-stat-xxx tests run fine.

How to handle test cases currently unsupported on a platform?
For example  test-stat-default issues a setup for 
PERF_TYPE_HARDWARE / PERF_COUNT_HW_STALLED_CYCLES_BACKEND
which is not supported on s390. The perf_event_open()
system call fails and no event-00-07--1 file is created.

The compare of the test result then fails because attr.py
has nothing to check against.
We could test if an event file exists and if not report an
unsupported test. Is this a good idea?
Any other proposals?

Right now I have commented out these subtests in my environment.

-- 
2.9.3
