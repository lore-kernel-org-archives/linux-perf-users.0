Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0423016F1;
	Tue,  9 Jun 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992963; cv=none; b=oYfF2e4trwWdeFo1UIma2LInOfUJjluXZgB8I8rg10nV8lmIpRm73Z3aVXVpdfz0Dfuv6dkzsXQx6G146GCeGV/TYkApBUs2Us+ePAlAZaGSLkzlF0DxMt6gUWdJe+xhrsSlGwBrMmxGlVMbsVrB8XlPu65zAQllT+h9jq+kQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992963; c=relaxed/simple;
	bh=/e1IP8/oX5er6z1qkuYL3Of8m1Oz5t3A0icktxfNjV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnt66SZYE6z/CHMBCc64wRtob11dcKBPXsLse2zyp7YDvQMIPaIpqfm0brSJ/Kg4DqlkLYXwHwuJSh3kOA/ZHBAlMDsRAKJmIWv5W6z9jj1PM/yI9Y4LXHA67372gU1aKm782eaJ3c/hlgPdtL793Q+TP2xRGYukUxYCA7tkiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wWrcr-000000021Mp-46bn;
	Tue, 09 Jun 2026 10:15:58 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 1/2] perf: avoid redefinition warnings for REG_DWARFNUM_NAME
Date: Tue,  9 Jun 2026 10:13:08 +0200
Message-ID: <20260609081500.743861-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609081500.743861-1-martin@kaiser.cx>
References: <20260609081500.743861-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwarf-regs.c includes an arch-specific dwarf-regs-table.h for several
architectures. This pulls in different definitions of REG_DWARFNUM_NAME
and causes compiler warnings for W=1 builds.

In file included from util/dwarf-regs.c:23:
.../dwarf-regs-table.h:5: error: "REG_DWARFNUM_NAME" redefined [-Werror]
 #define REG_DWARFNUM_NAME(reg, idx) [idx] = reg

Undefine REG_DWARFNUM_NAME before each new definition.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

Arnaldo: I've now gotten to the same point as you. We need two separate
patches ;-)

 tools/perf/arch/powerpc/include/dwarf-regs-table.h | 1 +
 tools/perf/arch/riscv/include/dwarf-regs-table.h   | 1 +
 tools/perf/arch/s390/include/dwarf-regs-table.h    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/perf/arch/powerpc/include/dwarf-regs-table.h b/tools/perf/arch/powerpc/include/dwarf-regs-table.h
index 66dc015a733d..7e746cb31b66 100644
--- a/tools/perf/arch/powerpc/include/dwarf-regs-table.h
+++ b/tools/perf/arch/powerpc/include/dwarf-regs-table.h
@@ -7,6 +7,7 @@
  * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
  * http://refspecs.linux-foundation.org/elf/elfspec_ppc.pdf
  */
+#undef REG_DWARFNUM_NAME
 #define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
 
 static const char * const powerpc_regstr_tbl[] = {
diff --git a/tools/perf/arch/riscv/include/dwarf-regs-table.h b/tools/perf/arch/riscv/include/dwarf-regs-table.h
index a45b63a6d5a8..009a4e3c51ab 100644
--- a/tools/perf/arch/riscv/include/dwarf-regs-table.h
+++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
@@ -2,6 +2,7 @@
 #ifdef DEFINE_DWARF_REGSTR_TABLE
 /* This is included in perf/util/dwarf-regs.c */
 
+#undef REG_DWARFNUM_NAME
 #define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
 
 static const char * const riscv_regstr_tbl[] = {
diff --git a/tools/perf/arch/s390/include/dwarf-regs-table.h b/tools/perf/arch/s390/include/dwarf-regs-table.h
index 671553525f41..e90b63157702 100644
--- a/tools/perf/arch/s390/include/dwarf-regs-table.h
+++ b/tools/perf/arch/s390/include/dwarf-regs-table.h
@@ -2,6 +2,7 @@
 #ifndef S390_DWARF_REGS_TABLE_H
 #define S390_DWARF_REGS_TABLE_H
 
+#undef REG_DWARFNUM_NAME
 #define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
 
 /*
-- 
2.43.7

