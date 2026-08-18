Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608F283FC4
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064532; cv=none; b=dlplqZYhGRcQtaqA3cpJ1GTBU17OZu6Ltz66aCYy8fgueGMUt/9FFb01b2oEwg8rUAouohCkcXVQtD3VQA9kVrBPbhvYp5Y6bk2n/G7uxLbBL8HseC2l8HsPRpyBgceCfdzsJfjW++4+a/Uf6U5HKnF1XW2uv6FcQEQbUi4+Y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064532; c=relaxed/simple;
	bh=ut+2eq7WSaSVlLblrB/noknMPuxRnWmAtoR5s0E3O/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfeSObEPFl20yblNCOWpBANos1Vc0PJlj5NcXsWEHiVSRX3aZ/a6ENmCesOlCfquWw/aIv53+/i7gTXv3P65ZL48iYCn0scGCyQqpgcQvg6uf9ItU0G8Ha2QSOkCeu3B59zbIprZFuW6FhPohKEV49i9YFj4YU1iGrIPuOrdlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe1NkzwW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe1NkzwW"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso3644b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787064530; x=1787669330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5b3SGhODqk0c4vJ8OoIQWWGMwcq+bbZgtoc9iFh8o/E=;
        b=Qe1NkzwWC4zeenGh7+q0Swy6mKqIapMijZdkLunIXyhwKBNzMAV56pUen5RkT9L8RX
         yAteAl0hCLnE8w8uH1MN/OfQgV3jFObddndOuFTCTpiV5CteOQaoIDDtw6OB9+i6PQEi
         4H43nHZZylnK7yeOWUKX/YIuhpgB9T1HKsSOs3PCeBknQNrXcE94n/XaDO9jkGVpHepN
         GaXjkHVjEXTOBBAX310Tnr7fZOqP9qEoewn9UZ3OofNDOKCFDcFnQ4BpzcxynYXQSyKQ
         YUD+yF9UVQ0FRdrcXFNVRFVLJWg7ztK9QAH6hqfdgHDe8EqkuhED6M1x0AwPXlt1AZjD
         po3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787064530; x=1787669330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5b3SGhODqk0c4vJ8OoIQWWGMwcq+bbZgtoc9iFh8o/E=;
        b=N9yq4s03UM9mQa9rpzLDASgCo7vCzszfxoNkVcRRY/cDkm4PGIGRZ1Nrryc2DWC3N7
         TlplQLr1s2YqGtoxGth16k2WsM4S/4mQRK2qJ+PBj5Fc7EwicEYBka9SO0AzZmsnJsRX
         usLK+BsFlADqWffwYnigx19m9+Rdnd1g6x0duseEvikgHRTLzxV1VFX260MPvIG06rxN
         1r+xmB8b28MUlbdSXpY+mkzG3SvvpeF1Hl2nxw5p6znBfn1Isg/LL3ioXfdTsA/WYw96
         cMltoyOQ7qw5Ur6nzuG/WDQXF3QZIzwAd83ZTIxxMC4S4V2dal1mlIXW7cbs7yWhFsbZ
         TbPw==
X-Gm-Message-State: AOJu0YzoXTCgkhwWEh2NDxCTO059G6dIc0oV5nQ7Lqi4PXF1U1uECnjW
	5vnK2VcuPTwH65Nf1Fwi2vD7W7Km9+eJKWEWM7X0trUcBAgVWQfg5iZ0hd/Am0jeFQ==
X-Gm-Gg: AR+sD11mG9eDyTkDCU2LhRgn4wM9DvGVXTEN8bxcpiqdhAfUMdEYSJ/pJPQndtuQaxy
	jbMXm5PmnB0ieP5hkCzkedxN60/+gMZTvKc+FZ90GD2HxVeUFURlR9D620OhhtWSsnE3qYs31CM
	3SFMGUrVkLYILpVuvJtFaKg3bc+jf8pMhqM7aiQp70ov5a5RBItxO5JZftvs3SMXtvYplTWJXWz
	dasor/L4JwZzhQMHFM6cCkZHsw4ua0nF8jKmC/E3ofd1RZo9PHXCMs3i1LCNINPFyohyXndF4XQ
	lW1SreQPF43V3+JutTAuSqFRKbjUgWv/YXDbgElqksxZwfhUAGt0UxghxCyIugFJyIPSG9FZOT3
	gTQryT//GWP5if1SorY6YmHuLuTXj74XrgGZNiNk4L6pskJuv28+0dQwZmvZlST4dbuGEZ1AJbT
	cNe39MEKcvMYt4tSAd7tybCC+8ADII/xJhjvZdOHJ1lqZyUyVd+FQprfaCoR3o/DdibrtPnNRuq
	PyKJGwDxAFOkRH1U6M3srnhkoWBPxsdynlZ2wgPGAP1nDhIJ9qCqCnWOeteqbFB8AfRAhoknw==
X-Received: by 2002:aa7:888b:0:b0:84e:24df:3870 with SMTP id d2e1a72fcca58-84fdddf222fmr33587088b3a.0.1787064530349;
        Tue, 18 Aug 2026 07:48:50 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851c5382f1esm638832b3a.41.2026.08.18.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:48:49 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: sashiko-bot@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	triet.hoang.dev@gmail.com
Subject: [PATCH v2] perf unwind: handle allocation failure in libdw__get_entries()
Date: Tue, 18 Aug 2026 14:48:37 +0000
Message-ID: <20260818144837.741469-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818142902.639F51F000E9@smtp.kernel.org>
References: <20260818142902.639F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of zalloc() before dereferencing the allocated
dwfl_ui_ti structure.

Return -ENOMEM when the allocation fails to avoid a NULL pointer
dereference.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
Changes in v2:
- Free the ui structure before returning -ENOMEM to avoid memory leak.
---
 tools/perf/util/unwind-libdw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7f35042be567..fd8a5125468c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -379,6 +379,11 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 		dwfl = dwfl_ui_ti->dwfl;
 	} else {
 		dwfl_ui_ti = zalloc(sizeof(*dwfl_ui_ti));
+		if (!dwfl_ui_ti) {
+			free(ui);
+			return -ENOMEM;
+		}
+
 		dwfl = dwfl_begin(&offline_callbacks);
 		if (!dwfl)
 			goto out;
-- 
2.53.0

