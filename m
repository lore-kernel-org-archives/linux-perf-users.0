From: Arun Sharma <arun@sharma-home.net>
Subject: perf record regression?
Date: Wed, 9 Mar 2011 21:59:39 -0800
Message-ID: <AANLkTikcz=_HX7Ws2Ojmky+JgQhk1cj2YW=uxSkYkXBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61783 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1CJF7k (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 00:59:40 -0500
Received: by iwn34 with SMTP id 34so1211236iwn.19
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Mar 2011 21:59:39 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-perf-users@vger.kernel.org

I pulled the perf/core branch in
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux-2.6.git today
and found that:

perf record -ag -- sleep 1
perf report -D | grep dso:

was returning:

 ...... dso: <not found>
 ...... dso: <not found>
 ...... dso: /boot/vmlinux-2.6.38-rc5+

i.e perf report was not able to map IP addresses to the correct dso
for anything in user space.

Using git bisect, I narrowed it down to these two commits:

commit f60686f71f4afec7b2925b4682f33c70c0a7eb17
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Mar 9 07:48:24 2011 -0300

    perf evsel: Assume rest of perf_header_attr functions

commit e62e48df064b431029658089ab1f8b529ff6da3d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Mar 8 09:05:57 2011 -0300

    perf session: Simplify evlist creation from perf.data header

perf built after these commits is able to symbolize properly for
perf.data collected using an older version of perf. So I believe, the
perf report side of things are ok. But perf record is not.

 -Arun
