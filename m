Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DA1B80F;
	Sun,  7 Jul 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720375283; cv=none; b=uwkTRenOG7d36k3+OU8l9YB1/RiNveTeXIbVfeVhGuEsDSU0lfhnRedebp2aFfewQ7fZoWbc2UDng6F726QRQS602kKvdGjSpvuxNVCS1dCmHP+NyL8KKFq2NaS2ERVc9Gd2KBQFrBKhCOdxNeOMhPKPrESY94IHTAA19qtN8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720375283; c=relaxed/simple;
	bh=OpxCgfEXEorWNo4Da8hW1Cm7T3Z4snG9SnjNTGfLf4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bf/kgm7WEYpIquqH4TdbIwYawcmWZRTcxuaP6vmsSeXhYlftyiWhfPdBo/rXcYwi514Ue9QAvCc7X/csBVDdbUwPVzcUYEn9hirNmkpPp8mM0p0aiBiiJqQvQslR2cm8KXKTsdq9efC1dTjE44zVv4/gRgfsj+H5dHf3eh75/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3xnUTPp; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3xnUTPp"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so439928a12.0;
        Sun, 07 Jul 2024 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720375281; x=1720980081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93Ojm2olTWO/cVVcGJO1BWPZLGlAEblYLC3+GArrsIA=;
        b=P3xnUTPpZlUoFMPJv1txMnpqJ11FwcljRlcPZBzAtqj7d10LiIWEDDurNK98Cu8uwt
         a6r87eAjPnYsrrQAc9p5JSMNmN6GLdGafeklYKZdS3SFbkhjZ32dhMaQ7GbQxXQVGTBT
         BVc/xJRksQwP+aAJetyIe9SZYHGLD2UGgZsZouDSq6AYW9igBX0chVTw7qHRHRcKdQ6F
         3VCxLbmoZ0z+aEz73mGpFzZzk0/029e9X/BtEga/mLPhKfDJu3Dw7Nrr+E/YRA+xPyF2
         zlFYC3WQu5mxPFiq/iHs9i1/vqL9CUPJxwSslFjYQk+GFdHfVehWMVrijccjOj9SH/5C
         e97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720375281; x=1720980081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93Ojm2olTWO/cVVcGJO1BWPZLGlAEblYLC3+GArrsIA=;
        b=N0riXi2z3fb7PG87OjhniVheU0deg/UufBr6fz9VDMnfsGIaJTPFRM8vWDGyaNKuHV
         jkB/aOhvp97GzxCoRflfRBs83Cu2KbobnyRoPKtfwGlVoKqIdKVD1QWR3CCMCyzAODtq
         gPSp1ag9UWpSmPQT5Mlk1Ugomoa+4QfJ15SekGXzp7CB6e35dTm8MuHbJbUA923Lo+Ot
         3vIE/9cReRrGTufMWaOCeqwAOhe4w0Hq9DgiUC3u2RoRGYhxhcP+Q/jWI2k01MsbqDKY
         9y2qpqoxK6UZN3Ctmq/wT2ceRQSc9JTuH6I3/Fm5Y+pER8aPslP4DqooroH6KgIqp0/5
         YFog==
X-Forwarded-Encrypted: i=1; AJvYcCUQkvrpNyvcurFb3AHiJWTvhOXLM9SHZfYO5TVz5pFO5Qcj7IPjRm9Rz8c2h4vNfRiTQgWijp8W6So/N1M3Hqt/u+m01UgAhWCB+HuD/QzfHu2lyNj7qTn1dPNMhgxpFBODCEecSqcrXDIoKl6mKg==
X-Gm-Message-State: AOJu0YzQcKC9BiNUc4Jic/pp3wgEkOtUbsdjVhGVN6TbiWdKxjwS5LWF
	U4fxX3lAyzftR5dN8ptv1jZXdV19Gm3XPvmjMCpyREF7e1a6vt+u
X-Google-Smtp-Source: AGHT+IHTE23/0P0T4ySobBhOOM5/UDk/WA3TIXDz2U6mmIginobvrohUUSfRowNxuwgUW6YWmiM1Sw==
X-Received: by 2002:a17:902:d48b:b0:1f5:e635:21e9 with SMTP id d9443c01a7336-1fb33e88f87mr125721095ad.2.1720375281095;
        Sun, 07 Jul 2024 11:01:21 -0700 (PDT)
Received: from localhost.localdomain (n058152114213.netvigator.com. [58.152.114.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb8a279debsm10171115ad.19.2024.07.07.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 11:01:20 -0700 (PDT)
From: Haoze Xie <royenheart@gmail.com>
To: irogers@google.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoze Xie <royenheart@gmail.com>,
	Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH 1/1] perf record: Fix memset out-of-range error
Date: Mon,  8 Jul 2024 02:01:00 +0800
Message-Id: <11e12f171b846577cac698cd3999db3d7f6c4d03.1720372317.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720372317.git.royenheart@gmail.com>
References: <cover.1720372317.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modified the object of 'memset' from '&lost.lost' to '&lost' in
record__read_lost_samples. This allows 'memset' to access memory properly
without causing out-of-bounds problems.

The problems got from builtin-record.c are:

In file included from /usr/include/string.h:495,
                 from util/parse-events.h:13,
                 from builtin-record.c:14:
In function 'memset',
    inlined from 'record__read_lost_samples' at
    builtin-record.c:1958:6,
    inlined from '__cmd_record.constprop' at builtin-record.c:2817:2:
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:71:10: error:
'__builtin_memset' offset [17, 64] from the object at 'lost' is out
of the bounds of referenced subobject 'lost' with type
'struct perf_record_lost_samples' at offset 0 [-Werror=array-bounds]
71|return __builtin___memset_chk (__dest,__ch,__len,__bos0 (__dest));
  |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The error arised when performing a memset operation on the 'lost' variable,
the bytes of 'sizeof(lost)' exceeds that of '&lost.lost', which are 64
and 16.

Fixes: 6c1785cd75ef ("perf record: Ensure space for lost samples")
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 019305b94e5f..a94516e8c522 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1955,7 +1955,7 @@ static void record__read_lost_samples(struct record *rec)
 				}
 
 				if (count.lost) {
-					memset(&lost.lost, 0, sizeof(lost));
+					memset(&lost, 0, sizeof(lost));
 					lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
 					__record__save_lost_samples(rec, evsel, &lost.lost,
 								    x, y, count.lost, 0);
@@ -1965,7 +1965,7 @@ static void record__read_lost_samples(struct record *rec)
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
-			memset(&lost.lost, 0, sizeof(lost));
+			memset(&lost, 0, sizeof(lost));
 			lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
 			__record__save_lost_samples(rec, evsel, &lost.lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
-- 
2.25.1

