Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479991A841F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123886; cv=none; b=jhC1s/HegrCn6XTIpA0uhV6b5wS8w6XmG14aJ5baDAT7AB6wTEVvy6hZ/Qj9ofaG7dz7t6IpF44uN37I/muDr3VG+IU6E03JMxLWu+Gm9pGQtagl6jK3SfnqMZh7tTlGeIzWpvePLwx6+rUGNblLbadqf+Y/Wr/z14eI0ENmhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123886; c=relaxed/simple;
	bh=9WsK29GipO9NFsc3hIC2PewS3A5xwy+nUOe36/bHbco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KliBUBPDaitaFatQAH77Ihi6lZf/bCdPrxzx8v8Y65Xdg+9r4Ph+zxtTeA7Xcujci3Gvsd8hbt5IxsyG1qcd94Ulv2e2s7THzqt/j7c269tTlN6qkH7RRNMGAtgZ3nJouoJEwXy980tuxprAaMUKFM5A0paPFWnmdCW9tHTmDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVw56T1W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVw56T1W"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef66fd6e78so26783857b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123883; x=1734728683; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmmTceEXI49vAlTZsXzZ0kDXlU3YmEJweJHtvtDSTLk=;
        b=fVw56T1Wn/gfOSCeDetmk4e6M794RU3h6CkdCEk7SKpqbgtdChuB2kX7kwrwz58hlg
         NzAkhu/v4G96mrxYwcMMgSBeW05ZY5neAnmIZhDfyshBywal8jcbz18eGy2xT1q6VbYK
         SY0w9Nf6g6l4hvQGqv8QWmP0Pt2dWPBlUr+dfM41LJ1aGOUH6x4rnDQxHYwax8KPgi6t
         5JQ7bNYd1+JwF4O6HpbAxSzszpK/P/L8eDpvit2n9+ggh230OgR4ZvBQMX8UwKywLbPH
         E5YmxEc5w9HxE34WxeyRTW5rIXm3YlLrCErRc5Cj/KBs2l3ReMTzbiuP8hn8tuGnaGKg
         9ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123883; x=1734728683;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmmTceEXI49vAlTZsXzZ0kDXlU3YmEJweJHtvtDSTLk=;
        b=XTWqzWoR5D4NIwuunxF8bzkEj8Ly35euDG8/h2sCKrwvr8MQAboAOQYtx1Jk/MRfgY
         H1QPKSTuOoViRxtQR1JP5p8bcizq/a0qKummtoOGDtHFkfSZOeqkvc/YYL3cxXUqi46f
         xfJ2IQFVFA4LJegoKl3Da8K+DmbTCmA4NItNXbQr7dQo6jnhEo0Eq8Gr4OWvex/mgld4
         rt6Z6BnLMRXe4voa0lGnVxBc7jS3x19BLjpLlMDIzNzt8rED6GsBFs4tXHALVI3E4B6J
         AfTD4d8dgbkh+QN8bZCNIEcbVbDqpbbNg4MMCHCzYiOxD4cNHTfLE6MgZsiX+Kb4AgF5
         NQQw==
X-Forwarded-Encrypted: i=1; AJvYcCVM87avjUzcY+t6gBoscNQiUYsLo6Hz0IgRrSIoDAMPGdLci+qwYdlNbVa/BG7H/JU7RUt/tTtoT6OUGqnLJEXj@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSPTnKN0hjlbDbCBeRHeWJ29M6ND9WttRbf8hEmD+U3wIYTIe
	cIec2YuVIZFDDtCKTLwlQLOMREwL+UPXrwKUjF5O6dyN2fbylX1NJia9Ml+Kl7yTWAG3wieUD8v
	s47Uv/g==
X-Google-Smtp-Source: AGHT+IHpiKviovMECOth7u4kOhfEglD8RAZ2s+tFKqdgpPkBwtpkcy8GbhxAXictuSVtrav/UTjOTS2cR59l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:26ca:b0:6ee:61ea:a40e with SMTP
 id 00721157ae682-6f275c1849amr58497b3.2.1734123883146; Fri, 13 Dec 2024
 13:04:43 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:22 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 5/8] tools headers: Add non-NULL assert to container_of
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

container_of on a NULL may yield a non-NULL, confusion and errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 10f74f021d55..8d617467c5c5 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -38,6 +38,7 @@
 	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
+	assert(ptr != NULL);						\
 	((type *)(__mptr - offsetof(type, member))); })
 #endif
 
-- 
2.47.1.613.gc27f4b7a9f-goog

