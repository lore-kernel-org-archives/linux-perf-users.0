Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7C1EABB6
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970468; cv=none; b=fvvCNPYQiatEMpEiCaZB/nzFgalTVoOdHTUZ49jOAPIMgrEqAlIDrVFjLPb6aS0JVuIv92QdOd8UHYj0YHzTg04PeGknPHH4Ma621AzkIdhJuiBQKs5K5QhpOUhoZ9DF4gY6IZWiBecmtVIEBUgTZVIHdlN9W1BfOLo3reYAxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970468; c=relaxed/simple;
	bh=VX9TWUF2qGeJZiWNv+7mi/FjvE3szYCNmmy+gilPg2g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SQu0pbkHLgCvYZ9pNBTLZjJ74EguybbrTLPgE+rUkiHW5rwE7ztTHU6FOtLwb2UtdiT6TXgwyvKSGnugzruZZr3vPRbRiJeAUoTZCsZJDVDDBNM4mgZg6YxgRuTJ6UoICvQS/dYS3INe91hxBGaUATpOjC6au/vCG+dwbPkCT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIPYB+Hp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIPYB+Hp"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e381f195051so533658276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 14:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970465; x=1732575265; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEfOo4KPSbQdX3jmc6H31yrRxVNnjZvuIGaMQg2zI=;
        b=SIPYB+HpXzKCFxvCt8vWLeDj2M33d0jQH1lbIz9v5oQX0AH6hDggi4Y2bpae0QF4/b
         fDayX+oIYE6svke4THPe7iSSbv3CzzOzu3/Oo6r7StmRkbUDQY7SXfTHIaeWDm8Ylhd1
         ceJVZVz/3VGN3XXKa6aLXlITpDVJw+zKPCUfLq3HTeaIfOw76T1J+6MPWlpfoWqOx8Td
         WuEN/9cTDK6Mcg1Fy8iehQ3X+CALfu8KjMIBwLcmoDA+giZd0QAjj9eUG3+nFwiP68Q9
         S6FhExRbEyi8dGfxVDcdRr0F/2JiOhPt6Pec4Zids4AfDMAKtWXFdQaNcSIvWB4RGyVz
         TQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970465; x=1732575265;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQtEfOo4KPSbQdX3jmc6H31yrRxVNnjZvuIGaMQg2zI=;
        b=caKpWBZ8ntJskgyWiP8vSyGtwFWm6hqA96KiqQtWRJyG+g/H9tENMPx1vZo/OXl5CC
         mtchavBnOeY6gOXupaFwTudFAbxsoWpD+UEMXVAd5Me/OpLl+AbboPDhwZo3erjJXAQZ
         A+akteBF9AiZeAJxbg3r82WOb/Dm9Mf9jn89XDZmFthRbEZHXbZmx4P+5roBpQfCP3v5
         mNKzKq9D8cyfX78sPYx/VNrx7uboJsmwDXZkrBAw0yOcBWQsFai3UW6THi+jr0i7V+uY
         qSsBK1JfCtPXoVBIh2XR5AQt5qGa/Sv83DBYBTCWLBB2MnOHDJyRkGn/tscV1VpfkcdO
         6CRw==
X-Forwarded-Encrypted: i=1; AJvYcCV89ED1ImG+02iz418quQfOHMDjtQNg+hzp3JuQ1cK7YVrppsGUB49HTcGUySe+1dxm3KIXynLwb92oJpWj3G6P@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCKdYf5d4+YqF3h6J7sjfjwy+ouxBblRpI/F7ZPs4BIQQPYe6
	NS+FIpJdMrlThakpmlexYOHyKUELWV2wDXLWFQ7ZrHhSILIoNHt8UbeiXAjnHJ6u3mLSsrTddYH
	+NhFT7A==
X-Google-Smtp-Source: AGHT+IESymJgcL0iR2MG+SNvIYAz+LsVdc118GWunXIeRiiyTRrJ3UvGAsXkTRV4gaFo6qBZ/eIAB/2/E+Pu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:c50e:0:b0:e28:eaba:356a with SMTP id
 3f1490d57ef6-e38265f8620mr96382276.9.1731970465464; Mon, 18 Nov 2024 14:54:25
 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:40 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 2/7] tool api fs: Correctly encode errno for read/write
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
2.47.0.338.g60cca15819-goog

