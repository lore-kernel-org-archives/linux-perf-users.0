From: Noel Grandin <noelgrandin@gmail.com>
Subject: perf script not writing out symbol names?
Date: Thu, 18 Jun 2015 10:26:22 +0200
Message-ID: <558280AE.9080102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34353 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbFRI0a (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Jun 2015 04:26:30 -0400
Received: by wicnd19 with SMTP id nd19so14997361wic.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jun 2015 01:26:28 -0700 (PDT)
Received: from [192.168.1.164] ([41.164.8.42])
        by mx.google.com with ESMTPSA id a8sm30244596wic.22.2015.06.18.01.26.26
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 01:26:28 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi

I'm using 'perf record -e cycles --call-graph dwarf' on Ubuntu 15.04 which is kernel version '3.19.0-18-generic'

At the moment it does not demangle C++ symbols, but otherwise 'perf report' looks fine.

However, if I try to pass the data through the FlameGraph tools, most of the symbols show up as "unknown".

It looks like the 'perf script' tool is not writing out symbol names for most of the events.

Any ideas?

Thanks, Noel Grandin
