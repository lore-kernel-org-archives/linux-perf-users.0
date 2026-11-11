Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364430;
	b=5CmVUdpoaRCznY59wRkB5lM3atOxDq3MNk3qPvwKf8YHrdAJK/DjU3mCtmPmX9J/nVUV
	 B/Du9R1Cyq36O1gTF81rcAIiFiz373ajp4XY/t9ISC82QsbdcMd2HO/1KQCfyFFvRBQmN
	 /ljyLZFgEPp47Si5Pp4Zk/csj9UTrkN3XmJEp/c9P1BkBUDZ8hZ8Jm7jpixp3/IhfElXl
	 EbReGYm0ntEgYAzwD0Sd5946XPorUvj8UbSQ4w3ccR0JJMU/yGIrZ1+J8mU8LRLAVdQ++
	 hWsX8vvr4wBuVxiDY53ug8GpuHdW4w2mxUzeHvs/Ql/fFY/ppDuuHFCbRF5Tg8bK3uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=jlD4Bciblq1b+ZYxqiHc8ppLMiAmYd+QfhnLka4AQDQ=;
	b=xhDjqAqj5jFNchIPcA5RRhwauq+lcl5hXnUMEuQrHSYrzm0k66zn9CVTzq6HQ5Zn27ZL
	 374hoSgkvc8NAgpM2eUjY3niP0KylMVrI9QTKQj6vi7xn+0rOABI7vPDjtcuBgUvnuxAZ
	 xOPHM0f/pX8spSdWNO7gvOP/2/w4Aa3PD3srSOBhie/argLOHfLd8IJDyktv45sxLITbb
	 dZFUuPAgRC+ECISWhb1b2kfXQoqwSeSbCH0j7pALFybfoRAQgHIhWExzP+1ECYS8GKjHg
	 EhQiKFml4/UWLQ2oLirxiiJqE5Td0uWoMm5/jlqxxd4A+ceyxFAEM2Xye3wusuu+3mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yKMQNsgH;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48515606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48515606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yKMQNsgH
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3acec6677so4232059c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364429; x=1794969229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlD4Bciblq1b+ZYxqiHc8ppLMiAmYd+QfhnLka4AQDQ=;
        b=yKMQNsgHg+irsdJm1/g/NRK7RIJNhX2/9vgiYobHu/N9xd1tsgSmKj7PXCLi0nEdLE
         zZ2bAFauGblv3fOSJ+GwxrB8xxxyiUT/ObPQ4BBQStYW7EpTWW9tZUHaV4bnt3kkopR0
         ef06WiKEJHzgu5wyHIvz4Zt98fwhBgsMS1RE2qkrZFM+Ndp6Hc721CMoj9DuYd7SGonH
         2TfY/oYRo5RegfL02PklzwShp41e00wGZU02qVykB9+aONIWU2o+TxRcsu0iedw0R75H
         7gKoitNegRtYdYGdc7xkzvTeFuX8a8XRSrscDnI2j7WRvG7ySy4iCZF/efZxMX12YUQF
         NwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364429; x=1794969229;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlD4Bciblq1b+ZYxqiHc8ppLMiAmYd+QfhnLka4AQDQ=;
        b=G+fL4qj1whDsNvUgUKOkeOkKhlOzvdKJmqqBbkYKgY0xloa+UVaWmXhK5qtHoKYH5h
         f+1yh6M8TCFKdXY4t0snHtzDQ568hLOasaOsL4+Hvu78oTVIiBv3XxMaAX27VuLxw9fh
         9jTaw1zy/bDAYWbIs3pXXN1TQZwp11jFxSXkwULyjnXbKuTZu5oU/OVS3S6v7IMq39ik
         fxLJXwirIkoavuIZhFm/JanJNBlzsBZZFyOnfCA+w2w0toaZ3MK6JpKepQEavR0dpuSo
         HTFYmNXiPQJ+R2q6kinaiVMgLvQDcI4FzgzlbOkoKyMvsDBwxIYG4r7xeHhTEX5umxhU
         EshA==
