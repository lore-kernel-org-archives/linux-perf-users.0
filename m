From: Han Pingtian <phan@redhat.com>
Subject: what's the usage of 'perf inject'?
Date: Mon, 28 Feb 2011 18:09:33 +0800
Message-ID: <20110228100933.GC10612@hpt.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab1B1KFZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Feb 2011 05:05:25 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1SA5PlM022799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Feb 2011 05:05:25 -0500
Received: from hpt.nay.redhat.com (dhcp-65-65.nay.redhat.com [10.66.65.65])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p1SA5LkW024124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Feb 2011 05:05:24 -0500
Received: from hpt.nay.redhat.com (localhost.localdomain [127.0.0.1])
	by hpt.nay.redhat.com (8.14.4/8.14.4) with ESMTP id p1SA9YWd021799
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Feb 2011 18:09:34 +0800
Received: (from hpt@localhost)
	by hpt.nay.redhat.com (8.14.4/8.14.4/Submit) id p1SA9X5D021797
	for linux-perf-users@vger.kernel.org; Mon, 28 Feb 2011 18:09:33 +0800
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I cannot figure out how to use 'perf inject'. It looks like I can run it
like this:

$ perf record -o - ls | perf inject -b -v

and get a lot of garbage on the screen. How does 'perf inject' be
supposed to use? 

Thanks in advance.
-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY
