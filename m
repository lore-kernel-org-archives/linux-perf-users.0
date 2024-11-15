Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EC18A6AF;
	Fri, 15 Nov 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662145; cv=none; b=EoMWzRcwoXRJ5Zb1po1tOcdn/Ie6SPhSc2UvQ53hIBQSueTYTw2ioeYccDMC5YKnN6GkxcMzRKN0/moPYUtF5UPcyk5AC56kL9QM64odvwc1fQ5dv1GGObuwOMNC4wENgLPdAeu4ulelz/gYZ9//wDPrpfDIOdbzYWFKO+xdo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662145; c=relaxed/simple;
	bh=LYj0ZplyG9Vo0EPIMvcwA1YhtRdMisOa3iNrdZWcQIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zsuk2aeN5/LicPs8pwq4CJ0tvnfASwIzstKzbVjpmtQekxrFG2+TQ0t0ngNWZn/6z13YXZF4mMb3fSdCNHmmtffBuhQ21vxIXh4aYDcHftwX5sjQ329ifZvgCABu2ofWeDJGjC4Uqh7t6BbOUZ1fwBa6dyix1eJSR/0UzaYE+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KhTFDEyp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KhTFDEyp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731662134; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bXirQB7Wpqqf9oweOV3ntUvN9WtR57BGS51ClJ8dkgs=;
	b=KhTFDEyp4PZxmb7CrXN2AIKJvxHBbAB00lGs/jRE5dN4QDbq7JesQ53HdOXphS7PFAh7ohfn0f84ttzyFlKm9uGWOHxUvHf98jRVcw0SQjEkwAScvSRrPvvM8m6opR/eDY/91zVBcylDks0YXvKWJcUIU3TH1y8XT5Lxa9xE4EM=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WJT6t0I_1731662128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 17:15:33 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] perf tests: Fix an incorrect type in append_script()
Date: Fri, 15 Nov 2024 17:15:27 +0800
Message-Id: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from the call to readlink() is ssize_t. However, the
return value is being assigned to an size_t variable 'len', so making
'len' an ssize_t.

./tools/perf/tests/tests-scripts.c:182:5-8: WARNING: Unsigned expression compared with zero: len < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11909
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/perf/tests/tests-scripts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index cf3ae0c1d871..1d5759d08141 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	char filename[PATH_MAX], link[128];
 	struct test_suite *test_suite, **result_tmp;
 	struct test_case *tests;
-	size_t len;
+	ssize_t len;
 	char *exclusive;
 
 	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
-- 
2.32.0.3.g01195cf9f

