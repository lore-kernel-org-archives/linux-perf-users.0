Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFF23AB;
	Wed, 13 Nov 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457277; cv=none; b=ikTJyZtMV40fi/eeD8gIdqiPAv411ZFcEmALlD7fEu/iTa0q4HVOUunZgpdv/CDpAmBjy5VaOdp017rnqN0+mqA0u4Hw9pG7pegv8zeW0Nro3DbECzUxxLugdTWn449Xws3B3EUx38Ik91sMdzw+vLYGuOzMOGTxc3jmYZqSpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457277; c=relaxed/simple;
	bh=KJ51AifgLpojBmlX5fPQBdlRAar0/5FKRY8S60gkj+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jxJcNQU0ARSG7zfRJWDqZYZz63gVtju7YIyY3oCH9zSsk7oPXaHXf8HkKJIahTXEAju4TIitSnqjlZmTrUfcT9npUJ58UJbiCC1NkZmA/ffKpctqkznFOaRPwr+corgCGLOMhaHKlx+HeqgFshaEmiwR/+gnXAQ1HR2mPv5Bl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWKpQeoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWKpQeoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25A5C4CECD;
	Wed, 13 Nov 2024 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731457276;
	bh=KJ51AifgLpojBmlX5fPQBdlRAar0/5FKRY8S60gkj+A=;
	h=From:To:Cc:Subject:Date:From;
	b=XWKpQeoNUSuZ1eaz/pkGOdmUheq8Yqvbu4pL4PjsKW0jGpant8T2Fu1WP08AA8X0z
	 XH9uTC6NNk1Mcyp3eveqO9RuQ4Jl6odOqgwx3iQeUrVq224hA1cv4csstTJIHzaGHF
	 AmScKmMYCvBUpPNPhL2iujkIHBZbqAfgEHoRvA+u6UPtKWJ+obUZSAQyXuGZhx2wLV
	 u8am2Bb+QwlAA+cZ90oEzuZZcdlLA87FSq5ywPugcyFLbL8WfWSQTG8k5Lr6uXMzMS
	 C0T1KG3HwyLqPUBeRgwdq3NOaNhvYJZmuKy7c/Tc4EYtWnEn3HMFnS+ejFqjVGDEc6
	 bP3kosu+2+aGA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf-probe: Improbe non-C language support
Date: Wed, 13 Nov 2024 09:21:13 +0900
Message-ID:  <173145727287.2747044.14103970580490941023.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
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

Here is the 3rd version of patches for perf probe to improve non-C language
(e.g. Rust, Go) support.

This ported the last patch on top of tmp.perf-tools-next, and add a fix patch
for compilation errors.

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

Thank you,

---

Masami Hiramatsu (Google) (2):
      perf-probe: Replace unacceptable characters when generating event name
      perf disasm: Fix compilation error with stubs


 tools/perf/util/disasm.c       |    7 ++++---
 tools/perf/util/probe-event.c  |   32 +++++++++++++++++++++++++-------
 tools/perf/util/probe-event.h  |    3 ++-
 tools/perf/util/probe-finder.c |   15 +++++++++++++++
 tools/perf/util/probe-finder.h |    5 +++++
 5 files changed, 51 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
