Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08033B19D8
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186658; cv=none; b=aD86zzs18Pu36FTE75EMzGGF03/XNBFuf+yLCOjJwkICRP8XSSVJ2sLFhL8K4Dybj51BqKFsQCxSdeHycKhHeqmtepUY5Zep+2CMLU9jhYftwWip3aT/5ned1c+KplzI/C026A+1F1EBvUJRRVxMG7+CrsutTmz8/m0Q48P8XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186658; c=relaxed/simple;
	bh=ao0+j/VWrtkqvpndCog9ILrmyonUtYXYAl9+J8XCDE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0/93wRQb4iNgxh73fbbltnmBPmTPO46L72a2I6ub5QtGr1fUzqHPZr5PeITxnjw243TLr2U3h14inNRR9QQTJKu/Z/ihVRIEN4tOMItjVDvok1zXdGIeLW0popK3Q4p+9wTYB9vMin3+cSAa49VueFZteYEXjTPIsWLvKx6Usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz6nS3yt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz6nS3yt"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8486c3411c8so8788595b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186649; x=1784791449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzDwUxFf7ofb2cdMu6W6wSMZZ+txsXtnRwXL0z9AixA=;
        b=qz6nS3ytRVlHwZV2Yfj81ISeMepWLQuW7wP5+OdA+rnBwXodrCkJp3svzcKM5DVzDN
         mBT90eqc0UYv/pwM3QVBQXTMG+4pHzdg38JRZsI6Fxr3R4vmx92TWfM3FCg9H5cuYWax
         BW0J01vJnsvU8XGcx3vIg93xaAuxQjYH/sCeGmATczHKSrcW+uobb7Yt03qvxsFODa62
         IiZQnnoyv/B58om6eq7AGUdw6JK0LWauZhDZWbzGNNjzUOm+dKfkEX3B7YSSzZUhFYbW
         n/Oj27sACbHfSyvxkUNzl5iwxNnQpQaOHQa6AcSlGozB1tqS5FEtOfN5Y2NHjrgL5QES
         iTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186649; x=1784791449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzDwUxFf7ofb2cdMu6W6wSMZZ+txsXtnRwXL0z9AixA=;
        b=dwglMhe9RoVCy0SZ/xubDFwVUW2d9agc8Jo3SYcP2hdyyM1oBGmV7B1scBafJkTLpn
         CcN1SAjP6uxPniz7HbhT2PdHSH9P5pG5cCOCXSMJrEJKCsG1YTI0QCXhqCqa8Ubl3j5p
         yIwiRU7bmr2lsraFqIHaGNfA434wjGdpEovLVEPtJYt3cAyi2Ogpoelr+ip+IGsM59Kc
         Tb4B9k8wuAyfBowP/8K9gCMasEqHzeyV34tFrsarIrHSHaJImlrdp3m+gUOwhquaKs75
         JvH8NHWSb5AlDTtXSq3w1uM+qstj7iHy/qAcbQc3Ea4yCuaIZFXJotNCbSm069gF3oV4
         rv7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrp9m38VD/3cwOIsMBwJbQax4cB3KzF6nlAHsdcvC+VmnkxJMgR4rbasGjH8ZiRn3lnNidODiEB7nzwsfeoevoK@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMKQ7ehnzYImrphrTCX+gQh2fxg9P3NcdQtJ/Y908DKQdFhBV
	YJXUvyCcNsmUnbe/eqpKFDxtT4UpSoAlyhlA4/6SDeZoe6U8FYIqpInrtfnbOcuWOlwN8nEZKXE
	QsME36J9CEw==
X-Received: from pfll18.prod.google.com ([2002:a05:6a00:1592:b0:847:7f5d:6b90])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d5:b0:842:83d1:ee6d
 with SMTP id d2e1a72fcca58-84a672b4596mr5569262b3a.45.1784186649066; Thu, 16
 Jul 2026 00:24:09 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:49 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-8-irogers@google.com>
Subject: [PATCH v6 08/10] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b0d421768dc5..55dd1af9c81f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2359,7 +2359,6 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 struct popup_action {
 	unsigned long		time;
-	struct thread		*thread;
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol	ms;
 	int			socket;
-- 
2.55.0.141.g00534a21ce-goog

