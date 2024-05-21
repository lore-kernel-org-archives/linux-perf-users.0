Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8DC28DA0
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310487; cv=none; b=nA1feGG3gCzHoijVfVJXLTL/0xOD17yhGZzqYwKIj5e3xWvxpG/wRlfGWCeZ1z6YrO7YCbpGfR1q+erAtoX1W0IuZq+x39riV862ZsLEZxEdqjFaj69sEnzhO6oU1W/UVONZRYxbV4qM43HlrgQfljNFqdu9UH+hHPkSwqrh1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310487; c=relaxed/simple;
	bh=u+E6REgtt4LmBWcn1J39wz0rLp+zw/Txu+ik6PwwCrU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=JiRTy+ZnN7+35kS6QIQqYjCRJJM97a10wyuUAJj40UgIh543SBNnc9pe2psd7fO/Mx11TldY/JhNnsfYAxAD4Jk6olqAUS5VdiaQL3UIB1ZkK5f7nx1dGNf6BR2OFQK4MqSJe3++WfjuyZHYasBz+lT8OhwbcbXxZx7E+jX3mzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKcVsnil; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKcVsnil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716310484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RwKKN24ApkrMKnad1o3adB3dZNyuUNkwimjIpYmbzMg=;
	b=DKcVsnilvi3uhOE/o48U5XaAYXtyC8MZ+9IvVKpJnZ1tm+nTv97BvLm4OTXXpzKTpWpuEx
	mcaQTH4BueVPn1MRJ3iAcsbxIRz7pl9aNm6HkUbROaO9pTh+V4veoPepztCiCLld6m4BsK
	ZtbzgNICyanjf1qAfTbCL6K9ECW/+xo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-ESlZfNLiOE-IlOotURCzwg-1; Tue,
 21 May 2024 12:54:41 -0400
X-MC-Unique: ESlZfNLiOE-IlOotURCzwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F18DB380673B;
	Tue, 21 May 2024 16:54:40 +0000 (UTC)
Received: from Diego (unknown [10.39.208.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEF25C15BB1;
	Tue, 21 May 2024 16:54:38 +0000 (UTC)
Date: Tue, 21 May 2024 18:54:35 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: linux-perf-users@vger.kernel.org
cc: vmolnaro@redhat.com, kan.liang@linux.intel.com, irogers@google.com, 
    acme@redhat.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: perf stat VERSUS perf stat report :: TopDown Metrics
Message-ID: <alpine.LRH.2.20.2405211842450.4040@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hello!

I have a test for perf-stat record/report functionality, which compares the outputs,
basically whether `perf stat report` is able to reconstruct the same results as
printed by `perf stat`. In the Intel environments with TopDown events/metrics, the
test started failing on the fact that perf-stat-report has a different approach to
handle the metrics:

================================ perf stat ================================
 Performance counter stats for 'ls':

              0.69 msec task-clock                   #    0.477 CPUs utilized
                 0      context-switches             #    0.000 /sec
                 0      cpu-migrations               #    0.000 /sec
                97      page-faults                  #  139.648 K/sec
         1,776,212      cycles                       #    2.557 GHz
         1,970,435      instructions                 #    1.11  insn per cycle
           403,140      branches                     #  580.389 M/sec
            11,837      branch-misses                #    2.94% of all branches
                        TopdownL1             #     30.0 %  tma_backend_bound
                                              #     13.0 %  tma_bad_speculation
                                              #     37.5 %  tma_frontend_bound
                                              #     19.5 %  tma_retiring
                        TopdownL2             #     12.1 %  tma_branch_mispredicts
                                              #     11.7 %  tma_core_bound
                                              #     13.2 %  tma_fetch_bandwidth
                                              #     24.3 %  tma_fetch_latency
                                              #      3.1 %  tma_heavy_operations
                                              #     16.3 %  tma_light_operations
                                              #      1.0 %  tma_machine_clears
                                              #     18.3 %  tma_memory_bound

       0.001456908 seconds time elapsed

       0.000000000 seconds user
       0.001647000 seconds sys

================================ perf stat report ================================
 Performance counter stats for '/usr/bin/perf stat record ls':

              0.69 msec task-clock                   #    0.477 CPUs utilized
                 0      context-switches             #    0.000 /sec
                 0      cpu-migrations               #    0.000 /sec
                97      page-faults                  #  139.648 K/sec
         1,776,212      cycles                       #    2.557 GHz
         1,970,435      instructions                 #    1.11  insn per cycle
           403,140      branches                     #  580.389 M/sec
            11,837      branch-misses                #    2.94% of all branches
        10,657,272      TOPDOWN.SLOTS
         2,089,661      topdown-retiring
         4,053,942      topdown-fe-bound
         1,964,281      topdown-mem-bound
         3,218,078      topdown-be-bound
           334,345      topdown-heavy-ops
         1,295,589      topdown-br-mispredict
         2,632,973      topdown-fetch-lat
         1,379,176      topdown-bad-spec
            21,248      INT_MISC.UOP_DROPPING        #   30.590 M/sec

       0.001456908 seconds time elapsed

While perf-stat (and perf-stat-record) calculates the percentages, perf-stat-report
just prints the raw numbers. Thinking about it, it might be useful to know the raw
numbers too, but rather via an option, while by default, both should behave the same,
shouldn't they? Is perf-stat-report missing some metric postprocessing?

Thanks!

Michael

