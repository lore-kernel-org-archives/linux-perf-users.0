Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931566;
	b=z02LLqbIcu475xhioJiaqS41ghZrN1+pdNe5+Q3OJD5x7yv0AHix558ETJldDJELYwOQ
	 1/vdwWDRSi1vOkwViyi6McOC0JP7G/NSF9JR7h5mPWxK26XQ9tFLm/ws7QEWsDvYZ9krD
	 HEh38xlv5FOONVt4jp4cwi692sdztbYJBsk6hBk/31azffFAEyGcORq2TQ31SdWAAgq64
	 fujYPk60fL0PX92lAwhsT25j6AmC1GLMhYG43sTb35KVniXI25BO3bG5OGtW7Fn+NBHw1
	 cLiwj2He009K3bbJplVCEKAcdFfhSHpm+6GFl7k7AfpZbacLzgZr9ySdS5fKu2rA8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931566;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=JVpok3OUZDEp45kySO2Abag7oswwRng8Ow2vP7NskhE=;
	b=2/M0HzbeiicrRxMb0SDJ3E2aLgUj4/wKueX5Mp9j/fY14BFTxHFNP6Z4ChyRy0SH0Qky
	 QBRCrTSDEywZODfR649AIWUdhWMeRY1bj7hwM20gLsB6tvuU+Joljw2DifdzCgeA+e13C
	 Vbt14mVXZOayJnECkXwA5IYBvc8k1neHQWqHQmjN7YHKfZPFXc/VkX98BwZvjVoRUZX7q
	 Oqwkm+FyiO5+eGF/Nmwkikq1Fs+6+nPwP4+j4xfFS+Qf5hMKK+OxW7yHnJKftfvQhx8OS
	 Cn1Mc0zrQIJl7eytsurfd90ms2His/1rAWMqZI1Ie70e7DCihO7YcmiWqUoGYJAAK6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=mzPAWTYl;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A5BEC606A31B;
	Fri,  6 Nov 2026 02:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BEC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=mzPAWTYl
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf iostat: Preserve the port count when growing the list fails
Date: Fri, 6 Nov 2026 10:19:13 +0800
Message-ID: <20261106021913.2341-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793931563;
	bh=JVpok3OUZDEp45kySO2Abag7oswwRng8Ow2vP7NskhE=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=mzPAWTYlDq/K319C2gqoh565wnw+TXx4xNaW1iBaOQugUi7hgYKYW3k5Ok3n+0Kxl
	 E8PMmY5CGV0UEtb2UGwHsuq3Vzp0J0RjRGa4mBwGaERl9Uiw+7R8uVNOeJU2c1t9kr
	 TKowJKLVDETSH16U1vw3GlseLcrQAnY/83Iflq8wR9FfJMRbGspUdr5z9BQFnCQ+1m
	 hrEIYejoSORn9TY31a4VEhBoL5o6lVJUviQ0XDLGIDH5ZyH2/VLv548SR4oCMzjbkQ
	 OEJFzrLdvsKgITaiXZXZbysRSn7BByuX1VE52utgOj9jfmSF+GY3tNT0qbykW2U5YS
	 zdqCl5fbDzcPw==

From: Li RongQing <lirongqing@baidu.com>

The root port insertion helper increments nr_entries before reallocating
its pointer array. If realloc() fails, both the scan and filter error
paths free the list using the increased count, reading one pointer past
the allocation. Failure of the first insertion instead dereferences a
NULL array.

Grow the array before changing the entry count or the port index so a
failed insertion leaves the list valid for cleanup.

Fixes: 19776d3cede7 ("perf stat: Helper functions for PCIe root ports list in iostat mode")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 tools/perf/arch/x86/util/iostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 5ecc2de..7dc31f5 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -129,13 +129,13 @@ static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
 	struct iio_root_port **tmp_buf;
 
 	if (list && rp) {
-		rp->idx = list->nr_entries++;
 		tmp_buf = realloc(list->rps,
-				  list->nr_entries * sizeof(*list->rps));
+				  (list->nr_entries + 1) * sizeof(*list->rps));
 		if (!tmp_buf) {
 			pr_err("Failed to realloc memory\n");
 			return -ENOMEM;
 		}
+		rp->idx = list->nr_entries++;
 		tmp_buf[rp->idx] = rp;
 		list->rps = tmp_buf;
 	}
-- 
2.9.4

