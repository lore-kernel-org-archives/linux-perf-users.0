Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E673A5449;
	Sun, 24 May 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637145; cv=none; b=NY7sz5//WZxl5jayMEwtdHcxx0pXwR+ovVp2sV91ML0rlV1tEsxYrRtMDvXwe72MqXIZ7bAfyDypNngbH1WXufw0eIsOFb3Ap49zR9ip27H2vR7w14m8DDvLxPcqC25EZjxAzw7jht1UrNUkO3jg9HKupEh2hOt4mOBwZzd2Crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637145; c=relaxed/simple;
	bh=upuFwr/UQ03zcbEHWIIPmZMU9Zyn/iW8m3xxDMCPPW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKgK+KD5Bt2ZVmuFJkiKiQbfCa7c/9TxBXsl+4AIP9dWrrb7oyOWLAHyVQ6fFxMGDZSjlLrQlWZAqbxAS9pa1o+yL4SfuavpuSIkpmw5HIXFxezx/i8lb1w344xvvX7Q8Dci8XeniyIlB/FvlEWP3jcz1lubbGMyXxBHLWz7FK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PijDN8v7; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PijDN8v7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779637144; x=1811173144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eo07lhz1ZYzs4I7CDsALtpJV5qdnglg24lvtIPhYQ2w=;
  b=PijDN8v7jdNZ5Bw1S88nYfEjEnGwYlAaT1M7EFbX8EoJ7v73w0pgmt2U
   2uFtXtRp6/rz8QLwFq/88yUL0qG962GUHoHED8zuZLRNDuOmdvyBT9LM5
   DNIBwOQ1NbqoTAniH6Dmvnynkmp1OX6lPT8lTS2NViEf4p2fnWUrqg1jM
   xjWwdR2rHJrxArV6OMWpNEkPBg78XzbRzLgSzvOficOxz3Tkep//0QtTa
   Paq6rQCFWYlOgUPbFjrOl46bPr4TuYt3pUWO9rEaOMqGvFHTlrYU83Qr2
   8cJqs+c0K7IqzGqDK7+c9LgvxOTvbpEYyZgRjGVx7ISS6ID6VdmAV4EkR
   A==;
X-CSE-ConnectionGUID: KP4fJ1PpRj2YoiD1PWIFUQ==
X-CSE-MsgGUID: KzOVSTDJR2CEABSJxJi+qQ==
X-IronPort-AV: E=Sophos;i="6.24,166,1774310400"; 
   d="scan'208";a="19877271"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 15:39:01 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27340]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.199:2525] with esmtp (Farcaster)
 id 3bd2d114-3875-41b5-affc-bd66079b8795; Sun, 24 May 2026 15:39:01 +0000 (UTC)
X-Farcaster-Flow-ID: 3bd2d114-3875-41b5-affc-bd66079b8795
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 24 May 2026 15:39:00 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 24 May 2026 15:38:58 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<avivb@amazon.com>, <zeev@amazon.com>, <blakgeof@amazon.com>
Subject: [PATCH v3 0/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Sun, 24 May 2026 18:38:46 +0300
Message-ID: <20260524153848.16334-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260504133923.23373-1-avivb@amazon.com>
References: <20260504133923.23373-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds support for Graviton5's customised CMN-S3 which has
zeroed discovery registers.

Robin, I understand moving driver state into the core perf header isn't
ideal, but I couldn't find another way to grow the struct. The v2
submission failed the kernel test robot build on i386 (COMPILE_TEST) due
to arm_cmn_hw_event exceeding the static_assert against the 'target'
field offset when CMN_MAX_DIMENSION is increased beyond 12.

Patch 1 moves struct arm_cmn_hw_event into the hw_perf_event union to
resolve this. I'd appreciate your feedback on this approach, or any
alternative you'd suggest.

Patch 2 adds the Graviton5 workarounds themselves (unchanged from v2
except for the DTC logid fix below).

Changes since v2:
 - Revert DTC logical ID assignment back to xp->logid (per Robin's
   review)
 - Add patch 1/2 to move arm_cmn_hw_event into hw_perf_event union
   to resolve 32-bit build failure

Aviv Bakal (2):
  perf/arm-cmn: Move struct arm_cmn_hw_event into struct hw_perf_event
  perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

 drivers/perf/arm-cmn.c     | 55 +++++++++++++++++++++-----------------
 include/linux/perf_event.h | 22 +++++++++++++++
 2 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.47.3

