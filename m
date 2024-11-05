Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064F2161EA
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842024; cv=none; b=KW01JuSm7uLo4VLlEFJYd8NrV4nxtbxaMUD2VwtERkQWb+m0HCAYC+4Pors0ESKCa43w9PIK0d7be0SHBznDRrtOR06czJkqA4BPpZVFa2FFb7R1xXUTayJRS+TZY5xwCp0b1/RfLZFh5FzymiHx+RkaOe9K9U4rqC2du0GAnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842024; c=relaxed/simple;
	bh=0UelXkPPHtu3Lbgh81jbZ3m39fj7o+Lntdf2ZlzEBXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bblizaKU8TZ4g8tJQs69w6LY3TXPwLyqJ0UMJm+1AprF0dVVWrFuOEKPsyccHZkRN4hwkFhm4sxMqei/7zEHoEnAj2N6o18Lx2/B5dUgG7DQjd5WIsmNwDzpAg/BO4/QH+T7r0Rx1tGklCr1P3fDgnLY7TRnvU7VFR+PEAVH9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c22uhavI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c22uhavI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea33140094so113850417b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842022; x=1731446822; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=c22uhavILiY3pfg4m0SZPXY7lzvvT2OvNmlb0Ne/mRm3TkbZJPvNNZe9qcPE3eK/2G
         OMS8msNCCZdmhF9Pz7TjAr7XgbuFzR3KPhSi8jKL0VejF/EBQ1thkDcRkGlPC4e9amAf
         7plyG12Mjj+k7bl1Q3LWqcem2St1Rxk3n9Kf0pykCfduT94YAjlp8oPKA4Df5ZUEEK1f
         TIq2Fr3L/krE5ZU1e6L8PggaYBX6y1wpNrFEIapUob14Z8hjV3ypqskVNzq7POrRAOBB
         SsqyPSfRgAb1CAWfNAt0hibaqrr5YaFeD9vpBLkiyVv8xSLXm1scUG978Swy4fJfynad
         3JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842022; x=1731446822;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD1HnzB3QtGTgZf1hSToxgFVkHLaqYNzGE0Bj2UaIas=;
        b=ojLcAQrBAr8zkhjIjF5vgSdQDo8ic73X/IJ9z8aYG86mv1C8g7i6Wk2FwvpkE7IIcC
         Riq7sttNwSUs3E4EddtUyd8Jb4T8ikPjxfogRyXj9mrcwuNnldoQRk8vHGJnl+TptTtz
         UcFVBqQVfpbHVFjPqpVOwneK6J277ucBv9LxvME25rSek/VmfQr/MonZXGBNg2AJ1zyA
         lufrQ60/0BjlIcGm1M3mmlWVSs0WIWKfhVBYgDuZ0zeWPbElUmnI+/oBHD9zpgjZhYPY
         edcdY5tiuzhHznHBiNkygIhde5hqrLpjp9vWJvtn4OTsiOBWWiKIQRJ8KQIvhbTubSkh
         XV4w==
X-Forwarded-Encrypted: i=1; AJvYcCXMCTpTzM1Vq0JjqPrF5yd+30mk9Oie7ro5CZ2x96RgUEhUdpbB3o3cGhqv3x+H1y6RqBZRtBdOr+1SDB0Oe3a8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fmAm6lCeAXKNyK4T6uDYBBB/2xFDcvQfiY7DIuC5LvNKn3V3
	j1qPanBM7nUMDXHVpWiD/UzBEih/G6c9nu4YvSIVT4Qvg4i3nKbon7gCSVC7LpWvHtA9ou4v33q
	fMfXDLQ==
X-Google-Smtp-Source: AGHT+IFYSn4fm4eOVvhMAc1U4XJw6EVUkAy+GbjMDQC/ITS0oQnXnGjHmMvJHsNARXGrhxuvsS1osl2UYzCM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ff9e:ab12:75ac:c1a0])
 (user=irogers job=sendgmr) by 2002:a05:690c:628a:b0:6ea:571e:ac46 with SMTP
 id 00721157ae682-6ea571eb62fmr1160007b3.6.1730842021751; Tue, 05 Nov 2024
 13:27:01 -0800 (PST)
Date: Tue,  5 Nov 2024 13:26:47 -0800
In-Reply-To: <20241105212652.401943-1-irogers@google.com>
Message-Id: <20241105212652.401943-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105212652.401943-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v3 1/6] tool api fs: Correctly encode errno for read/write
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

