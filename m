From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: sampling and reading
Date: Wed, 05 Nov 2014 11:41:43 +0900
Message-ID: <87ppd2xtaw.fsf@sejong.aot.lge.com>
References: <loom.20141104T212325-617@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:37043 "EHLO
	lgemrelse6q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaKEClp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 21:41:45 -0500
In-Reply-To: <loom.20141104T212325-617@post.gmane.org> (Arnav's message of
	"Tue, 4 Nov 2014 20:27:08 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnav <arnav.gupta06@live.in>
Cc: linux-perf-users@vger.kernel.org

Hi Arnav,

On Tue, 4 Nov 2014 20:27:08 +0000 (UTC), Arnav wrote:
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

How about using

  perf report --show-total-period

?

Thanks,
Namhyung
