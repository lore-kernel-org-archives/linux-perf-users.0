Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3F2505D9
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191015; cv=none; b=QBgb3fyCD9E+2M3/RS448J4I9YLemEcU+rDGteAb7EY+dm+EDc8vbqYorDG5s7ZfD4Hz7CPeGQCvRxjtGJD6JguoS/FMR6tJtrlKDnFFxkJ9RkPG1jjVCqBNNd2Q90tVaeKkxmQT48K10o5y7gqJHPHGXgukKgQ0FX+E35QIpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191015; c=relaxed/simple;
	bh=jHHinlEZVa5yN+d7vDapFB1TODkutiB5wNc1vVQbyPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b56rQgFLxNQIuD+EsNGemod9KaqF3fPeUm7SVQjFD6Xp1Q3g7AdsgFFXMnKeC67D3pSp80/8FkeQCXtkKKBCh+KkgzeAs0rOjrjkI3mGq6XN7S/xc3wwGyO0mr3golOCtdx7DFjCt2moeLAZSl3X83z+zPMAe5aH841tdJ7rOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99D25FEC;
	Wed,  5 Mar 2025 08:10:26 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76E4C3F5A1;
	Wed,  5 Mar 2025 08:10:12 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	bwicaksono@nvidia.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf/arm_cspmu: Add PMEVFILT2R support
Date: Wed,  5 Mar 2025 16:10:05 +0000
Message-Id: <cover.1741190362.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is part of something I'm working towards, but I figure it stands
up on its own enough to be worth getting out early. Compile-tested
only, but it's straightforward enough that I'm confident.

Cheers,
Robin.


Robin Murphy (3):
  perf/arm_cspmu: Move register definitons to header
  perf/arm_cspmu: Generalise event filtering
  perf/arm_cspmu: Add PMEVFILT2R support

 drivers/perf/arm_cspmu/ampere_cspmu.c | 32 ++++-------
 drivers/perf/arm_cspmu/arm_cspmu.c    | 81 ++++++---------------------
 drivers/perf/arm_cspmu/arm_cspmu.h    | 57 +++++++++++++++++--
 drivers/perf/arm_cspmu/nvidia_cspmu.c | 21 ++++++-
 4 files changed, 100 insertions(+), 91 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

