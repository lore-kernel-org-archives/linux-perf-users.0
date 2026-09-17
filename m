Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7170378822;
	Thu, 17 Sep 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686561; cv=none; b=rg48mtqBy0v8WCsH9d2Thx6SjCNB/BeojMf2XHY8Eq7/XYr2rNzvdEuedZ2+qWhjAR4BPpRL5wBKrhZrbSwcKQr5UJ6I9rWjDqNKfQk1US6ich5z3u6WcwePEchoabNNR0RlL1Zt+Z09qO2hkNaQFZG67LRo9MVD9Gy7ECK8U9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686561; c=relaxed/simple;
	bh=ZgWcRLXwtIAUoGG3QJ7wr3sl+rb99MKPs6GCa9yt4g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIr/DZKXkNrGN+MiZ2jwKOkb052LIRdHrVCqVC4S36ZTwp0LIpVOjc+/CvLvztTr0SFEHA4s5yvJtfqaURsEc8M8bl0jUjMLs2wLgAgvGp3J/jzXyRpBnnWNaJYprr3EvkHNOg5/8eZvQfG7fzUgkJxNuPyenO4zTCgqE1KZFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 15BF55E89F;
	Fri, 18 Sep 2026 01:01:52 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 73C8E162297; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com
Subject: ptwrite uprobes v2
Date: Thu, 17 Sep 2026 16:00:27 -0700
Message-ID: <20260917230127.924985-1-ak@kernel.org>
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

For more details and performance numbers see the Documentation patch,
but it's multiple orders of magnitude faster than classic uprobes.

This is v2 of the patchkit with various cleanups, fixes, simplifications.
It fixes the VMA iterator bug that caused crashes, as well
as addressing a lot of Sashiko feedback.
I stripped it down to only the minimal kernel code without the
user tools with minimal dependencies. The fault handling is deferred
for now.

Comments welcome.

