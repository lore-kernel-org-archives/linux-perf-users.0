Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348504;
	b=wY+sTBmyRmQoF9Yk15DsRljn0n1i29suQza6Bp/oBnadmLhS1MYyO9jnHOJdlMzG4pDw
	 jCEllUIljo0Feea61dVHtNbwPlarojWG00yDA/dlQ2kSnVytaMdxf598YL+q1zWfXziK/
	 sDG1/Hvv8cRr1icErTCzh3FB2sg748Um619KNW05A5+NCXRAse8pBtKss8Nxba1WWoHbs
	 TNG4AIoSnXvH0W+IiufiCSIZlgb6CmpVqwfJmgFTcwh29LOKs8EMEB6wqB8lauxvO/5rc
	 F0bd3VHdDXrgozuSSSBzbMnV/UKHltaETuWMWHX8eACqzSekLgvBCdiiUs4ntOIydEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mGcfYbMPj8IwWwyiHhdRUSmz+4bidkToTLWPH+Ookn4=;
	b=bMKyWOZUml1fTqxFWJD56jPFo+kORLa4GQPypn0zxa7VIz6tW6DmFildM9oJR5OJJIx+
	 nYYJq3gTM+gSz9LmzOvl8wgadhiryit6oPA9wgaHrYsA1KZlOXigfP0UrcPuBmLCmC8JQ
	 eTRNuDQ8nj5EmmLEWwmYtz67cPXQDIjAo9hnS+dBrUJw6NDHRKyKUyUCi4tJT7f76Y8/L
	 tWh53dnzMVBKsnWJQAFpeL0U/58GGxqheBq1DWDTx6obLfoO6KrwFfg4SeVbQqZ54tUVy
	 2IZYCDYjp8aVFRt/Y4xPeqCjmH4sT0nsa22IDoVdgTHHbe5qDrvDrUYbVwrxgHQ+kcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XjRtr9io;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A060A5BDE
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0A060A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XjRtr9io
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso2048432c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 14:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794348503; x=1794953303; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGcfYbMPj8IwWwyiHhdRUSmz+4bidkToTLWPH+Ookn4=;
        b=XjRtr9ioXzaJEDYsbRTqM0nVMi5yc+sSFRyWieAdm+rPmmbuMu06DL5cdnMiXOZPt5
         ZJZwxNIPMBD0DAuhFMRNiggSg3RBWaXgV3iZFTInD/NCw9ygluTAQJDJmMeXzSTfVqBp
         lIbD9k/e9T4uJXYmBWrvD1zbcO6mJP5B0MEBcpukYV2z6VPlVzKJl+8pnHPCZhT6aOXi
         omg2UyGvIVGSciU9PevJgI/uPkpEtbzkX/tPrRJ7VplsSUaFeeaqEAJ1v5w/whesyu6R
         RhLI6euXpqXNov4EQDgIWcXWF32pbyT6ovjQgzPwZl/6QlcFJac/tEN+kjpD1oTjeoMl
         YqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348503; x=1794953303;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGcfYbMPj8IwWwyiHhdRUSmz+4bidkToTLWPH+Ookn4=;
        b=sTPVITBiWO664dd2PcqYrkc0Cz3MlHXwlbrkqjr3csflhnMuLidwsGAV/YZGRigAy0
         eWvqwVbe0vKkHiy1jGrg6iLjwFVs/JEkwm/W79Ls+s8Rnz2O5oD+RU982s0Dq5DrgrWt
         sVdi3e6W4MO/8/z1MhwUTJuc3kS5jvy2+2TemLcNRyhCPFEJLFQSfpqCFc+qMvdoWoim
         mfwR/sgF8pDSS9PnOyeJPPBoRuL7XEcl/s8PSvuV5vmYhffClbqVgjyZF0ggJyF4Ao/f
         RCo4VKoi2pWaHUrWxZ58YwCvsXUnmbnfzhdy6ZDElxCDD7cju5lD3V/UvWAm6VZ9u2g5
         lWbQ==
X-Forwarded-Encrypted: i=1; AL+hErGhIiov+meVt2S/tIBv9W1IoRWR7Ydixq5rx+tn42TTYe7CUHpUqCr1zmbfoOUEhIY3gBiakZ/U90BQJODApMvy@vger.kernel.org
X-Gm-Message-State: APuU4Z/UtEy0JpSB+v0NOjz6BvV+D7hZJL5l7/FXsXfKTSzx9ILpWRLK
	8UMrMSSeCulVF4sMtwmzD0YzSIVXHmfEAJhjfXN/KlqbE/L9+WiuqREGzCB6Ouw9PQOUh6XIvpZ
	GygZjl0/lCQ==
X-Received: from dlar3.prod.google.com ([2002:a05:701b:21c3:b0:195:d59a:94bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:458e:b0:1b2:42db:8a1d
 with SMTP id a92af1059eb24-1b3c0337490mr470920c88.29.1794348502797; Tue, 10
 Nov 2026 14:08:22 -0800 (PST)
Date: Tue, 10 Nov 2026 14:07:46 -0800
In-Reply-To: <20261110220803.2503416-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027231513.816148-1-irogers@google.com> <20261110220803.2503416-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261110220803.2503416-4-irogers@google.com>
Subject: [PATCH v3 03/20] perf vdso: Constify dso parameter in dso__is_vdso()
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
2.56.0.542.g3ef89b7020-goog

