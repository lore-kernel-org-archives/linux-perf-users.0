Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62141DF271;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172365; cv=none; b=Ik0tRD3TzywNiZJaGuUBVTsG7qNJYOhJceusDJr+kZ/nIAU6lwL1YtQtiVdhsQYCLYFnhrAWO3SAFRhxkpGSayZeB5oA6ojLlIX7+WoX5BEMB4YnHHeztayQRNhbKjKWRsOIrN72h7ORSpFADReP3oe2MtLMQmm+JEdnXP8ld3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172365; c=relaxed/simple;
	bh=N/trOawW8zW8kIfWITPPjLkmw1yysrCMHn9BOCzKgAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baKLgfZfiTeR4RKTAnnFdvjD2IJc2EC6nu5yCsBaqTX9Fwf6v1HFvMBvAdH3lPYpd+j23w/89x/RBDnVD6JTB/hMVBbr7x8GRt+ov3wO7hJhPt4ykgL3AzRtms74+Su2P0l67zw0OjIVJYKsdRRD/I3dHmomDFUMY3QXwPhxUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0LtX1cT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0LtX1cT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C8C4CEE2;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738172365;
	bh=N/trOawW8zW8kIfWITPPjLkmw1yysrCMHn9BOCzKgAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0LtX1cTVNPRiOHizosd6+mswH0+XqTf3GNL3DZ6m7qGvZNYE8xPCBbFY1A58m/ts
	 MndkeGQr9pGpH6wj3F2pget3ATE/0xKvpzXoOLJqK4JR7yBeF9rGm+l/i7XUJvsn4w
	 g4jhulgVkvDsspaJ9gYZBCKXzDWsU1aG3MivZDcRz8rAUSusIC/C7GRKbvHDdyLyVh
	 c/36jFF57ah04jNRdd1f9kcUUIquxkGUQgy8urmoBOrD0SjIqvmidGuMqKkxF6uZQ2
	 l3j8wAJKFciIXeIDR5XABD6e2SRHZqV7VduVsvFq2kmc5zsg9QUgNNlhyMF9lbLhsi
	 XiL+/mSFdshSg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdC26-00000004SdM-3PuA;
	Wed, 29 Jan 2025 18:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <mchehab+huawei@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <mchehab+huawei@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <mchehab+huawei@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/6] tools: perf: tools: perf: exported-sql-viewer: drop support for Python 2
Date: Wed, 29 Jan 2025 18:39:05 +0100
Message-ID: <761ec2ebe518b5506e67d088797b559f89c396bb.1738171937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171937.git.mchehab+huawei@kernel.org>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As stated at process/changes.rsy doc, the current minimal Python
version is 3.x, so drop support for EOL python 2.x.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 121cf61ba1b3..b096592fd35f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -3939,9 +3939,8 @@ def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
 	indent_str = " " * indent_sz
 
 	expanded_mark_sz = 2
-	if sys.version_info[0] == 3:
-		expanded_mark = "\u25BC "
-		not_expanded_mark = "\u25B6 "
+    expanded_mark = "\u25BC "
+    not_expanded_mark = "\u25B6 "
 	else:
 		expanded_mark = unicode(chr(0xE2) + chr(0x96) + chr(0xBC) + " ", "utf-8")
 		not_expanded_mark =  unicode(chr(0xE2) + chr(0x96) + chr(0xB6) + " ", "utf-8")
-- 
2.48.1

