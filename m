Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE33CB2D2
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074753; cv=none; b=BXXuyO4+pQ0eypboljMmBs4STobafdEUjyrq02Yg7fFiYnxNIoZYr2K+F9l0+OT30W/MnFLmJJDO3wroTZdz+4JAuZLVMoF3sdnq7MHfWXQ6a/fZxzT3ht8AcqPQ77+UEcFe2J4dkvOyoNPWJ100y6Wn1lHoc6RVG71oGWvI5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074753; c=relaxed/simple;
	bh=ta6JMRCFXjLUeBnG81+mh3Tb+SbSzVoUS2YdVhYtjLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvFxcenvqvHYl1aYddbxYQv+RMVBTwzoc6iI/BRhCYgor/I9YZnkjgrQwjf6f1TmsW5CUqW6ydsm0sypRzIZvOgClqhYyFZEm9Tz9WHlfAT7J6DtxHSkitp2C26x9mLYTBGpszwyQiX0pT9wPJM6Rwf+WIHpnHVbfCuM8/Gjpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik5eeMmn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik5eeMmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783074751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTcEU/gYSHD4siSL1yLnl+9JECGjezlJB6+NroTCcbw=;
	b=ik5eeMmnmuPStKEdLried7ErQV5NW3UZN/B/hXVJ/VBFYpXRakFIWo9phkCGHKutnQTT+C
	fp11+2nKdWjIFhywNIX8j5d/qDrLCX0vfDWKunRYjYECSfvS8b9TpTG2KahgKIPIWVXK0X
	I+26+HCnFSvFFcEepf/T9/aFldA3+fA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-Tm6V7Rp9PLS8mGoW_M28NQ-1; Fri,
 03 Jul 2026 06:32:27 -0400
X-MC-Unique: Tm6V7Rp9PLS8mGoW_M28NQ-1
X-Mimecast-MFC-AGG-ID: Tm6V7Rp9PLS8mGoW_M28NQ_1783074745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C184195395E;
	Fri,  3 Jul 2026 10:32:25 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.34.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB4DC1956095;
	Fri,  3 Jul 2026 10:32:18 +0000 (UTC)
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
Subject: [PATCH v2 0/2] perf trace: Refactor augmented_raw_syscalls using bpf_for
Date: Fri,  3 Jul 2026 12:32:13 +0200
Message-ID: <cover.1783070132.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

