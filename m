Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B41FC7F3
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772917; cv=none; b=ib8cf4w7VYAzn16lo2vrdadCq7HU99NmLmDAEXHwkFrmAGDBZVp+8p3MspAV5sESpu3LIIfYr0JQiOrxCvhSdMsBuBjv9enlva3FkW0algKG/k62DuJ1H2P99BXBL/o10MGJBADXFOyFx/pqxcAQhuyeV/AAar5fVX6IzR01WCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772917; c=relaxed/simple;
	bh=EttioCEzotPWFiddBHkBE0AJBG8efcrrqir3XlI9I80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPQ6XGVrZCBLwa5N5Jg6zPoPiMg88MsBUPL/S4l96OR+xgprkJtgoEa6TiiRuAgjsPX9WMSR4Lde4n8AUSjCxV5i/UVqnzWd7CHI4gBTgkT+UOuGyVavkW9RR5gt0FlusuDlAdru52D6zvSO7fLDUb7QXt3gOhVeC3oMMdKBZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxVmE1DF; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxVmE1DF"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa67fcbb549so661066b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738772913; x=1739377713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mES9zlK4q0Abt8GXLMsE8pcYClHIX0RrLwiPkvwA/U=;
        b=FxVmE1DFOjVySRaSZy2dg+ytsmSiX3HuCUUIwBVsGWM62AJyZlmv9jsRVTLErQrQtZ
         sB/CarAXtk2NUCEyMp+8YX2t3KDGCcZudfKgkG09mOvY1YyaIyUgdd6odHa2MSkwSe1O
         hGAGeRv5Lk0paEdDqWUoEdeHZbw4bVmisCTHWDK96JDdxRb2WdhX3QoUkGrVGPd8g7Mn
         XIukEFMMJgXEkQ0BcDo3Ej+odQNuriu7uMQyIDOnZM6jRCHFJMZSuUcL8aXM+4PAVzQ7
         7OuHhXerWYq+pGqAvPWIQzuwWKUYPB9I+tpLqwY1laHDR6c+jVstT6DQYNNROdeUBYt5
         +kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772913; x=1739377713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mES9zlK4q0Abt8GXLMsE8pcYClHIX0RrLwiPkvwA/U=;
        b=jr8G9heYuhVCJWBhhqv9YeMW4ALs64xC9SQGxjMFoNZrV8Uwj78jAMlaGn5iYgdVCz
         n2l2wFemwsbslN2HCs3UAc2WKHMrm1/FaARi8zUkwViyOxnLwYzBH4z98Y0Ui0+CHmH1
         elkWahfXc0kslH+71f9zNc8LdI9LcJ2llQ6Nns5T3V0ybND9FSVtMS2Ma7r0UeYQzQVL
         2YTwDbqJAas6emdwDQiYGGokjxo2xZDbHMs/9kHmMecq3WPwpdEF+EK4accUpkwnXpig
         pTCYy0uIIKzRwZlZom0qAwT7J0/xRG6pRJsCjA4iqm5tvqXV9cp4GjEbUO5oSN1vb7p4
         0C4Q==
X-Gm-Message-State: AOJu0Ywcc/WoTswiXRtNwLTOLt5RaJ1bUdE48mC3R0vGqweRuYUWKaQR
	9HO+MJqfKFV1utOezibh1WVVA7VAMAT3of6EKeIad4VXL62FvwQQUM46B5ovBGp2032S/q98SWZ
	/RowUdg==
X-Google-Smtp-Source: AGHT+IEO002sEP2tAcE1es3lzHcp552u1N9eSedG+5a9pqj3xDRDruIrADWaB9Xm5GoOz77Xf2midHQ2rbG6
X-Received: from ejcrg9.prod.google.com ([2002:a17:907:6b89:b0:ab6:8ef1:7284])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:856:b0:ab7:6606:a8d5
 with SMTP id a640c23a62f3a-ab76606b5camr238720966b.48.1738772912988; Wed, 05
 Feb 2025 08:28:32 -0800 (PST)
Date: Wed,  5 Feb 2025 17:27:42 +0100
In-Reply-To: <cover.1738772628.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738772628.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <6b1197cf7daac315b998e8c96042822b56d4bd25.1738772628.git.dvyukov@google.com>
Subject: [PATCH v5 3/8] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.362.g079036d154-goog

