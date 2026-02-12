Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6F8C1F;
	Thu, 12 Feb 2026 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770865065; cv=none; b=Q6M4T6++nWlw8FklmQv3vaezFDdt/FGxXwJBYRQWMTZA6sNG6yXkNMf84VeDWHy4SY8oCcKzL5S8qTxG9RCYrENjAedvRDa30YtLsiCE+3DCEQZJeuukA8VRS3vedRkRH+PPoUIPMcJadbHE7IoMw346XpKIbHEGXNOGXkEg6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770865065; c=relaxed/simple;
	bh=qDi95gXPeKSx1B/kQxplnAEXrVehXMzQbJQS3unG+CE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OA1/Llr4X6VmmgjYuM62Wos14ZKHs6rg+Yf2I0y+pynokOsaBtKc0blvSnSiNPQxhziOcCtewKBWq/lCmRROaiY6sqmhd62CP7XZHs1YIB8XjT25p07mtfIoQluAl1eDRzuM9/1LIaBWwQV789xx/V2tYZgQltWXsolYUoKePAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FTaJz/jx; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FTaJz/jx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=p3p4S/9B4d08/50wA4bAAPqALJ0SzHf67YHkuXNRqUk=;
	b=FTaJz/jxWvf4fQtQdwnm24K3twY6floyZ8iAzOdu/2euIoU+kp7kyE4dXZEgqc
	YwQIRUxeHIKk5vpzYP5igSmwAmc65uAys5qhp7zyKjOAwTPBVr/vV23uBCzFCxA+
	EYRrLPAaMBB9v48UpfjbhrUPNfe3iFA7J3ysHinzNQ4GI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAn4v_YQI1pVsBpLA--.2058S2;
	Thu, 12 Feb 2026 10:54:18 +0800 (CST)
From: Chingbin Li <liqb365@163.com>
To: james.clark@linaro.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libperf cpumap: Fix argument x range [] exceeds maximum object size
Date: Thu, 12 Feb 2026 10:51:27 +0800
Message-ID: <20260212025127.841090-1-liqb365@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn4v_YQI1pVsBpLA--.2058S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUJF13XrW3ur1UJrW7CFg_yoW8GFWxpF
	s8C3yUGFZ5Xrn5K34DJ340q34jgw1Iq390va43K3y5AFnrtas7GFWvy3Wjkr13ur4kK3WU
	trnFga4UJF17Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1byZUUUUU=
X-CM-SenderInfo: xoltujiwv6il2tof0z/xtbC5hoEdGmNQNopqAAA3z

On RISC-V 64-bit Ubuntu 24.04 Server (Running on QEMU), the following error might occur when compiling perf:

cpumap.c: In function ‘perf_cpu_map__merge’:
cpumap.c:429:20: error: argument 1 range [18446744069414584320, 18446744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
  429 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from cpumap.c:4:
/usr/include/stdlib.h:672:14: note: in a call to allocation function ‘malloc’ declared here
  672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
      |              ^~~~~~
cc1: all warnings being treated as errors

We use the volatile qualifier to prevent unnecessary errors caused by the compiler's constant propagation.
---
 tools/lib/perf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4160e7d2e120..ccf473994111 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -410,7 +410,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
 {
 	struct perf_cpu *tmp_cpus;
-	int tmp_len;
+	volatile int tmp_len;
 	int i, j, k;
 	struct perf_cpu_map *merged;
 
-- 
2.43.0

