Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dnI29a9X"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF36B9
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 05:57:42 -0800 (PST)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 34F1140332
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701352659;
	bh=JiMwEX70Mmq7JJA6SKHo9LkE/wA3v6qQVTVhutP/NRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=dnI29a9Xjl0OVyksLUCM+pmYN/rZwEbK+3NDDNQ3upI9Kk8ltHmywKjLo6WKO6y7k
	 ZAUD5X7zWOMFQbZDsgKdSLCmelR8qDlbIuz5t85fICSP8XqHr3XyC9qCgz2w8xnf9y
	 sYSLwusm5WAEWDRL7l5X8yCe+CIMO4/RxShkuRRbQ0BlKyD259+Ljv37MZ9dIJMPJF
	 moavpRkYLmXVH47mLeLp8Fw/Low9CpbvNZNncFjj9GztJ1B0bWO24BeDPquqoKlQgR
	 2Irem6hez/qq5rE/JlIQVAjxQzRPCyh7qJ8lxblBDBqVqfVeghg/0Cb+psCfqCeyrb
	 kSWTIYBX45lWA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfc3496f51so9491025ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 05:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352657; x=1701957457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiMwEX70Mmq7JJA6SKHo9LkE/wA3v6qQVTVhutP/NRE=;
        b=lQgP7UO+64UCv+xA4piAFEuktP9wyYlEdV1qvpjp6ppBUBqRGZEhAz8MB5OOH+VxSL
         gZL/zweprbty294ohf6HJIcuxcFFs/d29LJzvIuPyEJRaFKgUTjjPOFsGwChTzRq7MZz
         ZLMOJt6930WCoCoNwAoNVW9VwqspzpnWpTOhfXBVK5uBQFTStK5IKbqLSkIE1eX85lRx
         CakRzi6HoHCOWCMAVLSwrGyCRznSrRkSCSe11NyvEfycj7NXiv0fTYyZT1MQFjXw67b4
         AQfwszbQKwcmIMLLHpJYWiqAVxZU3pK+u5SqarCwi4wKQRTnsYhp8ZYA/GEHXKTawpdI
         mlrQ==
X-Gm-Message-State: AOJu0Yw9KgX8SkbG7tEwj04T6YsTrh9Z8gET1hVYqVhYOVIWY0PkDljR
	z1RHUFH47DCBmYkKh+VHQKANbDPrXKcK7LXe+evjBmTKJwge1eLwusa2/bfNcpzCw/J+WGyaqWT
	jKl3cBna7vIFhiziDOa5amki7NNH1UYFGbYlXEJMjdgtf5fI=
X-Received: by 2002:a17:902:ea84:b0:1cf:87f7:5dd1 with SMTP id x4-20020a170902ea8400b001cf87f75dd1mr20074204plb.1.1701352657163;
        Thu, 30 Nov 2023 05:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeTTxfOdzeODnzR/xhLs8dtxM+rJ6KQDnMyI0c4oTzAOA72NLkE8Em8AuyuuFxE/ZPx4u5qQ==
X-Received: by 2002:a17:902:ea84:b0:1cf:87f7:5dd1 with SMTP id x4-20020a170902ea8400b001cf87f75dd1mr20074184plb.1.1701352656897;
        Thu, 30 Nov 2023 05:57:36 -0800 (PST)
Received: from chengendu.. (111-248-138-204.dynamic-ip.hinet.net. [111.248.138.204])
        by smtp.gmail.com with ESMTPSA id ay7-20020a1709028b8700b001acae9734c0sm1380486plb.266.2023.11.30.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:57:36 -0800 (PST)
From: Chengen Du <chengen.du@canonical.com>
To: namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] perf symbols: Parse NOTE segments until the build id is found
Date: Thu, 30 Nov 2023 21:57:23 +0800
Message-Id: <20231130135723.17562-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ELF file, multiple NOTE segments may exist.
To locate the build id, the process shall persist
in parsing NOTE segments until the build id is found.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 tools/perf/util/symbol-minimal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index a81a14769bd1..1da8b713509c 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -159,9 +159,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 
 			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0)
+			if (ret == 0) {
 				ret = bid->size;
-			break;
+				break;
+			}
 		}
 	} else {
 		Elf64_Ehdr ehdr;
@@ -210,9 +211,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 				goto out_free;
 
 			ret = read_build_id(buf, buf_size, bid, need_swap);
-			if (ret == 0)
+			if (ret == 0) {
 				ret = bid->size;
-			break;
+				break;
+			}
 		}
 	}
 out_free:
-- 
2.40.1

