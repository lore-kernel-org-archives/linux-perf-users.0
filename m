From: Mark Davis <markdavisinboston@gmail.com>
Subject: Comparing output of two perf cpu profiling reports
Date: Thu, 28 Apr 2016 09:27:07 -0400
Message-ID: <CAPe7T+9fYXHWa7X4x-su6LujYuOFv7BB7j-jCcdH-hw3oQM9Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35254 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcD1N1J (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Apr 2016 09:27:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id w198so9944519oiw.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2016 06:27:09 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, what is the recommend way to compare two different perf reports
from CPU event profiling (via sampling with perf record)? I'm
comparing two macro benchmarks, with a couple small implementation
details between the two. Right now I'm manually comparing the output
of perf report to determine the salient differences. However, I'm
wondering if there's a tool or otherwise best practice to essentially
"diff" the two outputs. I could just use diff on the --stdio version
of the reports, but sometimes lines get mangled and I loose
context/hierarchy.

Any tips?

Mark
