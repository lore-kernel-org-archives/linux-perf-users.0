From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Inlined functions in perf report
Date: Wed, 21 Dec 2016 10:58:23 +0100
Message-ID: <20161221095823.GA19249@sesse.net>
References: <20161220115954.GA35897@sesse.net>
 <20161220121755.GL3124@twins.programming.kicks-ass.net>
 <2027151.EnbG4A8ymx@milian-kdab2>
 <20161220135450.GA32756@kernel.org>
 <20161220140822.GA10075@sesse.net>
 <20161220143746.GD32756@kernel.org>
 <20161220170108.GA6467@sesse.net>
 <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:59532 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760099AbcLUJ6l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Dec 2016 04:58:41 -0500
Content-Disposition: inline
In-Reply-To: <df263fe1-e1af-881b-311e-5329bb51db0e@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, "Liang, Kan" <kan.liang@intel.com>

On Wed, Dec 21, 2016 at 08:53:33AM +0800, Jin, Yao wrote:
> I just pull my repo with the latest perf/core branch, and apply the patch
> one by one (git am 0001/0002/.../0005), they can be applied. Maybe you have
> to do like that because the mails are probably coming out of order.

OK. I applied everything on top of the branch you suggested, and now it's
compiling. But seemingly I don't have too much success; on a quick check
(perf record -p <pid> -g, perf report --inline) I don't get anything marked
as (inline), but I get these warnings:

BFD: Dwarf Error: found dwarf version '6931', this reader only handles version 2, 3 and 4 information.
BFD: Dwarf Error: found dwarf version '18896', this reader only handles version 2, 3 and 4 information.

and so on for many seemingly random version numbers.

It may have been that the stack traces I happened to check don't actually
have any inlined functions in them (the load was a bit different from what
I've looked at earlier), but the BFD errors are new from what I can see.

/* Steinar */
-- 
Homepage: https://www.sesse.net/
