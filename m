From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Sun, 15 Dec 2013 13:18:40 -0800
Message-ID: <877gb5vmmn.fsf@tassilo.jf.intel.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6175 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab3LOVSl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 15 Dec 2013 16:18:41 -0500
In-Reply-To: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	(Manuel Selva's message of "Thu, 12 Dec 2013 15:06:04 +0100 (CET)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: linux-perf-users@vger.kernel.org

Manuel Selva <manuel.selva@insa-lyon.fr> writes:
>
> perf mem -t load rec -c 1 make -j18

With -c1 on such a frequent event you will not sample much, but just
throttle a lot, as the PMI handler would use too much time. 
Your numbers are likely garbage.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
