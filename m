Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB8329395
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022736; cv=none; b=XjTq7nE3qLSnjl61Ewn+GdPkEn3CMUzXJpTZD6M1JjG+OqGrvis8q5zUflbxZB6JgLqlId8PAhiKR7o8SNciQVPOmdpMZL1Qaw8R0/uoQMvy2DJgMCS/z3hxepDXAKBh1X9CA+u3c7nBtgiOCi9H1q9O+p0oI9lT7OXTjLRWOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022736; c=relaxed/simple;
	bh=ur1ihC43xddQznk7Ns8aDDmFgrqkWiVi+eSJlMQwVr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuhtvkvunkx3eXXgSu9Wbk5LEswes/girfwCwBVuPlD6efttb50CwkmsUKaBugyQcQEZBwIVSvi6DVowJU9wFQUiZiSuCNIC+WHxWdqf1WngrsoFcjLRGFkWSNh6VrNCUOkdX1RjKBV/MzDVvk95LuC1PTMmnFDE6qiO6twdOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe56PJv6; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe56PJv6"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so7996434c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022734; x=1775627534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzUE8o/xisKqOKJCzk2aXjzNBdGN2jfwbKU3R/mLXoE=;
        b=Qe56PJv6TEezovrVclkcs2pRGutqd9Uk+KIPKEvvRke1xckjAtAXbSgp4hvO27Zx+S
         Ega5ydgrrHfYkbwrJmNqX1Jh0HiNm3pNETOmbI7xj6z1arJQMuRoNLXPeN0MsVaSkR//
         VkeX07YKXg1dKvpE3YT6OIqDLkFVhg7YmiSG0JgyyRXQ2Ic+LTF3zMpblL8MhSuFzTOz
         E+FkP0Bd0YG8PlyitxObm++o4nWSVCuWIyhuJx5RLE2sx8taFKFURONNrh7Lp3Tz4WfC
         InhyVytvHK6+OaoP0VLpKzSJp5iw7rOhC+t2lEM+bDhmQ3Kn99HC6WBHpGuDymxSmaRr
         khzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022734; x=1775627534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzUE8o/xisKqOKJCzk2aXjzNBdGN2jfwbKU3R/mLXoE=;
        b=mTfwhL2D06tmOZIvouXPmNyBhWxD3Vg5LECLbps8US/TCChewLWgjxCbF46LFxkKAT
         SHO8RD8Oz7mzkUpyMohPAcbXER4pqwxbTCn55B6w/n07IINhdB6vCE6adaFjCPjziTq1
         oY7A2Rn2XxywSRJRWIDyHApE8SqTrGkhv1W4txjDr4lhFi/P83R3JB8h+s9pPg9CNVCp
         KKhnpvCggdytSBcGQ/UcoNPonAOx7TRAt0LrZ0j0idpEQZa23Ox1sP5xwaJMZ5tHrwGg
         zm1fvo8FY60G1k9ePvygqjERXgUMGR5ljWWweLaWJL2AhqnC458d2qjtgo3uOxotn13o
         Z+7g==
X-Forwarded-Encrypted: i=1; AJvYcCWh+ukYmOeXYqQralzTVu+I9yLp5ZiHjzdFlSzCXsWFRUW/WVY0oVNoFlGVht4vlvLSJI/TClhDyJ4Ouhh4ygs6@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrI1UzaaO73zbcm5PsVgpvbABhJl+q1KWXzfMbTD1hG6DVm3k
	mHhBtlfkQ7HCikQuTqNVNjZN7kwsSeeeL+A6BZ95yHWKIX/o5nUBnqF7E4xZrIjs+x3RBEMyVP3
	qSSs5gjqIVw==
X-Received: from dlbvg26.prod.google.com ([2002:a05:7022:7f1a:b0:128:ee69:eb75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:602:b0:128:ccb7:7fa3
 with SMTP id a92af1059eb24-12be6587e81mr1348386c88.34.1775022733680; Tue, 31
 Mar 2026 22:52:13 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:01 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-3-irogers@google.com>
Subject: [PATCH v3 2/7] perf header: Add utility to convert feature number to
 a string
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

For logging and debug messages it can be convenient to convert a
feature number to a name. Add header_feat__name for this and reuse the
data already within the feat_ops struct.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 +++++++
 tools/perf/util/header.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..fe5d21dde04f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3770,6 +3770,13 @@ struct header_print_data {
 	bool full; /* extended list of headers */
 };
 
+const char *header_feat__name(unsigned int id)
+{
+	if (id < HEADER_LAST_FEATURE)
+		return feat_ops[id].name;
+	return "INVALID";
+}
+
 static int perf_file_section__fprintf_info(struct perf_file_section *section,
 					   struct perf_header *ph,
 					   int feat, int fd, void *data)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index cc40ac796f52..ca22030a1434 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -132,6 +132,8 @@ struct perf_header_feature_ops {
 
 extern const char perf_version_string[];
 
+const char *header_feat__name(unsigned int id);
+
 int perf_session__read_header(struct perf_session *session);
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
-- 
2.53.0.1118.gaef5881109-goog

