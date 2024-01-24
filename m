Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D7E57C
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070628; cv=none; b=IlfWU5PjUW59Vu1x0lV87fLKW/FeVrRC/DM4D/4vS/GeM6VMaOAuqxn3jaXwmfOM/SCGLgA+hboqMexuKVN14365GBM+GrnAV6rOI1mEL/wbNLEqygo+GLNJ840XZAx8ZDrtT+9U0hCV/tOKty1OJWraAqE4xuHDj4WkUH63RO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070628; c=relaxed/simple;
	bh=wAPN92LmutrG1J7tODQK7l+NELlZtviSaofT8hDTZX8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qqDn/i8di4BuHqO0ehuDjTBpv5RiV9hpTVEIoST6tdprjkzGPYOIf6hQn1+CssP8E1MR7GAOEWrm+sJljeLG3IX0UC7YN8IM6O3TyLj5/Jdh3g+xN6OcL9Z4sie/BqaZ/+TqffpZ/od2qRQjy11sMzRCEMaQ0E5J1s3pa3LQo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2h5VVtCi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2h5VVtCi"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fffb2798bfso47984987b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070626; x=1706675426; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4oZgP0u854CsY5ow/oTQ92HkoqG8y7HxBbY77RLxY=;
        b=2h5VVtCikY8ahjW8YJ56VzXPTIRlujumIx4cYrX7gyOhzHAEL6/IouAoZF4kSrDmc7
         NMV53qNIBrOmw+MPnnJqJHDq41hxr4RV4ut/JJPXWASFjD3rNV/DVM7QK9csL9JP/pFy
         lJI6FUYJOALsN8LIRp7kzzh4vsKm5LelvmzKMs0LL8AzeZ9XqQm5LHKm9yQ4x4FWJbp4
         KspVg83i27ebyk1Q4ssFW7FVTOFGOJYHEaPwPga8pC5snnwa6Tnmhin/G7B+QGzMcsUi
         iBizrhjsUifySqMMG8SMsFgoOpCo6TC+iZ8EeFs2w2A79t7pOkq9sahFhFgBHWaZpPPp
         GRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070626; x=1706675426;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4oZgP0u854CsY5ow/oTQ92HkoqG8y7HxBbY77RLxY=;
        b=JkCu1jqf0qbGcjAJF13NCSGHeVTOnJT0t7bwxMAKjexW/IiEiSJDaq3H4qu8f7yTkG
         yT/nJrRljhW+vpmR1xjgVOE4rmbeveQkaVOGnaAyerNyEV/tEOJqO94bUxqss3paMEaT
         5VFQVwck9dQenjz7MktfpQSwWDvNj6iWtP3FHMqLgKlpVqKDiMSRSpggGu0fpMQ+Fs5B
         B0joydqSn70NzjYU65UNpLe4CuurgN9v6zte+ldZbb9TYDfM7JA3bEaYfryLgCkFcP2s
         rC1B+0mS1ofcHyp9kwdMor8xOOc/OuRKXBm2R2OnD8dzPcn/NqNbFeKdAp90cjsPGagp
         TUQQ==
X-Gm-Message-State: AOJu0Ywd3MoOOQwOumJ/+mDKW3UJ4KzJPv099XZ2bGRJkAddDiiNZ1QX
	tIpyxefbkDSjx3FvUspDGYIHVJJB3BoIeENlcQHBbHyDDfft4/hkscpwl9CKAYeCYLgGFBug3QX
	FSbTvoQ==
X-Google-Smtp-Source: AGHT+IGz1evaAtu5wd1hbGCCuNwF5lnKKQm7avVw1zbNQRovesO9EjIJpUKhNkORobP3DGp98F/q3jJTkbX3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a81:57d8:0:b0:5ff:9315:7579 with SMTP id
 l207-20020a8157d8000000b005ff93157579mr142336ywb.6.1706070625900; Tue, 23 Jan
 2024 20:30:25 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:13 -0800
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
Message-Id: <20240124043015.1388867-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124043015.1388867-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 3/5] perf test: Workaround debug output in list test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Write the json output to a specific file to avoid debug output
breaking it.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/list.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 22b004f2b23e..8a868ae64560 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -3,17 +3,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-err=0
 
 shelldir=$(dirname "$0")
 # shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
+list_output=$(mktemp /tmp/__perf_test.list_output.json.XXXXX)
+
+cleanup() {
+  rm -f "${list_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 test_list_json() {
   echo "Json output test"
-  perf list -j | $PYTHON -m json.tool
+  perf list -j -o "${list_output}"
+  $PYTHON -m json.tool "${list_output}"
   echo "Json output test [Success]"
 }
 
 test_list_json
-exit $err
+cleanup
+exit 0
-- 
2.43.0.429.g432eaa2c6b-goog

