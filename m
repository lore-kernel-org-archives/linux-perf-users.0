Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F181194A6C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123879; cv=none; b=JLugtJIvrUYJVRx51D/Bn3IlES3kR8z1AidCn5HQOd8v9Eqd2F6Fjt+x2j9vA2OR4PNuk5yWy7fZ+BsiyuEcemGn6BcnbyQaTaUa6n9g3xskcKqvfXStf+ouWoyP7vErhrjl2EjEaXh34ZpDKbqIdpFMvwbCuXUT2fKe4FXeUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123879; c=relaxed/simple;
	bh=4pKzkTV7w7BbOGxOqcD1NuW63SK6U/7k+L92iQDdz8k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UoYbLvfj3b+2eLG8BcypHMDDm7Q6CbAX/QAi1OluVTnVpu0k+E3Sjqr3D02+HrHrk+mT8Vh/f8Q/Tu+ziGZkl6pNumMzZ7GK/WTg8cAZBVbeP5aZ8NfAAlmmTQXcX68EU81W8iOFZ/USFp1jTi/zQKRH4uDVKFRQL3zJAjrwuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQu0MsXu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQu0MsXu"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3c7dc4bd41so3209227276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123876; x=1734728676; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vioVLOwmrwPBoDuHBo/JSaFU3XJwmvCOkzBZLpYE96Q=;
        b=yQu0MsXuMk7sRRsTYFtqEO+sATyce382HPFl86s837Dq2rvhpaBSqjExIiEIzo2Efh
         2OpJP65Z0u963yd3ZSTCLgUT0s5iOek26u7EhFwDJ9JgnzYRtvk3Lg+vREDKwcGUvkkM
         DN1UGnl7rHA06II6CbxFy4t+o4D60RBmcLZpUTBM539E/+3V3kq54B633bBjSReG+P4p
         uXMmicUgmCdaKQJ7mIRyLiQSWjSl8LrRBoa3qs2Xizz13iFUKojDx+5bFvrEVESVegMy
         xicltQjMLPAGQYY+wXXhSEthWwwhYYit2fpUQr1mspA0dNjQJvNOJjWecOjJaNXpoLMA
         lbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123876; x=1734728676;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vioVLOwmrwPBoDuHBo/JSaFU3XJwmvCOkzBZLpYE96Q=;
        b=d2/r7F4nd4mTUcolXxnDHj2ZE4cY9DP3uhq2DGm5Y11RH+u1b7UmkQPcZC/0/HbyG0
         WVLITp/F4Gawz74hxsQP5eFJWLXXPUDICwpGMH1vnsmJuJg3eb4PWEvetGkMG9eLBs/N
         tZ/gONq1X51KRTIKiy+JJYYk+QW64P8hc+PyWJoHoMUSaJHwkqtDeOzJm3I1HAr3a2JC
         Z5ilF7xJ4mC9PUdm2MqIcuyY7J/LfYVFE2AqdSrPIA8UbPKbNBwnBxT398jwGXXZUkHa
         Bs+AcOIUdkKn8C+eD1ey4DhMlMfzMp98Dm+cc+QlGaeX2GEZT/UM+WAPbxfdbDG13ceh
         RUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiunE2bMEq8LoLDk7dSJaJIcUHAVrE+c/g+2FbAMMQ5G8kUsbimA+sQFqzeFLkiIlwS7+tDKprsOOJk+ZxwBuv@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnmelb45Ny02IFu7WdelsO98UzDobYVRxVPqsWtSLY0cFMEFq
	NwLyt06U+fFB7lR2SGy2yt33vwOCfcp/JB+mG19bmitW5jB8dr2XI6w8WpyOrdUdRp04cgHYjeA
	GUhwgNQ==
X-Google-Smtp-Source: AGHT+IFJoR+VUIap2R8w7wBB5lIJC6iiEWzTJTmaxzdCenTqSqXLAehauJytbWIoze/wqOYJJA/lOzwErMku
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:a34a:0:b0:e39:8650:5cff with SMTP id
 3f1490d57ef6-e434a06de27mr1841276.4.1734123876288; Fri, 13 Dec 2024 13:04:36
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:19 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 2/8] perf test trace_btf_enum: Skip if permissions are insufficient
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Modify test behavior to skip if BPF calls fail with "Operation not
permitted".

Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 5a3b8a5a9b5c..737da3113966 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -23,6 +23,14 @@ check_vmlinux() {
   fi
 }
 
+check_permissions() {
+  if perf trace -e $syscall $TESTPROG 2>&1 | grep -q "Operation not permitted"
+  then
+    echo "trace+enum test [Skipped permissions]"
+    err=2
+  fi
+}
+
 trace_landlock() {
   echo "Tracing syscall ${syscall}"
 
@@ -50,6 +58,9 @@ trace_non_syscall() {
 }
 
 check_vmlinux
+if [ $err = 0 ]; then
+  check_permissions
+fi
 
 if [ $err = 0 ]; then
   trace_landlock
-- 
2.47.1.613.gc27f4b7a9f-goog

