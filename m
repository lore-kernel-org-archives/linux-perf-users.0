Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1A51C343;
	Mon, 31 Aug 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188830; cv=none; b=lozry8bDZHZRUugi4FMRJ8JaFbB5Beh+mgEQ7syw7jAucCw9O8IM5OgFhJjKrc1/K4/Y+QarJlKZ1qxgctOTfWYZB+Q/s5JM9HUssk/ykycKsPIiLlDmIpIPc0Hr/aAw4X0ImbI9bieIR9tLNLfKWuTorhMZ0+KWp+XWwJd/diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188830; c=relaxed/simple;
	bh=UftvirRnSwtEwLfdrnLllSR5JKICCIS9aq3XkxBt538=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1OF+2awVZzmFo3Zx18Gylnj+RaE/gW1JdHr7mT4p0hcAd3d62sO9JBTv28WBvneO9An1YR3/toGhJx7ESvrmlyl7e+B8KP0Eh+z+2AM00lwiKghCDaLy76fvJqs9m1VpDxOvt9FmlH4msP2JeIYTaLlYA/UKR9kLCr3vbBpIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 355385F574;
	Mon, 31 Aug 2026 17:07:06 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id EA64F162257; Mon, 31 Aug 2026 08:07:02 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com
Subject: [RFC] ptwrite uprobes
Date: Mon, 31 Aug 2026 08:04:36 -0700
Message-ID: <20260831150651.1134594-1-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobes currently always require entering the kernel to log anything.
While that works well, it is rather slow.
    
Modern Intel CPUs have the ptwrite instruction, which can log data to
the Processor Trace buffer without entering the kernel. 

This patch adds support in uprobes to patch in ptwrites instead of
the normal probes. If a user collects Processor Trace with perf
the logged data will appear in the PT log, otherwise the instructions
will be nops. 
    
The benefit is much faster logging, but it also has a lot of
limitations. There is little filtering (other than what perf or
PT can do), no EBPF, there are restrictions on what can be logged,
and of course it depends on PT being recorded.

Still I find it useful.

For more details and performance numbers see the Documentation patch,
but it's multiple orders of magnitude faster than classic uprobes.

This patchkit touches a variety of areas: perf tools, x86 generic,
uprobes. It currently relies on a separately posted bug fix ("RCU safety
for maple tree iterators"). The patchkit is on the larger
side, and maybe it should be split up. But I wanted to keep it together
at least for the first post. Some of the earlier patches are generic
fixes for uprobes.

Comments appreciated.

-Andi Kleen

