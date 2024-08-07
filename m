Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AA13D52E;
	Wed,  7 Aug 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045172; cv=none; b=aFF0ml4ZKyBcvefEbX2cT/JcEZb5/yGj0z+JOEy5jb04ZO7/Hc4ecDxmecEi15tkgwjSGHPEQ5Pk2StFn6uTF/gHmLpIQAPXTIdcwzcUpyVVYwSWykN6Bn92U+l2oBb/jUOQ6H8BSxFSQLHPN6QftoO2gXK+ysx0mokpwoXX1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045172; c=relaxed/simple;
	bh=pN4gnZ+hCxtsiADzh1TO3N3CQfV5XYtooZ0ao6aE7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOSBBd/j3BOmStrYkHi+x4iUnivc8gnksdbSqalZflPKRSkjnmo+FewHRptGsdJ7jQlDkB2QuX/oqmEXC/PFl2mIOt2IxB6QMVamu4q+fkspuryrKPdT8w3Y9aDi5qNNEG0OTFGF7EQh2tEwrJ9+8t90qxDt53yJQsqMgUahong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0cb12U/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0cb12U/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc47abc040so541235ad.0;
        Wed, 07 Aug 2024 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045171; x=1723649971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMhvpr3kLsVd+Zp0Hs2NgM4ZnpjLzgRQxx2+bJ3JpEU=;
        b=H0cb12U/gu7T/g7rD2x2NW+xgJ/TzZ/7il5U0KgRnt9aXaWiy+TCol0MWWPEnTYSax
         M0OANO6Djszq2JxN25CcREw2ZfAFReR61EIX4GAIFNyvFAQahrGzT8htPdsKL18v+dtY
         6Mv1T9M8LAfojHedlcilNfG+nKToMKDHSzJCtFtBaGCwk/QlksCMtAFj3GdcwDI5TlRh
         vDKoNE5A9jLZDeY9KEUgeBiXC2fGcWgQ5CiCXq7UUkrey8uD12iKEOaLgHt2qX4x7sTo
         xSqzndppJfHIEd7K6nla8/JhljjvSYMHMnyM6H+xLAapc6aHtRx3MH82mJ0mb/+vjlEd
         CEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045171; x=1723649971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMhvpr3kLsVd+Zp0Hs2NgM4ZnpjLzgRQxx2+bJ3JpEU=;
        b=nXzJ6+Za/POpFVwomQKGb5z7/1qE9i4dlizDnET2TBCF3WHBT+yrpq4iwSE9Wnp7Ml
         /NVOVjKOA56blmZKgeW2PU8Y2Y7k/Zps9MDeMhVsx6rPvcJrGyhKRM2zx27JU53JAOi6
         IOO5193U4G+r54zji1LhiFC/AifEwug9ai3N1Nb5ZZ1sux46e25Msnd3qBpIfDMbdc7Z
         +OeNn1P+leNTD/fyPosCiSKiMVR1DJ2ptXEgEfKWGUZVuns9voRt1alxGFKkWlNxyCrz
         sS4XCDclzYYkAD1OV1TVTqarcNpVC6dlH5SLhX8ypgNBzFwCpODkm0tZ9UTmfid1lMPl
         PndA==
X-Forwarded-Encrypted: i=1; AJvYcCVBnN2YLuYNhZzOEBiSegqm9dBuzZbPvwrKV/IJsnwClmDkR/MKrWN0cIeWqP3VB6ZgD2suf6VYiUs1g/yJg67BrNUfACfpQSaz5RzDwBZVj66lIrNHDwGza7ST+1laUJkDtYgDZGOlUayGGCV7DA==
X-Gm-Message-State: AOJu0YxTvk6xxtvg8165D8DD1tS2TUq5CPlICp0D8FfEwLH6/wkTa03W
	Gm48EETrTbPTZmlsxvXxCqnLQDLoawkXPjcVwBs1JO43E+bEoehD
X-Google-Smtp-Source: AGHT+IEEDbCElzMRusO7fp7FA+SwJos67RxC7Bn4ApHghMBa+U/Rqz3Ov6xx9I9N6d/iOATD56itpw==
X-Received: by 2002:a17:902:ea08:b0:1fd:9420:1048 with SMTP id d9443c01a7336-1ff572ecef4mr196368135ad.32.1723045170889;
        Wed, 07 Aug 2024 08:39:30 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59297329sm108097375ad.247.2024.08.07.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:39:30 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] perf header: Add field 'embed'
Date: Wed,  7 Aug 2024 23:38:42 +0800
Message-ID: <20240807153843.3231451-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807153843.3231451-1-howardchu95@gmail.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to save the embedded data's sample type for it to be consumed
correctly by perf script or perf report.

This will approach most definitely break some perf.data convertor.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/header.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 55e9553861d0..d60e77d5c25c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -80,6 +80,7 @@ const char perf_version_string[] = PERF_VERSION;
 
 struct perf_file_attr {
 	struct perf_event_attr	attr;
+	__u64 embed;
 	struct perf_file_section	ids;
 };
 
@@ -3713,6 +3714,7 @@ static int perf_session__do_write_header(struct perf_session *session,
 		}
 		f_attr = (struct perf_file_attr){
 			.attr = evsel->core.attr,
+			.embed = evsel->sample_type_embed,
 			.ids  = {
 				.offset = evsel->id_offset,
 				.size   = evsel->core.ids * sizeof(u64),
@@ -4147,6 +4149,14 @@ static int read_attr(int fd, struct perf_header *ph,
 
 		ret = readn(fd, ptr, left);
 	}
+
+	ret = readn(fd, &f_attr->embed, sizeof(f_attr->embed));
+	if (ret <= 0) {
+		pr_debug("failed to read %d bytes of embedded sample type\n",
+			 (int)sizeof(f_attr->embed));
+		return -1;
+	}
+
 	/* read perf_file_section, ids are read in caller */
 	ret = readn(fd, &f_attr->ids, sizeof(f_attr->ids));
 
@@ -4272,6 +4282,8 @@ int perf_session__read_header(struct perf_session *session, int repipe_fd)
 		tmp = lseek(fd, 0, SEEK_CUR);
 		evsel = evsel__new(&f_attr.attr);
 
+		evsel->sample_type_embed = f_attr.embed;
+
 		if (evsel == NULL)
 			goto out_delete_evlist;
 
-- 
2.45.2

