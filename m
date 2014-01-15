From: Andre Richter <andre.o.richter@gmail.com>
Subject: Counting PCIe / MMIO traffic per core
Date: Wed, 15 Jan 2014 10:50:17 +0100
Message-ID: <CAKqeN2875RCqC9iwt=HJgFCnEmLWeuMma=RPxLX948AYsSRk2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43913 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbaAOJuS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jan 2014 04:50:18 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so933445pab.29
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2014 01:50:18 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello everyone,

I am currently fiddling around with performance monitoring on a Xeon
Machine with an e5-2600 series CPU.

What I understand from Intel's uncore performance monitoring guide and
from Andi Kleen's Readmes from his super useful pmu-tools, it is not
possible to differentiate PCIe traffic per core when using the uncore
PMUs (the CBo boxes to be precise). It is only possible per socket.

I wonder, however, if it would be possible to at least make an
educated guess of which core is producing how much PCIe or MMIO
traffic.
Maybe by cross-correlating with some PMU evens from core-resident PMUs?
The amount of PMU events and configuration options is quite
overwhelming, that's why I would appreciate any hints I can get :)

Cheers,
Andre
