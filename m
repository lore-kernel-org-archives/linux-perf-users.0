Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF320A5D0;
	Tue, 12 Nov 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394032; cv=none; b=X5ANeTcE57MLYp87f+deAW9fKT4ZF6xoig/U96Mc+Mp2lB24GqEAtvH4XOeCwJ5BB9CrKCJA0dj48kKyRPfxnny6lAv2s106PM3KlLBv3s11JlmRZ1l9FWcDF5p79yJKlPuFFmPdDY2dxR1uzuBFR8dZuMqBCR7mXuDfUBY94Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394032; c=relaxed/simple;
	bh=obaMSikP1Ug9P5SplvLqE/5n90n4UBuBKkSTUDIDwuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1cu6kBgOknTuOJwZKv0T8HGzWSWH1piafL37NGKH1P3yxPHc0oyNdI3SGRa/BEwbNjKfxzH/YUrffstgSQ4eh6rzTKXaxc7+zlWQHk4WymoTtMVroSGp5HVzwARUZ9cyfDibNqF2PLmF6ElKgcHi22bXcw6pMGNu+lMWyoEOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16732f9e6803-dd118;
	Tue, 12 Nov 2024 14:47:05 +0800 (CST)
X-RM-TRANSID:2ee16732f9e6803-dd118
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26732f9e8e55-4f732;
	Tue, 12 Nov 2024 14:47:05 +0800 (CST)
X-RM-TRANSID:2ee26732f9e8e55-4f732
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH] perf jvmti: Remove unnecessary ret variable in jvmti_write_code
Date: Tue, 12 Nov 2024 14:47:04 +0800
Message-Id: <20241112064704.282702-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241112060103.282531-1-luoyifan@cmss.chinamobile.com>
References: <20241112060103.282531-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've rechecked the code and found that removing the ret variable is
not a good solution. Please ignore this patch, I'll submit a final
version to fix it properly.


