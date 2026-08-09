Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07733ABD83
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259716; cv=none; b=AuAJxJdGo3399jd+d82rndanRgzQQnWEfxFIdKnJqnzEWZz2ikzfpGS+xUKy5B7Oc5utsLIHJRgVncv11WkndheD22pwIMBY5QLzP28POdHj56cql67zbBbUvCXutfqxu/UPHRJrQ6ra0Z1PS3LCqQCWX4/00miN+3bFjUTUGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259716; c=relaxed/simple;
	bh=hSbqHz35q+6C147pTu9indautnQ/qPqTIIFrCoeW1ck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E6L4o9IxPvsYqwVMxkkVkScxUNC4fabgxhgPBKtNsFv2AqDDBfzmbegkH8a4UPW5QXFgaou/chzU7Ko8NDnVAnyXzD/czfMvviCheNlCx35a8lxXxrZ6w7nAW3SIJ5YLPZtWQXB9xohoNlIom8LfWU1wWBOD6XdMFDERZx9MGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqteYJpR; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqteYJpR"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1619957a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259714; x=1786864514; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HY1v4AGB3dNvnh/h3lWGdNn+nY0HzdSO+OIHYU03AEY=;
        b=RqteYJpR0qbKoR/WU7VcUOFKQvX1S/LsxC3wKgONnXsEEn0LOa83+voXSofir1SBOZ
         zhgNUmGllsRYf8xyl7Jx+hqoZIyNPHg55GuS6JgGsxUdg/tjBJvijSVWeV1rDdWFx9Nh
         HY+Qk58Fl1abdy0l7CyUVYEKf+VQB9ERFvenj4OVaolDO5KPpoDfthC9e1ICV2UaHSg7
         fQadgJblZ33sSVceYr7nIkhWVNPDuSiwzM83tA1Xr/SlReLVYCn5fN6AjduGV6hHX3rj
         mI+3L116bvmJDoyNtWYPsHul8zWSgUiqNf+p6r7Ve0ojmFZNW8zHau9AM/9L7Cot7d8v
         UFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259714; x=1786864514;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HY1v4AGB3dNvnh/h3lWGdNn+nY0HzdSO+OIHYU03AEY=;
        b=Iwg0NJy+LLDgonr9cfrYN9+Of/i+WZ8XaT/RbHeS/Xudu8lZiA3ydYm2m9yPktciYf
         L8ddYyi0pcF+wxSAg5EVKXqU6wmUo0sJTBgarR4TZlE2UkYR8JSi2de26d1HY+6pS8Pm
         PaDI4yJ0IN1PgE7mk+tbw5erw41P3+UuKp1r32x15SJ1ko9SL/ntIUO7PcK0Fs5I/b5j
         OC4zAS1P1DadiY2j1vNWF0Egf1gGRAwOOmGL/3ZweuKEFcZhZYq0WFwwUARNoICBDl2b
         tXfo2BYyGMLVchz8aYhQkSNt4I/cGWAoocOnq6hvA7aj7D56/0LqOpl8vx7u26KMHnyO
         CEJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rppm/G1zokYZODsA0uuMiRMp0N6KzYFVrs2H2DRwOexSJncIQNGwD4ibmwqt5Tt2pWLqEW4zD2Lh6e+Wmmd0nyB@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwwHtNmEYmYgS7JQ/03tCyvGRCZ5hSXvJ5DamQzEw/7+BThM+
	6SPE5oxw1aJ9GZZVHqZs3avM0mZkeVqB5qAL9vBUr3js0atRS2lO64UJBE93iewciDMg3CWYX9u
	hPHMebX08ZA==
X-Received: from dys5.prod.google.com ([2002:a05:693c:8005:b0:311:54ad:bcad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a114:b0:3c4:397a:69aa
 with SMTP id adf61e73a8af0-3cb85f4e1bbmr38240149637.31.1786259713975; Sun, 09
 Aug 2026 00:15:13 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:45 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-7-irogers@google.com>
Subject: [PATCH v3 06/15] perf test: Fix skiplist leak in cmd_test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_test() where skiplist was not freed on
exit paths.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 2ae828786c65 ("perf test: Allow skipping tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 41dcfbf874f0..4d0784b16723 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -1802,9 +1802,14 @@ int cmd_test(int argc, const char **argv)
 	rlimit__bump_memlock();
 
 	suites = build_suites();
-	if (!suites)
-		return errno ? -errno : -ENOMEM;
+	if (!suites) {
+		int err = errno;
+
+		intlist__delete(skiplist);
+		return err ? -err : -ENOMEM;
+	}
 	ret = __cmd_test(suites, argc, argv, skiplist);
 	free(suites);
+	intlist__delete(skiplist);
 	return ret;
 }
-- 
2.55.0.679.g6767b8d81c-goog

