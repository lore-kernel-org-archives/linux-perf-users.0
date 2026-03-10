Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413F3A785F;
	Tue, 10 Mar 2026 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115585; cv=none; b=iHspD8GTckjDtyH9MALaTPRdSkGF2Cr5avJmbRblCnfIQMlW/arP3Yl7ftyRy0VjL9pOJ5oXXBeW/xvLz/w9RsjV5dqiLss5hNv11BsLsLX7vTfSNjZ4f+pbBni3FpqwYcxGf7j9f3D5W4O6tvgVXRuguUO2167PBSFoSdfiBvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115585; c=relaxed/simple;
	bh=5ry/ppW7lOloZPuj9bdLTcSmk+JJ0YOeHepi/a+PQ+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLX1Z9buCkWqIOlraiFuUSIJNIbgrL06Z/MHgVvmev0M6MD+sNV5IrP8r4kBuHsk0OmNXNxQ5KUG/JrNt33o/yAfpsWwdU13GqGBSH99B/tG2F0YYRC+sSutQNJQiXjX268zrbPFi2fH7k5IX0RMw+eZHAWmvwgHPTOuXSHVGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0eAbQnmM; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0eAbQnmM; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0eAbQnmM";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0eAbQnmM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H5KsdGbr22scWntLAWhfc6lqZZwM81U3ABkjHUDREwU=;
	b=0eAbQnmMlZPg6KZHx4KVa4Gf2TbwEdaoQzwdjYswPr3OZg6MjEs9fE13G28A/qt5Jgd4WMYvU
	/VypVtOxzs+6dLHaNjf/pGvp8ZWx6ZJu2yRrkHmV5Olcogga1WCEeOSOuGstAFFuxNZhRHc6ztj
	l8SAHvnYvorU4mhw5dFcLSs=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fVKzm3K36z1BFnt;
	Tue, 10 Mar 2026 12:05:40 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H5KsdGbr22scWntLAWhfc6lqZZwM81U3ABkjHUDREwU=;
	b=0eAbQnmMlZPg6KZHx4KVa4Gf2TbwEdaoQzwdjYswPr3OZg6MjEs9fE13G28A/qt5Jgd4WMYvU
	/VypVtOxzs+6dLHaNjf/pGvp8ZWx6ZJu2yRrkHmV5Olcogga1WCEeOSOuGstAFFuxNZhRHc6ztj
	l8SAHvnYvorU4mhw5dFcLSs=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fVKtj4YmczRhQP;
	Tue, 10 Mar 2026 12:01:17 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 7518F40569;
	Tue, 10 Mar 2026 12:06:11 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 12:06:10 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <namhyung@kernel.org>, <irogers@google.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <jonathan.cameron@huawei.com>,
	<xiaqinxin@huawei.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<linuxarm@huawei.com>
Subject: [PATCH v2 0/1] perf: Add --pmu-filter option for filtering PMUs
Date: Tue, 10 Mar 2026 12:06:06 +0800
Message-ID: <20260310040607.1780971-1-xiaqinxin@huawei.com>
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
         7,552,182      cpa_p0_rd_dat_64b
                 0      cpa_p0_rd_dat_32b

       6.234139320 seconds time elapsed

wildcard match:
[root@localhost ~]# ./perf stat --pmu-filter hisi_sicl[2,8]_cpa0 -M cpa_p0_avg_bw
 Performance counter stats for 'system wide':

    18,505,025,031      hisi_sicl2_cpa0/cpa_cycles/      #     0.42 cpa_p0_avg_bw
        80,007,944      hisi_sicl2_cpa0/cpa_p0_wr_dat/
        42,014,906      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
    18,504,957,351      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/

      18.504994880 seconds time elapsed

Changes since V1:
- Address the comments from Namhyung, the description of the event filter in commit
  info is omitted, and wildcard matching is supported for pmu-filter.
- Link: https://lore.kernel.org/all/20260225034125.2157622-2-xiaqinxin@huawei.com/

Changes since RFC:
- Address the comments from Ian, replace '--uncorepmu'  with '--pmu-filter'.
- Link: https://lore.kernel.org/linux-perf-users/20260120095058.2778834-1-xiaqinxin@huawei.com/

Qinxin Xia (1):
  perf: Add --pmu-filter option for filtering PMUs

 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
 tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
 tools/perf/util/parse-events.c         |  2 +-
 4 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.33.0

