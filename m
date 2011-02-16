From: David Ahern <dsahern@gmail.com>
Subject: perf record: mmap fails when specifying process/thread
Date: Wed, 16 Feb 2011 08:43:45 -0700
Message-ID: <4D5BF0B1.7080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33266 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1BPPnt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Feb 2011 10:43:49 -0500
Received: by pxi15 with SMTP id 15so213796pxi.19
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 07:43:49 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Latest perf-core (pulled 5 minutes ago):

# ps -C sshd
  PID TTY          TIME CMD
  961 ?        00:00:00 sshd
 1042 ?        00:00:00 sshd

# /tmp/build-perf/perf record -v -fo/tmp/perf.data -p 1042
  Warning:  ... trying to fall back to cpu-clock-ticks

  Fatal: failed to mmap with 22 (Invalid argument)


It works fine with -a argument and when a command is given, but fails
with the -p or -t argument.

David
