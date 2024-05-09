Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4A12C47E;
	Thu,  9 May 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293513; cv=none; b=eQgPxqJA4wXML2jA+UkAhu6C51PXMSKNWt/GoRMxb9A3R8Wj7Y0pVm15Ebqx+Z3iFUeGJ6mWGzRjNq+CpeR/gdW5kc55zC4pK0kP0CYlIm1g6h6krhd9OLzZ06qZSjN1cCmE4ubPslesHRQW8tal1/cUQ0JHlYGxGuOTmoD6KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293513; c=relaxed/simple;
	bh=h56rLLQESrP902jXQcvCJeyqu6wUr06tUtubRmHajaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8+rrOqXjsc8ythg87esTh6ijfORR1IucB5OTGLhQKiYYLv+xgsIpwAcBjJWaz4fdDGLPZtFxleR+mLXjiPk4xwBR7SFWNDpYk/qFt0Dwg8LbE4emzYxGfOaNu/kzn99iqKuMA90yhAvvelq9XPF6lu7gW5V9IiYTpLp+0v4nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NT7f51a6; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NT7f51a6"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4D90614C2DE;
	Fri, 10 May 2024 00:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715293510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNIjf1loyxb2M+I7oQGgZ75djlDTOMb7Wgh8gotWQlg=;
	b=NT7f51a669Q1xWKUlAwHqXzf10BzIc2BXVRYpVk1hkXdzOxQBXvBKTsHvE4Wf+I55J6VGg
	pGXw5F7yjyR4XPhynyWahxCgKZ6gYUBKNOVW/kHykptPCfZ2g+OZdWR018qghds+gLcJCU
	lEv1Yva9MMAip7000ZgKFnreSlpOqQE9Jk4GsVRn+t9OkFXm+EVxG49C8/n5rk5TFVmcu0
	S/mVet5t6FSGDPKwqwNDUHyO8ApM4gbpUnzFJxOKaKBruWfhj78zSysqP6J8X7bhvrEVO5
	tdopD9IGomvkKosQN10DaLNXxhqhCKZ9mFFnOXHiLbja/xiN+VAnJoOsEAKE5g==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 48128612;
	Thu, 9 May 2024 22:24:55 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Fri, 10 May 2024 07:24:32 +0900
Subject: [PATCH v4 3/3] perf parse: Allow names to start with digits
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-perf_digit-v4-3-db1553f3233b@codewreck.org>
References: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
In-Reply-To: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=h56rLLQESrP902jXQcvCJeyqu6wUr06tUtubRmHajaE=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPU02A3x5I47GCF6qJY1SarLV6TN2fNlWUVPIi
 b7JAnSBSpqJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZj1NNgAKCRCrTpvsapjm
 cDm+EACqY63dVNYYpQK7h6OGo9S1cdUVvpehtBBPLlUUriXr2zgb/UoHtKPWlHZj191S0KTi04K
 AwsLT9Esm4evNGvS41RbiodL+ROu5bHPfZ7WBN1VBVmlPwpLmCwL5oYZragfXz4FdNo4eCbkEoZ
 yQ+lSwwu2mR3zvcIs37MNpmBVAqC1XJktMhF3O84AM8+pNw1hajEBEnnImAv4YOBA54gK7JqRvu
 /mG5QO7jtQr9E85Zhx1A43OpTc4RdgMhaRULjVku8MnZ6glUWBSCIs97i2shk8AZUJXcQCnzebM
 BBZUq3i5oxNwsxvfyYth7G0d24iyITk67TOMe2aPcv8C7QuIWL5mn8CIbHHoSojDO9frhmGsOOe
 8kjrzuiU+kImxS5nGuEclylpqm399MNWbXkT5QGsr932sgbmRftDVoeV5VJCWsxHjM83hyQZ7Qo
 NkYKdVLDe/WaoUFM96W5ax/cCNVlRXO1xTAp8zVVRKAPoyUDdc+1o44tvRieea0rLAY4Vfv691i
 JrcpFWtG+dxRj1tThGA0hhvYRm/qc68R0jXDbA/k0WCXFOp4dfJdFp61hmKb5EDShDDOUcFvivr
 8kN1wVE/JXArIaP7wxIRvH68HkPtKVd/ukNMAhIb7qfSVGqOmO23DMDVE+lZ6M3S1FdDGW70eVl
 iLNFgltY2FJTC6Q==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

Tracepoints can start with digits, although we don't have many of these:

$ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
net/mac802154/trace.h
53:TRACE_EVENT(802154_drv_return_int,
...

net/ieee802154/trace.h
66:TRACE_EVENT(802154_rdev_add_virtual_intf,
...

include/trace/events/9p.h
124:TRACE_EVENT(9p_client_req,
...

Just allow names to start with digits too so e.g. perf trace -e '9p:*'
works

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c | 7 +++++++
 tools/perf/util/parse-events.l  | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index c3b77570bb57..edc2adcf1bae 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2269,6 +2269,13 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
+#ifdef HAVE_LIBTRACEEVENT
+	{
+		.name = "9p:9p_client_req",
+		.check = test__checkevent_tracepoint,
+		/* 4 */
+	},
+#endif
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 08ea2d845dc3..99d585d272e0 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -242,8 +242,8 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]{1,16}
 num_raw_hex	[a-fA-F0-9]{1,16}
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
-name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
+name_tag	[\'][a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /*

-- 
2.44.0

