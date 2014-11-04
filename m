From: Andi Kleen <andi@firstfloor.org>
Subject: Re: sampling and reading
Date: Tue, 04 Nov 2014 13:08:04 -0800
Message-ID: <87ioiuk72j.fsf@tassilo.jf.intel.com>
References: <loom.20141104T212325-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52161 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbaKDVIG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 16:08:06 -0500
In-Reply-To: <loom.20141104T212325-617@post.gmane.org> (Arnav's message of
	"Tue, 4 Nov 2014 20:27:08 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnav <arnav.gupta06@live.in>
Cc: linux-perf-users@vger.kernel.org

Arnav <arnav.gupta06@live.in> writes:

> i am working on a project where i need to find program counters for every 100M 
> instructions.
>
> i have used the  following command to record the event
>
> perf record -e instructions -c 100000000 ./filename
>
> now, since counters are counted every 100M instructions, i read file using 
> 'perf report'. But i get results in some percentage form and not in numerical 
> numbers format.
>
> i wish to read the file and gather the perforamance counter statistics. 
> Plz suggest how to get the desired results.

Use perf script instead of perf report.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
