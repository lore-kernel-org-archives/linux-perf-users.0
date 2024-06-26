Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E5154456
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389730; cv=none; b=XqMRnQDmvRH2xh8tCkN1fRYSCECNHSqOiCsaYW8/WT2SLnMn40gsqQQqDK8aLF33j9zhR1JzEGgibHYOsFucFLpb3kytR4pGt4bjScDWP5XR7FkQrRyD+JRnJDhMafRZIgWc+QpMpW10q1jF6XqI4inKT9bKOuEuCm72TRXBLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389730; c=relaxed/simple;
	bh=jvcvQ5ufJMxPui64COMk6YKkVfi4dDfpQJoHNpA0LHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=anbEblx7uuqdRxmHYgaESPODSxDZZAjo5Oyf0oy2wuPhvpWw3GPime61GmYKmWGbrNKFcUuDvlkhRdmqCyY9hpJf6g6ag3V6Wo47UZnD7aJ7qUUWA52nj5tHFVoE/XcdElfm6EOVpgq9i1TFHgMVaz0n7xLNxb66l1RwEBnDnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8Dt11T9ZzxTqJ;
	Wed, 26 Jun 2024 16:11:05 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id DF66C18006E;
	Wed, 26 Jun 2024 16:15:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 16:15:24 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <irogers@google.com>, <namhyung@kernel.org>, <acme@redhat.com>
CC: <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
	<ahmad.yasin@intel.com>, <alexander.shishkin@linux.intel.com>,
	<ak@linux.intel.com>, <atrajeev@linux.vnet.ibm.com>,
	<caleb.biggers@intel.com>, <edward.baker@intel.com>,
	<florian.fischer@muhq.space>, <mingo@redhat.com>, <jolsa@kernel.org>,
	<john.g.garry@oracle.com>, <kjain@linux.ibm.com>, <tegongkang@gmail.com>,
	<leo.yan@linaro.org>, <mark.rutland@arm.com>, <perry.taylor@intel.com>,
	<peterz@infradead.org>, <ravi.bangoria@amd.com>, <robh@kernel.org>,
	<samantha.alt@intel.com>, <eranian@google.com>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<linux-perf-users@vger.kernel.org>
Subject: [PATCH] perf parse-events: Back to support for parsing of field "-"
Date: Wed, 26 Jun 2024 16:12:25 +0800
Message-ID: <20240626081225.51752-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)

When merger the patch [1], event_term can not parse the field of "-".
When use the following cmd, "-5/5-/5--" gives the same result as
"5", and the value collected by the PMU is 0 when user input "--5",
which is not the expected result?

If the first field after "=" of PE_TERM is "-", this means the user has
entered a negative number. If the field of PE_TERM is followed by two
consecutive hyphens "-", this means that the entry may not be valid.
So if the user input "--5/-5/5-/5--" the perf tool may need return false
or unsupport.

                 0      -e armv8_pmuv3_0/event=--5/
             1,359      -e armv8_pmuv3_0/event=-5/
             1,359      -e armv8_pmuv3_0/event=5/
             1,359      -e armv8_pmuv3_0/event=5-/
             1,359      -e armv8_pmuv3_0/event=5--/

If user enters "-" followed by the event alias name or event number
(such as r0010), perf also works, and this format is more like an options
to stat cmd than the -e argument.

  $ perf stat -e -r0010 -e -cycles -e cycles
	     11288      -e -r0010
	     7084679    -e -cycles
	     7084631    -e cycles

Back to support for parsing of field "-", they have the same results as
apply the patch and before patch [1].

Testing:
1) $ perf stat -e armv8_pmuv3_0/event=-5/ sleep 1
   event syntax error: '..uv3_0/event=-5/'
                                     \___ parser error

2) $ perf stat -e armv8_pmuv3_0/event=--5/ sleep 1
   event syntax error: '..uv3_0/event=--5/'
                                     \___ parser error

3) $ perf stat -e armv8_pmuv3_0/event=5-/ -- sleep 1
   event syntax error: '..v3_0/event=5-/'
                                    \___ parser error

4) $ perf stat -e armv8_pmuv3_0/event=5--/ -- sleep 1
   event syntax error: '..v3_0/event=5--/'
                                    \___ parser error

5) $ perf stat -e -r0010 sleep 1
   event syntax error: '-r0010'
                        \___ parser error

6) $ perf stat -e r0010 -e cycles -b cycles sleep 1
   Error: unknown switch `b'

[1] commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs before parsing")

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 tools/perf/util/parse-events.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 16045c383ada..1f0bdb89c43b 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -426,6 +426,7 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 "{"			{ BEGIN(event); return '{'; }
 "}"			{ return '}'; }
 =			{ return '='; }
+-			{ return '-'; }
 \n			{ }
 .			{ }
 
-- 
2.33.0

