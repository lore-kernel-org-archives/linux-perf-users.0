Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C30111A9
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F776B4;
	Mon, 30 Oct 2023 04:16:51 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SJrHd6Q3NzrTpK;
	Mon, 30 Oct 2023 19:13:49 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 30 Oct 2023 19:16:48 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH 2/2] perf tools: Add the python_ext_build directory to .gitignore
Date: Mon, 30 Oct 2023 11:14:38 +0000
Message-ID: <20231030111438.1357962-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030111438.1357962-1-yangjihong1@huawei.com>
References: <20231030111438.1357962-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

`python_ext_build` is the build directory for python.so, ignore it for
cleaner git status.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f533e76fb480..ee5c14f3b8b1 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -49,3 +49,4 @@ libtraceevent/
 libtraceevent_plugins/
 fixdep
 Documentation/doc.dep
+python_ext_build/
-- 
2.34.1

