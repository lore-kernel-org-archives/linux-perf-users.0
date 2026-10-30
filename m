Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373210;
	b=VbFlTRu/pvIrWJoRvjFkgk3WB7gLFtSnksDMg2aQF4BjSTt4LrWPkpTjbGboi0uyAeGZ
	 wtTdsVSVYRCq/BM8/iMvxC2Kjtduk3pVPoIg+JZWFxJNmIv/FfZIZRRlEGgNAoD+9/3+3
	 tIMZPoMUb8ngJiQkOtk8+FZHXVCJexSK8J6W4DXM/9MwDjqUopdKdibZjCMEHlLafSis6
	 LedYq1MygwlpNgQe1u5H2hNVD+MFtPNnYuRDTv7OSohky90ve6XaOdIauwC9OUW5rF2OS
	 uu3ccaRyEmeydZDBuL5y5gW3UqUYvQ2Nupv9UbqJ1D4tdSdZ7NDtKtxqLgT5ayeGbwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373210;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HdoJI368+i11GTohISpbz8VghvyqGRYi37yZFl4fhSU=;
	b=HqUcfAXNQboHhlzz793xjbyrvcFhvJNXcXueowRm5tdtQRp50Rwww3yJI6jjnLElPUPz
	 7hREnza0Yie3MP9LBnFJKMG71bos0iVZE66HYbz02+aUp7klO+MNEVTreVwhTu4x3JEuL
	 t3Fz/GJIAH6o61K6YJibpPpRGB7uWh8iyvrEuZzV8o/ESCUZmfteJtxI8qltulR16LFSY
	 /Y34Wlwyh7soSfyKfYn3uR6N9xKTtQS56ybLwvZ9gQwfRkFiFy7oWMrizxx1XNuxJEl3S
	 qH1cuhezSub4Ygq3Vfrlx2KaIdy8IRxOFnpo3ISBKEyScfKm8bFJeA0IxhNzIRGJ2tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="Qs4/9F3b";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF4606A335;
	Fri, 30 Oct 2026 15:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEBF4606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Qs4/9F3b
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2891682;
	Fri, 30 Oct 2026 08:13:25 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C88F63F59E;
	Fri, 30 Oct 2026 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373209; bh=RTr9WjFzrRPpi75Lbl9yzt4xCky73PggBYYT3kPl0So=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qs4/9F3bV3ucdyMATv0KEx+gIxVbXJYsw5kfb4dg0TeprsGcDsS5KXefn+opS7X4V
	 vPsawshIG+pAIfC+qTdgWwvi0RKk6PObf3jUOYJet3D4jx8xpQ20c8p1hMYoU8+MAn
	 x5Kb0bXsnrnFtqgPQwX7+GoFuOy9IsKeOlGabF9I=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:09 +0000
Subject: [PATCH v3 02/14] perf intel-pt: Preserve return addresses for
 asynchronous branches
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-2-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=1435;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RTr9WjFzrRPpi75Lbl9yzt4xCky73PggBYYT3kPl0So=;
 b=XUT/mOQBYxtVkq+U7mwQRfttiE7T/mUsjjaVtbkjo566QPr1S+sFczz8A7ynwzdk/qBATN+1m
 yI1UTGywamACmAugoUPcBqeuYl5mZ5fKj0S9y1Kxm5AlF1EyD2CLP3c
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Intel PT uses a zero instruction length for asynchronous branches so
the thread stack resumes at the source IP. A dlfilter can fetch the
instruction before call/return processing and replace that zero with
its opcode length, advancing the saved return address.

Set sample.ret_addr to sample.ip for asynchronous branch samples so
instruction fetching cannot change the return address. This also
covers asynchronous trace-end samples and VM exits.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/intel-pt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 8c21c9f52d572d2dd4e15b3b5c341b253ccea1b5..e8b9c8a67b0a0635e0110eda4b6ccb2511132fc7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1803,6 +1803,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 	perf_sample__init(&sample, /*all=*/true);
 	intel_pt_prep_b_sample(pt, ptq, event, &sample);
 
+	/*
+	 * For asynchronous branches, use the sample IP as the return address
+	 * instead of advancing it during instruction decoding.
+	 */
+	if (sample.flags & PERF_IP_FLAG_ASYNC)
+		sample.ret_addr = sample.ip;
+
 	sample.id = ptq->pt->branches_id;
 	sample.stream_id = ptq->pt->branches_id;
 

-- 
2.34.1

