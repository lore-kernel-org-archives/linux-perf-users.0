Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18ED2BE62C;
	Mon, 25 Aug 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159152; cv=none; b=qmq9kxp46RWW79fLP1tsht9s0p9Vp7V6jf5YFbGF3h/gGPZsev1OBhP1gi0bxPtc+Ip3FnQa8NRG/nt4wJX/QzcLT/sXMbEDJQMCbqOw87ef/59sYUZ1ek1wnnCyqU1JpgE9fIrV9JlhcgPlqutnxtxqK+NqKB8dHOVU7LQfIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159152; c=relaxed/simple;
	bh=u8H/POAkJXnqexD0Vo2T0kBej6xh78KY+6A9Mc8aNYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJs5LknS176VBTrQgeWSoxAfOFlpyPFiriMLQmGW935GOj3MaA1wTl/1k8LKoHWOhDe2Rp5KyPF2eAMop5iI3TgDG/w/s/wERr/ORs3Ce2RbpMSiD6cH7PbmZtx5XOCyx6fGVS+C0P/bAz1KbJqNn7riBwhrM7v6hKDTM/bm/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abChkQEz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abChkQEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA6C113D0;
	Mon, 25 Aug 2025 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159150;
	bh=u8H/POAkJXnqexD0Vo2T0kBej6xh78KY+6A9Mc8aNYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abChkQEzU5PNu5yh5V5zz4XaRUE6mimBliaIxCekwJuh0MLwa/xPzXMchzTd8A4Ml
	 Vwib2mNxW88e5ZXuA8SOFewTKrlNPBfmCTSMfByl9mcu5ZL1e6Ea8dC8rQEYrePu4B
	 ajp0QuFs7cE9wRwT4gkQXR/zgKyBGJdVpKiLjMXw6L8JYgINQUxu3ZLPfSNQNq7TFs
	 GuGyojSO/SnBdr8kRliTaSROa1FkKolRnOwukNLVmx/Jwf4frlPZifu3rW/PtDwUh3
	 MN4bUOOvVkrSzYb7uJ17H9kScX0QTZ4u9unlmj5ja/kimatMDgFgI0vBiuzx3DfCqz
	 4I+F7CG8/QW9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] tools headers: Sync powerpc headers with the kernel source
Date: Mon, 25 Aug 2025 14:58:58 -0700
Message-ID: <20250825215904.2594216-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  69bf2053608423cb powerpc: Drop GPL boilerplate text with obsolete FSF address

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h

Please see tools/include/uapi/README for further details.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/powerpc/include/uapi/asm/kvm.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index eaeda001784ebb6f..077c5437f5219b05 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -1,18 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
  * Copyright IBM Corp. 2007
  *
  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
-- 
2.51.0.261.g7ce5a0a67e-goog

