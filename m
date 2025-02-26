Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8372459D5
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566517; cv=none; b=D6f1rbcrugzrwxqfrXtKvk4pkleWaNzCHKsMnIxgTE/ucCccjCpMlFKQutrCSYM3HCFr8es0Rh5wxZ2g7gdUIFBXGyiiqT4dxHoV+zjYgeXFx0ksm4WnxE0r0rp6QCG4b29N2J7Ar2HDpwxoKixqlddMOkFJpNgj1yjWgNZzwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566517; c=relaxed/simple;
	bh=5EiFSMpBB+dPmpFSiJ5l3QtjK6IuR9uOkZs1Cfqm6ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSF2R477yRPznFFstseWlgKHVJVs2+v8hcdB4dUsIdj3Wll/WMBvfF24a2bEt4IiSSYNLuU8NWTA+GUrccL4ISBfeJp476jySkpUKoMQJzp4mC/+MuMJ153ovbLP+dChtFpl3/lPSeiNVTOtWg+07YRR2Y86mWiMM3c2zkqTsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSu4PZX5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSu4PZX5"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f378498b0so5509593f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566514; x=1741171314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnPKi8fEvcW6+/UgkZDLw5oR2nNK48/l+H7XRSgcBmA=;
        b=HSu4PZX5mBXaDI/iO3DD9eO05Y9TYCkk9SC5Q/DPcOHPTbpn636JJFUqwVBsMegTXu
         RRSnV2wo//emxyMTWQ3K+ni2F3xIymrj184OUKPVGzUR22VmWskrxH5Zi6RQ860kmhfP
         vQeLwGONDWutvsmIwQFgd9rms65z41vfcOWXhHY2pSfEhzj7MiR6Dsy0K87EwM2KEO34
         PFZ/HYrZHUdXM/1d21kiUz2NTmhxh8WoesZwctKZ57c2S0SjhDgpeLQjbfbFTi4Su4MC
         ivt3gwyIWNBapq22jax8dCuFxh6TIVtLSO76j4G6eN3bnFZWbXEVqIQgxBdY9FdOa3cK
         SKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566514; x=1741171314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnPKi8fEvcW6+/UgkZDLw5oR2nNK48/l+H7XRSgcBmA=;
        b=xEOubZaOLT2MNSmFnZxWVQw4QQjFIn9eSsgRuLhke8O8UPFaq01YCBwXvs2RRdmQl2
         4iTkKNBdsKVEbR93gH2fi46z/3pqqY7JkYuIkwyABbXXwzOYcDkzmbm/AhSS+gNe+Y6s
         jzGtU75LgMe+wnTphIbVfhmO/0eMPRxHmKb/CQNX+t7ANG9DLOBNW6wBhe9xuhPVxwkX
         AjNFzO6rQ/euk2q87aqDn7yZG5czN1MpxUqfIfqWzqwlMYFnP+3jFt1lQ1je5zWz9pVO
         j5zkTKcaHhlFJ27id/MWTOUIY+DoUNxgt6gPM4GZd1uXg9IE075gUfIS20BA6ysQOB5L
         wznw==
X-Gm-Message-State: AOJu0Yz3YmIasHy7Sf5V9XGqHBPD2/YLXpPL5/jtzTpSY9DJFcA1xVFI
	ECF4zsFr1mPUS1b8REofhUhyvUR7Z5AbTvbVauArEDN3xjsiB4sVaEioVNG1md6jrW0zvpaTw/m
	Tq2w=
X-Gm-Gg: ASbGnct0RgJZ9sywJ4p2ZdPfa5n8cHyJGAAmHfKodeYSjjwQPw1WZ47+KCDfMcbwFIj
	Hlw/QUGwEwpVxZe7Cn7gcICCSbZnM4sAw1AiIYS+w33wNwS7yQqVKwtpPyMjHb60mdLLm6HsfKp
	eiHJsZs9aazTFSO/ztMCtOHHZTKKrelv9bwdfEQ1TZDJp8jHK5Nx53iQym0VK6BVhJ6V6n+HIr7
	lpQMnMoR5BqP3jGjV0YfHxscj/b0/VZe2BxoLlRA+uO/YFX5zzt5F817CJMBgaUh2YjBN4n5aOA
	86fmxxOip8Xjo4a0rbkC12kQdaE=
X-Google-Smtp-Source: AGHT+IEOgLtlZFBNQI4Oefdb5y95WXLrPgz8hQbQNHAnUUq8U8VNjZ/k0l10FRBjyvMEjkLPnHcY7g==
X-Received: by 2002:a5d:6483:0:b0:38f:2a71:c105 with SMTP id ffacd0b85a97d-390d4f376famr1997877f8f.1.1740566514106;
        Wed, 26 Feb 2025 02:41:54 -0800 (PST)
Received: from pop-os.lan ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm5080832f8f.26.2025.02.26.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:41:53 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] perf list: Document -v option deduplication feature
Date: Wed, 26 Feb 2025 10:41:02 +0000
Message-Id: <20250226104111.564443-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226104111.564443-1-james.clark@linaro.org>
References: <20250226104111.564443-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-v disables deduplication of similarly suffixed PMUs so add it to the
help and doc strings.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 tools/perf/builtin-list.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index c3ffd93f94d7..8914f12d2b85 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -27,7 +27,7 @@ Don't print descriptions.
 
 -v::
 --long-desc::
-Print longer event descriptions.
+Print longer event descriptions and all similar PMUs with alphanumeric suffixes.
 
 --debug::
 Enable debugging output.
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c19826f218a0..fed482adb039 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_BOOLEAN('d', "desc", &default_ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
-			    "Print longer event descriptions."),
+			    "Print longer event descriptions and all similar PMUs with alphanumeric suffixes."),
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
-- 
2.34.1

