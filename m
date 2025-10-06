Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C00242D6F
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773448; cv=none; b=WKE4AKw+LxIO0kdx8br9u/ghY1fuwrksW2Yjr84ELXBJ2OnseCPWXvWg3l0N2oQpFjyYQy1xDIVNDmweeQjwtuPtsnMCWTzb+bkm48BUqSSjk18NMFoM4dNjJLJ554qQ1UYuEmiUkCkZjt4E3obIYxuQBnVLEOvJBKGA8/IY1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773448; c=relaxed/simple;
	bh=yIYBqrQomdIerl3sIvzLi+Z7Q4SYsWp9cnhRoeCFjb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecQHFytlXKXB0/umK8tKjPZVSjzKPJoBG7V2w8zlijs84EB8L2LOtfngvbLxB+e9sarH0ugbhqv9O3cYtVP5+qS4y1Ev6EeV5BfDI2bl31wtcuDWBR4opJK41DnC654iN7ibOrJsXxcnEdI8ggqXsx41XNUkBZ1Y3pdZ2ZPKGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ac8aLtj9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ac8aLtj9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2K1OAGzrXdshRn6pbWsHptgJhVI74TubPDOsAQiQxzA=;
	b=Ac8aLtj92atsJFU/DrXSFAjtHsPXeN7PW1uK18aIRh6rPf8gpwE6WoQeLAFUbiNxugzm0j
	GueQ3Np8GN477WjLmSl6i8Yu9kpm8T+7fnFY56b+uXw+wzwnZsfGC45DVl8+GAP/ALksbr
	nAuSEyLTGk1dB2z8BFV/NjMOSDbeyow=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-bnqe3_xhMCK9nvfMftqBmQ-1; Mon,
 06 Oct 2025 13:57:19 -0400
X-MC-Unique: bnqe3_xhMCK9nvfMftqBmQ-1
X-Mimecast-MFC-AGG-ID: bnqe3_xhMCK9nvfMftqBmQ_1759773437
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B89F1955EAC;
	Mon,  6 Oct 2025 17:57:15 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.22.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1EEA19560A2;
	Mon,  6 Oct 2025 17:57:12 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	irogers@google.com,
	namhyung@kernel.org
Cc: jmario@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 0/4] perf c2c: Detect shared memory cachelines
Date: Mon,  6 Oct 2025 19:57:06 +0200
Message-ID: <20251006175710.1179040-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello.

Currently, perf-c2c tool has no means to discover a scenario when
there is a single cacheline in shared memory, which is mapped to
multiple different virtual addresses.

This patchset adds a mechanism to detect this. First, an "S" flag
suggests that such scenario may occur (a cacheline in shared memory
is captured). Additinally, another option is added (--detect-shm),
which zooms to the SHM cacheline and shows the physical addresses too.

Jiri Olsa has drafted this feature some time ago. I have rebased it
to current kernel repository shape and reworked several things in it
after some discussions with Joe Mario.

Thanks for thoughts and comments.

Michael


Michael Petlan (4):
  perf tools: Remove /SYSV from no_dso maps
  perf c2c: Add shared mem flag
  perf c2c: Add map name for cacheline
  perf c2c report: Add --detect-shm option

 tools/perf/builtin-c2c.c    | 178 +++++++++++++++++++++++++++++-------
 tools/perf/builtin-inject.c |   4 +-
 tools/perf/util/map.c       |   5 +-
 tools/perf/util/map.h       |   6 +-
 4 files changed, 154 insertions(+), 39 deletions(-)

-- 
2.47.3

