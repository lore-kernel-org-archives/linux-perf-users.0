Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7C46AF39
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060015; cv=none; b=eiR3iPSZPq7TTZTGKfzuQmT0QxRKYPMv91G7m59iodJm8emGKwWGnFpXkdlfBN1bs5A/JGyId18I897klnWXCvWFndQp98ptoa1KYpLdMGmSWGSeyZS6049DXYKfmhCPqNAuXu205VHEUrxy65Q4wmMG+V/zem5IeCi+IjbsY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060015; c=relaxed/simple;
	bh=8CeMSsp5bG8bbzyCebrPJbm+yMmmsP613Zzq5fJ4G94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iewEj0hsR6DGPaf64ZQtafQ58mcmC4ebU4eRROHjxtnBbbQUs+R6XntSqHCkKCPEO9Yfx3/A5C/RPtIBYZsZ0nqlJhwq/YzhXQZrvaHCuYcHaxwJkCxc0AuoBi+G4Fw96ESgd/midVXv0MfXui/QJ1+xm6v9/4EKfbED5SzV4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDwRXfF7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDwRXfF7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so9135475eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060013; x=1775664813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGYJCmJpaCc2bncJjH0L02E19d9BBzjQUz5zjpm1zYc=;
        b=fDwRXfF7X3h4v9c1zuOL3IwSmlNzoxUK8lTG46q/bFsHXEHR8Nm8lz+Y8Vg6dKlFad
         uHJK2+kVUSX2ODyOYX7PoU93l7j0pghavUyIkk3T7/5fdFGTXlh6TYh6cCyKzZNV3ucR
         pAz8QdmhJqRQT8tRhSVvIuNlJy+BK0NwL3CdKtgGqwCbyBSvcN5gPbdNM7eVl4tXsuPR
         pF/9K+Esmcdno2VUBvGR2LZ73/CDDMRMi8VGJ/5A53U1LgFlizvRoVFwPdt08qic6nug
         vPG06Ki9S03JYMUeRZQRGe3HHwRSSUWIKkfiVTWDmZLu3QqiE5d9k/PG7E7cflq8WlDY
         T+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060013; x=1775664813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGYJCmJpaCc2bncJjH0L02E19d9BBzjQUz5zjpm1zYc=;
        b=azl3O3EV2f4TufHt1bg8OB8GD4dHMhXdPsCQc81//vHzaRfQYfueTS8wXdHcanrejs
         pPEw53iy8r5shvhhIU61SQIB4ucYmOMktiKHSChmHgcEcX0R/k4jCMYt8ZvLSTq/nZUA
         DwTTktwSfHVen4r0NBIAJRRQRnnHbEwUxPlpm4//cLPOJ/iNIPz3oLevzfxAokTCaTGQ
         q1SUcPKrnczobLtlfphNGsnHiILbYnm2EZvDZwtnOmiak6AeOXmW8XPn3n512WxRojXi
         YwMalo10RVHl+IEj7SmhMAPZqo/r1B4086kKbtCAroQ/CPr9pVhxXQLj+b1cv9opwDgf
         SnUg==
X-Forwarded-Encrypted: i=1; AJvYcCW6zvlaSEueom5rYO9NlqTAq7hwxUpnhBx8IGoRAvuuexSlTaoVDEgB1STOW4DFJ6O2b4fT19s7+fA3eDiP9td5@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLyqsF9bXb4MXlE1EHOEvWMxDKHkFldqsVF6b3V8i6VRXuqb+
	eV4Mr134fZABT1j9/OI9JbQv1H9Wbg/e6FTLeiJlM4vFmSJdxlLOaojLWCMR84YzP/gW45tYFRh
	rVmo/NAec8g==
X-Received: from dlaf1.prod.google.com ([2002:a05:701b:2401:b0:128:f497:319c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6189:b0:128:cc34:3617
 with SMTP id a92af1059eb24-12be64ac958mr2448028c88.21.1775060013079; Wed, 01
 Apr 2026 09:13:33 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:18 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-3-irogers@google.com>
Subject: [PATCH v4 2/8] perf header: Add utility to convert feature number to
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
index 9142a8ba4019..fcd53271e189 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3770,6 +3770,13 @@ struct header_print_data {
 	bool full; /* extended list of headers */
 };
 
+const char *header_feat__name(unsigned int id)
+{
+	if (id < HEADER_LAST_FEATURE)
+		return feat_ops[id].name ?: "INVALID";
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

