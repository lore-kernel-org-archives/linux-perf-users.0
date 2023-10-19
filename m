Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557114AB7
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRec+XUd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55A8129
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697704100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WbD//j60bqg4EDgJFHW9oU4iT8YZktt3CxKCn3h+KIE=;
	b=RRec+XUdTpgDUl/P0KF8hckdXVHq6mIiOvUCdwY8JbbqV6aVbsWihCDv5io3F9YJcfTqLr
	sVRX5U/8p3pwGic2UbRvsx97Br7DkcHZGv92ji2oKfP1NEQ0LMhdXwNXR4NrRwL19/AiRr
	jyRhHA6n3uxFCZaQN4AkZzZEYAktkvI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-WfkLoPpTPiCrS_SfM6kdpQ-1; Thu, 19 Oct 2023 04:28:18 -0400
X-MC-Unique: WfkLoPpTPiCrS_SfM6kdpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D4CC869ECF
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Oct 2023 08:28:18 +0000 (UTC)
Received: from Diego (unknown [10.39.208.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3B31C060B0;
	Thu, 19 Oct 2023 08:28:17 +0000 (UTC)
Date: Thu, 19 Oct 2023 10:28:15 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: linux-perf-users@vger.kernel.org
cc: vmolnaro@redhat.com
Subject: perf sampling count/freq/period strange bahavior
Message-ID: <alpine.LRH.2.20.2310191027320.11297@Diego>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hello all...

We have encountered a strange behavior related to sampling. Generally
said, the number of samples is usually much lower than it should be.

Let's say, for load L, `perf stat -e instructions -- L` shows around
250,000 event hits. If I understand the concept of `-c` option for
`perf record`, with `-c 250` it should make the counter overflow and
generate a sample for every 250th event hit, so, it should result into
~1000 samples.

Instead I am getting something like ~62-150 samples, for example 124.
I have checked in dmesg that kernel has not throttled anything. When
running `perf report --stdio`, I see in the header that there were 0
samples lost (so the buffer was consumed fast enough). Additionally,
`perf report --stdio` tries to estimate the actual event count:

  Event count (approx.): 31000

(Which is because 250 * 124 = 31000, so perf itself considers this
formula (n_of_samples * sampling_rate = n_of_events) valid.)

But in reality, this is not the case, `perf stat`, as said, never
shows that low number of events for the same load.

What else is involved in the sampling rates and why the number of
samples is so much lower than it should be?

Thank you for ideas!

Michael

