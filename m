Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E517A59B;
	Fri, 26 Jul 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989727; cv=none; b=QyrYA7MPN0dwBvHH2LGzTEBs3aHVxjVh0PXiZ3YpqPn///IdAl0RpHXD55gm49JFAAFQVxSOkdvnZ80p1kepBf15AZPfCPtb1fAr/wtHmQZmUERJz/hrHgevqcFfhHIgBxRlZQr+s0SzHEQUdpHYwxzYJMN4tLXea8PmTT1gEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989727; c=relaxed/simple;
	bh=Ia3MRLUWTQlrHm0z5p4CuK/VDQhtQu6Xk/f4G1FPiAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK4qtV0chGCozVcIfoKwdVeypbk3SedI+Bo0+ETgLUDTp5/MoRZ/C+VjfNcnGs2b8fjwYNrRgVVhMonZ1QyOWYKtvD1feAkLZJzHq5QZ5pjdxok6aRW9LNS6cFUoUQ4Us0idArhF5uIujRiYpsXzjOaFPE15YpaojkVFtAnHm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItL07xh+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItL07xh+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db157cb959so515570b6e.0;
        Fri, 26 Jul 2024 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989725; x=1722594525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73+g1pIsHWTk4o1x0pXyZyWF5R08Ka6OMNY6SL6d0EE=;
        b=ItL07xh+br1uDaxQ/3Ws9ZfCs3mjUCSvMA38rQr3sne/eeBw9Ay4lQ2dyDE9OkHkPb
         AU9wqCDm07cz0MOqT9eNsNhkWFCwFN+OIEW5oIcjudcImhMcSxKLjxp7oSQO7fnQIv2m
         T3bwMhV91rATZLjot4TRzQRElXoDRrI6j9mxa0q2DQ0sgoyv9q0/MIcg1eQiKmH42O6r
         +D4oKXMoZNlPtwUdEKZ9rsTFJyj6mf9LS/bInXa/MqQpwOG8TIQgi0/KEsJq2S0sS/0k
         /Wk6OvnczMDd8y8mlXcxHMLdR1UOFQoihahs0gga9HrNFkwPGRRu6OLOP6M8AOmIodw6
         +6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989725; x=1722594525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73+g1pIsHWTk4o1x0pXyZyWF5R08Ka6OMNY6SL6d0EE=;
        b=YyjHvWxnf7sOBf4VE09oiBkZdoChlwQuvgGBgpSneNG2Cu12WoE8amk/Gxfzc6S7cB
         rIwXo2q92+gbkihttxQHwEdl17x5cc1EMuWERAZ+JQtkVf9HwmBSCifWaxAGXcoXX3b1
         b8i1w39lksgvbOnZpIp5Rd6ccZWf0ctCP17Alqrb7+t2AVlh92J4B1OSV1ELRWcRlQ+0
         6hO22Z4bJHO39K28hq/+d1avoFFJaJhmkDMqTIGBe3zryc30yDU587dNw+m9Vbgnnc1P
         Mly3WFGbvmdNni5q74ptBdol6NbGgP+TPEsYoE3AGGDJmAQGEWt6XUyVlC/8jQQXPi8+
         PmGw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zQ8KKw+pVz6h6E727yEvIvgh7TAdNuKHrW6EGkY3e4yFwXuvd15AEW0l7TCkD1eQ3wiR5AKx88a2C8K1T2k5qKH4dBlh3oX1K6k74lr4EOt7zioPEFg1cofPntWtiKG4PTg2n4dSbols76akrQ==
X-Gm-Message-State: AOJu0YyIyXRkgxcBFgQkDZn8KaKW3DIbrjdxwOvt/exzajEUd858XL2J
	XlXZvUbW//MDOgr36sqC+cYQAxeA1cud5fziDpmd2ZqFAK3sD+NT
X-Google-Smtp-Source: AGHT+IGTwemDc2YGSkFCfBD/QacogrTzioFStiaPEmk2dbdM36TZrs8Ud73bvEhsJIqEssfjit7aag==
X-Received: by 2002:a05:6808:1414:b0:3d9:38c4:e9be with SMTP id 5614622812f47-3db1419db0fmr5467060b6e.44.1721989724761;
        Fri, 26 Jul 2024 03:28:44 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm2179964a12.20.2024.07.26.03.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:28:44 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: namhyung@kernel.org
Cc: irogers@google.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] perf record off-cpu: save embedded sample type
Date: Fri, 26 Jul 2024 18:28:25 +0800
Message-ID: <20240726102826.787004-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
References: <20240726102826.787004-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to save the embedded sample type for it to be consumed correctly
by perf script or perf report.

This is a bad approach because it most definitely will break some
perf.data convertor. Another approach is to add this sample_type_embed
to perf_event_attr, but changing perf api is above my pay grade, so
please give me your suggestions!

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/header.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 55e9553861d0..ccb5493dc515 100644
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
+		pr_debug("cannot read %d bytes of embedded sample type\n",
+			 PERF_ATTR_SIZE_VER0);
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

