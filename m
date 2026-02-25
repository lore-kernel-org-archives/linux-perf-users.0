Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13579CD;
	Wed, 25 Feb 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990908; cv=none; b=BC7nrRtxlC4oI1a0BLpe4srrrnb3MkreDr7uW7l5wr5H+1kyPqXTozb9932G5JsYTtH/qdZw5t7L6ulkB2nslx9hG9+Th+zEaIw/JMSb3+mSWFKXDpNcdppntQ7TuPZiRnPpcLOoDd0/xIEFcjCAIEzG5q3cmR5HzfIMEgWtp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990908; c=relaxed/simple;
	bh=1IKVxX88XcX5T82VgVAG5cLwq8aLKuMkz4FKHTdnbIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qc4f20sATCocNHGkl4VGMOPejSdtP9f5zC1mUeIouHKXDlMbB0YEB7SqAqedHwwfu5RNfIOfkZetV6/X0wxH/mxKoUX5XQ58kjMeIdR5yVM/UMbDcRQu+j8PMbNIfU4EslRUeqwgI7YdVm5dh0dIvW4f5xgncNqVC72E0agatvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uivG0Ayk; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uivG0Ayk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2wCXDF4IL0wsrqXJCQ9PHCOp3Z3zgXe/EgiV/p4J4CE=;
	b=uivG0Ayk2VFGVoG8MB0uPdJNL+jWPeJj8tQMGriIGRIkg3qYFv/cM4mW440TSAX9jhpGbZ/s4
	VfuOopBNyJk1nwK7G4w1HnGXYIMAjBc19iHzNxeRbKVysOLKDefMOKRtGNJqx2+M4G+dd0p4IDC
	s5SriUAeeT2n/WseSxKtXj0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fLKyD64NZzcZyP;
	Wed, 25 Feb 2026 11:36:36 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BD264036C;
	Wed, 25 Feb 2026 11:41:37 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Feb 2026 11:41:36 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <jonathan.cameron@huawei.com>,
	<xiaqinxin@huawei.com>
CC: <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>,
	<"james.clark@linaro.org.linuxarm"@huawei.com>
Subject: [PATCH 0/1] perf: Add --pmu-filter option for filtering PMUs
Date: Wed, 25 Feb 2026 11:41:24 +0800
Message-ID: <20260225034125.2157622-1-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch adds a new --pmu-filter option to perf-stat command to allow
filtering events on specific PMUs. This is useful when there are
multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).

perf event:
[root@localhost tmp]# perf stat -e cpa_cycles
 Performance counter stats for 'system wide':

     3,005,509,659      hisi_sicl0_cpa0/cpa_cycles/
     3,005,502,319      hisi_sicl2_cpa0/cpa_cycles/

       3.005460970 seconds time elapsed

[root@localhost tmp]# perf stat --pmu-filter hisi_sicl0_cpa0 -e cpa_cycles
 Performance counter stats for 'system wide':

     3,003,899,571      cpa_cycles

       3.003864470 seconds time elapsed

perf metric:
[root@localhost tmp]# perf stat -M cpa_p0_avg_bw
 Performance counter stats for 'system wide':

    19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
    19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
    19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
        75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
        18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
    19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/

      19.417734480 seconds time elapsed

[root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
 Performance counter stats for 'system wide':

     6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
        50,548,465      cpa_p0_wr_dat

Changes since RFC:
- Address the comments from Ian, replace '--uncorepmu'  with '--pmu-filter'.
- Link: https://lore.kernel.org/linux-perf-users/20260120095058.2778834-1-xiaqinxin@huawei.com/

Qinxin Xia (1):
  perf: Add --pmu-filter option for filtering PMUs

 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
 tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.33.0

