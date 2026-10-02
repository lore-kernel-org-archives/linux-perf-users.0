Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043044E055
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965603; cv=none; b=TE9ZA6WrqsXl4F1Mxed9loUp0H8qTBRzjUcr/0mysVeZZOScdOk7LTsqe5A5FnGyLENMXClKz81yNG5WL4zV+a3NtSx8FRSAeL2ONuHdZ7L21K9t99BrWwc2PvKEDpU6CcdP5SizczOzGoyHPAW3arvbaeXgS8Lrz+kftqUkB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965603; c=relaxed/simple;
	bh=OM46CAJaPz4QYEd8sDanlXYv8xwY3Glth8bKP5V2FjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p1IPVRdbANzLuybdgX+ms4mZLJTnbtaexIGNuRuIImdrVwemxTj3H1xvMqc5YMvipoxKtmXrbnClNB7m/yd3Fq/DGo2XINfmvVjc1nc1n6b4PdyhGpyjdkC8Cv4eGR/6rBHRedCg/sE3+CcQmkeJ2O1GiRty5l4SicgN+DkdrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbU63/K5; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbU63/K5"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso2939267eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965601; x=1791570401; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBeh34sZOWhKN5OeKCeSIDvs4CKilup494f+n9rG9v0=;
        b=bbU63/K5rBBQoTlBLstqm4u7J4hHXVnsd+bjfYqnCuQ/TXQwU25VKcvInEr3MYy5wb
         vslWaXj/uK+83Vgo0oaaHCfNCWpyiAmrjfta4GiCu4IYsQ7GeA2824YsRDd2WfH4JPhE
         +TlLZ+MAkjUSK9OhEBUwpD7OYGBujLW9FPKDmooXsZJmyzyILh+oCg6C2KCIPxi7jLNp
         jKBShg2EGmqeS6LCA2Rgjf3GT9f5HMVXQlRwQIM/+WYO426nLnPikGEuq69U1JH76m9n
         j5VMpu8UUBfS5fZ51kiZz+btIHmMugxJY+75stUUt6XPCmO4Ug3zuaqAauxeybv8k+JT
         pIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965601; x=1791570401;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBeh34sZOWhKN5OeKCeSIDvs4CKilup494f+n9rG9v0=;
        b=UfKFy+NaU3YbWBGY8tOmyGbnQNxzqLTsvBhVFhVT4dXtXFEFdj3VblgatNii+EYKdg
         paFPV4T6vmnstjBNTC32CRbtuB6q72Bm+Onte5o+FeOUgP6Xjf5O5i3DaP6VUZZBlH7A
         k1/td7jm5uCHceuf4Cl5IwWwSc56tdapQ4tY5YuWx0m0n5edYN+fzPSx0eP3VcacmrtU
         K0QjIQg6XPYWlJbBTfeG0zWlhklsxoiCMQbD4GVxlpW/IKqTjuQ5HakEiX8FUkYURsPG
         3Hg1mY77qxmK5pIq7x8vtP0vX2U8Cb4kEn/b0/YnyNhXNaPDLxec30LiNqmRyk9dbnKv
         +cqA==
X-Forwarded-Encrypted: i=1; AKwUvBwAYNwmZZ4cC/3vdxhuGOslCFdM1/jZ48IPa/p/LW9H5XiXUJ46zt72Of4FL+jn3ecQUKq4mx+TbwSdZUofsD45@vger.kernel.org
X-Gm-Message-State: AFuF++lXkatoZw8PPHLCHfRgMbVqzFOjxm3pKLQC9dil8eGt5NC/MBHL
	glgE5nQu6RHIcaCU6U0sQsGePd3tZH4fWrWFvsMeCwnvqIOTrEehngXr259zPCN4tfAlL2dW+00
	U7lS6xCChfg==
X-Received: from dlbsw13.prod.google.com ([2002:a05:7022:3a8d:b0:14f:62f7:d5cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2816:b0:14a:6a66:f6e3
 with SMTP id a92af1059eb24-14dd1969ba7mr6241334c88.20.1790965600160; Fri, 02
 Oct 2026 11:26:40 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:10 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-2-irogers@google.com>
Subject: [PATCH v1 01/13] perf session: Don't flush remaining events once
 processing is done
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When session_done() is set, for example by SIGINT or by a python
callback requesting processing stop, the reader loops stop but the
deferred samples and auxtrace data are still flushed afterwards. For
large traces decoding and delivering the remaining auxtrace data can be
slow, and the events are delivered to tools that asked to stop.

Discard the remaining deferred samples, and skip
auxtrace__flush_events(), when session_done() is set. The
ordered_events flush already honors session_done().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/auxtrace.c | 7 +++++++
 tools/perf/util/session.c  | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ed2113190785..f30f86156a3a 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2978,6 +2978,13 @@ int auxtrace__flush_events(struct perf_session *session, const struct perf_tool
 	if (!session->auxtrace)
 		return 0;
 
+	/*
+	 * Processing was stopped early, e.g. by SIGINT, so don't decode and
+	 * deliver the remaining trace data which can be slow.
+	 */
+	if (session_done())
+		return 0;
+
 	return session->auxtrace->flush_events(session, tool);
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7fea9e72726c..74b0fc0514d3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2018,6 +2018,14 @@ static int session__flush_deferred_samples(struct perf_session *session,
 		struct perf_sample sample;
 		struct evsel *new_evsel;
 
+		if (session_done()) {
+			/* Processing was stopped early, discard the sample. */
+			list_del(&de->list);
+			free(de->event);
+			free(de);
+			continue;
+		}
+
 		perf_sample__init(&sample, /*all=*/false);
 		ret = evlist__parse_sample(evlist, de->event, &sample);
 		if (ret < 0) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

