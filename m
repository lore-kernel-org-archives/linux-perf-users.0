From: Andreas Hollmann <hollmann@in.tum.de>
Subject: User defined metrics for perf stat?
Date: Sun, 31 Jan 2016 17:53:49 +0100
Message-ID: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:44186 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901AbcAaRBR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 31 Jan 2016 12:01:17 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id C5B9E1C247E
	for <linux-perf-users@vger.kernel.org>; Sun, 31 Jan 2016 17:53:51 +0100 (CET)
Received: by mail-qg0-f50.google.com with SMTP id 6so101313091qgy.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 Jan 2016 08:53:51 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi,

is there any way to create user defined metrics in perf stat?

Many hardware performance counters make only sense if you relate them
to other counters, so it would be nice to have it in perf.

I thought that I have seen something like that, but I coundn't find it again.

Best regards,
Andreas
