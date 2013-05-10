From: Chao Xu <caesarxuchao@gmail.com>
Subject: perf record always record the same kernel symbol
Date: Fri, 10 May 2013 14:04:10 -0500
Message-ID: <CAKZq+rfUO070Ph38EeOzGGxG3CtWiLZ4-eH=PLgby62Ugk3w1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60057 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3EJTEL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 May 2013 15:04:11 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so4524811obb.28
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2013 12:04:10 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I issued the following commands:
sudo perf record sleep 1
sudo perf report

Here is a snippet from the output of perf report:
# Samples: 8  of event 'cycles'
# Event count (approx.): 1609581
#
# Overhead  Command      Shared Object  Symbol
# ........  .......  .................  ......
#
   100.00%    sleep  [kernel.kallsyms]  [k] 0xffffffff81043fea

I also tried to record other commands such as dd, ping, the symbol
showed in the output is always "[k] 0xffffffff81043fea", and this was
the only kernel symbol. I checked /proc/kallsyms, this symbol did not
exist in the file.

I built my kernel from linux source tree with the default config. I
tried on both 3.9.0 and 3.9.1. I built perf from
linux-source-tree/tools/perf with a simple "make".

Could someone suggest where did I go wrong? Thanks a bunch.
--
Regards,
Chao Xu
