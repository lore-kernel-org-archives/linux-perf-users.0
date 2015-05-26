From: Taeung Song <treeze.taeung@gmail.com>
Subject: perf tools: What is the default value of report.queue-size ?
Date: Tue, 26 May 2015 16:40:28 +0900
Message-ID: <20150526074028.GB13654@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32972 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbEZHkf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 May 2015 03:40:35 -0400
Received: by padbw4 with SMTP id bw4so86656773pad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2015 00:40:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: namhyung@kernel.org, jolsa@redhat.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org

Hi, linux-perf list

I have a question about the default value of report.queue-size.

I found 'struct report' and 'queue_size' which is a member variable of it in builtin-report.c file.
But when report.queue_size isn't customized by perf-config 'report.queue-size',
I don't know the default value of 'report.queue_size'.

What is the default value of 'report.queue-size' ?
 
thanks,
taeung
