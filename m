From: Paul Clarke <pc@us.ibm.com>
Subject: perf annotate with sample counts
Date: Wed, 15 Jul 2015 19:55:35 -0500
Message-ID: <55A70107.3030106@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:42616 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbbGPAzp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jul 2015 20:55:45 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
	Wed, 15 Jul 2015 20:55:44 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A197738C8039
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2015 20:55:41 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6G0tfdm60031138
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2015 00:55:41 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6G0tf2e001838
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2015 20:55:41 -0400
Received: from oc3241255568.ibm.com ([9.80.209.201])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t6G0teJ0001819
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2015 20:55:41 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Is there a way to get perf annotate to display sample counts instead of, 
or in addition to, percentages?

The percentages seem relative to the function, which isn't as helpful in 
a global context.

Regards,
PC
