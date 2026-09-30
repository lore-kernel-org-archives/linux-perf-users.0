Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2F46D2D2
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783947; cv=none; b=uGo3dOmmoV2hqjOozRE2S5tGA1m/Mp/pdXGwrKrCTafkw6O3kFS7PF2OhAzbKtJMB5QwcVf652WnD8rdi1sR3ifg1hQQrZIJneISy57D0KN8mLiVFLgCeK8E3urifeYsTxDCLfIACHwAJFZzpaVRtk5yN9C1JlDhauJ6sc7fld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783947; c=relaxed/simple;
	bh=fvsBMFcu3Leki1paprd4GO9igVhuE1WvRPncPexrkec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBDCTA9LoT4XjYhrWwqqocUz0xoRGPRZuwhENogE4iq7/SluXszgMc71UyYt2vWH3SyeyOKp6XhnDRG0PdzBDx9iKgnY/JAA8p2myVqYu0fJghUN1OaxwUDqhBABySSV3fs9Lj1kttZwfel2acUlvyvGw6TvlOGN9/nYffdGZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li+chHqJ; arc=none smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li+chHqJ"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-8137b129131so3649643a34.2
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783942; x=1791388742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Izn5bAPBe1bZbR1JsJZ2Zid1xDZroTRIy3cYsqCZHmU=;
        b=Li+chHqJG+dTu0ff4+s8dZ9lcAJyMLq3PuEPJrzNJ0iBLYCRQda9hHJ6El+p2yMiv3
         ZPxEMa9lbxHSL4Jmvn01QaOLvCL/mJ1lfLzqR+ooZZPHC0YpNWEu/lr5joJTrxQAkM6w
         KbVLzZiG9detMAnU+2JFctEqSAYVfAdhuVAO+An7xeE7yrUWB/L71sKbPTy+VXccJA/v
         xZEDauwGtsH0BWsBmLYUnw63hbg9Mym7pJuRd0/6BC9ABqMITmnL7A2QSvzGgkfZUR6Y
         mXOfdiXjZO884k4/qx+JWxNOMCz/s1HTo3ymQZqMukCQbVrJSG+/rJki2KWm+oPlKnaQ
         3CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783942; x=1791388742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Izn5bAPBe1bZbR1JsJZ2Zid1xDZroTRIy3cYsqCZHmU=;
        b=yaE2DLH1N5n+55C9xntSt3k48LPDQlEWbeSJ/OdI5v/ZQc7v2Aryaq6KikW9hNfKi7
         9Eu1ylRfHWe2uMmCjUPaUB8zGxyx85FpFeWFQcr2S7xXDjbWG+3Cu4+ODVurwKY0HBXM
         YE2qrn3w/CZkJ9JAe/qxMUKsYx+ki3W2RaIae0qx9KprDu66POxPOZTPTt4OUa2emlx5
         6lA6Bx4i09S84u5RysMzT65rVaLow2bQ3DI/sApreeFlRAttN0oPtnmK4rEowX2R9Szv
         l29HkFq8+ixgzvvxyOTJzEBdpCCU3tqD6PxlWekRBk5yWcizBzbibB9U6tHDnm1i0+il
         SUVg==
X-Forwarded-Encrypted: i=1; AKwUvBxWXXu+BRmWV/vW3oMTdVZjZzKcbNPfg0gMJoksPRDTlcrxmAwOjEyIHsl8UWBWXKlz7T2YfTyoe9XrVm/La2pu@vger.kernel.org
X-Gm-Message-State: AFuF++m0Z3fb8EAGY3sVq8yS05TIS9boG5x4rQ83ptHEkrAdUdvSOdqy
	TkSj7PWrch2B8yjZAAOIfhqPjqFQs3QTZ4vuyIXy4RJb8qFrj+Obv43G
X-Gm-Gg: AYBFou31/yJjM8UljnGVMUMSADInJOiHkdf/bTd71gf/iv6YJsLoiKIE+xTYB5XtpmO
	gKdEGamFJZ4kvX0dNAsi/aglsG48F3u+0sKUb3gG2OMENypSg+r+k8yJwLRd2N1rsk1RKYpL9sB
	DNvH98fE2VTNjazPwwesBzamH34X7yF0SUvffp4PU2hVAroWDHcSTA5Jw6h9ChtGREu6di9Hve1
	mr0v95c6+7rJ6PkeT+P6ZrcMCNXsXfjr5DcNjROmpJBuqxRCaeyWn8XLilrtac6Tc+6nFzor5c0
	bmRsupLu9HbEJLlX0w6dpOfc6SzZiV6HbbsvWrdd7PypZNf9kGoYdKnskUAISYchLMp8aOisRUr
	8SR0s1EMQaCmncehmq7GbwSWwyozZH2fBpkL2zpmTetLKDgMhKrkVIZTRyYY0SRERxspLuZTCdN
	jr8HjqQr4DfMIDMD9kw1yVz9ZQNz6QbZdugeQshJIJOGzbxUHNtt5BgqeAazL3SzUYEsER8gIyS
	L/rgxoOzgAjdWPwpDdA2oyME7zEgofUBglxjyLo
X-Received: by 2002:a4a:e914:0:b0:6b9:8413:89b8 with SMTP id 006d021491bc7-6dcf592ea93mr1794882eaf.57.1790783942229;
        Wed, 30 Sep 2026 08:59:02 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6dd982ed764sm332033eaf.11.2026.09.30.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:59:01 -0700 (PDT)
From: Danishk2445 <danishkhateeb03@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Marco Elver <elver@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Luo Gengkun <luogengkun2@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Don't send SIGTRAP after exec removed the event
Date: Wed, 30 Sep 2026 10:59:00 -0500
Message-ID: <20260930155900.65984-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151610.GN88198@noisy.programming.kicks-ass.net>
References: <20260930144248.59858-1-danishkhateeb03@gmail.com> <20260930151610.GN88198@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danish Khateeb <danishkhateeb03@gmail.com>

On Wed, Sep 30, 2026 at 05:16:10PM +0200, Peter Zijlstra wrote:
> Is this the same problem as this one?
>
>   https://patch.msgid.link/20260920075026.990582-1-luogengkun2@huawei.com

No. That one is an exec into a non-dumpable binary, where
perf_event_exit_task() sets TASK_TOMBSTONE and the WARN fires. This is
an ordinary exec: ctx->task doesn't change and the SIGTRAP kills the
new program. With Luo's patch on rc5 that still happens (567 of 2000
runs), with this one it doesn't, and Luo's WARN goes away too, since
perf_event_exit_task() sets every event to PERF_EVENT_STATE_EXIT.

Thanks
Danish
