From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perfconfig : what does mean annotate.show_nr_jumps ?
Date: Tue, 17 Feb 2015 12:35:09 -0800
Message-ID: <874mqkxon6.fsf@tassilo.jf.intel.com>
References: <54E312EC.7010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36535 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbbBQUfK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Feb 2015 15:35:10 -0500
In-Reply-To: <54E312EC.7010804@gmail.com> (taeung's message of "Tue, 17 Feb
	2015 19:07:40 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

taeung <treeze.taeung@gmail.com> writes:
>
> What does mean the number '1' in front of address such as  " 1 13a9: " ?

The number of branches branching to that address.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
