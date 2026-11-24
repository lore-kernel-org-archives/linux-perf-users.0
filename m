Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521931;
	b=iAm8z1+vVWum+j+XtZTNC/dz3V9JzBvdH/ReX3g1+b9pJe+F2L1Udx+EsWROOLRPU0zH
	 4H2YevSnLmDN65jdZQT6+OQ4HQyAn4ujUixKAcY/bZRgYJ3EDFwNFCHvENZB32UoYKQQf
	 eGaeFlesHpcIEiVE1UK7yFOCzoO00S4YkdrvTqU+K+2Gw7xaOvm/Y1RHYa6w2QRz1/xZy
	 F5xXZOJlT+o03dNo6Yc42ZHHoiuNJvZPRg9z7+YOHfQJg23nh5KYGF2/LegY3T/1u1ap/
	 5pc63eCQ8IeJt5D7FgojcdY1dxX+rLZnhyQkSlhFf09o9lRhYUjqBcweAD34rIqxWQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t5DAWPIQJxmMOKP/hqm8wEkBGU/+0/HwxtbEt17HY6k=;
	b=4SmjPlpcbo4l5W68Rn8u7cJ6qJf/SnDeF/0HJwZNsJ4t2AT4Ad51uCMS6Vn78XxXSq6+
	 wuD1ZHfPyFd+7VUZo59sQLDF4MhP0NJMyq+sJCuNLx3+xhKo1TqzOlm94OP9UFvNitdBp
	 5WasUc3raSObVbvjagp7ozObYUY2BXnerBW9tEQR9kMst/JRDLCs4XX5VHAKnrt27vXNz
	 dJm1oJ4hJl8dZFy+8Q1ZV6wKbpj+u7MxECmoxw3ZWP/QwE4v8ItIwMg97JFuaortx4l0D
	 zjam973pzHcuPqObmXe3/Dur/xxOM2iznhsLXHhCgk/RyXm5X5PWjHErB7cNOU9iVBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VR0E6/eJ";
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C9606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6C9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VR0E6/eJ
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0458cc9easo33224185ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 04:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795521931; x=1796126731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5DAWPIQJxmMOKP/hqm8wEkBGU/+0/HwxtbEt17HY6k=;
        b=VR0E6/eJynbXo7eq0j9UewlBP/PeW2gHmZsgZ6eFtRxlOOQNxuDjm1JQjcj2xFcVFY
         0HjK545rm7jLRYrlQ0J6WvjZF0j33RKlxRkZXhUHHWbfrcf1bxoHvmBk/L4RcZLG5sQi
         1i0nMZ1IA1KHsiXVj29BbLOtvtDiIEsA3ZT5uInpvtShc12HPyr2yZRr1We0qdbcwyq3
         Vkzn7ncvugd3GRxl6zjW1WQwvlpn7cs9arRwuHyNLmw8XiLBcD8BFs0FhkvNRqLf9Vc9
         Rz/VHiXBSGzuo93VBX7elVS8hZRhibFzrdDukcEaOuO6AgbWAdXSweP7hLCiozygufms
         Jqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521931; x=1796126731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5DAWPIQJxmMOKP/hqm8wEkBGU/+0/HwxtbEt17HY6k=;
        b=ZTwhKNk6W7X/BPefrNDXX2oBZ9LXzFXEDidW+BmNBN3PQL93t0tIXa5dq1SfbY8vCF
         /VG2iA4C2YUqj+lZKXBDFWsDvBLtkOJdX/NkkpLfovMnmrONCtEC9jVRho/dOE7+ZBxv
         SvDtjFPwasMv/UavNdnMNKTWqZpu9YV/NGjcBrW5ylYW34lYD8cjaCASGbQy8FVW7/pQ
         46pEVvUn2KfuytK7ALrk997LKO9CgykxJBv4vyUcLluh7cB60Fbl2/f+1ZNrBZ23L5HN
         k/VLR19XhUdD47qk5wk4AsnqEcU5Z+1hvu6gwE1cU5RUcDcCpTVMI816MHqI4dTUq1DC
         GpKg==
X-Forwarded-Encrypted: i=1; AL+hErFKPQCRi/3poSuO/rQ5hiS2XzC+3P36luiDNBLTLqRC6OEHmYyXipVwNhext26JWschU1k4g/zDLBcJTcFyR5/2@vger.kernel.org
X-Gm-Message-State: APuU4Z8MDeez3XmvX1/XTX/rHtGZfAKyC2TaFmTl8i5HBmRO15xDQswG
	QaBvpfSTHCxzw5ByyM5/leh71keM5WE+L5te2vreiSk57XlcjUeZXFfL
