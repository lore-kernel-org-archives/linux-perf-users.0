Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375B3A9871
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192947; cv=none; b=rd+lLu8aYZtR142yn+zXqxClNAQbCpQ+Dkr5gNX2tpZBJhiZV0Hm21BUG0T3Cfc7+3ae0VipuM3/Pa/aLOBqaMu0UK5+8ZNZJ+TcPImMFkrTv8o+iMHYZmBAMi4cry4G6H8WjnodyqyB8AlG56Fm1y9B/loOPt/vauzaN0CbZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192947; c=relaxed/simple;
	bh=U9k4Qm9eyK94bYQJQ9zrSic0JTOe3RhTEzD45pUrBrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNfI5zqo8SDfwtRo9IS+RWN1TN1PrFQMpFvKvrAovh7DQSkc5Sbo0YJEvjtw9ygMXyr+vTrk6cHtGyxxiXmlsOo+zHBwZ4bInPkFasAJBKGBjNnmTXj4X+4+xrxCx1tOfowByLeommONgWF+xwMon73JAbRi6A0ivN3dpCJOaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHvMjUl1; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHvMjUl1"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139af2bd2c8so2808512c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192945; x=1782797745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GGQIOfJ6x+HMiWhcnWOxqtuSfU16REz533rzX4xnxU=;
        b=WHvMjUl1tmg+MURHTr1nQ669pndYEedShqq9JJvG+yvSVXevdQtbcxobUSsZFw0E9n
         gD3axK20QMHZidUlfU6kwPXUiwF30s/gUPjOaT4lmaJxC228GeHGbIsu6eKDihpj8pUk
         modxfBnPdN5O2BcRyqD2bqKQt0QdIemALz1y8hQVLHborFdSDbwmVP3vCuyl74rbU8Gw
         9IMYnt0bK+9V+2QL0+tB0yB2p+cbTWgl7ezlXNTWxaBvGPcJyIk0zbAN/F+rfK2n44oU
         yVFuOWVhPVMxzDeGxYQllW5VhNksMtWr5LMzvVne6t88i0JpO8Oa9EVa72j5UQBBEFf1
         rRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192945; x=1782797745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GGQIOfJ6x+HMiWhcnWOxqtuSfU16REz533rzX4xnxU=;
        b=cW0w9i0LRlEysqY0O0xAsIWXrdepJZoPpHrrcVOPshodPMpiMmsPM2e7RvGJ9Thx6Z
         bjycANFbHw9MLu1tkcIXf5SH+INakrP3qVl285QI5nwkv0S4L9S1splUaNxCKneaJkJ4
         76SurR+mbxQb8AhvhhsgITr+Xisbu+I0gQAAlnbF8Pf8vXJvsvfIxb+vcj2MzGpo4WIS
         vDa2e+ELsGNlYJlVxJrlodPwDTYvQbfYzga6UYQTdM8s4rVw+yX7b9Y0kvI5tHeM7Yyc
         Xa/dSKsSv61B+JrtWURRVlSQht+9cFjvupdwJTrbOINmXsXAQXjJkRnH39bj917o+0mU
         zMdw==
X-Forwarded-Encrypted: i=1; AFNElJ8Et9YnkkvsuIqGhsrfL5pXhiAzIlYhQsIU88Rfj2YAdq7kXFOxPJT8UJpKbqeDrlKN+JONxtJ+NihrlCHMg65i@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFrOjVbpe60je4xbS5ZEHgeBAgHApM62iN+xs/aJNMzqihzFx
	gy5B1wObHLgd2GUorZ9tkvPz9GFvwDCCyc2hL/XYrtxRset0sWUqiJSaYFb2RLIuNHFwZPo9GJE
	g4MBDxMr2ig==
X-Received: from dlbek5.prod.google.com ([2002:a05:7022:c85:b0:139:c208:51f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f8e:b0:139:7375:c435
 with SMTP id a92af1059eb24-139c5dc4c3bmr972633c88.20.1782192944729; Mon, 22
 Jun 2026 22:35:44 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:09 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-8-irogers@google.com>
Subject: [PATCH v1 07/13] perf test: Fix skiplist leak in cmd_test
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_test() where skiplist was not freed on
exit paths.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 2ae828786c65 ("perf test: Allow skipping tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7e75f590f225..cf5625cf4f11 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -1781,9 +1781,12 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
-	if (!suites)
+	if (!suites) {
+		intlist__delete(skiplist);
 		return errno ? -errno : -ENOMEM;
+	}
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
+	intlist__delete(skiplist);
 	return ret;
 }
-- 
2.55.0.rc0.786.g65d90a0328-goog

