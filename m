Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046546EF9E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942149; cv=none; b=rNjQUq3eEcLRh4kX1nksaWmVyAY/4ci8m8zognwgSu4pSQdW/xJGrfipXtyEfaACRUQ+TbZ1W0bLDDbqUsOV6hauBi5q1L77ixfCYBFqswtld2KQFMkar0k9MvWT6OQK4g4/WnE0gYQC22zPpotXNDnQRWRscvpUrCdpGw2FpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942149; c=relaxed/simple;
	bh=Wj54mRLaARZ9PYNlr4i+zLQI/GYTbiqCc4R3uKPNcBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T6w3wzvcImphzo3LIIrG2rcfiBk3bwZ8qxqAbw8rWZvdEKlPin79vuSZ0Q9ND9GAqUxzrqr8P9mAtL424+IqVMldraFH10a6ED221NLVehLVaqQ6U5Z5p/U0skpF661RveryTh5uYOPYFlJTm8icPsxUKPNTX8juONB7RGfWPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzuOg1kL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzuOg1kL"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-472326ca506so789088f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785942145; x=1786546945; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ep5s2RfCR1ouH4tpNMfbsvxcvHXIBQkHbYkhl2XlO8g=;
        b=tzuOg1kLfznTvkYNRZDZZ8E3f6DqHDAQGNVMf7GwJanDqYuvDm7CwNh6PkQbyA+XsU
         yXFnQaGQcu1QJBKSC3Ir7rpcpXbtSWnTCGX9FWigaH/dMFSihj4r1l5FdX8ilvZLPAcF
         ON9ua5jPe+dRyygcR9vzk5Go29GlqcSIydbt60SBh/PSKa4gM5j0VoaTNS2M3DdEDiCN
         IbN3cN3+Gt2T9hyQEtMGk6zG2BpLxow2uPPPryP32owCYGQwLrjUopF4M9DWcGcPMX23
         xYSPy7u61b7bDAZWr3OcL02G5F5SOVL7mkDT7fsG/Rja2Q2tQdE1WkZIwCRwQcU49v6G
         cDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942145; x=1786546945;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ep5s2RfCR1ouH4tpNMfbsvxcvHXIBQkHbYkhl2XlO8g=;
        b=O9GsisCXijTngBrzqzEZQ1nFVhPkBPlyRZOB9Sq0J244SsH1kntCsMT6PNXtcpOXir
         wvdMHWTEjTvYJ4x0LxL1SC1NUPPYVZ5MR5VdsEZwHzzl+tclZBMU1GLB9dzqpyASlmVf
         AxH6qCyqJZxP8KQH0xVw7tSqEhPVO2bvIxpdql6BWEaIC4eC+0aleXbnNr5/iUK4v1el
         lvVD1UraHNl189deKilbFCqiv/syKHAUgZIqVwVJf2F/HjBaiNZwLyVTa6u71Zr9SKnx
         76YinTaMbEvB/CMr8BQLA3KcNs8x3OSWV6d+x67EKFzFbQKt7SDdwIFniPVCDEkr4H22
         xnFA==
X-Forwarded-Encrypted: i=1; AHgh+RppGZPqNlZNJiapHOG9uNcxj352HrbtvYl1VI3Lv9ODybrb26tUqo/lCz4kD6YI9svDmmh7O+601bilytYdclke@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTZRAT2ujseqNT5BdXCZfVx/kBwkp6wLhFprX5tunLMMlEzMu
	HUD758p0bGCgMSbRAZni2vJt8ZB1aeM+vsnHVOMqQ5YR237ml46xnbfGwB2ptA+qi6U=
X-Gm-Gg: AR+sD11s7TVzGqzOwTl3WAIuNwoD589V3OGiicEoSSZX5ykLwdORqJYt0mcnOBJLo8K
	Js2/zVrBbhJi1fF2t/3ujojJ1KuVyXQlASTgghO3zhoqMrCth+M0C8FAm82I4qPrDBMTrxHcQEo
	GDwm6N6RHPVQOQ8AISywWceGvREk4vdurD4Cy4HQCFk61tJ67XJg8e/bpmslf/9RuB4nSNW/Ove
	+aiDVU3HPD7cmVNbdS+ZqATDRJc/HUkJqPnwE/IZuguA2mp4iyQcI9fOodqklMOpF6cw/RpUfNS
	elAfMpYpsD0QIT1I9H4F/zWlGEcVr/drUtJYd8ym+eY55CkyspiHRPWZS5zuJOG+PrRc5bu52b7
	2S27rwLbI9bb2pgb2WBuAp/UtQsnnk+PWqh/YMYZhswSLeK1PCHaN53PX8lWyyy080tHuDCORNG
	2CqWFwnhJ3CYYqoDEpWPAo+fRdtl1urHtuAVNBY6HOClKleKALZS8USqGmK+0xX1HO
X-Received: by 2002:a5d:5541:0:b0:47a:b86f:3ed1 with SMTP id ffacd0b85a97d-47fec62bacamr9911458f8f.21.1785942145445;
        Wed, 05 Aug 2026 08:02:25 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23ede6sm10308695f8f.30.2026.08.05.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:02:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf: arm_spe: Add support for a 'software' discard
 mode
Date: Wed, 05 Aug 2026 16:01:50 +0100
Message-Id: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5Qc2oC/x3MQQqDQAwF0KtI1g3MiKjTq5QuwszXplCVpNiCe
 PcOXb7NO8hhCqdrc5BhV9d1qYiXhvJDlhmspZra0PZhDB0/5QVn38C+Tu+PGLioZ7HC49CnmBE
 ldYlqsBkm/f7z2/08fxEhcjRsAAAA
X-Change-ID: 20260804-james-spe-software-discard-87691ce1a949
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Al Grant <Al.Grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Add a mode similar to discard mode that we get in SPE V1P2, but without
requiring hardware support. It works by allocating a single page in the
driver when opening the event so the buffer can still be programmed and
SPE enabled. The same page is mapped multiple times to make up a 4MB
buffer so the full interrupt is serviced less frequently.

Unfortunately we can't rely on userspace to do the allocation because
the existing HW discard mode came with the relaxation that an event can
be opened without mapping a buffer. Therefore adding SW discard mode
without doing the allocation in the driver would break old tools. It
will also be useful for very simple tools that only do raw
perf_event_open() calls and don't want to mess around with mmaps. Tools
also can't do the hack to present a 4MB buffer to hardware while only
being backed by a single page.

Discard mode is used to activate SPE related PMU events so that they can
be counted by the PMU, without the overhead of collecting any SPE data.
So it's likely that simple tools are using discard mode with only raw
perf_event_open() calls.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf: arm_spe: Factor aux output and flags out of buffer fault handler
      perf: arm_spe: Factor HW discard mode out of arm_spe_perf_aux_output_begin()
      perf: arm_spe: Add support for a 'software' discard mode

 drivers/perf/arm_spe_pmu.c | 208 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 168 insertions(+), 40 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260804-james-spe-software-discard-87691ce1a949

Best regards,
--  
James Clark <james.clark@linaro.org>

