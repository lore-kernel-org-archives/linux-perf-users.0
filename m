Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114A2076A4
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213051; cv=none; b=ob7FeVGISpvOC9O7WWMQ1RKtBGMCjFDEYX6oUK9PZwoMAzCSLHQVk2WFkx9Jud9gHam26Np1OxYE4MY86dEly2j9ZsB+gOWBPsFCsr1YjnkGrmeIWyOMWqIfqX6mFfYVqfZO2JB34qpTqA+OQ/g/rS9a/WDRsgh/PARBN2TG7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213051; c=relaxed/simple;
	bh=ZDWnivU9epDO2wwqKF9f942pu8WA85fR3AoRxuouQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIBrSNn4hoWUa9A+BUwnHw+J44hWNj9xitQ6/SxrWJzox/DFb4zNg4AKQxpLX/+fCPm9N2U514EJOZIPOWbtSECTKJUKO1EVsPYpacfxLIr1iONtB0p72YI+nNPEeUmXF7CDfV3knnwCLeI8mU5+edfERNr/7yJ6I1a/0xyGmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wl05xRrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wl05xRrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730213048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HiaNHtmelLWvgwh5fqUNp7JwQHgr8mn1+Tng2O5pQA0=;
	b=Wl05xRrAW++UxBtuCIab3QRXutBMMorm1v4jGsU+DIr6an7f4+eUaALpSqo62QWGvfCIBS
	ighG3+710TnHaG+9QpX3U1mvH25S9Ff/MrkwMHZyaiiucS50GutobqkFkkVnEeWWpdmfeX
	hcAwOt19e2mlAUprgkZ61LhhpqMp2os=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-qzAqueBKMV2WVTQFCXmTcQ-1; Tue,
 29 Oct 2024 10:44:03 -0400
X-MC-Unique: qzAqueBKMV2WVTQFCXmTcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE271956077;
	Tue, 29 Oct 2024 14:44:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.131])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A22781956086;
	Tue, 29 Oct 2024 14:43:54 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.co,
	kan.liang@linux.intel.com,
	yangyicong@hisilicon.com,
	tim.c.chen@linux.intel.com
Subject: [PATCH] perf test: Parse perf stat Topdown events for aarch64
Date: Tue, 29 Oct 2024 15:43:47 +0100
Message-ID: <20241029144347.25651-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

The 'perf stat' output on aarch64 machines with topdown events wasn't
counted for in the 'perf stat STD output linter' test case. Add the
topdown metric to the skip_metric list as it is done for topdown events
on other systems.

The Topdown events are also disabled on aarch64 KVM guests because the
value of caps/slots is set to 0 due to the part of the system register
being a stub. This prevents the metric for the topdown events from being
computed, leaving the 'perf stat' topdown metric without any value at
all. Add the "TopdownL1" to the skip_metric list as well to handle this
possibility.

Before aarch64:

    100: perf stat STD output linter:
    --- start ---
    test child forked, pid 403305
    Checking STD output: no args Unknown event name in TopdownL1                 #      4.3 percent of slots  slots_lost_misspeculation_fraction
    ---- end(-1) ----
    100: perf stat STD output linter                                     : FAILED!

Before aarch64 KVM:

    100: perf stat STD output linter:
    --- start ---
    test child forked, pid 404671
    Checking STD output: no args Unknown event name in TopdownL1
    ---- end(-1) ----
    100: perf stat STD output linter                                     : FAILED!

After:

    100: perf stat STD output linter:
    --- start ---
    test child forked, pid 404777
    Checking STD output: no args [Success]
    Checking STD output: system wide [Success]
    Checking STD output: interval [Success]
    Checking STD output: per thread [Success]
    Checking STD output: per node [Success]
    Checking STD output: system wide no aggregation [Success]
    Checking STD output: per core [Success]
    Checking STD output: per cache instance [Success]
    Checking STD output: per cluster [Success]
    Checking STD output: per die [Success]
    Checking STD output: per socket [Success]
    ---- end(0) ----
    100: perf stat STD output linter                                     : Ok

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index cbf2894b2c846a04..0f7967be60afdc7d 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
+skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.43.0

