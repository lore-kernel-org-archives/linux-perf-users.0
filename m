From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Callgraph like kcachegrind
Date: Thu, 28 Jun 2012 14:59:39 +0200
Message-ID: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42079 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2F1NAU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Jun 2012 09:00:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SkEKV-0008IX-Ik
	for linux-perf-users@vger.kernel.org; Thu, 28 Jun 2012 15:00:15 +0200
Received: from bg-1.or.uni-bonn.de ([131.220.141.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jun 2012 15:00:15 +0200
Received: from bartoschek by bg-1.or.uni-bonn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jun 2012 15:00:15 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

is it somehow possible to get a callgraph like gets it from kcachegrind?

I tried to use -g/-G on a program that runs but the information is not as 
expected. I do not see how the 100% runtime of main() is distributed.

Christoph
