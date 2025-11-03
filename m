Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6DE27E045;
	Mon,  3 Nov 2025 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134533; cv=none; b=QudmoDVGMzBe4QDS7PaMHBRxhq2B02uH+XkUe4rohu1gtEUcoNzU0IiuoEgeVIkBM6tAxMVMbp15yAQS9eTjL713mbRRWAIorCt8/fnyIvxfn7oJCm7BRlO3iYbiEFCJ7zoiUTKkk7HxrvQKkikgiNI4gJM9xs55lBaCRisIYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134533; c=relaxed/simple;
	bh=T834OqKWmV0Fy9zRBH+AZl4fmz5/uHYjIXfITrCsZ6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SkR63QSvr9Bh9xHfwRLhp/tIVovTiEQ1No1WMCOkgSs88pU9Ypb7RoCYA/ZTv432DjdqF/OVFkN2atz8k/mj7doi/y54c0wBAjwv+u+8izpZIoWisnq913ZbJ+c0nAAuYcenqVSvQ+QbPzg44kcoB9C4+KheP7KaF0ojcs6hcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202511030947356328;
        Mon, 03 Nov 2025 09:47:35 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Nov 2025 09:47:34 +0800
Received: from inspur.com (10.100.2.107) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 3 Nov 2025 09:47:34 +0800
Received: from localhost.localdomain.com (unknown [10.94.13.117])
	by app3 (Coremail) with SMTP id awJkCsDwmPmyCQhp9KQJAA--.13804S4;
	Mon, 03 Nov 2025 09:47:30 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<mike.leach@linaro.org>, <leo.yan@linux.dev>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH v2 0/1] Fix spelling typo in tools/perf
Date: Mon, 3 Nov 2025 09:46:32 +0800
Message-ID: <20251103014633.1213-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: awJkCsDwmPmyCQhp9KQJAA--.13804S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY97AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxV
	W8ZVWrXwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?BEku65RRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KU/myUvcVyK7rkHspOjZBu4Q/51zyjXsDLAUWvI3FwgIEgo4lAMTnf3ETstjRH9TRgfn
	uLVmFDsoawVDLT+bklM=
Content-Type: text/plain
tUid: 20251103094735c696401974d91050ac2f12342e55767b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

v2:
 - The subject of the patch has been modified.

v1:
 - (https://lore.kernel.org/all/20251031025810.1939-1-chuguangqing@inspur.com/)

Chu Guangqing (1):
  perf vendor events arm64 AmpereOneX: Fix spelling typo in the metrics
    file

 .../arch/arm64/ampere/ampereonex/metrics.json    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.43.7

