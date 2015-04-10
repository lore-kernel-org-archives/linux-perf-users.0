From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Uncore event for one process
Date: Fri, 10 Apr 2015 05:14:33 -0700
Message-ID: <87twwonpsm.fsf@tassilo.jf.intel.com>
References: <78FDB3A8-3F50-43F8-A69D-D7C6A37A2859@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14199 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714AbbDJMOg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Apr 2015 08:14:36 -0400
In-Reply-To: <78FDB3A8-3F50-43F8-A69D-D7C6A37A2859@gmail.com> (Tianwei Zhang's
	message of "Tue, 7 Apr 2015 01:57:20 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tianwei Zhang <artdream07@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Tianwei Zhang <artdream07@gmail.com> writes:
>
> Can anyone help me with this problem?

uncore monitoring is only supported socket wide.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
