Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F5D30F
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHqg13XM"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6798BE
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86766bba9fso830855276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091846; x=1697696646; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lab+IK477apFFSLjWykol92FbgsP0NP2xQdCcWnRJJc=;
        b=HHqg13XMM6x5HB+wzaqVWPqgMBahLq/RY1RmgEc2/TmpFv4ho4MxYKvra36JQDWIf0
         PsrGWjiBAuiToHNVg8at7GslsuGc9hywA1NRAZHS79TVEmrkOFYFU3/osWIkZKIDS1tb
         VUfskzb4hwHd1ULwHXp674ukE7Kg6ids2LsZZybMBe+86SiIk5CD06mb2zn1kwb7128N
         snnnO1QpY4sve61Yv6HhfLVVKykoQVXfAnDvu74tTlPeIsrU37It0HHQ2cNio8dE4LtR
         X23KzD9P3ZLNtNc79cq+Ac5ANJpjIhxggQkilLvEHXNIYGfVNPYLhZ2z3vlU9RSYnHRE
         Q+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091846; x=1697696646;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lab+IK477apFFSLjWykol92FbgsP0NP2xQdCcWnRJJc=;
        b=KDc2x3RMNd3QWlhIqza7DyC/XSfdFUrnI1FY/XfFxNmL+IBB14qDkz+GHZtlxgTj28
         vmiBZycfFnMA09dnrDYZMu8lmE/09sF1mOsHTQgjyd8c75qD4WBnOPEy+aslbzm8SzWo
         8D/X5WcsCev6p5AnKxyY1bEIG4idm+X0ylvAv/tZSDO+96pjs2fEtkvO3eWMoM/Tc/yF
         Eo3xUY0eXR9vMblCdI8rov1OxFzhaPEc1QqapuubJF3EqfsAvC3rPyftiouNDnIzEI/s
         NJMUZgW/Aixoyp/+SlXv92AaZvEkHJTmSjw2RLBPbjPqx300yXhFJ3v8nhJ0FBFC6ryR
         TCPQ==
X-Gm-Message-State: AOJu0YxNVCSN/u7I/NQrpQLUfRFMVEPwWma3PyOivFUN58TqNpq5DLro
	YG5u+GIKg6NTwKdHqk+lS2sqbBU2rS5B
X-Google-Smtp-Source: AGHT+IHnIAXcUzihWQojvyw8UJR3bPVrgp/MTrrJXWebCRY8gHHYkJpjznxCH58B5pkwT3b1yo+r8GOb/Yxd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:2fd7:0:b0:d9a:6419:f8c2 with SMTP id
 v206-20020a252fd7000000b00d9a6419f8c2mr121947ybv.2.1697091846096; Wed, 11 Oct
 2023 23:24:06 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:47 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 01/13] perf machine: Avoid out of bounds LBR memory read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Running perf top with address sanitizer and "--call-graph=lbr" fails
due to reading sample 0 when no samples exist. Add a guard to prevent
this.

Fixes: e2b23483eb1d ("perf machine: Factor out lbr_callchain_add_lbr_ip()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index addfae2f63ef..e0e2c4a943e4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2622,16 +2622,18 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		save_lbr_cursor_node(thread, cursor, i);
 	}
 
-	/* Add LBR ip from first entries.to */
-	ip = entries[0].to;
-	flags = &entries[0].flags;
-	*branch_from = entries[0].from;
-	err = add_callchain_ip(thread, cursor, parent,
-			       root_al, &cpumode, ip,
-			       true, flags, NULL,
-			       *branch_from);
-	if (err)
-		return err;
+	if (lbr_nr > 0) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				root_al, &cpumode, ip,
+				true, flags, NULL,
+				*branch_from);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.42.0.609.gbb76f46606-goog

