Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361F2C3244;
	Tue,  9 Jun 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992938; cv=none; b=Q5BU+in2mE8SRHM6zOl2CPbF9MGgww337Hqmk/zgpaSPtYVGoNgaPoqj/0gPD1FBn34mymVE2jDUYu3mponRAPl+EyxqxduLBvkY4OmkwEQGmDpZD0kNaWTkIS0X9O4Pq+bggvvjlRWCl++P2DqQfkmARhetCpqObYtptQ69p7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992938; c=relaxed/simple;
	bh=YWuwoRVdEr3bFtbLCW7SgI1rzY0pOTA7FE29cj6FNb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tycBThyrmm7vUugTWQSEWYuWWLJWj5BQLUqi0+sa3go9sZ6lxIkQmzFPNaSQgBDu0C48mBCfeGKu6BN8agVnvri0rrdNRqAQaT/aC9axCDc5xa3kqUbFHtrggpnLnaL41ceZCfEabKYxsXHlEhj7Jz4i/0wHFCp5XizfW9hSVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wWrcR-000000021Mp-2rj7;
	Tue, 09 Jun 2026 10:15:31 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/2] perf: riscv: fix register name strings
Date: Tue,  9 Jun 2026 10:13:07 +0200
Message-ID: <20260609081500.743861-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the register name strings for risc-v to match the syntax for kprobes.

This requires redefining REG_DWARFNUM_NAME. Make sure that different
definitions for different architectures don't create compiler warnings.

Martin Kaiser (2):
  perf: avoid redefinition warnings for REG_DWARFNUM_NAME
  perf riscv: fix register name strings

 tools/perf/arch/powerpc/include/dwarf-regs-table.h | 1 +
 tools/perf/arch/riscv/include/dwarf-regs-table.h   | 3 ++-
 tools/perf/arch/s390/include/dwarf-regs-table.h    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.43.7

