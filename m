Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B242AA0
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930704; cv=none; b=MEQzONbgW3xzS+PfBj1IRMvvtAQ2brOF7sqIn3QWuK2ay7UvS7oT60t+ZESeuNQwT0Dyshbpgkc/l6tbcDEn8fVVps+h16eDwwdnuFRPG0zrWuW8ohjqOxJeIhF4aeQ7bFu8YsfuIRnSFkVJKjViEFGknJVl4ENT9hdMVNr8nuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930704; c=relaxed/simple;
	bh=cKRKDlTYzk02KIht+8zMy/vs8H/m5dVPY/usBSU0pFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cTFDoPngfbDdpM3aFQZK1cVLSwbbylghESdnvZuuLfjW42+rDYSsebw+MhmL2FXcmh6W9sn0zNMZYBi4uDqbwtPa3HrkMtEFNXGQEdo4af4wW+DKSRvwjD332K5GcedeZeylng4mugPEmaY+Tv4iItWCV3cCls7LaNxtlqgtD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cu2qJ9lt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cu2qJ9lt"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71080f4c006so215488b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722930701; x=1723535501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7gGKzt0COJ+dLcQRMsfHv/hBjxXbxW2aiYGpImKKTI=;
        b=cu2qJ9ltAHJmCbS3Lzr27LTXBkO4ENL1D8tYPbbpVDZdXu0jU9VxLkMmTK5Zavq3Xs
         /5jPtEAXX6YPLEy5Qdt7AfKab11j4+n/xe0zi3iM/Z9DLtQPYuG04/8f7w9jPqi7oJMt
         4KhxWcs890OlJw2EzDWwjWzMYrasPw+DCEqqAGx/RO2Z2VTUET70/P+S7UHrgsj3jKY8
         RMzDa1kNOC2DVUhsTr6H9ouX6KI5VsAhch8CpLTKT9TkEtfCiz4vLLCiPwR0RORbn47P
         NmizTgl6M3B8z8Q4xDSgcUxwUsTyyq53MViGmiuwMZfzQIIeWgnOpI3b5tcjTE1SDdtP
         t1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722930701; x=1723535501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7gGKzt0COJ+dLcQRMsfHv/hBjxXbxW2aiYGpImKKTI=;
        b=RKLi1w+F9tqvrPIql9mEmKblRKLhGKC6y/jttVE6oicd4kQDEFQEzM6TdXWXx4uK+m
         g87myRX+J0cOXZE+41wfen6J1AyRh6iv0jtTe3j6tpYzoM+38zAvdfKY1Rjzi4mSUv+R
         Lw5e150sYp1Vn46jiPGFHi54VUpL/8C+bU0ifQobCko76fTBvx0u7NPgA3xoYIimH0GU
         6XbrZwUOphGD+yZrFUXP6xUU9USxOmAsh7Nu8hUNKARj5N9epWRYmnLxfm6KaSd7HCBh
         IjUdJXWVq44LuCjx8Tow7RIa8A2QcmhGUyIHljO9ld0uvJxxYOsjKyWcs5x4868QOwuN
         XPoA==
X-Forwarded-Encrypted: i=1; AJvYcCXb/Eg7/3B1SHAF7pLxzIs6r1cZx/y1pVe/+Tdg/znPFucG+vV+I2bPLX2w4pEoxLKLbrmuAKMZqw2hfD+W7jOBfQLTSnvS9WVxdXxyR88A7g==
X-Gm-Message-State: AOJu0YwHfWuPrhfkXDpmwcXIZ7hGEJ6AYnRTdITU34BzkWYbhSC2m08k
	+QREnoFyi687Ys8AjQltmPrO1aV/67mtFxfnIQAIDtAvZu1MzB+GHQTebUIfx0w=
X-Google-Smtp-Source: AGHT+IEueMGyq2f0jKR2y7ycU6Aes3+5qeMAltNcBEcOXiS1TeYV7hqPoH7+09fTBnzUixVd+dg6Qw==
X-Received: by 2002:a05:6a21:6d8e:b0:1c2:8f50:b450 with SMTP id adf61e73a8af0-1c699580868mr16271434637.18.1722930701353;
        Tue, 06 Aug 2024 00:51:41 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d0126c11f9sm6162103a91.30.2024.08.06.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:51:40 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf sched timehist: Skip print non-idle task samples when only show idle events
