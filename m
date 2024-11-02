Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784A15688C
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532178; cv=none; b=FrVQJQkDUqmoA5nvdGftHMENb1maAjcXBX4pt1Rttui5nn3dCQGT2naI8zPz/Hxkm2wWywzfAwIu7naZcg8uABjASDsuw3z5aUW8JADqMAYT2HagGeyyaCbTYZSoSfpMxJpimQOES684nVLjQzORFVXbrUm5xelGgwoy236kKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532178; c=relaxed/simple;
	bh=0UelXkPPHtu3Lbgh81jbZ3m39fj7o+Lntdf2ZlzEBXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bwnSgMcQsw10yssFwMaokC0zishsvz+3rzelUxZCHAwEEo0XjuQ3ZPPgkT7zKAcA9ppU0FBERKwYrS6CCb08ZU7gBEeXRMFQ9VAxYuG/StIWwXwjSG2QKg+IXUtfaNi/ITOmr4SyYZrrEB51i7yDsaCIvFfYuCdFR4YxwCRFv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPinLDdP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPinLDdP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3231725c9so53396677b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532175; x=1731136975; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=hPinLDdP/Gw4O1MYEbyW2O1A7KdPsfpNlBCP5GjUZPZxawCENADGATatJ6RpbOXoQH
         jxUqixTuXckjNQL8Kx7qH1XTRp4ou5fd+l6YOXnnGJU5yVAns1+IzP+TCt3tvwzos/M8
         HayCcQflf19bKJwNIKW/eaRenmRr56AzAGKQ/avcW5ibGCVeSyVx5nuN/72vowKRkBJh
         6a+RX85ji5PngC4+7rpJNTeUgX+ERtUyqd7A6NGEkLdT59QyU2+TA5QfHlKhNOtZ/gtA
         MUXmq1ln+1LK/bWBi9fg71QopMgjr0pwFHcF4K5apb1DC2Frx6PunSiiDNsiiNLTaAaH
         0Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532175; x=1731136975;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=iYqpvG2os6XL+dwwEhbq77zEIgotXoTcNP86b7WUOgYgmZWW1TH1Li3TZHTjcrl6vW
         mZIjdSjlcfJkhvZCxslm4UKhZjqNDkL7HEEXm8teJsvp8Fdo7RUhHO907OYhSPmsCa8r
         IT95CLq6A68kFJMuhOWDULPKqHsN2849keB+HNpqkA47P6gi6o+WbMWvDpg99zTBiJJU
         c/Oe6Rt03XNU4poajgX0A6ro3MHn5P0R2X04AijHYJ128+LGl8eb9fGpP+UA/JeB+ARR
         931o2FPIp7k/eKhbW4teUGPW7APdenOFyH+XTifJ98vmtmlBtx7e1DI0nFFqPuZazL8g
         djcg==
X-Forwarded-Encrypted: i=1; AJvYcCWWloj40eJgeeKJTSrdnv5dM6r0QjSbzEUqWQjsqCABCV9go4LI8aW9+NPTaWfhYOea9gjjXSNetCeXNU+0LfMw@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyfA6k6LVObrsAWcegXzSo2vxS6ucerADnvKCdwbSrsppQu+k
	uBuW9S5t19YphFJhHu3rKE2EHrp1DBd/Tn87VBkZy+YiuJjdWF8fe8VjFuSDYh8mnoSqqWZkM5C
	8CZeRxw==
X-Google-Smtp-Source: AGHT+IF21gMzgWnRaUKTKbXwNyiHym2o8AuHXef8LQcQlcWusd77OnFCfPRuJOYkl8uUuhlLFhhWKw08INli
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:3808:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e9d8b214c0mr15194697b3.3.1730532175462; Sat, 02 Nov 2024
 00:22:55 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:43 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 1/6] tool api fs: Correctly encode errno for read/write
 open failures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from returning -1 to -errno so that callers can determine types
of failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 337fde770e45..edec23406dbc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *value)
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = atoi(line);
@@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filename,
 	int fd = open(filename, O_RDONLY), err = -1;
 
 	if (fd < 0)
-		return -1;
+		return -errno;
 
 	if (read(fd, line, sizeof(line)) > 0) {
 		*value = strtoull(line, NULL, base);
@@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int value)
 	char buf[64];
 
 	if (fd < 0)
-		return err;
+		return -errno;
 
 	sprintf(buf, "%d", value);
 	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
-- 
2.47.0.199.ga7371fff76-goog

