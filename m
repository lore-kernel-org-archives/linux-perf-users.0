Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8941BFDE5
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167834; cv=none; b=m+iP8eOFts3+17f972r0Iyt7gNb/2w+zsuvOUtIVAts6qhaLb6e91vP/9MfhgGBWzuE+6dsyDmAJfLCRuMgwf5gf000dFrp6w1K+o6UnZCnzmYl6RryafQ1WEtVzHNctGvROwrDrV/Zcv9g0+Ug2j+15GxotbCTaTq+6VDaHxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167834; c=relaxed/simple;
	bh=T4reglaGk2agCmsig/vvfDo/NC8b4AeSgIq7WlrArvk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ez7ThS+Rik5ZhDqMPIfWh04fZe5DnlhyYicb+8X0J4puozp8Q6UgmQyOjXqSSfezgmy+Q+WVztyMWuRprGzrxgAZQwXuKRqxfSUpgtcyIr9H0mc3k1cCzyCb6t1cDKdXCpMjSky/wclrq/6Eth9QhCUrX8K7Y6Eg2ZUeyf08MH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLDjdP1w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLDjdP1w"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1aa529e30eso311178276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167832; x=1726772632; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQMBpXmFrHu0lZBKkOWtMtzvpev+htAWAEEd8xjV15g=;
        b=xLDjdP1we35/IW6y1CWo00x7bSphROdFTc3OoIzsa7c/jm9umH7qQM3HO4QJ+ATgGL
         grEQNnL3JoXO3k13bHZ88pL/Z7QLupghN8OIDlNNDxpD9AUXe5il+5r7bSe1i1ncEBJd
         /YUfE7XWm0dxEdrfL385keCNsws4o3OPK6lxC6hXoMMAwqf149iy6bA9AtoKTmoC+0wY
         5U2nLccrrVjLHm1SszfeSlZBwiNDW8hY7j8LyP45/kVRnxBPtanTHTH3FG4NXyyY146/
         sReOKnriK06kWf6B2zOwj16K6scmZjjgVyGPnoREZ9s4axIQCABuYG9iEeXtl46LVqkd
         Sz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167832; x=1726772632;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQMBpXmFrHu0lZBKkOWtMtzvpev+htAWAEEd8xjV15g=;
        b=xGhv+I3eHxZc52TGweGQuMJBeDSyq+9uZ57OHa8fgzVN7Up9QxBcCBmHQ9+n1H1nnK
         uokdt19Z22RtR4aHuR2MmC1WM+skkA0SnkKixvIe+vvHpUpjrs6EVLG9UhQwd9fg1aRV
         DA+kOcO77yAlqbWWUpVwpuxIs25uU5XfZrArBp8Zy9Bw0iMQ+XMMhT+cr3phVWR5+MZu
         l5NvrGZupwWgRi4DswoIYNDmnNino+CZmeskFAfjnktcl2oLCXQnbOlWzY4mTBRlnH3W
         48Zqm2P2Emlke1O7oLNw0Q/c5u5uQGPQvstsc5uRP+2OKDwPzwNfhmHxcDAQ3uNJGipL
         3DMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHtP6Lxxy088BtRIPBlwve6A2ErRNIBMm54+QudhkLKP2id+CM3HQ5yQBB76dBuGgDNeL9YMOEpuhWPXGPXEB8@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtQrhFGy7U4/7TYR6aGN9H4FFp5oKGfI56cy2dm0NnA8F6ykO
	K5yLT9kWZqYrR+Zgw31/3Zf8sPZxksOxCwEtWZ5N7L7PYBOrdcrmLkGcLG1gqyh6gd4jkm/y/F7
	ESiF1Mg==
X-Google-Smtp-Source: AGHT+IGZL/HvVahdSTWcK3oVoLbA+pDzQ5l89m9u+mrgImC94FUUrwM2wgkmYZVeutyA7IjYNfBdE82i96qy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a25:dc4e:0:b0:e0b:a2a7:df77 with SMTP id
 3f1490d57ef6-e1daff5b91emr387276.2.1726167832049; Thu, 12 Sep 2024 12:03:52
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:28 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 01/13] perf pmu: Simplify an asprintf error message
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use ifs rather than ?: to avoid a large compound statement.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..779db2ac06f0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1466,13 +1466,12 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		if (err) {
 			char *err_str;
 
-			parse_events_error__handle(err, term->err_val,
-				asprintf(&err_str,
-				    "value too big for format (%s), maximum is %llu",
-				    format->name, (unsigned long long)max_val) < 0
-				    ? strdup("value too big for format")
-				    : err_str,
-				    NULL);
+			if (asprintf(&err_str,
+				     "value too big for format (%s), maximum is %llu",
+				     format->name, (unsigned long long)max_val) < 0) {
+				err_str = strdup("value too big for format");
+			}
+			parse_events_error__handle(err, term->err_val, err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
 		/*
-- 
2.46.0.662.g92d0881bb0-goog