X-Forwarded-Encrypted: i=1; AL+hErH4v0Shoy7oemQou5HoxrPz4OvbnqqjkdTanQU6uWywuX5Iv6HViCdbnLs0YromE8FWVi4NnSEOFaLONJY5VUEL@vger.kernel.org
X-Gm-Message-State: APuU4Z+smV/76057DqPDO1CoJwZbBaqBy/zcE//qBl46seLfKMrMqbyl
	qLLkN96gts5Po/sJYq4G7iTCenfFfviKZZ7WfhSLk4Z8P6LMu6Igjt5w
X-Gm-Gg: AYBFou227969BmuB0ZR/oqeLfA9lSUrgpLan9aYFG/Lrk352D26o09TZiBfxB3aJffK
	iHnG0FwIY6CyjcyT0cYiu9g5MgXbQenXjfXQpOaUbEAeZy/xgNmBosxkBXn/ZfiqTEDfCPBDKIA
	NQS++/5jjBmYG7RH7TP2JeixidyIbz1m4ERiE5FwIjYTjZ2EpwH2RRXUoW2oeD+tV8ttEsFdul3
	XJ7TnZhlXyDMqdEZWU0pzngyaRWYdTwC9lEwXebvBBc4k81aXX3ILCX6b6jXhmglcE9xHBUlIcv
	h8kV8cGAtiFkTT3hxppWK8a5sjoG7QpCzbx7JdigK9dlAudPjrcKbCfS4l2j5OFVD0+tfDOhMF7
	oADg2Z+0TEgAQrwDBTPXBGj0pJh/EEssevpqOCJUgJewqnj8I29tIQxmMcQQLOJB9GueQP+Z/P1
	VgMdrn8AS9ntH+K24kDopcaUWqYf/C5hFBoqBycdS/MgQOpyLxDtGbBWYyPbCILekUwpuyFkZtt
	jDvzm6V85XaVchC8sXuvZqHanIRHivqurVX8QcRfqSbE2zZNazEnvsExq7+rmQih57kEge0SqA1
	APNAdnoCqG2cleg0EW+23aZEIA==
X-Received: by 2002:a05:7022:e881:b0:1b2:60ab:1e9a with SMTP id a92af1059eb24-1b3c02fe53emr1138924c88.10.1794364429330;
        Tue, 10 Nov 2026 18:33:49 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11177332eec.15.2026.11.10.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:33:48 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@linaro.org>, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH 3/3] perf jevents: Check the JSON keys that jevents.py never reads
Date: Wed, 11 Nov 2026 02:33:46 +0000
Message-ID: <179436442670.1969352.8208885798111703671@gmail.com>
In-Reply-To: <sashiko-outbox-207848@kernel.org>
References: <20261110222250.1864777-1-takano32@gmail.com> <sashiko-outbox-207841@kernel.org> <sashiko-outbox-207848@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Both findings are in my tree.

The missing Fixes: tag, which you raised against 2/3: adding nargs='?'
to the model argument is fixing a hole in 5a09b1fd1b1f ("perf jevents:
Add model list option"), so the tag belongs there.  It is in the commit
now, so the next revision of 2/3 carries it.

The sibling hint, which you raised against 3/3: you are right, and the
suppression has to go rather than be narrowed.  get_close_matches(n=2)
on a key such as RetirementLatencyMxi returns both RetirementLatencyMin
and RetirementLatencyMax, and the code kept quiet when the other
candidate was present and carried the same value in its table.  But the
value does not say which of the two names the author meant, and the JSON
object can hold only one of them, so a metric written next to a correct
sibling with the same value was the one case that disappeared: measured
on a table that has RetirementLatencyMin and a misspelled
RetirementLatencyMxi with the same value, the check exited 0 and
reported nothing before the change, and reports the key and exits 1
after it.

Reporting both names is noisier, which is the trade: the report names
the key that was not read, and the two candidates are the nearest names
to it.  A table with no typo produces no output either way.

