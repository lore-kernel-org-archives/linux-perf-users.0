From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf annotate: Support of full source file paths for
 srcline fix
Date: Mon, 09 Nov 2015 16:33:26 +0100
Message-ID: <1447083206.15375.56.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49959 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbbKIPd2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Nov 2015 10:33:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id F006842E5DB
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2015 15:33:27 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tA9FXQEl004640
	for <linux-perf-users@vger.kernel.org>; Mon, 9 Nov 2015 10:33:27 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

the commit a9710ba091b0dcdace90f791706e9192313ffb7c  has introduced
an option for showing basename/full path of the source files in the
perf report/script output. But regarding to perf annotate, the path
is always shown as basename,  since the value of the related option
is not propagated into the annotating mechanism.

This patch addresses it and enables perf-annotate to print the full
paths as well.

Tested with latest git version.

Regards,
Michael



Michael Petlan (1):
  perf annotate: Support of full source file paths for srcline fix

 tools/perf/util/annotate.c | 1 +
 1 file changed, 1 insertion(+)

-- 
1.8.3.1
