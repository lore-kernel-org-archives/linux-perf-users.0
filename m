Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B01DDA18
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265367; cv=none; b=p00KIXuVqlNBgHw+JezeNaOA9y9GOwNRnvJmFBI1Tmrp1gX2B506W6g8rcRdSsmpVrZ6iE7GQO0gjnXAASDq15YxdO/lhdMeouheOmrjvcfzLsQsllgzT88GAeI6IlpxXbaO568fHmAzzRx0NXA5FTvqOl2tdDw3yQudaoMZdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265367; c=relaxed/simple;
	bh=vKWgmcHfwYmk+WOyH/m/NR1zFQDp05YpYR4cyM855Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di1zpQZMmdjYBBEb+x+y0N0gWfMC4S5UrP/nTijqkZL6e5qjeRLf+T/9Myg3FJrarjXe2AX58FGPq9bSxYYs4tKienQsCXNo8mTUPzXguT/2p5dtKkYuPWpd8tpjJobQI3YvL3lyyFc2ThtunR+CCuqZ+acpIcOAnjBWwFlCG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdVR39vm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdVR39vm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so719484b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786265366; x=1786870166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKWgmcHfwYmk+WOyH/m/NR1zFQDp05YpYR4cyM855Uw=;
        b=MdVR39vmB79zYVCnuCjTxRTPEbJ2elSh0RfukjsWfRWhT5AC3BZZbwo7/b8B13V64K
         voDysGnMfFdsaQcNjeaYmXNtP/QWZ4zbgxVSZCXqXydkEq1KxhMHfE6kmZwuowGJs7gc
         9+Nsq7M9ypSbPcl7b2LYHvhZ+P4sFiEAL2biLrzrdYZTu9Hh+9whLDMYTUF+77meDuXU
         Tkg3wLJ0vbSA0VoSjoXSq2sMIEnzLdjj87YKcPjkQz+XzXIn9VnSalolcvmboLtLNsdh
         3oX9t3ggRvySXXtF9HbQywwR1vjC68w+xffETpCcms9H4DHSya++/XqYAufM7ihzg2k/
         btKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786265366; x=1786870166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKWgmcHfwYmk+WOyH/m/NR1zFQDp05YpYR4cyM855Uw=;
        b=oVExWByIfmJrR1YEv8qbEuMIHQNrx6eH3uNuslyNlNikZ3zBzuYlu5sXSn2EraRi3T
         C1FxoAHeh1X78tzWcRs5IRqxpN2gyfsZ1ZE2ZrX6hcOmq227go/C/PtoHTDqrTbB4no3
         5gc2H+PlcouFn++m/xDq/U8qDU2iUluvFpJnEnU98zQWM7xxk2IqSIRuqhE3DS0DUUUK
         0YUVAO5hHKAm8fEMxESR1zgjwQg1SL/xy6ekZpcNemkcgeIsniZA0yXkoX+BymVpovWR
         L2KGfxmtnTs6Zq+AhYOqP7l5mOH0RoKbi31xuURcGHRjR+f2djNeI9trzp9g0614FmdJ
         ckQw==
X-Forwarded-Encrypted: i=1; AHgh+RpthoFRGSgxgXVwmJ7LComIIBuOOkpAEe2gwXzdRsenvXR/nuEV6u7xrSQU4wMRpjTRgHzuMmDHrj7opXh5O3mw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zHnceoI/YbfFsIFs8fZtI2AZU4zWlNIVyWqK0nb4CzNlIjCl
	M3E8GH0Ld2a7j8smVCl4IAiSVruleWXuKmcRsfPsbyNUQsGS1c3aOHNnH6Re5w==
X-Gm-Gg: AR+sD112MxLFNT7tRq8ZvV2geq5MnHcOkdVqoOPaU6DGGd16M5mRdQGvksTbm8VEY+/
	0p1aUIalL7+Mfc8wJGU0aSw85cieBeGVIUCjh/buoN21qwG4l775eb9y/cN4nS9UqGB29X5g+cF
	GTHMkRthtrUm2rXL8HQ8OoJPXWR0au3nqZWp+zrD6jHcvs01SJWm5ruQsU6uTdQyXsKc3poLYCE
	vT2j/v2m5vM+kFPBrWN4RYEvfIAsQejaPiOuvyL0q+krSoys+0jDfW76pQt9vXtsl8D0Gs1FuVE
	cQQTeuUHnQjN1Cs+717P7MiYyoceZ5bVlGQaR1DZpl/Ej5bX9OhoRM+LglEyRFSP2JXWeKTfGpk
	bxLH6pfUKyVc6UD8fb+HuMHg/x4+G294/bbTRWGdzM6NKxiLECaIVc8uU+a9uqbdLl9szWMpGJ2
	zRWNxGT/kxioLT/XDFI7ei/43piS6scqi3+4CMjOrND8bnGeyYESe9HBMgXobm3iCRxF7jBN7m+
	7BDRCAnWQXck5k=
X-Received: by 2002:a05:6a20:7f86:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3cb85ea363cmr32830018637.19.1786265366126;
        Sun, 09 Aug 2026 01:49:26 -0700 (PDT)
Received: from volcano9dee-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb877b4sm32757823eec.19.2026.08.09.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:49:24 -0700 (PDT)
From: PVS Narasimha Rao <venkatasuryapala@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST
Date: Sun,  9 Aug 2026 14:19:03 +0530
Message-ID: <20260809084903.23914-1-venkatasuryapala@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <anQeWZD8J-gHMt_3@google.com>
References: <anQeWZD8J-gHMt_3@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks for the review.

I reproduced it with gdb and confirmed the mismatch: the values in
do_test() are a plain array of struct sample_read_value with a 24-byte
stride, while sample_read_value_size() is 16 without PERF_FORMAT_LOST.
So the synthesizer reads overlapping bytes, and the test compares the
same garbage on both sides and passes.

read.group.values is expected to be packed per read_format, though
evsel__parse_sample() points it into the event data, and perf inject
feeds such a sample straight back to perf_event__synthesize_sample().
So I plan to fix the test input rather than the synthesizer.

I'm preparing v2 and will send it shortly.

Thanks,
Narasimha
