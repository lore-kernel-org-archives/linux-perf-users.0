Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0217D2;
	Fri, 14 Mar 2025 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921875; cv=none; b=BXsmShrPb2jCejk+EbJGsM3lIke2E9zt61+duH4WC+mnIhM+pTBfFc1r05i5Dchdq9ABTvhx0tyJLrgPw4sML9mU/4HHrlgIs8Zyyy0awCDYm+ld1Rg5e/ed9xgpd8ApccWPxk7ukTJ3TUHEZEJB7pa/db+iyE2osiE+0Te+BeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921875; c=relaxed/simple;
	bh=i9AA/zhlCnFE/+e4r/W6os708zn8Y0MhgioOipmNA+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvAra22rnhBy7Ub2+by14fOuZkanIZ3JEcY2KXXV4y4ErT+TagNmAKbRBO9djUTAZHUVuSM1QdXCXElSarr3DgY3LtOQQKSKWkiumtayE/MpPA1exgRWJxKINnJs7yuTbgLUY53qo/ZUvAT5Ar7S2Owqsu+jllZPFMeiOCxq2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XFr9s+hi; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XFr9s+hi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/6ocz
	hbU2L4ZOKkadyou5vBjazrcdhF06suzlbkT2OM=; b=XFr9s+hiiYLoRKXPHpG7N
	tx0Oa2jf7GQ8isZQSr7ux62rYpxz3yyYYkWi2UV65JjvkvmmC8kUzObxQOTx9tri
	4PieSRtuMph5XF7DFYCU8HMDslKvd5eqXhmUkJRy1BA4ZSi+K61ZS376mU1yj7tB
	Tj+V0SenjPZJvXlWlw8ftQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBHZ6kVntNnwGBgSg--.4239S2;
	Fri, 14 Mar 2025 11:10:14 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf kwork: Remove unreachable judgments
Date: Fri, 14 Mar 2025 11:10:13 +0800
Message-Id: <20250314031013.94480-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHZ6kVntNnwGBgSg--.4239S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4fAw1DXFWkJw1xKFWfZrb_yoWfJrg_Gr
	93Jrs2kryruF97ur4IkFWrW348tF9a9rW8GF9rX34UAayaq34UXF4kG39FyF90qr17Wr9x
	Xwn5Xw42kF4Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbjjg3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgEQeGfTmdCGvQAAst

From: Feng Yang <yangfeng@kylinos.cn>

When s2[i] = '\0', if s1[i] != '\0', it will be judged by ret,
and if s1[i] = '\0', it will be judegd by !s1[i].
So in reality, s2 [i] will never make a judgment

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/perf/util/bpf_skel/kwork_trace.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/kwork_trace.bpf.c b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
index cbd79bc4b330..9ce9c8dddc4b 100644
--- a/tools/perf/util/bpf_skel/kwork_trace.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_trace.bpf.c
@@ -80,7 +80,7 @@ static __always_inline int local_strncmp(const char *s1,
 
 	for (i = 0; i < sz; i++) {
 		ret = (unsigned char)s1[i] - (unsigned char)s2[i];
-		if (ret || !s1[i] || !s2[i])
+		if (ret || !s1[i])
 			break;
 	}
 
-- 
2.43.0

