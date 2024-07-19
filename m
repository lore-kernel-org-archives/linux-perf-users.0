Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A639ACC
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382650; cv=none; b=oOrji62+sIHcZzZCM0lG/X8mFiGeVIFfze6mXnoG+zjzVDXDv+WIc/aibaRvU4xCOwvlgT6Ejc8TspmYr8pKPkrlAaXKl4s3Lr8eJjqPClS5e+urfh1gQwlRYtmSs3of8TNXqRmziwWoqmu/7prV4o2Av2YgJ9VbIi/MeIh6aD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382650; c=relaxed/simple;
	bh=wwYeozAgBA+ClUlk99VZwKGnz5BPWW/3jkA/R9DO66c=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=CRwClmALKr2evEs4WCHioAeQqmeuqRY3sndgqbfPcvTKsHBlRdcHbVH4nNiER4kIRLKF2HFwEZD1sPLk+8lNeVJ198WXvC/H3ZYq7NjVU54DXA8x3IMeUCKJjRh361+GGqiy+txjEtBDbSlBvVRXgPdqpLTEbiQJh7JNGVvCsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuAP7LHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuAP7LHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721382647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bbM4aFeishCM7G7vWkDhwSQwM6OdHKTI692O5zgJMHA=;
	b=MuAP7LHGwDQslcNwYLB/baCFVsSy3fHLnhDYElzheW1hGzEcyTsN1c7jLtfj/vakYuAKqH
	kvTGccUEeIypy72jf9kTCeMocr+2robMymCFJEeOVuzdY/n5fFT61D1R5gj/kdqAiB2DNy
	JeBo3OKqv0aRney2WJGxVR8B2tftHwA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-fG7l4bDnN3CSEtYEujuEEg-1; Fri,
 19 Jul 2024 05:50:39 -0400
X-MC-Unique: fG7l4bDnN3CSEtYEujuEEg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1CB71955D42;
	Fri, 19 Jul 2024 09:50:38 +0000 (UTC)
Received: from Diego (unknown [10.39.208.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B722195605A;
	Fri, 19 Jul 2024 09:50:36 +0000 (UTC)
Date: Fri, 19 Jul 2024 11:50:32 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: namhyung@kernel.org
cc: acme@redhat.com, vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Subject: perf test fail :: "perf stat --bpf-counters --for-each-cgroup
 test"
Message-ID: <alpine.LRH.2.20.2407191137440.11376@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-799602945-1721382637=:11376"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-799602945-1721382637=:11376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hello Namhyung,

we were investigating some test failures of the testcase mentioned
in $subj. We have narrowed it down to:

    # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 1 perf test -w thloop
    
    Performance counter stats for 'CPU(s) 0,1':
         <not counted>      cycles                           system.slice
         3,020,401,084      cycles                           user.slice                       
    
         1.009787097 seconds time elapsed

As seen, the system.slice is not counted properly in our case. It
happens even without bpf-counters being involved.

There were rumours that it might be caused due to too small system
load, but it apparently happens even when the load was replaced by
"thloop" workload from perf-test's workload library. However, even
so, if the load was insufficient, we'd see a value – 0 instead of
"not counted". The "<not counted>" result is printed if the counter
wasn't properly enabled and running.

Have you encountered this problem? What could cause it?

Thanks.
Michael
---1463784192-799602945-1721382637=:11376--

