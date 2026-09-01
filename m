Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216137107E;
	Tue,  1 Sep 2026 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223621; cv=none; b=sc6L0hS7/kpK5aD1vlaDC20sRwC6LsjUhL0SRqfHYjeKVHZQhC9+TjPfME7KaWf55uInlK9f9t+1fFoKmFi1mnmFVtjVHdRz9CELDnUYemWOIYTyb/6CwSrqp9k7LcZAhGldIfHS4bPkj3lPu7/TlgKwx2TQ+J/1aJtWVo9Wa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223621; c=relaxed/simple;
	bh=Ir0E7pRDg9tseeOVUCLMUKkniJB2ZIIY6KAxs46dMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=edgmGars4z6OF5x11Id+42Miy0KWGbxkFHLj9+o3o1x/EIiIY3yeY0G6LRWuk55rhpPtV3KEIMLXpaWBErF1CFag56prvzJ3MTA/S8gAIgPp4ueHL39at5hHYDcKNh9vdWrOJkr07OO+cUOxJFM6zssy8VA7NnbbDzmBIwD7Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlSTpCRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlSTpCRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7904E1F000E9;
	Tue,  1 Sep 2026 00:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223620;
	bh=fgX2ZQ0/L7xnGc9Gc+o0FHCjvceD3r2veUVXYujxj0c=;
	h=From:To:Cc:Subject:Date;
	b=jlSTpCRLUAirGrMy1NOxLFXtKwp5K/2TwH17UF13rm0lzFU9Chcdjrc2zu4U36yZi
	 3ujcVcsDKDSGq+W6hv3mZMaTQgY2hGK6Ilb+fY+3aOAnX3OWnk/giodQipXq4IFsro
	 JZTOSONYRxiIUSdqfcHyB2azx85PlhEsZ/tksN9Y4FIpsY5FhTbNtS5NwFn8Xj5XE9
	 1lI4SsTA0UQGG+mOTof5Kj+hUUmqKsLb4cnPrcL8iCRl4Dba5LQ2b4nE+nSCnBBouX
	 o4KLw25RLq0UMToCQWGOhqWtEcyGR/J9MdqaLYWKzdG5qOn8vc/jMYszdiJoTpK67S
	 dF4UI7QtXvqIg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/2] tracing/probes: Fix BTF structure member finder
Date: Tue,  1 Sep 2026 09:46:54 +0900
Message-ID: <178822361441.115597.11442662641658772793.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

This is the 2nd version of fixes for the BTF structure member finder in
trace_btf.c. Sashiko found 2 problems in it during reviewing the wprobe 
series.[1][2]
[1] https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kernel.org/

Here is the previous thread:
  https://lore.kernel.org/all/178818875393.104360.1469039168635349344.stgit@devnote2/

This version added required tags and remove unneeded NULL initializer[2/2]

Thanks,

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
      tracing/probes: Fix BTF kflag check for anonymous struct member access


 kernel/trace/trace_btf.c   |   31 +++++++++++++++++--------------
 kernel/trace/trace_btf.h   |    3 ++-
 kernel/trace/trace_probe.c |   15 ++++++++-------
 3 files changed, 27 insertions(+), 22 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
