Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB71A3BDC
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731747; cv=none; b=a71NC9pfv68Ca6ua8TknLNWnOS6+mTDMyBvNssHY5GGF0QlUkBxhEsZCeV/IoDTihwSmhEB8A8jZcjFyrrhfFx0eir+sb2WCqsoMZrmLxiu5yLPvLgGxXOvCARUAWD6LO+K18sMN7IaWWq98B38ynxeu2JSY0Bv9Lont5WitUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731747; c=relaxed/simple;
	bh=bwPxoLGrbCPaxY4RUl84QG7RB/MKfFMxPB0oh9jgNwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5ujvWFgNeraregvXH3YjUedjwzsP+jRR+B578+AV1XMW7igueaIksEyLYlXyl6G0yUQxw29VbJjljXvPvpnPE5TSWt2zjbeBX1uX+SmUdSY7PI4N50S1fAOrddbcomxOt+m2l5sS457WphCWIOabyGkj8IFxFBj5JLqI24S6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=IRHZXds1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="IRHZXds1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso331243f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1723731744; x=1724336544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3S9SlZlCivX+9wrTGllTqwoY0HNBQ46uqVFAXjbSLE=;
        b=IRHZXds1gaEvM26klBzDQyZDBu1MXspnXX71pOKyQaSDsC7OMrVZ4EXGD0hJnp/VQQ
         3EcqtppBQ+MoPD0VePnO+JBkKKzRr/DII/ksA/J7jgaNmDeddkuV18pFr8GWidjUI616
         rbZMG8+4x79ZeFytYQKsVZxTXp2BIMLNEmMoKAGKq48QCbATxsQ9+V/kq7CxMg4Zqrbo
         KIl5Vjq0QZ5zg2xIyB/5rr4a482wjLJLFBrAE7HDlwRjTyuAp5qf5UFC039SpuoTf1ZR
         3DNN38/herDczszJiqUXMh9gDrSshVBhnsUXNqQDXzZjic4Rz4sd2cA9yCJPdr8RmVap
         MdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731744; x=1724336544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3S9SlZlCivX+9wrTGllTqwoY0HNBQ46uqVFAXjbSLE=;
        b=k7SO99bu+IlKQoT4e9S02ms0LEk50zWoqabVP24tpO8fPDNjgMtunC16UUh9NMxeCG
         ePOKimSLv8i7ebHprGOuJjItDhz5iF/M/LdohnIRbHLwe2iGai0GYLfhEdrBqBhVaYYx
         wdf8j/E5B9vwdQOW7E6Zh3oGwtqyxgbYWdta1oWXT/vdmKnVKI/QGAVa7Mq5VBVLN6QX
         PaUC9aUEGoKAzqZMQJcZMebSett6XGIa215cEM9AS3H9UYOgAPUX/zljabRl1Xk6AY9s
         LBEmy4zZ55CA8Zo4uRwhOdYHVTU4ZBj1gAUlYkm/Bue+Hh8prm67CEFIHakqpNsCDysr
         PVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/LFCsuzY6eatxVXS259o356IBvAwyLC880OCft28QGnaRz/wkA4RNEh0rvUpuQVbn4y0NEgSsU+mtDAIwGWqaRAf3Q+LeC9zOLrf/WxJC+w==
X-Gm-Message-State: AOJu0YzGS+w58RSeMg5rPELKP6Awz7Se/kbG6hhEI8DaCPUfBbGEj92L
	zGc+WrP3a0aiVPQrVryaLrEkiIkqMytgx3yS7Z4MaMKHT8QkC+95dKNJb3PHMFE=
X-Google-Smtp-Source: AGHT+IG1+08AvwY9H1Tzt/sARe3oMheibf53emloX1WYLJWNxi0fgE+jW7MoHtMBTCCYbqftPT0K7w==
X-Received: by 2002:adf:a315:0:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-3717778ec82mr3712345f8f.28.1723731743650;
        Thu, 15 Aug 2024 07:22:23 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1661072f8f.87.2024.08.15.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:22:23 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@cloudflare.com,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Yunzhao Li <yunzhao@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf hist: Update hist symbol when updating maps
Date: Thu, 15 Aug 2024 15:22:12 +0100
Message-Id: <20240815142212.3834625-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AddressSanitizer found a use-after-free bug in the symbol code which
manifested as perf top segfaulting.

  ==1238389==ERROR: AddressSanitizer: heap-use-after-free on address 0x60b00c48844b at pc 0x5650d8035961 bp 0x7f751aaecc90 sp 0x7f751aaecc80
  READ of size 1 at 0x60b00c48844b thread T193
      #0 0x5650d8035960 in _sort__sym_cmp util/sort.c:310
      #1 0x5650d8043744 in hist_entry__cmp util/hist.c:1286
      #2 0x5650d8043951 in hists__findnew_entry util/hist.c:614
      #3 0x5650d804568f in __hists__add_entry util/hist.c:754
      #4 0x5650d8045bf9 in hists__add_entry util/hist.c:772
      #5 0x5650d8045df1 in iter_add_single_normal_entry util/hist.c:997
      #6 0x5650d8043326 in hist_entry_iter__add util/hist.c:1242
      #7 0x5650d7ceeefe in perf_event__process_sample /home/matt/src/linux/tools/perf/builtin-top.c:845
      #8 0x5650d7ceeefe in deliver_event /home/matt/src/linux/tools/perf/builtin-top.c:1208
      #9 0x5650d7fdb51b in do_flush util/ordered-events.c:245
      #10 0x5650d7fdb51b in __ordered_events__flush util/ordered-events.c:324
      #11 0x5650d7ced743 in process_thread /home/matt/src/linux/tools/perf/builtin-top.c:1120
      #12 0x7f757ef1f133 in start_thread nptl/pthread_create.c:442
      #13 0x7f757ef9f7db in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

When updating hist maps it's also necessary to update the hist symbol
reference because the old one gets freed in map__put().

While this bug was probably introduced with 5c24b67aae72 ("perf tools:
Replace map->referenced & maps->removed_maps with map->refcnt"), the
symbol objects were leaked until c087e9480cf3 ("perf machine: Fix
refcount usage when processing PERF_RECORD_KSYMBOL") was merged so the
bug was masked.

Fixes: c087e9480cf3 ("perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL")
Signed-off-by: Matt Fleming (Cloudflare) <matt@readmodwrite.com>
Reported-by: Yunzhao Li <yunzhao@cloudflare.com>
Cc: stable@vger.kernel.org # v5.13+
---
 tools/perf/util/hist.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0f554febf9a1..0f9ce2ee2c31 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -639,6 +639,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * the history counter to increment.
 			 */
 			if (he->ms.map != entry->ms.map) {
+				if (he->ms.sym) {
+					u64 addr = he->ms.sym->start;
+					he->ms.sym = map__find_symbol(entry->ms.map, addr);
+				}
+
 				map__put(he->ms.map);
 				he->ms.map = map__get(entry->ms.map);
 			}
-- 
2.34.1

