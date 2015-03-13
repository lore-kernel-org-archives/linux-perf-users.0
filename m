From: William Cohen <wcohen@redhat.com>
Subject: Why the need to do a perf_event_open syscall for each cpu on the
 system?
Date: Fri, 13 Mar 2015 14:49:28 -0400
Message-ID: <55033138.5010500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbbCMSta (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 Mar 2015 14:49:30 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2DInTeb010618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2015 14:49:29 -0400
Received: from [10.13.129.108] (dhcp129-108.rdu.redhat.com [10.13.129.108])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2DInTDa015472
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2015 14:49:29 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

I have a design question about the linux kernel perf support. A number of /proc statistics aggregate data across all the cpus in the system.  Why the does perf require the user-space application to enumerate all the processors and do a perf_event_open syscall for each of the processors?  Why not have a perf_event_open with pid=-1 and cpu=-1 mean system-wide event and aggregate it in the kernel when the value is read?  The line below from design.txt specifically say it is invalid.

(Note: the combination of 'pid == -1' and 'cpu == -1' is not valid.)

-Will
