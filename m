Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2A386571
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620034; cv=none; b=U0/ia6aZLeQo6ze0EsZAeu4BkW7ZkmvpABh19DGpFlnC/A7vU+fZowsnfLBkryCw1sE9syEB9le6i5Ta91OWitlJIrn5knKobpL2WC4gi4BvoGM4KuAuvsj5v9pxj3ImHeA09MsSWquiZf50gSoGK0Duyj9QGMEGbfl7SgCUGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620034; c=relaxed/simple;
	bh=PI/j/yj9qHF2Z+Ytn13c7SIHR6WctmiBbL2upSsY/xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fa8T9zrRBA1Dk6sEIOcMDeRNfQMb8P3/SnwrdEt/I42+hGRm59dEwKH56T8U9c6o4FV2utUuCgZ0I3evELdB9gaA8BwkW4kPl80RjdyIUeb9AzSDEmZ4leZiWhHBhp1K+a/PUGXlItdTo8W1rZgy1M2vuyGWWaMgKdxq4yO7EOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM4jGmid; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM4jGmid"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so6345931eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620031; x=1791224831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctpKLdPcvE2rYSGOL9e2LFMyTzgCZSjxqpbnDuaYYEk=;
        b=rM4jGmidQWPfQa/q/lixFfOC1Ky38qPT+z2BZbDL7rHm7f7OZrzN3ZisPt7qujheQP
         QpHpUCEY1fx/xbnHl02JdcRC7Zhv/UBiWACVRReXS9kFBxHxhucWVrFSm7gHEVsGX6/7
         ruo+2B9hIZWPeOIvYjAg0PboYS05ypMsfIJ+bTy3IqmM0Ufiyzimw5F/iqYnZJQfnyQJ
         fT4ORvKAX+OZ7wcy/zSdeuNqAzHmK7iU6X8lBZYaxwhTot/UhAZOLjHfAjLJHP2tdn9S
         l3V20ufjBg0HMvUZtHkBpQNNDY9TKLL3BFN9fx/QQgLqyaR+waQ0rNM0UZwDkVwnz1pD
         t3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620031; x=1791224831;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ctpKLdPcvE2rYSGOL9e2LFMyTzgCZSjxqpbnDuaYYEk=;
        b=Fv7xHqhnX3xrR3Ls0zkgo9oTKD6d563UWta30+lxTsKvCFFaN4falrrXAmCEINz0Z/
         bYdfzwpQpE5ygkPviYKeO+ZeLdkwGpOtUGQgzXGo2WJMM/lw4DdrBWQxCkTvHj4EyCsq
         GW2hC8SigPkTlHM+GFSwDKIPZS2/RYm6YYGo6QsfDKeUSLs97akFCzz1B+kmk6bkrYnm
         96qYrvkVaKwlh4GnmkhIOXWbIrAgmawyvAbGaYzPQN3EtFhPXM17ZrljfGIcQJRFPLnj
         Tj4qX19WRg89mNG4UnonRR5dInCTedPntOLZ2vV74a3IARGfWuPKJ8uBzKjMYvHdxTJb
         YXhw==
X-Forwarded-Encrypted: i=1; AKwUvBwt8HFTl5D60gz/i+8ivRXMsAKRd2ACHOZ582U4HEAIpd4uc3mCii052T5jv8FoJ1TlhjYGE7BE6bscdn9ZMDiI@vger.kernel.org
X-Gm-Message-State: AFuF++nkkr621l+LqTot5969eNo3ztqpxctC5cvEqAAUJ/jx/rqRKZIh
	UczeXGz5wWVIJ1q5ppBlJzZ6hOWOkGFupaq0VzYyXXxqdYLgVaKCzKC1suo1KPPgKsmFe1ztJ73
	Gi4u0dJXOtA==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:144:c32a:6a84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2906:b0:144:eaa7:2917
 with SMTP id a92af1059eb24-146ce67f240mr8997537c88.10.1790620030109; Mon, 28
 Sep 2026 11:27:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:26:05 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-27-irogers@google.com>
Subject: [PATCH v6 26/26] perf test uprobe_from_different_cu: Scope probe name
 to PID
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf probe names the event after the function and binary, so concurrent
runs, as with 'perf test -r3', all add probe_testfile:foo and all but one
fail with 'event "foo" already exists'. Name the event foo_$$.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 83505093257d..33bf36c4037e 100755
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -17,12 +17,15 @@ fi
 
 temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
 
+# Scope to the pid, otherwise every run adds the same probe_testfile:foo.
+probe_name="foo_$$"
+
 cleanup()
 {
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo || true
+		perf probe -x ${temp_dir}/testfile -d ${probe_name} || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
@@ -83,6 +86,6 @@ gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
 gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
 
 perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
-perf probe -x ${temp_dir}/testfile foo
+perf probe -x ${temp_dir}/testfile ${probe_name}=foo
 
 cleanup
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

