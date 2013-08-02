From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf record + perf report
Date: Fri, 02 Aug 2013 14:07:47 -0700
Message-ID: <878v0j6bto.fsf@tassilo.jf.intel.com>
References: <loom.20130729T104749-103@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6904 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab3HBVIN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 2 Aug 2013 17:08:13 -0400
In-Reply-To: <loom.20130729T104749-103@post.gmane.org> (Etem's message of
	"Mon, 29 Jul 2013 08:52:20 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Etem <etem_deniz@hotmail.com>
Cc: linux-perf-users@vger.kernel.org

Etem <etem_deniz@hotmail.com> writes:

> I am running Ubuntu 11.10 64bit on x86_64 machine with 4 core and 
> hyperthreading enabled. I am using the following commands in order to get 
> per-thread performance characteristics of a multi-threaded application. 
> "perf record -s -e cycles,instructions,cache-references,cache-
> misses,branches,branch-misses /PATH/TO/APPLICATION". "perf report -T --
> stdio".

AFAIK per thread display mode has been broken for a long time.

Best you file a bug on http://bugzilla.kernel.org on perf.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
