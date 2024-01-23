Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C181474A7
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968383; cv=none; b=mt8OMS4qssyLeVe6q9nQue70WlHb6NwwU0565vKaoRC7YQfXOPC1oDZuM/rtn4PALbzfwJm43ZqGtSA8Mj8IjsA9nyQoK9F12gKvxVAER8Jn7gWiWvc2XMEjIKkOD396HlZP7EhhUPtTbHbMogM4+3g7rQe1QeYrvi5bpqgetmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968383; c=relaxed/simple;
	bh=IEvafp8noNqOSfOmOKDMTOQOH5/R9XopGqVio4nEPyc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZfiY1Rupx6uuqsUdpxS5P5H2V7YJ2ROvv+XT9uBz/ti66RJthhKX8mzdDKz1+DAY7I8bcn2RIGx4/zOC+SoUfndIs8i+MI1aZNKbiy15NtrqAfgwN5KmeHpjuyqxlLlVW4G3sAj2ks1z4/GHHuzoq/YlaPBv4JHZMznHMgp+tWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmr27no4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmr27no4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc265e7a67cso4125808276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968381; x=1706573181; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q79azOTXwSlimUfkUpJ2p/ZsQdIQmqJ7jFQrY/iqycY=;
        b=gmr27no4HkxKA6Oy5axRfTVGcB5pDb4hJOHV1Xf8ZPXxlh2gEmoozDSJo40O/9tzpd
         vg6ds6KjHZoVDxQgDs5sPUJnx5rWUxP11jck4JG9De9atfJo/8I+dX1InkRiVqFwFrzB
         Bk+Fr0hm8AqexjBS8lXDvtn0v6tz5GnMWXcpd+COIv4+ySgMTOlq/7ElmVK/aiy19LgO
         AxICSAwWVE/CycYPutxKp+p0gqhcIbNe4n8hWTW7Lr2+ikVoUd/ISM71i/gggjricoBB
         spbs6sP62Quo5WdTumzJe6n9TbKrmYBbW9hGTgWZlLWk0uMuz4sn2FJoh+DvKiCR20DC
         2sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968381; x=1706573181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q79azOTXwSlimUfkUpJ2p/ZsQdIQmqJ7jFQrY/iqycY=;
        b=MtgaKhU/iK3UyoXARmN/LWq6eIB/dip6MiwWzo3VGjNAw7PowvcCa9I8k0zBYAcX/H
         +rGWwON23p7iOnhJ0Aj+j55SOelMByt2iT8cI84ESmkL8ozHNOnj2QxxhD/9Cq11YwnA
         v3qQn7OKZIEmViSkUiSqOd4URianCcfyBItpWGfWn+bG+dCIOxtcbJHtao8J6thAsiDZ
         tI+1UP9IupwleUcadSXUq5E0nbzONHitjj7wlwT7YLuDZ7KSr/qM0jX696aHeW/4jfvH
         0VcDu+lcfCphIUzedOXZNGFrScnDREJ+KRMwtYF+fXNwTt1JebwD7D997zY4aw+pPDzo
         6OZg==
X-Gm-Message-State: AOJu0Yy8pCftvedah85rFGSk4Wd50O+DKl8KtgHRN4qZguJoDJRUtn4Y
	lWt1WSJ2TNZlEAaqQiXQmBYszYdg1KpysrIjGBk2t3HPgJTz8kQriu1EOBEz2J3/F89X3M9e5pP
	6eehDwA==
X-Google-Smtp-Source: AGHT+IE//rM3tBa89THOE9itYLd9DpILsWAlR+A+hD2lh5TpNO7nBlKg5HNk8uzlJAmXvKyC9a3AmpIdfUGW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a05:6902:352:b0:dc3:696e:ffae with SMTP id
 e18-20020a056902035200b00dc3696effaemr438504ybs.3.1705968380873; Mon, 22 Jan
 2024 16:06:20 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:03 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 4/5] perf test: Fix script test for python being disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"grep -cv" can exit with an error code that causes the "set -e" to
abort the script. Switch to using the grep exit code in the if
condition to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 5ae7bd0031a8..b43077dbaf98 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -36,8 +36,7 @@ test_db()
 	echo "DB test"
 
 	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
+        if perf version --build-options | grep python | grep -q OFF ; then
 		echo "SKIP: python scripting is not supported"
 		err=2
 		return
-- 
2.43.0.429.g432eaa2c6b-goog

