Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022C1854
	for <linux-perf-users@vger.kernel.org>; Sun, 21 Jul 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721532003; cv=none; b=Y1UwBu3TiVLuWCMzcNMMME2AlTCMIdpp9B9JXuqgEAVQ0eTP1tDFCoeeYUGvS1CLxtmOdIkuPrQbRYflnfwHhSybKj+tmXhNTPRilNZeP3FTxwvCuBal5UZRS+HyXgxFRv70Ue7DEnT+8jmZH1Rg9HEcF5f6wWnvf1T7ERNZ0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721532003; c=relaxed/simple;
	bh=fmiWUtLoLSg0oXD5COw+p1HKt/OkeyiZZryCTS1y0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xsrx65IS2NFuhwXP2D6tKWRxHjVy/5jv9eOkEABPgA4O6SvljZo/wK97qJ2rwAB21w1eoLBmaBwhwTV04RFFF5BdWQcNzTwIigNV/E6KQT7ufwy6zlA1QbEcg4OuKjAjcChku139OYFdze3zWFIg47JSLg1u0z+2/tdCti/jDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aeEZ4zCG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aeEZ4zCG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so47631181fa.3
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 20:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721531998; x=1722136798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8IKB8sxXNF6g036oVsRu5aXttvdlBEUNATyMc+zuAo=;
        b=aeEZ4zCGiCQRNEW4CjpvouznLlbEFeCbnqpIuDuHPjSDG8E5V3UYOvJzScYXVzW9Rz
         Pk16t/KpPBHnGh7Tfn1Krx5ywPFCNqkAMKiiTtBuZa11vQ/LDLGoD2VcVABC4B2MmNwb
         ir+Cqx6ykHtStIFyToQYoFBV9kdqrmnv18wPJA4uWcCfZh5XzN9XIUmVHnB3nP3doKuU
         JoKqLzl2Tuc22F1t+Tf3DA257sJLGRa6X+5sPTb/RbpOjGJqBuLtIfm/Ax8yHz/yZHzc
         VIbCtjYHY8QCu7LGMZozWnf9xPYGGTZFv7RAb46BqTTAjFDYAkrKBYS316vl+ZiTiN5J
         y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721531998; x=1722136798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8IKB8sxXNF6g036oVsRu5aXttvdlBEUNATyMc+zuAo=;
        b=Cr7ZHxg6OeogIG/YHzTTS1aho6JJV88mgkC7Bj1nWoaQMb7W88ONylDsG4m1RPJT3u
         E0kZVZTts/vED9Japa+BQXYJ3cLwV1jomUrGOQgv+jMvdc76ggSD1nw7k+ZKAZ5T5+vw
         L++d634ScXdOUFFTulV8z3E77SL6rzEVs6fTCG73vWQf92kUbhl1h+dUKrDbTfZJ7vgj
         GGDFJJtMqKYnHiykUfNbQthqiVBK2xu3KHGtp2451o8l8BdHLLpY8A9LBf0W6WPml2Qq
         DEqpvosM4S/lUhVwzb8tEzalDXXWmPlkeKVVZs0H54gXCCbCcoPCPVQGpUTCoXbGl64w
         eNjw==
X-Gm-Message-State: AOJu0Yx0S/u4GY47/Yn21OfMVn7hJDiLL1tqtufgE05dys+1Kxb2guvE
	gqNNWGlnrADzJm/Oyz5ksQrUa5hFUKI8iM3K7OK0+zFRfUvyvr+z66nZ++lT2z5LjDZI+pkkOhZ
	2UY4w0a0X3PzzMxTk0okFQjYzeX9XT7bpxKAKMQ/Ea9fsxmomD+nk6jJIGh/sGVwpDvPLkjfa1+
	/k4de1cPmhpj/CyR3Ry8CQqPq6cfWU9d8saC4foK3AMgQAphyqKQn0MXQ=
X-Google-Smtp-Source: AGHT+IHc3wmiD+skdiqMr6Cm3540sI2oYmkEJicmVSbBLP9S8TwTr0ZZN+fR3kg9LhTJsHSXug7lGA==
X-Received: by 2002:a2e:97da:0:b0:2ee:8817:422d with SMTP id 38308e7fff4ca-2ef16789b22mr31000521fa.5.1721531998401;
        Sat, 20 Jul 2024 20:19:58 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7a3c7bdac0sm235270666b.60.2024.07.20.20.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 20:19:57 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv3] perf tool: fix dereferencing NULL al->maps
Date: Sat, 20 Jul 2024 21:19:44 -0600
Message-ID: <20240721031944.62913-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
thread__find_map() could return with al->maps being NULL.

The path below could add a callchain_cursor_node with NULL ms.maps.

add_callchain_ip()
  thread__find_symbol(.., &al)
    thread__find_map(.., &al)   // al->maps becomes NULL
  ms.maps = maps__get(al.maps)
  callchain_cursor_append(..., &ms, ...)
    node->ms.maps = maps__get(ms->maps)

Then the path below would dereference NULL maps and get segfault.

fill_callchain_info()
  maps__machine(node->ms.maps);

Fix it by checking if maps is NULL in maps__machine().
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 432399cbe5dd..d243cb794a99 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -169,7 +169,7 @@ static void maps__set_maps_by_name_sorted(struct maps *maps, bool value)
 
 struct machine *maps__machine(const struct maps *maps)
 {
-	return RC_CHK_ACCESS(maps)->machine;
+	return maps ? RC_CHK_ACCESS(maps)->machine : NULL;
 }
 
 unsigned int maps__nr_maps(const struct maps *maps)
-- 
2.45.2

