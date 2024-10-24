Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82F5FEED
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787813; cv=none; b=p+enEQ8y2JJ2vWSDavi552j4d2AERgW3YL/LXor2NJhbaLyLVq+SI8kM9wsKpKotenJfJpm5KwLjmCLsjwk8zAcYrR8ArDyo/YHA40rptM8hoJcwTmUEoZhz8TJ63lEFQLYvkQw/w9RpL9/H3mF1X1ki0X/Kon695QYVSalsRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787813; c=relaxed/simple;
	bh=SDCvV8aE6hdIf4M8P8Q+cOyK6lnxNUXKQPWiu6Jri7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkafS6Rjwi5YiSCRMXTKmFsZhU25PG18Y43Ae2zG5U5giFXJIOWMd6g3w6RhB8ARJEyKS35189QJeqA53RrEMI2OSAl20GlEZm3QHLslg1MTdSeB9XOwX2LNeEjXl6CtwSz2Cxt1XoVfbCe7MhmO8hOR/0cu3t0bBv9CvgOxR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cz/KHKCA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz/KHKCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729787809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j+nv3eEwAGh0frH05xjtAGDDHesSMoZyNGwhnkoHhXw=;
	b=cz/KHKCAR5SECMAgwwe9V4oJ9wC8nDSEWeEjs1NJSbemsSasZIJCedlTDriIQ5CjQ9iJpp
	ccFvPqMWvoAs2rFojWIF1Lv26WzCNyOhgpYzrv+M8IGNrUkHcas+Nc3VWisSdtDMmI1E0a
	USOD5VWgaUJPpps97Y04qMlryLvtOPk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-S_TOOROzPRuUIq22LfKHPg-1; Thu,
 24 Oct 2024 12:36:46 -0400
X-MC-Unique: S_TOOROzPRuUIq22LfKHPg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B56F91955EA9;
	Thu, 24 Oct 2024 16:36:43 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 075F1196BB7D;
	Thu, 24 Oct 2024 16:36:40 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org
Cc: mpetlan@redhat.com,
	kan.liang@linux.intel.com,
	irogers@google.com,
	acme@redhat.com,
	ak@linux.intel.com,
	alexander.shishkin@linux.intel.com,
	namhyung@kernel.org
Subject: perf sched timehist --state vs perf script
Date: Thu, 24 Oct 2024 18:36:30 +0200
Message-ID: <20241024163630.24882-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

Hello!

We encountered an issue with 'perf sched timehist --state' when
we expected for a test case that the process of a workload would 
eventually end in the dead state(marked by 'X') and be switched
out. This can be seen also by using 'perf script':

    # perf sched record -a sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.167 MB perf.data (166 samples) ]
    # perf script | grep sleep
           sleep  151541 [000] 193461.410617: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=3132275 [ns]
           sleep  151541 [000] 193461.410624:       sched:sched_switch: sleep:151541 [120] S ==> swapper/0:0 [120]
         swapper       0 [000] 193462.410688:       sched:sched_waking: comm=sleep pid=151541 prio=120 target_cpu=000
         swapper       0 [000] 193462.410698:       sched:sched_switch: swapper/0:0 [120] R ==> sleep:151541 [120]
         :151541  151541 [000] 193462.411100: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=407210 [ns]
         :151541  151541 [000] 193462.411107:       sched:sched_switch: sleep:151541 [120] X ==> swapper/0:0 [120]

But for the 'perf sched timehist --state' the process is shown
in the zombie state when it is being switched out:

    # perf sched timehist --state | grep 151541
    Samples do not have callchains.
      193461.410624 [0000]  sleep[151541]                       0.000      0.054      3.129      S 
      193462.411107 [0000]  :151541[151541]                     0.000      0.000      0.408      Z 

Shouldn't both commands report the same result, or is there a reason
why 'perf script' uses the dead state while 'perf sched' uses dead?
It also seems that the 'perf sched' cannot read the name of the zombie
process, but that can be a different issue.

Thanks,

Veronika

