From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
Subject: perf top -z not working?
Date: Wed, 17 Oct 2012 08:26:53 -0400
Message-ID: <507EA40D.60206@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bureau84.ns.utoronto.ca ([128.100.132.184]:57602 "EHLO
	bureau84.ns.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756147Ab2JQNnu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Oct 2012 09:43:50 -0400
Received: from [192.168.0.100] (69-165-148-254.dsl.teksavvy.com [69.165.148.254])
	(authenticated bits=0)
	by bureau84.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id q9HCQkxh005716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Oct 2012 08:26:47 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

(Please CC me in replies, not a list member)

It seems that `perf top -z' does not behave as advertized, at least not 
on the 3.2.0-25 kernel (Ubuntu) that I'm running. The man page states 
that it should "zero history across display updates" but the counts 
still seem to accumulate (the total samples reported rises 
monotonically) and processes still show up in the display long after 
they have exited. Pressing `z' or `Z' seems to have no effect, either.

Have I misunderstood this feature, or is this a bug that has perhaps 
been fixed in later kernel versions? I haven't been successful searching 
for information about it, beyond the man pages and what the perf wiki says.

Thanks,
Ryan
