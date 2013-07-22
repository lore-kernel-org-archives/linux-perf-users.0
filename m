From: Milian Wolff <mail@milianw.de>
Subject: perf mem: invalid or unsupported event: 'cpu/mem-loads/pp'
Date: Mon, 22 Jul 2013 19:34:40 +0200
Message-ID: <6210395.6gJQB6qfUl@minime>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd24202.kasserver.com ([85.13.143.162]:51044 "EHLO
	dd24202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302Ab3GVRem (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 13:34:42 -0400
Received: from minime.localnet (dslb-092-078-025-029.pools.arcor-ip.net [92.78.25.29])
	by dd24202.kasserver.com (Postfix) with ESMTPSA id 7E820CFC167
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2013 19:34:41 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hey there,

I just found perf mem in the output of perf help and wanted to try it:

$ perf mem record ls
invalid or unsupported event: 'cpu/mem-loads/pp'
Run 'perf list' for a list of valid events

 usage: perf record [<options>] [<command>]
 ...

Am I missing a kernel configuration? Or what is going on here?

Cheers
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
