From: Arun Sharma <arun@sharma-home.net>
Subject: from perf_trace_context import fails?
Date: Tue, 22 Mar 2011 18:04:41 -0700
Message-ID: <AANLkTikzNfTyHHgL5QiqSwXJvd-rGqCOx1MkizkqPuOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54622 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab1CWBEm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Mar 2011 21:04:42 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so8039436iwn.19
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2011 18:04:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I built/installed perf from the perf/urgent branch on
x86/linux-2.6-tip tree and I get:

# perf script -g python
generated Python script: perf-script.py
# echo $PERF_EXEC_PATH
/usr/libexec/perf-core
# python perf-script.py
Traceback (most recent call last):
  File "perf-script.py", line 16, in <module>
    from perf_trace_context import *
ImportError: No module named perf_trace_context

It didn't look like Context.o is getting installed in
/usr/libexec/perf-core. Am I doing something wrong or is this work in
progress?

-Arun
