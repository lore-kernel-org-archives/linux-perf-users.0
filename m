Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A13624A8;
	Fri,  8 May 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228837; cv=none; b=HW2SHECgKu7s+D0CVeZMaBBBHq0e4RBjaEjlJafywfap87fe9zNFUnorL8M3O/fOEilEjfdXCd/FcKQjdAyX3Psg31qYw/EA/GyQHTJAPJzAV/LcipIBW4D/RRzFX2DKUv4dtUiq5ERG2FW8+XDOFW90jC9hVR7Oul7Iszl8zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228837; c=relaxed/simple;
	bh=a73lSRvoBg8oqtRew8SX40A5vzZ5CLJdEpWjAqKsG2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMagkHgdeUK2x2YdGhD79vALdxQVR7U/pUMzGhwME2G8jL9EuhWWTcA4FnktyklEUR2cKKQa65qlSEFEf4VLJxOoUV9STRWRwcK5rS61Xg5U0z/IO9ut5jDFdW11iTjvhnisKJhMnZx08DlkmX7BkkOuIrAVrDhuMFTQPHztOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XyMTjeGi; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XyMTjeGi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228825; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a73lSRvoBg8oqtRew8SX40A5vzZ5CLJdEpWjAqKsG2Q=;
	b=XyMTjeGiAv5gDoypJmY6DpY767AnMIl1x6yoUif2T+r7WjTGlSAkioAVWLFYFZ+xLKee9floI1CVzviCPT/gN5m4WHp6viPqIUKI9GukR84vDpuN8HCHy1rE4jQL89oDG5t9YNNX7IfhnPuK8XnYPW5VsHE1332wGBWaa8nGskU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X2WjvBI_1778228818;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X2WjvBI_1778228818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:27:04 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: cp0613@linux.alibaba.com
Cc: acme@kernel.org,
	alex@ghiti.fr,
	dapeng1.mi@linux.intel.com,
	guoren@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org
Subject: Re: [PATCH v2] perf riscv: Add SDT argument parsing for RISC-V
Date: Fri,  8 May 2026 16:26:58 +0800
Message-ID: <20260508082658.3982-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416124945.121699-1-cp0613@linux.alibaba.com>
References: <20260416124945.121699-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping.

Please let me know if there's anything I can do to help move this forward.

Thank you very much for your time and guidance.

Thanks,
Pei
