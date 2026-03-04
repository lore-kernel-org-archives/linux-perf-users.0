Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD0A38E13F;
	Wed,  4 Mar 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615317; cv=none; b=ClZEg3gcZ4SoTr2+V7e4PbuF5B2rCWsz2l7XvWKb1dVCDKAULlndWRq88nnVFBrUWjEoDBv551PlUQolRSJXGhqETOY5SdS5f6fal0tmvyQgORvw2ZdROocvB5eBLAchP/xMxJozz3HYM/PK66taEurKCPBzDmDXrA963yl4Ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615317; c=relaxed/simple;
	bh=V/Qojnuj+I9U45r4POyL6r8L8dOX5Juzne+U50WlNzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hpZlbBmo3GPu0F3ZMS4+EQFlmN4eVdc459eCXkNgsAP6qfEsDX2Exmi6JGE3uB2y8hW9PulXqpx0ycpT9eGUpiSLzHiPTxKC19nS4IKeAzcG+xlJSKM+6xYB9/m/G1uM9mv36LhtPjNdvrHRKbpMLJMWIURRg03rRlsdqbwfhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBMcoeVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBMcoeVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E0C19423;
	Wed,  4 Mar 2026 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772615317;
	bh=V/Qojnuj+I9U45r4POyL6r8L8dOX5Juzne+U50WlNzc=;
	h=From:To:Cc:Subject:Date:From;
	b=jBMcoeVU+vWY4QpZHjyp/qBZE8TAocJUWiFCUwTqebiQq+kiWI4kUOvob1NztODd2
	 QlKk+d/rls6KBvS6C6W4ddANTroatNb1foVl8SjHNWJwU7yZQRmCw3wl/c38H+hYLx
	 74iHkG5dkrXW4Yo/npVo1jPnGu8226wP1qGtnT/gJLArtMX9TZWBek6gNly+BaulwV
	 qBovdmuqUd7YcAxwLyT+TF/AvJ1td8CN8Vnuc3hjZDkOJgktzw/ZdmG9D3RHBggppX
	 7VicvcdwH2RYhEKGWpUaF92W2xfFGfzWSr3sBKZVCXx+1QBm2MMdqUWjOSzeUcH5et
	 Nq1kf2AbIOatg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Naveen N Rao <naveen@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Zw Tang <shicenci@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH] kprobes: Remove unneeded warnings from __arm_kprobe_ftrace()
Date: Wed,  4 Mar 2026 18:08:32 +0900
Message-ID:  <177261531182.1312989.8737778408503961141.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Remove unneeded warnings for handled errors from __arm_kprobe_ftrace()
because all caller handled the error correctly.

Reported-by: Zw Tang <shicenci@gmail.com>
Closes: https://lore.kernel.org/all/CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com/
Fixes: 9c89bb8e3272 ("kprobes: treewide: Cleanup the error messages for kprobes")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab25b4aa9095..2c2b7bd24dd4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1144,12 +1144,12 @@ static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	lockdep_assert_held(&kprobe_mutex);
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
-	if (WARN_ONCE(ret < 0, "Failed to arm kprobe-ftrace at %pS (error %d)\n", p->addr, ret))
+	if (ret < 0)
 		return ret;
 
 	if (*cnt == 0) {
 		ret = register_ftrace_function(ops);
-		if (WARN(ret < 0, "Failed to register kprobe-ftrace (error %d)\n", ret)) {
+		if (ret < 0) {
 			/*
 			 * At this point, sinec ops is not registered, we should be sefe from
 			 * registering empty filter.

