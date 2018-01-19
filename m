From: Jaroslav Skarvada <jskarvad@redhat.com>
Subject: Re: [PATCH] perf: add Python 3 support
Date: Fri, 19 Jan 2018 16:01:25 -0500 (EST)
Message-ID: <1953812760.1652541.1516395685287.JavaMail.zimbra@redhat.com>
References: <20180119205641.24242-1-jskarvad@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeASVBZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Jan 2018 16:01:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FC02DF14
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 21:01:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73A9260C9B
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 21:01:25 +0000 (UTC)
Received: from zmail22.collab.prod.int.phx2.redhat.com (zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 69D7D1800B60
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2018 21:01:25 +0000 (UTC)
In-Reply-To: <20180119205641.24242-1-jskarvad@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

This is an updated patch for kernel-4.15.0-0.rc8. It also applies to
linux-stable HEAD. Our project Tuned is consumer of python-perf.
We are trying to switch Tuned to Python 3 and the python-perf is
the only blocker for us at the moment.

Downstream Fedora bugzilla containing the scratch build and
Fedora Spec patch:
https://bugzilla.redhat.com/show_bug.cgi?id=1536656

The patch needs testing, but with our use case in Tuned
it seems to work. Any comments or patch updates are welcome

thanks & regards

Jaroslav
