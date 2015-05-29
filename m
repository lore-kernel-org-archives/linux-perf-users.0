From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC] Add --show-total-period for perf annotate
Date: Fri, 29 May 2015 08:55:49 -0700
Message-ID: <877frridiy.fsf@tassilo.jf.intel.com>
References: <555F3F8A.6000204@suse.cz> <87mw0wc4vt.fsf@tassilo.jf.intel.com>
	<5562D33F.70706@suse.cz> <20150525151450.GK19417@two.firstfloor.org>
	<5564685D.1020204@suse.cz> <20150526170316.GO19417@two.firstfloor.org>
	<55658462.1000605@suse.cz> <20150527140431.GT19417@two.firstfloor.org>
	<55686262.7010307@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63024 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932349AbbE2Pzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 29 May 2015 11:55:52 -0400
In-Reply-To: <55686262.7010307@suse.cz> ("Martin =?utf-8?Q?Li=C5=A1ka=22's?=
 message of "Fri, 29
	May 2015 14:58:10 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>

Martin Li=C5=A1ka <mliska@suse.cz> writes:
>
> Following patch sums samples that belong to a line in assembly langua=
ge.
> What do you think about it, would it be acceptable solution?

Basic patch looks good to me now. Thanks.

The only ugly thing is the global variable, perhaps that could be
cleaned up.

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only