X-Gm-Gg: AZFdTZeHruFDuBow9ORECsKT9X6MpGasCdFZXzS7vhfZ/xG2BVwHup0Hjol81GpqiFT
	IiaskB61aYEYM8NcAj3eyEKHOksndlz0pDwsoezFQ6n9Y7KJtYQtXUbRoKIq4v8vTb2hkJtPbjd
	8QnMpnH/H0hWU1r/NGQv1xCjpZUHtxAnsehzyiaEItL3vShO9jyHhlp5XrM/M2zrY7PEmH78uxs
	ZJNT5tsWXXQqLrF27CZp3+xx/j37wZC4kJVeLLhWlBwYdwSGau+VZlgTxT2NzcuNkShp0EHTP1I
	w8CuXg36QeunDMGuFM0B5ZCNy9kCHIxTh1+09WDa8haCFkj3b4ppFoRnq7DaWrDWkVbhnOSYV8a
	fPX3CxhnsN30nseMxbs3/ADI83Q4gftUvdw2n0VfpR3XWJ4yU+FZNJBbqDPngFrh3Ge1TporkkY
	qUBkvNQOHY2BCi085gOulyz2IaNubQezJoi+viyPW3mOgVt+Y2M1DcZVe9tA6UDzyf/fg56H5vh
	SyhFz0adcvAChsp2x+jNv4WJa8UfWoS1QIIu3BXbiOjYJloG2L+Z4swG/61RuCuC1KDbTz2t1gq
	ESIjv98RjG+ACqf3TyBMUmBNvx3vnJeByXzVswCdGkrFUo8w4EyBxERxdxRflGHop4GSB/imCBh
	GDfoQGRn2MEns5a2YIC0IAZVMyA2tFXciAkyGXpzuDYQe9e5vR9QwXOvYrhTAI27QO+N/Wiaq37
	nLM2FHOC6Fhp3oKIt7fel8M9Pwxdh+Tl/DOKokRc3nCPsmtJK5LzT1k+gqTmRZkM9bGyStvkFHP
	g/RHCZN/NFgk+haVeAr276DRhoQ29pcZmyRbVlgvCGd8wqFMfoimx0zNmri/zNf
X-Received: by 2002:a17:903:94b:b0:2e8:93b1:49cc with SMTP id d9443c01a7336-2f03f1bf19amr157803285ad.35.1795521930686;
        Tue, 24 Nov 2026 04:05:30 -0800 (PST)
Received: from localhost.localdomain (27-32-254-230.static.tpgi.com.au. [27.32.254.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm39621705ad.62.2026.11.24.04.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:05:30 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] perf: Reject group leaders detached by CPU hot-unplug
Date: Tue, 24 Nov 2026 22:35:02 +1030
Message-Id: <20261124120503.334-2-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <20261124120503.334-1-danjwade95@gmail.com>
References: <20261124120503.334-1-danjwade95@gmail.com>
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

CPU hot-unplug detaches the events of a CPU context but leaves them in
OFF or ERROR, so once the CPU is back a detached leader is still accepted
as group_fd. perf_group_detach() does nothing for a leader that is
already detached, so closing it frees it with the new sibling still
linked, and closing the sibling is a use-after-free.

Detach them with DETACH_EXIT as well, so that they end up in
PERF_EVENT_STATE_EXIT and are rejected by the check from
commit fa091f46c383 ("perf: Reject exited events as group leaders").

Side effect: poll() on a hot-unplugged event now reports EPOLLHUP, and it
is refused as group_fd even with PERF_FLAG_FD_NO_GROUP.

Fixes: 226424eee809 ("perf: Fix corruption of sibling list with hotplug")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Reviewed-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
Cc: stable@vger.kernel.org
---
Unchanged from v2.

Tested on mainline b3dfbde62cf1, x86-64 with KASAN and PROVE_LOCKING,
2 vCPUs under KVM. Without the patch a sibling is accepted on a
hot-unplugged leader and the close gives 15 KASAN reports. With it the
open fails with ENODEV and no report appears.

 kernel/events/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe6..2de4c3cc37ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15342,8 +15342,10 @@ static void __perf_event_exit_context(void *__info)
 
 	raw_spin_lock(&ctx->lock);
 	ctx_sched_out(ctx, NULL, EVENT_TIME);
-	list_for_each_entry(event, &ctx->event_list, event_entry)
-		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
+	list_for_each_entry(event, &ctx->event_list, event_entry) {
+		__perf_remove_from_context(event, cpuctx, ctx,
+					   (void *)(DETACH_EXIT | DETACH_GROUP));
+	}
 	raw_spin_unlock(&ctx->lock);
 }
 
