Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988478;
	b=qM/mLAmwflZCp6gjmTuEfnQ5t8r0CWSosAzyRZl/OexaNWafmDTsTv168ex6EVdu2bXY
	 4jYebslPGL0xIn0TkPmVpMEAw38Qw+tdEt4yWahDSlJJuglcQtYmvjPUfawq5fQPotrNi
	 f83JIhi6K3inEam9zfIz8ECmXbJu40ZtQyTi9PtSi3rER4ChM/e6Fz5Nzh2lfU3EasxX2
	 x1P2bOQ4gK8ajkxuppb9VlRQAekedzPuc1CtVqvmtbrky58F2bISCgpqN4R2K7zUeotLv
	 qj2cFUvrWAWKhF+oV+lKlW+keQuGaNCvxZcQ0enoexeYxWKbT/7yo717fyQP0QyTHCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mS55piVJmiIxDLjSYEdmjlah1SpUzzUUwdlBrhFXVxc=;
	b=5L1HDlDyxXzXRUp4ZLKkZc0AAvyYRmaxDHYfKI+Zb329sAMlTNXRdRFfoq0sY/w3tHM0
	 oLaxL0++J+87gvY2DXm/INf8iyUvcVn74EHnswH15UascfC76mk1sFfcIGC/Csjw0W3yk
	 /gyEfMr7RLQ5+CojXZuGBYcKOFnImQb7ajBYFFDS+grl2blDmFCQNEtHDuKbQGEnile9k
	 BIlQUiVMgOsXnxoeUtx8SLPnN2RUBzdXaqFVii2A1qziiqMEOMUnOImqPDwAYBmQ2OcBS
	 deUWCEF0Rf22cZmmnM91gGTOufxPyIPtburMTyAwPKZNDV1iZCtHkuUdqzvjnqFH9Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QtD+tjS9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACBE606D803
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACBE606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QtD+tjS9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4BEC1682;
	Fri,  6 Nov 2026 10:07:52 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 199153F673;
	Fri,  6 Nov 2026 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793988475; bh=5EaGEokxUmNP4DAbaJfVst4VbM98zfSaDMbe3rDMmaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QtD+tjS9tMU2FQ85v3Q72YakUQ8pedLf4BUbFCdgnjU9fExrWgHVV4M6JWOKyrhpF
	 cpHrI4B3SBUQn0r79Igashp5HFxkHe8/YZTXh0ZZ/VsPQta4nvHSXiXo5RyImS4CKh
	 CYZGkCQf6spYkRQ7hOHET2huXRVWQyhBxV4NvCd8=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] perf: Arm system PMU and BMU drivers
Date: Fri,  6 Nov 2026 18:07:42 +0000
Message-ID: <cover.1793986672.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously:
https://lore.kernel.org/linux-perf-users/222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com/
https://lore.kernel.org/linux-perf-users/c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com/

As promised, this a resend of the new drivers which missed the boat last
cycle. No material changes since the respective v3s, just rebasing, and
I decided I may as well post them together as a series to pre-resolve
the Kconfig/Makefile conflicts. I've also revived the BMU DT patches
from v2, as some interest has been expressed from within Arm, but again
they can still be considered somewhat optional as it's only the first
two which the AGI CPU folks are clamouring for right now.

Cheers,
Robin.


Robin Murphy (4):
  perf/arm_cspmu: Add Arm system PMU
  perf: Add Arm Bus Monitor Unit driver
  dt-bindings: perf: Add Arm Bus Monitor Unit
  perf/arm-bmu: Add Devicetree support

 .../bindings/perf/arm,bus-monitor-unit.yaml   |  41 ++
 drivers/perf/arm_cspmu/Kconfig                |  13 +
 drivers/perf/arm_cspmu/Makefile               |   3 +
 drivers/perf/arm_cspmu/arm-bmu.c              | 541 ++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
 drivers/perf/arm_cspmu/arm_cspmu.h            |   1 +
 drivers/perf/arm_cspmu/arm_syspmu.c           |  67 +++
 7 files changed, 673 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,bus-monitor-unit.yaml
 create mode 100644 drivers/perf/arm_cspmu/arm-bmu.c
 create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c

-- 
2.54.0.dirty

