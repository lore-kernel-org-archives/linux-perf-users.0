Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195668;
	b=xYFg9P08xtt7z+zZsNdG1pnlHK5FLu0S0Bry8nJgbGXVb3TR3AIK348xBf5wvtFK48f3
	 WXCwjPpw90lTJDTi9wD8KBVlGjpCZRwpXin/LWlw1qdOG35X0Xf4kTmu9XorHbSZcOJP6
	 roUMah7aObFzWQZdtVvCEnfUROUMQK4kyRD9dFkIXZh2jq8euupoR5MW9GkseIzHq263a
	 06E0ibbJnojON4uegR1Xp38PbA6Qv3cjq2OZVifWx8YkiSv+Wo5hPH+LWUkhFiPXT0ME+
	 5iIFNBlYDe6LGJM1bx/EUIRo5YIlOXlg2ZvdvKcwKBza6vK0t5xBDzJzUVZ+GFx1MCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aYJ744NugWVIMiKS0QCbcveofl6d6KXX/uG4XmRzDN4=;
	b=TsvXXr47fqkBfWuS/4lak2NzIXRg7Vmi6zhoxo/KOHBV61OprSYHGMIqobZu3TTUZM2b
	 y8tkRDIoeCeNrh0Z29j8xtWlC+O+zO0CFyLg+QXE1Gw8h2fImyWTDMQkQbT8FzSu5ouoE
	 ac/dwV21yUWpoNKRiszpDF0ItTNOvsOb+49tTWqKHWtJ//Tq9KDwSdr4nZxFHCyU+zx6R
	 uMEjfr1WE5nef0rDqL4bAq0z5qr5vJq8xRzz7eYtMxMMqUgNqHzUBKqAPV+Be/Be24oSL
	 X147In8qMzUCOfTwN84gCdFeaIIZQkHyt6EytNi4Y1FE3YYn37nvNDtLlhE2csC9N3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7d1Z3rc;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9533606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 17:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9533606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7d1Z3rc
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4b5138f0991so1267936fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795195666; x=1795800466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYJ744NugWVIMiKS0QCbcveofl6d6KXX/uG4XmRzDN4=;
        b=r7d1Z3rcU80Ftfsq8u4pPrTWtL5a2QJWqXuQn0sj5yw3f7cL/WZIG5XkJqNSOm7qff
         Fa8lXfMkaa18EL7CIrW/qCDwpp6ppb7YhXJWhKglUiMkyISqXdbV5etgPGa8r83fq3Wf
         jaNDGMk9n86YtTvhK54DUNaoGCJB1NSWlmeVo/49RbzwcdruJz0q9d2h8MfFncGLVuOC
         kNcvMS3t/mU+onD2BPtS1Bx2k6dZsaYrkbzaDUhkoWfsUQjkcUYe9XYWs1p76wbLpqGB
         5UfF3zsUUnkQEztUqvvSSS/U/rXiO1/8yM/RA1ayotKkQu8k1ljxL9kqhCX84QLJg4p4
         u0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795195666; x=1795800466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYJ744NugWVIMiKS0QCbcveofl6d6KXX/uG4XmRzDN4=;
        b=BE8OrxW+zH2fFaEbELvAVXBBRdBuErVHEm55Zq1DOYEO0x95J20SBfnNPGQJ1VFSp+
         VK0iFCZAEBxMYQIpMnK+OMT4sAMVsbO80WhrVn4jjGzyUAggJfnxHWM7EGOBv3/S/Dox
         BQstgWuSsmPYhuHu6fzYksDTYbfH5yeisOwzdqAsoz+nySiOfOQ5OXMJDyrP499oWqUC
         x5PlzJZHr73Z8fradIYuuGWRFt11Q7gLIh+ScJZ4ni6jWLKyj03lhH1HD2HOm3qZI5Un
         LuHgeAYTZod1sF4hSA+D10lJXtqu9vGMH1sjm7npN9UZPGQQQMQxA1dbFHvfSPZn94nJ
         4eNA==
X-Forwarded-Encrypted: i=1; AL+hErF7LYk4UDr+v58ewhM5X3tFTj5qeG3N2V2Lv93fhtHb6IRPioi9WEymARAk96NPz/mbMUxRvBbgMtZYtNqYX51E@vger.kernel.org
X-Gm-Message-State: APuU4Z9DJzvQSCF21y5SBeS/CtFUlwgkc9yCTRsW1SrrK/eDxoh8r4Mx
	caXpNxrv9VmZ8lOcsrlhYqE+COtVCXNdF6K45jNWHj2rpmOISmvokf6c
X-Gm-Gg: AYBFou2T0ryZvj15nYpapihTljD99pYaUlrzk3qP5TLSlRe1fER8edm8DWlRI5H/AXh
	8SwDeVlNO0+JjnsmLkRtfnFIwZ7IfMSHBe1zuH2dwi5l3lkxsadAiJwczdv0PjOXiZOdTmLxMHn
	6rFTiML6WGgWgH92p5DlHUJJbMYMWm4GHRBFeaaYzDITDARCANbDWTd02T+/4ZvEjMkvlqOQ4iV
	zmtv5ETeB3rGL0uPh11xlN/21m2nqyDMplZA7ww49uW+FRrVFlvK9gy1LrGMZ32bTzu5FE9LsJ6
	tFfA68BG/KYp0nKHR0RR9J93g3EXi/sc0pnuDUElyML0l4bOvnIFASi77sebbyBNnTQPzcSRMAC
	hgN41ptkhae4X6Vsycr/bT72F/Us6RNyd1qSuuou8pHlob+Zq7mHRDbFnyHSE2IL1CceGCWFTy8
	9DBKKWD560DbiaXK2eRlzqJOsyl+CYFVnYJKd+d4GEUfsSRcngEmV2VO09X9EvqChljNYO01CQB
	sADdOqXEgQIRHwMqsdGlQTiIJGv6A4BVFgT0ZxkppZqcCfI9froBslGCaAoTk7+9oodfQGhN5Ln
	wNZmpv5omhyuEkxTIl8ILPk=
X-Received: by 2002:a05:6808:4f08:b0:4b8:46e3:e223 with SMTP id 5614622812f47-57a0a113076mr2651142b6e.15.1795195666573;
        Fri, 20 Nov 2026 09:27:46 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm2473520b6e.9.2026.11.20.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:27:46 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Suyash Mahar <smahar@meta.com>,
	Amir Ayupov <aaupov@fb.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/25] coresight: perf: End AUX output when an event is throttled
Date: Fri, 20 Nov 2026 09:27:39 -0800
Message-ID: <20261120172739.1843303-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <b851c070-19d2-42b8-b19d-be4b02ad9715@linaro.org>
References: <b851c070-19d2-42b8-b19d-be4b02ad9715@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 16/10/2026 14:46, James Clark wrote:
> Reviewed-by: James Clark <james.clark@linaro.org>

Hi Suzuki, Mike, James, Leo,

Could this go in alone as a v7.4 fix, with Cc: stable@vger.kernel.org?
It does not depend on the rest of the series and applies cleanly to
v7.4-rc3.

Thanks,
Vlad
