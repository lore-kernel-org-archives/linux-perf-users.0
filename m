Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17170221FD4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043380; cv=none; b=r3t//TVI0cDrx9ofoRvqpcedIn1wCP8FW1JM2JgHSMvI+Pw1JjnNAPavK8yxOBLz6Wm2JE++QBpOfrnEvMO3oiRSU3pXxSq6uEA21NqbP+nagOSbvqkDEmEPQGJRRTRzSKgOQQTuiMC8su1mCVzGElgzEcR3UxUWeOkwPedi+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043380; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DRCJHc8aNQiSu3gMOf1e99yF5JtMwsFB6L2aZ5P5JLB34PbxqMMPEwULNGY5OT4rzVHlRR6DNnlQ6UwJ71fibDB1GnXjhZ9ly+XVoviFuvZLLFeXJmnTK/TCU1p/YlHtSQM3rjmoM1PLsDfgOXyhSL1GvfcLlBawBdYRCbYkUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xs++6KqQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xs++6KqQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so16146592c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043375; x=1776648175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=Xs++6KqQ3StK9HIy+UdVngP2dAqsCUs6fVoEadiIBiiFlT2xNRtg6aaPTIdMhpxSsy
         18PvwgorH11b8iM9PmR1WovM/J8HLz6sxpDZ4ESN+JbgO8qpgTeaPcvx6BszIQr6Xl8J
         rK5DkgDy0taFcwH0tySkqsoCFIGTW2Pfh1ohCLX6lPAU+ejkfJc7lhqkmaS2nCZPpvy6
         BoHHx6geERFEh0s8U8duLAbr+xArXdlTyUt6U1/THRzBv6KHVtqSPVQW8IwZsVbM2fs9
         X80hKvQ220erqIe0YomxHJ5VghFcinlVpAIpiU6pv64wcmioXeWCiESHdHvYpDp4kPNe
         Lg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043375; x=1776648175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=bZxnqx7SsWTzrxoBTwk1TcMZka3100jMNulHLCnM7y3tekxxuYiUOVqfPqklvDaSAO
         HTfwKgLSx+PB7sNjnDIzKpd/l90xGFB109OS71ppzARHMvmdA3J83XOwx8zu55sna8YH
         wmkw6QC9/phw/S/6Vw42pdxiNSaVMbWfZ9roeq50Hh8SffYRRyxFFAShq5jQWW12Kdqu
         YnSmzEa08lbU9UAsQ1cKtVr3ZLnSsPeuvhKsTDlWvmlojpzxEGBjus0F70YZJORGFYr2
         PjmkGcnt8GazBggHPCQQKyHrnz6NCkNylURwCdImOKlVvvxNRFjkE7ngaw0LqoELY+wN
         eM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHMUIgmtjBJUGxeVVb3FcDDa+kvC9/ElJ895GpnDKh+ucA3Up75ks6uJgpW5qqBGVHmANtyV5oC0A/OFHqzzKQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAwmcbrXWGeshMKoYwL69pe58lCJZZKvuxEd6aSPZFPEw9zML
	vwcOsQIfFwzPybt3dFg8JxaQ+w5iePjiGjQZT3wsrOB33aMoqhIS2JNVA1Uxc79q6IuU5Kg8V6C
	oy/KzxWPADg==
X-Received: from dlbvv26.prod.google.com ([2002:a05:7022:5f1a:b0:12c:1fa5:ab7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2229:b0:12a:6b99:1ad4
 with SMTP id a92af1059eb24-12c34e899d7mr5747983c88.11.1776043374997; Sun, 12
 Apr 2026 18:22:54 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:05 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-12-irogers@google.com>
Subject: [PATCH v11 11/33] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.1213.gd9a14994de-goog

