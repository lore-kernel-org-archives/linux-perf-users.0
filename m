Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA031420A3
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420966; cv=none; b=EdaEvsTjjUOD8xyeDZDuYc3ji5cEHqtklvmeVtYwUF9cGyhQe3HUEYR0uN4mdTY0xL5ZusfjCZ3pTPwIgkBp2leQwX4vhIy5zNlXdqbh7WD0Cd+TLAvUR2WX+5gOrfcC4Mi/xP4leC8TAL8AgJMBVcsc4qk0hKpA0tD0vgkDDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420966; c=relaxed/simple;
	bh=r6Q0nzWd1ZDsObAExwG1cgxL3ocuqsKb/0LPlEHr6oo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=RQXTm4HePSAM0C+8WxLh2cBYqFNlvKWuJTg7Pcr4Wt2IH4ww0CR5LhKu6klMRkvczmukey8a9/6QK6Ifc/scZE1f/JKlvpgGd2+ZgAMBxq6EEWEHrikfVIHiB9sNuO+w0uCClSfJMnD/y8sdOU1o+T0Ur5G7J5hyVwx7WyKL3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovhFGgAX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovhFGgAX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so7277958276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420963; x=1715025763; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PG3MsFbzKXuMYVhzdetV6dfQOniDDSPTL8GyKyGGWq0=;
        b=ovhFGgAX6TmrLu2MF3CS/BJ0x3w+AdBj1m/zWBec2ruFTX1dXO4KnoA+pwOzYoWhmS
         DF5YSp4VFwW/FmgBbREGuLN0fsFahJPpBINbOnFEo0AMeOt+Hpez2STWWp2lhOWNU18D
         wpjaDMvwyrgdDwbrEXMVEIFNh5fLbn7R2ZHmUIzbolPY6uYFgpfKFX9UA5rskDIoJguq
         pkKuXUQrIMR3dU3RlQ+fmj6CdHtUWOuzVx5HBV7lk6mO5A9W0xt5UqeIOhFw5YWBPjP+
         SOnhGvXxyI4dTx6q7KCmjMymXiUiObvMu+UAzUarLdnnZ7Ks1v9PktLxiwd+C9H32Eyo
         LNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420963; x=1715025763;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG3MsFbzKXuMYVhzdetV6dfQOniDDSPTL8GyKyGGWq0=;
        b=p8Gz8lJHXdFoB47oYUsBMV5i2QNsIrwEA1wpK4Z0L1puIZIvXX89rwpYefumIAp84k
         JZ4bOMIeNhq0dO22kSl7xb926Fk26+I+pfEtxQ7fuRFXoS7OOOpNZDUBp/hJ7JUQHWIn
         C2cZFOMF4Ob1H+o7L0mTJ3JTDk05NVN5m0AIApyKKv6tJhQ/VUsWZcrffox0mH6MhYOO
         hHJ2wYYrH6ohd5K48l28q7rWHL92SjcLQqQ/HLqj0p1wX2fMqZZk2LjEhNxo01wuprQz
         vkdxQf8+qu4udPHc5wh6c+1UemNdNftcZ4QCFUuquFIBeyiFGjz7p0Pnngbu+W3+8jhH
         ucrA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/z0K/9oa0/KjH1SmJy4Kr4EmkJDL8762dSjhqLnzFGDxWLCTfRYOfFxnPbsI1ctqI30WXErfrk4fTu67zI/qHPLxDtLgLDCDrblA0OBNNg==
X-Gm-Message-State: AOJu0YzN7lXAOL2P7tEktWjsjzOeWSdOjr41MvH6OtPyCuaucbnL2E5+
	5AJARv2job466KwDN3tGuc3CVtsSdem9+yF7WN8x//jQZBDVUfo7Ze1uR27IKGFcdpUu3SbpS9w
	xZEd7xg==
X-Google-Smtp-Source: AGHT+IH7v18SP6SyNvViyH58YP8Uh+9qXPeg/EpSjD89cxZN5TRvsLnjH+Am76ywHnuHqGFQl4RUJD7Y7rZS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a25:ea44:0:b0:de5:53f2:f614 with SMTP id
 o4-20020a25ea44000000b00de553f2f614mr66567ybe.12.1714420962772; Mon, 29 Apr
 2024 13:02:42 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:21 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 2/6] perf Document: Sysfs event names must be lower or
 upper case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are either lower or upper case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..e7efeab2ee83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower or upper case event names in sysfs to avoid
+		scanning the directory. It is therefore required the
+		name of the event here is either lower or upper case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.44.0.769.g3c40516874-goog

