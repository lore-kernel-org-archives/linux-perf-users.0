From: Jerome Correnoz <jerome.correnoz@st.com>
Subject: Re: Is it possible to get source code annotation for kernel modules ?
Date: Mon, 15 Dec 2014 08:51:36 +0000 (UTC)
Message-ID: <loom.20141215T094546-812@post.gmane.org>
References: <loom.20141126T215923-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57223 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbaLOIv5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Dec 2014 03:51:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1Y0RNg-0002Ju-Sf
	for linux-perf-users@vger.kernel.org; Mon, 15 Dec 2014 09:51:53 +0100
Received: from 77.242.202.232 ([77.242.202.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2014 09:51:52 +0100
Received: from jerome.correnoz by 77.242.202.232 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2014 09:51:52 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Could someone please provide support on it ? 

We would like to know if 'perf annotate' can allow to display the C source
code interleaved with disassembly for the kernel modules (we can get it only
for user space application. For kerne modules, we only have the
disassembly). Is it feasible for kernel modules ?

Regards,
  Jerome 