Date: Tue,  6 Aug 2024 15:51:31 +0800
Message-Id: <20240806075131.1382728-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when only show idle events, runtime stats of non-idle tasks is not updated,
and the value is 0, there is no need to print non-idle samples.

Before:

  # perf sched timehist -I
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.763235 [0000]  migration/0[15]                     0.000      0.000      0.000
   2090450.763268 [0001]  migration/1[21]                     0.000      0.000      0.000
   2090450.763309 [0002]  migration/2[27]                     0.000      0.000      0.000
   2090450.763343 [0003]  migration/3[33]                     0.000      0.000      0.000
   2090450.763469 [0004]  migration/4[39]                     0.000      0.000      0.000
   2090450.763501 [0005]  migration/5[45]                     0.000      0.000      0.000
   2090450.763622 [0006]  migration/6[51]                     0.000      0.000      0.000
   2090450.763660 [0007]  migration/7[57]                     0.000      0.000      0.000
   2090450.763741 [0009]  migration/9[69]                     0.000      0.000      0.000
   2090450.763862 [0010]  migration/10[75]                    0.000      0.000      0.000
   2090450.763894 [0011]  migration/11[81]                    0.000      0.000      0.000
   2090450.764021 [0012]  migration/12[87]                    0.000      0.000      0.000
   2090450.764056 [0013]  migration/13[93]                    0.000      0.000      0.000
   2090450.764135 [0014]  migration/14[99]                    0.000      0.000      0.000
   2090450.764163 [0015]  migration/15[105]                   0.000      0.000      0.000
   2090450.764292 [0016]  migration/16[111]                   0.000      0.000      0.000
   2090450.764371 [0017]  migration/17[117]                   0.000      0.000      0.000
   2090450.764422 [0018]  migration/18[123]                   0.000      0.000      0.000
   2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
   2090450.764505 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
   2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
   2090450.764590 [0016]  s1-agent[7179/7162]                 0.000      0.000      0.000
   2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
   2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
   2090450.764639 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764668 [0017]  s1-agent[7180/7162]                 0.000      0.000      0.000
   2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
   2090450.764672 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
   2090450.764683 [0000]  <idle>                              0.003      0.003      0.010

After:

  # perf sched timehist -I
  Samples of sched_switch event do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
   2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
   2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
   2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
   2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
   2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
   2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
   2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
   2090450.764688 [0016]  <idle>                              0.019      0.019      0.097
   2090450.764694 [0000]  <idle>                              0.001      0.001      0.009
   2090450.764706 [0000]  <idle>                              0.001      0.001      0.010
   2090450.764725 [0002]  <idle>                              0.000      0.000      1.415
   2090450.764728 [0000]  <idle>                              0.002      0.002      0.019
   2090450.764823 [0000]  <idle>                              0.003      0.003      0.091
   2090450.764838 [0019]  <idle>                              0.000      0.000      0.154
   2090450.764865 [0002]  <idle>                              0.109      0.109      0.029
   2090450.764866 [0000]  <idle>                              0.012      0.012      0.030
   2090450.764880 [0002]  <idle>                              0.013      0.013      0.001
   2090450.764880 [0000]  <idle>                              0.002      0.002      0.011
   2090450.764896 [0000]  <idle>                              0.001      0.001      0.013
   2090450.764903 [0019]  <idle>                              0.063      0.063      0.002
   2090450.764908 [0019]  <idle>                              0.003      0.003      0.001

Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..04770c2ae008 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2729,8 +2729,14 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		}
 	}
 
-	if (!sched->summary_only)
+	/*
+	 * when only show idle events, only runtime stats of idle tasks
+	 * need to update, and can skip non-idle tasks sample.
+	 */
+	if (!sched->summary_only &&
+	    !(sched->idle_hist && thread__tid(thread) != 0)) {
 		timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
+	}
 
 out:
 	if (sched->hist_time.start == 0 && t >= ptime->start)
-- 
2.25.1

