From: Tianwei Zhang <artdream07@gmail.com>
Subject: perf event of node-load
Date: Wed, 8 Apr 2015 01:23:47 -0400
Message-ID: <B27347FB-AD17-4FAB-A128-4DCF4F9546EB@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33874 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbDHFXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Apr 2015 01:23:51 -0400
Received: by qkgx75 with SMTP id x75so72827122qkg.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2015 22:23:50 -0700 (PDT)
Received: from nat-oitwireless-inside-vapornet100-d-15872.princeton.edu (nat-oitwireless-outside-vapornet3-e-23.Princeton.EDU. [140.180.244.35])
        by mx.google.com with ESMTPSA id b74sm6896545qhc.28.2015.04.07.22.23.49
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Apr 2015 22:23:49 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am looking at the perf default events. There are several hardware cache events: node-loads, node-load-misses, node-stores, node-store-misses. I am wondering if these events refer to the accesses to the DRAM, and the misses of DRAM (thus leading to the access to the disk?) Since these events should be uncore events, why do they belong to the hardware cache events?

Thank you very much.

Best wishes,

-Tianwei