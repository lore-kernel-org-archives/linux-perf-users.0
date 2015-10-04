From: Andi Kleen <andi@firstfloor.org>
Subject: Re: demangling of @plt entries
Date: Sun, 04 Oct 2015 09:03:16 -0700
Message-ID: <87zizyliyj.fsf@tassilo.jf.intel.com>
References: <1896568.Zv4hrWaDKC@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31728 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbbJDQDS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 4 Oct 2015 12:03:18 -0400
In-Reply-To: <1896568.Zv4hrWaDKC@agathebauer> (Milian Wolff's message of "Sat,
	03 Oct 2015 12:43:34 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Milian Wolff <milian.wolff@kdab.com> writes:
>
> c++filt --version
> GNU c++filt (GNU Binutils) 2.25.1

I had a similar patch before, but it seems the problem disappears when
binutils (or rather libiberty) is updated.

-Andi
