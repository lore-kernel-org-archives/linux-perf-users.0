From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: perf sched record with -p option
Date: Sun, 4 Feb 2018 17:31:07 +0000
Message-ID: <30C2D590D16A5C46ADFE65219103779892616691@AZ-US1EXMB02.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co300216-co-outbound.net.avaya.com ([198.152.13.100]:10526 "EHLO
        co300216-co-outbound.net.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751651AbeBDRkm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Feb 2018 12:40:42 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

The data files collected by 'perf sched record' are very large and our embedded
system target has limited storage, so I thought of using the '-p PID' option on
'perf sched record' to focus only on a single PID and its threads/children and
thus reduce the amount of data.

However, when I review the results with 'perf sched latency', the results from
data collected with '-p PID' are significantly different (e.g., ten-times longer
latencies) that those from data collected without the '-p PID' option. Workloads
are the same.

Is there some reason why using '-p PID' option on 'perf sched record' wouldn't
make sense?

MV
