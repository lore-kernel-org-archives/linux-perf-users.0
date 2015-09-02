From: Dennis Gnad <dennis.gnad@kit.edu>
Subject: Understanding timestamps in perf.data
Date: Wed, 2 Sep 2015 11:28:00 +0200
Message-ID: <55E6C120.3030504@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:46440 "EHLO
	scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777AbbIBJzO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 2 Sep 2015 05:55:14 -0400
Received: from kit-msx-29.kit.edu ([2a00:1398:9:f612::29])
	by scc-mailout-kit-02.scc.kit.edu with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA384:256)
	(envelope-from <dennis.gnad@kit.edu>)
	id 1ZX4Kw-0002M0-Vh
	for linux-perf-users@vger.kernel.org; Wed, 02 Sep 2015 11:28:15 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am interested in timestamped performance counter data (with a 
specified sampling rate) as there is supposed to be saved in perf.data 
when I use "perf record -T".

However, I don't understand the complete output of "perf report -D", and 
can't figure out which parts of it are the timestamps. Is there any 
documentation that I overlooked?

Actually if it helps, I am only interested in the name/raw event, value, 
and timestamp, without any code/library information. Maybe the 
information on which CPU it is from (on a multicore) could be 
interesting as well.

Do I need to start looking into the code? Any good place to start? I 
probably need to do this anyway, instead of parsing the really large 
perf report -D output.

Thanks for your help and best regards,
Dennis
