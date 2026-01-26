Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F922D785;
	Mon, 26 Jan 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769398314; cv=none; b=MMsl8RpgwzrHg5N1wT776n7YDJhmb6nElSoOWPMLfbfFaWVbZGufIEPRlbqM2O8CD0Ky3n5u8HiHM5es+afFF1v21JmCVQ3aFb892dYwOvq+J/4+RoMDj+vDHiDNObZcwNPT3d/RB9rTdyyDwGREQXBRZAbySXxbczM72ihYQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769398314; c=relaxed/simple;
	bh=u1OewxbbJGRvHTCZRukFRx/JGEtiKLFZYmLon3qdpM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkDewe6tWc8gOLUVeUkTJt0d1rUxjmOX7gOV5Vbew8rQQkWA0Q32A48qBCgsGSTiA09cXcjgSAr+dsWCf2IVRqqiUTBW7/geVrcR1kiMjdOsIoQkIz+GImgq5J/1peJ9EakBOrlYfimRXlDYEkaCQVOxdClk/TtKiaHJ9KS3rqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=t1/7o/Gd; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="t1/7o/Gd"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 60Q3UVTc017067;
	Mon, 26 Jan 2026 11:30:31 +0800 (+08)
	(envelope-from baisheng.gao@unisoc.com)
Received: from SHDLP.spreadtrum.com (zeshmbx08.spreadtrum.com [10.29.3.106])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dzv6H1Xqbz2P3QY0;
	Mon, 26 Jan 2026 11:24:39 +0800 (CST)
Received: from BJ15137PCW.spreadtrum.com (10.0.73.52) by
 zeshmbx08.spreadtrum.com (10.29.3.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 26 Jan 2026 11:30:29 +0800
From: Baisheng Gao <baisheng.gao@unisoc.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <cixi.geng@linux.dev>, <hao_hao.wang@unisoc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] Support clock domains without a PMU instance
Date: Mon, 26 Jan 2026 11:30:27 +0800
Message-ID: <20260126033029.7923-1-baisheng.gao@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 zeshmbx08.spreadtrum.com (10.29.3.106)
X-MAIL:SHSQR01.spreadtrum.com 60Q3UVTc017067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1769398244;
	bh=7CWfXsj803L/F0YgUgGR75n6iaf/Odl6c64TnbCJgP0=;
	h=From:To:CC:Subject:Date;
	b=t1/7o/GdKxDOZ3rDh0XOmevEt7lSKOW/EgXYxk+aZBK3+l+uDG6FUjywPpLQIvaGN
	 kOfDjz8AUWbAAZM4bX0bgoUSIjGzTWinE1u9gXtjIUh4b7pxlMvsv3HDG7C+4yds0m
	 R+QVXfrqT6AtYBYsoVYwaJuI3YXZebkDEz2EiSWtxU+c/EI8FmBNK73wZxa8UTQdpM
	 ttpGohXo77QMKKtHNr2DJuelRQbO6rzXzhhpEFdypDgAn7t4MRhFk5OWaxxx3oJGKc
	 y1OwnpqS6Gm6H6aTC0PG1Q7Vmaaq/lMfVWjrZihFyr0q+gvJ2PGNyZxs9gzEoFjym2
	 VMp6xcXCZMmGw==

In a system, it is possible that there isn't a PMU instance in some
clock domains. The original driver will crash because of the pmusela
pointer being NULL in this condition. This series fix it.

Baisheng Gao (2):
  perf/arm-ni: Don't crash in probing clock domains without a PMU
    instance
  dt-bindings/perf: Drop irqs for clock domains without a PMU instance

 Documentation/devicetree/bindings/perf/arm,ni.yaml | 3 ++-
 drivers/perf/arm-ni.c                              | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
-- 
2.34.1

