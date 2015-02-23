From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Bizarre results from perf event API
Date: Mon, 23 Feb 2015 12:44:24 -0800
Message-ID: <87sidwuzmf.fsf@tassilo.jf.intel.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34524 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbbBWUoY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Feb 2015 15:44:24 -0500
In-Reply-To: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	(Benjamin Moody's message of "Fri, 20 Feb 2015 23:26:10 +0000")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Benjamin Moody <benjamin.moody@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Benjamin Moody <benjamin.moody@gmail.com> writes:
>
>   pe.pinned = 1;                /* always track */

You definitely don't want pinned

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
