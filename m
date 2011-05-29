From: Francis Moreau <francis.moro@gmail.com>
Subject: kvm-tool seems to be stuck
Date: Sun, 29 May 2011 21:41:30 +0200
Message-ID: <BANLkTikJJiW1-tYZeeshAUeSiNLhtFEGwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:64888 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1E2Tlb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 29 May 2011 15:41:31 -0400
Received: by pxi2 with SMTP id 2so2078974pxi.10
        for <linux-perf-users@vger.kernel.org>; Sun, 29 May 2011 12:41:31 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I just wanted to give kvm-tool a try and it unfortunately seems to be
stuck somewhere:

$ ./kvm run --disk linux-0.2.img --kernel
../../../linux-2.6/arch/x86/boot/bzImage
  # kvm run -k ../../../linux-2.6/arch/x86/boot/bzImage -m 448 -c 4
  Warning: Unable to open /dev/net/tun
PPrroobbiinngg  EEDDDD  ((eedddd==ooffff  ttoo  ddiissaabbllee))......  ookk

This is with kvm master at 6dfc8581f14d355a89e7edaf4394ee8c69177f1f
(cloned this evening).

Could anybody tell me what I did wrong ?

Thanks
-- 
Francis
