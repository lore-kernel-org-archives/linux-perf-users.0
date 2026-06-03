Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987633DEC8
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498701; cv=none; b=OD49dUxczQTixj4VL5qPyI5vTOYg/sXnOkw66GiW1GVUzzZyRAQ2FiY/rszqG2x+pMdfWiSSmflBU9Wd3ArrebhhkUTdoiSwmFxzVf8tkfnbDubb9N+wxIWBnecRXlgCjnz2eciZhr2kM+GM/SlDSl8r4GQj2p8RuuxkDTReQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498701; c=relaxed/simple;
	bh=KxnTltFTHspXt8d6XzhpddUVNKj9CgXqqLOhG+NdNvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7hr2x6RGYQmsm6Ok6JsF1j53iqA2ZT3rtSxV/W/VZuZQSXEv0swtLmedcwrIZYgAxc10TuLNwcY3AWwW+64DHtwEnsQfscQUi5i3TKkSKx+AdAoO2dho4ml6huIYIXqE0Bh9IAa5H+lRtbxfpJzsnCELPVxTueeRnimt4d21sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=S6yA5gLb; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="S6yA5gLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780498700; x=1812034700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxnTltFTHspXt8d6XzhpddUVNKj9CgXqqLOhG+NdNvo=;
  b=S6yA5gLb3kcwGbQru/istlfD/7c4EqLkYW96wt31odth8NhsG2RofblR
   Bo9TstO50fy4W/YwDZEbIOsDKdjLJtB8eiJEw0ggxOHlE3LxgF5kEnzZ0
   WYlhcL5S/j8xInLjVUzevH9I4CgcFcOKWfMQMvu1VWJ38lvrrfqiHSPZr
   /w/qYeMCAVr0L9JsXpR9zxU9904UXCg+lpugW9Pnc7iA/6qt2qr+CUHK8
   7WzLWxwfInhgRs7r4kJSspR07R88qYJRUrzfRyCruCmOBJPzjPco8mxgB
   YWgVirdEV3l9HZ8aXDGapeiJWkf7z5VjVHGCPcOwqsffpLzrT35omsHqf
   w==;
X-CSE-ConnectionGUID: qOPopO33QFaaCsarnBxoOw==
X-CSE-MsgGUID: VeYg+/tYTA+jpta7AEw33A==
X-IronPort-AV: E=Sophos;i="6.24,185,1774310400"; 
   d="scan'208";a="20524493"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 14:58:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:6912]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.23:2525] with esmtp (Farcaster)
 id 53c0d7f9-d983-4572-944c-3809d9be45ec; Wed, 3 Jun 2026 14:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: 53c0d7f9-d983-4572-944c-3809d9be45ec
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 14:58:14 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 14:58:13 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>
CC: <avivb@amazon.com>, <linux-perf-users@vger.kernel.org>,
	<sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v4 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Wed, 3 Jun 2026 17:57:36 +0300
Message-ID: <20260603145736.27910-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <59893923-0faa-4cfd-b062-16df596637c2@arm.com>
References: <59893923-0faa-4cfd-b062-16df596637c2@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Thanks for clarifying these, Robin. Much appreciated.
