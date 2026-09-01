Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63F366048;
	Tue,  1 Sep 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272494; cv=none; b=ZiTF0nQ5NWaFnUX/uDY/pd4+2Qx2eN82saSXnEhkr1OEM2KxZaPLQRhI+cqg8OnTKolt09xpXMTDHWIcWPfdoRL8gDyBlupcBl2Y/SF/gJVh2gRbjU1yg0g1rOCG5dwqkRk5TIjR8FdUGSWM5pOsT29rZeN0kGg+xxAUwmHODC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272494; c=relaxed/simple;
	bh=Z5KC5/voZNvU5d96y2OKaoXL8EZmW60+UN09Xzk6T1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t87IMhzJdhn3YRtkAaR6pSpupcFlTB9hERhhW1yqeB9zNnlBQPSOOoG/PXuCocVtvx97NxPAKSw9h/45zhZA9JISLgntDxraC58bIF0+k+HIElNbGDHnFAQMyvNx6xMBmZ06XwMlzueQqImfKvnFRrCBiOgkAkWtZ9DsVSyg+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLxkpoDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLxkpoDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD68F1F000E9;
	Tue,  1 Sep 2026 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272492;
	bh=YAKNeA/4QkQbqM7hiTsCNwtyw4TIDuXo+NwB0Wtjg8Y=;
	h=From:To:Cc:Subject:Date;
	b=cLxkpoDemeEpk0FOZWJ8PTfdzMQIIQmHZWADV7Sa0nYy1cxf05eBmqWvEY6QtJiyv
	 C0SDFrR1gx3xBgfQYM9gWxFPusKPFUagWnBXJxakhGBu0fugR6NdsgKa/RrRovqIEv
	 iAJTX8FQ+fKAohkcnFoNnkGDDQ/HWLPp2v5llt42q4iRDDSYrxw+UBWF2QWaWEYXZ6
	 QS84Cx49gp/NO5M+5JdtFyKdfsLpcKAtihFG88GyCw8zWu+iG8jU4MSHq8uuEQWF4H
	 faK2UnGEWYLP3bczrn48EzVuX+t/m1TC1VZP8x4bxeAw0rLDP9jkz9cUOxMOgkEF/c
	 MJdVvII5Y11hw==
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
Subject: [PATCH v3 0/3] tracing/probes: Fix BTF structure member finder
Date: Tue,  1 Sep 2026 23:21:26 +0900
Message-ID: <178827248631.123716.2627172171811720261.stgit@devnote2>
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

This is the 3rd version of fixes for the BTF structure member finder in
trace_btf.c. Sashiko found 2 problems in it during reviewing the wprobe 
series.[1][2]
[1] https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kernel.org/

Here is the previous thread:
  https://lore.kernel.org/all/178822361441.115597.11442662641658772793.stgit@devnote2/

This version decouple the indentation cleanup part from [2/3], and
add a new cleanup patch[3/3].

Thanks,

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Masami Hiramatsu (Google) (3):
      tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
      tracing/probes: Fix BTF kflag check for anonymous struct member access
      tracing/probes: Fix code indent in get_bitoffset_of_field()


 kernel/trace/trace_btf.c   |   31 +++++++++++++++++--------------
 kernel/trace/trace_btf.h   |    3 ++-
 kernel/trace/trace_probe.c |   15 ++++++++-------
 3 files changed, 27 insertions(+), 22 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
