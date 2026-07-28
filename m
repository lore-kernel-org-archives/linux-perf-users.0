Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11F336EC0
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254374; cv=none; b=uWNlJWdRUaWktpjOW/Kjihix3pFgqy+/4h5S1OQKIzWGI6Ss0qyLD83dqHRIyTcFGQ9sRP0hV+uWVqAewWvWhyybfTDqPsS8REPsaO7ZjzTdj5O/MrCo1LxcFPymUt+oLLiU1sOQBZUCBZPyJOXNOpdqMy8EsOC59wFcYce1Kjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254374; c=relaxed/simple;
	bh=nVkco82+yfXz0BQn2xyAzX3TupsGHo0xXHaVTkcrZB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUiIUfzNYW71ah2fS9Q5NOcwzkJCUAaKsnZW0PkQkEzGGZpO5FPormSfUnfhmAggyQC8Ic8yuTdGA+IPVfatsYkMaLuUDbSLmT39nDiOd+LBZQe/lcfZoZtghm8Iz0Gtf1r9cB3Vz8Wm9h9YnmTD9nuoQktB5CxYPKSPZQPRfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pI7+CWFB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pI7+CWFB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6CA169E;
	Tue, 28 Jul 2026 08:59:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54EF33F66F;
	Tue, 28 Jul 2026 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254371; bh=nVkco82+yfXz0BQn2xyAzX3TupsGHo0xXHaVTkcrZB0=;
	h=From:To:Cc:Subject:Date:From;
	b=pI7+CWFB1Kkxunc6WyKU72zAowhxdmNVEAeKVIImVgZiHYfKVlop2CgU3btkDeEN7
	 CKoRwoRh7itJndrY0KI3HKAwYz0Cuh5bfG5HMngmOiTc0DocKlln9PJE+co/VO5/95
	 CCjVDuTHk6TI/54KnZjwLMQTecB+AoLKgBaftEXQ=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com
Subject: [PATCH v2 0/5] perf/arm-cmn: Support CMN S3 r2
Date: Tue, 28 Jul 2026 16:59:20 +0100
Message-ID: <cover.1785252273.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/cover.1782830759.git.robin.murphy@arm.com/

Hi all,

Since nothing else has come up, this is a very minor respin to fix
the bisection nit that Leo spotted, and hopefully it's good to land?

Thanks,
Robin.


Robin Murphy (5):
  perf/arm-cmn: Rename filter variables for clarity
  perf/arm-cmn: Refactor event filter programming
  perf/arm-cmn: Refactor event filter data
  perf/arm-cmn: Plumb in new filters
  perf/arm-cmn: Support CMN S3 r2

 drivers/perf/arm-cmn.c | 490 +++++++++++++++++++++++++++++------------
 1 file changed, 347 insertions(+), 143 deletions(-)

-- 
2.54.0.dirty

