From: Kumar Ranjit-B04060 <B04060@freescale.com>
Subject: Not able to profile a 64bit application
Date: Fri, 3 Jun 2011 09:21:41 +0000
Message-ID: <8CB5FB7FBAFD274A8E92A53BBAFE339D0D33F4@039-SN1MPN1-003.039d.mgd.msft.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
 <20110602192018.GA21739@ghostprotocols.net>
 <20110602192249.GB21739@ghostprotocols.net>
 <20110602192427.GC21739@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:29458 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab1FCJWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 3 Jun 2011 05:22:43 -0400
Received: from mail118-tx2 (localhost.localdomain [127.0.0.1])	by
 mail118-tx2-R.bigfish.com (Postfix) with ESMTP id 05ECDE603DD	for
 <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2011 09:22:40 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.248])	by
 mail118-tx2.bigfish.com (Postfix) with ESMTP id 371CB12A0162	for
 <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2011 09:21:43 +0000 (UTC)
In-Reply-To: <20110602192427.GC21739@ghostprotocols.net>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

I am able to do profiling using perf record and report for a 32 bit application but for 64 bit application, its not able to resolve the symbols.
Anyone faced similar problem??
I am doing this for e5500 core.

Regards

Ranjit Kumar
System Performance Team
Freescale 
