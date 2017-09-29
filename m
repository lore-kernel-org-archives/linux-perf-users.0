From: Milian Wolff <milian.wolff@kdab.com>
Subject: hotspot (Linux perf GUI) v1.1.0 available - now with timeline and record features
Date: Fri, 29 Sep 2017 14:51:18 +0200
Message-ID: <7930902.vyxaDBhfys@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:38840 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdI2MvU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Sep 2017 08:51:20 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

Hey all,

I have the pleasure to announce the availability of hotspot v1.1.0. 
Hotspot is a GUI for Linux perf. Right now, it's a drop-in replacement for 
(parts of) `perf report`. It aims to be easier to use, but comes with powerful 
features to analyze the profiler data. This new release adds a graphical event 
timeline as well as a graphical form to run perf on either newly launched 
applications or to attach to already running processes.

The full release announcement contains pretty screenshots:

https://www.kdab.com/hotspot-v1-1-0-adds-timeline-recording-features/

You can download the release tarball from GitHub, as well as a portable 
AppImage, so there's no need to install anything:

https://github.com/KDAB/hotspot/releases/tag/v1.1.0

Thanks, hope you like it. If so, please consider contributing:

Patches: https://github.com/KDAB/hotspot/pulls
Bug Reports: https://github.com/KDAB/hotspot/issues

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
