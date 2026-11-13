Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590293;
	b=Z0upVaOwEc4t1eTVJOTou7Weac5UZaHJwy+RAxtprODc6SoO93W45gB74T3ej+jXHSen
	 ByFavQ+fsUOUjmnK6JGB0SpRbg8GWtSYdgI7lEQnoLUbcvKUIOEsx8RTtVOB00J6DRqvJ
	 SdnOSjF4udpP6WH7W1KVKo5bJbzQ43CXTbmBKJKEsO97jSWRjpM3hJzYGFk3Uu9EI5xmE
	 ZVe/LUMmXfDdv6wjpjI1OF5/lMB8lkW7shOPCb6OJ2VjyJwmPPcU3vi5NJw2dwhc+YtNO
	 U8/uk4pVRbQe5j4xuhAUk0vPkpNVsdomnW3y3QXnmFiwdIWC98gD//ps4RKaUDNnJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tWKhcWpD9mj2d8PnUU3UkZsThd7QQmlRjYnUzdhDGBc=;
	b=1fyWpSsuYZzpUo5nkyOVcNOKU8Whsu4ghBpTdyAxNzQEIoYFVtV1aJFNO04sKFrAYlU+
	 y9zzIlZpsH5Kxsx7lgS2xYAQLVThpClLyfzLbZ36pJypsuRv5lGi0xlu3n94i0JdZI8/h
	 oFpgKlugU6k7MUjNV7SfY9uQTpnX5lKG5OKcNYTqefUwBx+SvtnukmhWybUmSpQdqFKhp
	 y0t1CR9g3BHEE+1iuGbbShrwwTXIJtmNgNSDuLskMtwk+LemOvqqK07Lzvcx8boGeAltZ
	 MHZm/UkFQ2p0fEle74bbF6NciQ1ZqeSuhKlR0I3/oYnI5hYlxfYt8Q//PINSGu8dNfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="V/z+4bs8";
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B6607A5FC
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9B6607A5FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V/z+4bs8
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b238436265so571276c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590291; x=1795195091; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWKhcWpD9mj2d8PnUU3UkZsThd7QQmlRjYnUzdhDGBc=;
        b=V/z+4bs83TrSCAPh7xtP/G6TLt7Jb+F0KcjVqXcQswmAOt3FCP5X6OQW9+88yDFEVH
         WlDYMA9+G1JNF044GMulzrTgeZqjotijVLYuX0lAGM7zl21pQZlVCRoqGWBLAlLEiWT/
         WmVcuCyRhk1KhBxcyOaM0ijSRKi5acFUv4tF/SQxcVbpZqz+pPkQDD67rPbhAyKiMJng
         yblJb5Jx9pgwrkoc1tuxdikItr9cIKyt1wH4HWg7XHVmUdIo7QoH3aK4R0CEe/dHUQ/P
         eIUepxg/jcf8ZtVH5AQCfaQJznfTO7wSRPgLBRscLteM1bsWDjAC3ANbQ/QSupzxymJk
         VFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590291; x=1795195091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWKhcWpD9mj2d8PnUU3UkZsThd7QQmlRjYnUzdhDGBc=;
        b=GrZ3nna49E/RIl07C/idXMxtck0KfAA2sS2q7zRoKCV3FXEBrqp04dh/0Lr8tkvz1f
         PJOTPNbltjrCjb+g9ZglvECGJk/YtT+DiZqdBS338M9yk6dl7ntmmQ4swNuoPgBGIr06
         x5cO5p649LrCZaabQ06NcBiSSL/lOf0blqlqRC3epuBs56TWVmzStrvQT/hnynbIFF4M
         4UpaOm2Xmx+Gr/OUNvMB7ePBoYIWfT9lLyUbiZiFDu+WD1HEuk995V1Phzv0vtkQCn3v
         WNjeCN9Dq0+6DM5C4LNc7DWCVJtkC1KplhA/ke3OVkjRMPY/C8y7BZlQ1B+OJieFQYqB
         3ydg==
X-Forwarded-Encrypted: i=1; AL+hErHaFVwQMD90idPk38P73H5SznXSi7b6wA6ick1bKgZiT2nucZzEI60II+f5w36Vu7ebyxrHzM3fNZfKFYoYmnYT@vger.kernel.org
X-Gm-Message-State: APuU4Z9jg5kM699h1XR88cV8Ys4TXoARawFT95PzlD6CRddpltrwilEb
	bsxQ++XF268IA8u4oDuAYdVWKUPuiHl2c2UZBi82MUM1RE0Jc5J6RNKNN15BdDefs5zjHN6Dem/
	O5DmPjN2p7g==
X-Received: from dlbvv12.prod.google.com ([2002:a05:7022:5f0c:b0:1b3:b6c4:6fd4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:a42:b0:1af:16c4:d06b
 with SMTP id a92af1059eb24-1b5030a3490mr2624195c88.10.1794590289931; Fri, 13
 Nov 2026 09:18:09 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:17 -0800
In-Reply-To: <20261113171734.2188066-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110220803.2503416-1-irogers@google.com> <20261113171734.2188066-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113171734.2188066-7-irogers@google.com>
Subject: [PATCH v4 06/23] perf vdso: Constify dso parameter in dso__is_vdso()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, haghdoost@uber.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

dso__can_shrink_symbols(const struct dso *dso) needs to query
dso__is_vdso(dso) on a const struct dso pointer to exclude vDSO images
from symbol shrinking.

Change the parameter of dso__is_vdso() from 'struct dso *' to
'const struct dso *'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/vdso.c | 2 +-
 tools/perf/util/vdso.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index c12f5d8c4bf6..7f2dde70f3e4 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -361,7 +361,7 @@ struct dso *machine__findnew_vdso(struct machine *machine,
 	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
 }
 
-bool dso__is_vdso(struct dso *dso)
+bool dso__is_vdso(const struct dso *dso)
 {
 	return !strcmp(dso__short_name(dso), DSO__NAME_VDSO) ||
 	       !strcmp(dso__short_name(dso), DSO__NAME_VDSO32) ||
diff --git a/tools/perf/util/vdso.h b/tools/perf/util/vdso.h
index bc74ace603ae..b6e05bc2d9f3 100644
--- a/tools/perf/util/vdso.h
+++ b/tools/perf/util/vdso.h
@@ -19,7 +19,7 @@ static inline bool is_vdso_map(const char *filename)
 
 struct dso;
 
-bool dso__is_vdso(struct dso *dso);
+bool dso__is_vdso(const struct dso *dso);
 
 struct machine;
 struct thread;
-- 
2.56.1.703.gf848ed807c-goog

