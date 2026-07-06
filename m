Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8A424641
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339366; cv=none; b=dtiGN0/5ikCA62uI/gWO7eldpoL9zGAgVtxFtS56BFHEIHF+YDi/SSacAL+ccbNLHp29Hdo7AuoILHSwj9/jdJoeLLsGtJYlVqRPOxDeE/vjJiYssgFFMQzoyc/u88ly/zdU5ojwnJr+Te9CdtjzsIpaVn3wB0i9oh2aSwR0aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339366; c=relaxed/simple;
	bh=5OzzRBkqv5shnpjJGB1yKfPY6YBZX2VAOjcBBySgaxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3hePwsYLvunHtVpz0qh4q+0MNszFau2c0lAydddaQyA0edmlueZ9tWY7zPkcpwY1lRFrZBer33mxn8y0Xb2+VVLhvCwWvmLWca8fJiX2ZP2H1Riy6hyz42q9bsI4xvOkpMeoH1nM93omN4siMQ3Rg71tDby76wgWymQ7V1Kyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heVMYusT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heVMYusT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783339364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TNbmDJ8yv71XW6Zt7jckZQoQwWxn1/Tz59wt93140ho=;
	b=heVMYusTBxUj7U6SFoe1yxh9iRhTG/N8ddo/Wz1ViphDRfMyNCZWlObk10BmA4NKecG9mO
	ZjxR12jiaX9cRhHvy1aFoUyILOjTO90vIL6ySdwoz86UI27eF8aM+QRy4RpdX+PBuK30wa
	0qQDCYTmw3oablkvJAK92GiaO3uPNhc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-YMjoI1w3P_-0kvO10rTivw-1; Mon,
 06 Jul 2026 08:02:41 -0400
X-MC-Unique: YMjoI1w3P_-0kvO10rTivw-1
X-Mimecast-MFC-AGG-ID: YMjoI1w3P_-0kvO10rTivw_1783339359
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D54C1955F23;
	Mon,  6 Jul 2026 12:02:38 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.49.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 839AF1956088;
	Mon,  6 Jul 2026 12:02:33 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Viktor Malik <vmalik@redhat.com>,
	Howard Chu <howardchu95@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v3 0/2] perf trace: Refactor augmented_raw_syscalls using bpf_for
Date: Mon,  6 Jul 2026 14:02:26 +0200
Message-ID: <cover.1783339165.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The loop for processing syscall args in augment_raw_syscalls has a
history of breaking with Clang updates. In the past, we've seen it break
(i.e. stop passing the BPF verifier) between Clang 15 and 16 and now a
similar thing happened between Clang 21 and 22. While the issue is
mitigated on the main line by a recent verifier update, it remains
broken on the 6.12 and 6.18 stable branches, effectively breaking
`perf trace`.

The reason is that the loop is quite complex and the BPF verifier often
struggles to prove that it terminates.

This series fixes the issue by replacing the standard for loop by the
bpf_for macro, which uses numeric BPF iterator. This should prevent
future breakages of this kind since the verifier has much easier job
proving that the loop terminates. Small adjustments were necessary for
the loop to make it work, see the second commit message for details.

To keep perf compatible with older kernels, the first commit factors out
the loop body into a function, which is then called either from bpf_for
or from a standard for loop, depending on whether BPF numeric iterators
are available.

Changes from v2:
- v2: https://lore.kernel.org/bpf/cover.1783070132.git.vmalik@redhat.com/T/
- Small refactoring suggested by Namhhyung
- Make `size` in augment_arg() an int (found by Sashiko)
- Keep the original way of clamping aug_size to TRACE_AUG_MAX_BUF (found
  by Sashiko)

Changes from v1:
- v1: https://lore.kernel.org/bpf/akWqIfWPMCdaGgGg@google.com/T/
- Use bpf_for instead of bpf_loop (suggested by Alexei and Andrii)
- Keep the change backwards compatible with older kernels (required by
  Namhyung)

Viktor Malik (2):
  perf trace: Factor out BPF loop body
  perf trace: Refactor augmented_raw_syscalls using bpf_for

 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 155 +++++++++++-------
 1 file changed, 98 insertions(+), 57 deletions(-)

-- 
2.54.0

