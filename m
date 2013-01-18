From: Jeff Johnson <jerojohn@ucsc.edu>
Subject: Re: perf not measuring LLC events?
Date: Fri, 18 Jan 2013 16:28:51 +0000 (UTC)
Message-ID: <loom.20130118T172647-728@post.gmane.org>
References: <loom.20121215T192044-606@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33431 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3ARQev (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Jan 2013 11:34:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TwEuF-0006ex-O1
	for linux-perf-users@vger.kernel.org; Fri, 18 Jan 2013 17:35:04 +0100
Received: from delaware-204-222.ucsc.edu ([128.114.204.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jan 2013 17:35:03 +0100
Received: from jerojohn by delaware-204-222.ucsc.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jan 2013 17:35:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dervin Thunk <dervin.thunk <at> gmail.com> writes:

> 
> Dear all,
> 
> I'm trying to measure the LLC events of a program. I'm running
> linux-tools-3.2.0- 34 on a fairly recent 4 core Intel machine. For a
> certain program that reads a 64 MB file into memory, I get
> 
>  Performance counter stats for './algo data/E.dna':
> 
>                  0 LLC-loads                                                   
>                  0 LLC-load-misses


Dervin, 
I am experiencing the same issue. I am running perf on an i5 machine. Have you 
gotten any feedback regarding this? 
-Jeff
